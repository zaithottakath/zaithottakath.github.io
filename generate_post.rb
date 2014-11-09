# generate_post.rb
# > ruby generate_post.rb
def prompt(*args)
  print(*args)
  gets.chomp
end

def normalize_file_extension(file_extension)
  file_extension    = "md" if file_extension.empty?
  file_extension[0] = '' if file_extension[0] == '.'
  file_extension
end

def generate_file_name(title, file_name_suffix, file_extension, current_time)
  file_extension   = normalize_file_extension(file_extension)
  file_name_suffix = title if file_name_suffix.empty?
  file_name_suffix = file_name_suffix.gsub(" ", "_").gsub(/\W/,'').downcase
  "#{current_time.strftime("%F")}-#{file_name_suffix}.#{file_extension}"
end


title             = prompt("Post title: ")
categories        = prompt("Post categories: ")
file_name_suffix  = prompt("Post file name (enter nothing if you want it auto-generated: ")
file_extension    = prompt("File extension (enter nothing if you want markdown): ")

current_time   = Time.now
file_name      = generate_file_name(title, file_name_suffix, file_extension, current_time) 

file_contents   = <<-FILE_CONTENTS
---
layout: post
title: "#{title}"
date: #{current_time.strftime("%F %T")}
categories: #{categories}
filename: #{file_name}
---
FILE_CONTENTS

puts "Generate file with contents:"
puts file_contents
continue = prompt("Write to file? (y/n): ")
# Customize the full file and path for your own needs
full_file_and_path = "./_posts/#{file_name}" 
File.write(, file_contents) if continue[0] == "y"
