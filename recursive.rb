# In this case Shared by CIFS Windows Folder was used
# Executed file was using on Mac machine
# Run with "ruby {path}/recursive.rb source_dir target_dir"

if ARGV.length > 2 or ARGV.length < 2
  raise "Please enter source_dir and target_dir only"
end

# Change constants for your Windows configuration
USER_NAME = "user"
PASSWORD = "password"
SERVER = "server" # Windows machine name
FOLDER = "folder"

source_dir = ARGV[0]
target_dir = ARGV[1]

# This method was used to separate copying file methods for different platforms
# In my case read file -> copy content -> write to file was working for all file extensions on Mac, but on Windows those files were corrupted
def get_platform
  platform = RUBY_PLATFORM.downcase

  if platform.include? "darwin"
    platform = "Mac"
  elsif platform.include? "linux"
    platform = "Linux"
  elsif platform.include? "mingw"
    platform = "Windows"
  end
  
  platform
end

# This method is working only for Mac
def mount_smb_volume
  system("open smb://#{USER_NAME}:#{PASSWORD}@#{SERVER}/#{FOLDER}")
  sleep(5)
end

# This method is working only for Mac
def unmount_smb_volume
  system("umount /Volumes/#{FOLDER}")
end

def recursive_copy(source, target, rewrite)
  platform = get_platform
  Dir.entries(source).each do |object|
    if object != "." and object != ".."
      if File.directory?(File.join(source, object))
        new_folder = File.join(target, object)
        unless Dir.exist?(new_folder)
          Dir.mkdir(File.join(target, object))
        end
        recursive_copy(File.join(source, object), new_folder, rewrite)
      else
        new_file = File.join(target, object)
        if platform == "Linux" or platform == "Mac"
          source_file = File.open(File.join(source, object))
        else
          source_file = File.join(source, object)
        end

        if File.exist?(new_file)
          if rewrite
            if File.size(source_file) != File.size(new_file)
              if platform == "Mac" or platform == "Linux"
                file_data = source_file.read
                source_file.close
                File.open(new_file, "w+") {|f| f.write(file_data) }
              else
                File.delete(new_file)
                FileUtils.cp(source_file, new_file)
              end
            end
          end
        else
          if platform == "Linux" or platform == "Mac"
            file_data = source_file.read
            source_file.close
            File.open(new_file, "a") {|f| f.write(file_data) }
          else
            FileUtils.cp(source_file, new_file)
          end
        end
      end
    end
  end
end

mount_smb_volume
recursive_copy(source_dir, target_dir, true)
unmount_smb_volume