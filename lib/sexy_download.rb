# encoding: utf-8

require 'rubygems'
require 'tempfile'
require 'etc'

require 'sqlite3'
require 'active_record'

class CookieExtractor

  CHROME_COOKIES_FILE_MAC_OSX = "Library/Application Support/Google/Chrome/Default/Cookies"

  def initialize domain, dir
    @domain, @dir, @cookies_txt = domain, dir, []
  end

  def extract!
     find_host_key!
     generate_cookie!(read_cookie!)
     @file_path
  end

  private
  def find_host_key!
    server = @domain.scan(/:\/\/([^:#\/\?]+)/).flatten.first
    raise "Malformed domain!" unless server

    parts = server.split(".")
    @host_key = ".#{parts[-2]}.#{parts[-1]}"
  end

  def host_only? host
    (host =~ /#{@host_key}/) == 0
  end

  def host_only_str cookie
    host_only?(cookie["host_key"]).to_s.upcase
  end

  def secure? secure
    secure.to_i == 1
  end

  def secure_str cookie
    secure?(cookie["secure"]).to_s.upcase
  end

  def get_connection
    puts "\n== Reading cookies from #{@host_key} ..."
    @cookie_db = "#{File.expand_path(Etc.getpwuid.dir)}/#{CHROME_COOKIES_FILE_MAC_OSX}"
    @db = ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database => @cookie_db
    )
    @db.connection
  end

  def read_cookie!
    connection = get_connection
    cookies = connection.execute("SELECT host_key, path, secure, expires_utc, name, value FROM cookies where host_key like '%#{@host_key}%'")

    @cookies_txt << "# Cookies for domains related to <b>" + @domain + "</b>."
    @cookies_txt << "# This content may be pasted into a cookies.txt file and used by wget"
    @cookies_txt << "# Example:  wget -x --load-cookies cookies.txt #{@domain}"
    @cookies_txt << "#"

    cookies.each do |cookie|
      if cookie["host_key"] =~ /#{@host_key}/
        line = []
        line << cookie["host_key"]
        line << host_only_str(cookie)
        line << cookie["path"]
        line << secure_str(cookie)
        line << cookie["expires_utc"] ? cookie["expires_utc"] : "0"
        line << cookie["name"]
        line << cookie["value"]

        @cookies_txt << line.join("\t")
      end
    end

    @cookies_txt.join("\n")
  end

  def generate_cookie! cookies_txt
    puts "\n== Exporting cookies..."
    file_name = "cookies_#{Time.now.to_i.to_s}.txt"

    file = File.new(@dir.nil? ? file_name : File.join(@dir, file_name), "w")
    file.write(cookies_txt)
    @file_path = file.path
    file.close
  end
end

raise %{
  This script is totally based on aria2 (http://aria2.sourceforge.net/)
  I did not find on your machine using 'which aria2c'
  In Mac OSX try:
    - sudo port install aria2
    or
    - brew install aria2
    or
    Download and compile it yourself
    ;)\n
} if `which aria2c`.empty?

raise %{
  You forgot to inform the download url, like:
  $ sexy_download http://myDownloadUrl.com?q=ZHGT ~/My/Target/Dir
  or
  $ sexy_download http://myDownloadUrl.com?q=ZHGT\n
} if ARGB[0].nil?

@domain = ARGV[0]
@dir = File.expand_path(ARGV[1] || ".")
@file_path = CookieExtractor.new(@domain, @dir).extract!

command = %{aria2c -c -x16 #{@domain} --load-cookies="#{@file_path}"}
command << %{ --dir="#{@dir}"} if @dir
puts "\n== Downloading with:"
puts "\t#{command}\n"

system(command)

puts "\n== Deleting #{@file_path}"
File.delete @file_path