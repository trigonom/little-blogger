#!/usr/bin/env ruby

class String
  def decorate(left, right)
    "#{left}#{self}#{right}"
  end
end

# Read posts, and convert them to HTML.
posts = Dir.glob('posts/**/*.txt').map do |path|
  text = File.read(path)
  html = '<html><head><title>A post</title></head><body>' + text.decorate('<p>', '</p>') + '</body></html>'

  {:html => html, :name => File.basename(path, '.txt'), :word_count => text.split(/\s+/).size}
end

if Dir.exist?('gen')
  require 'fileutils'
  FileUtils.rm_r('gen')
end

Dir.mkdir('gen')

posts.map do |post|
  File.write(File.join('gen', post[:name]), post[:html])

  # Some nice output...
  puts "=> #{post[:name]} (#{post[:word_count]} words)"
end
