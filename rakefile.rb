require "fileutils"
PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))
REQUIREMENTS_FILE = File.join(PROJECT_ROOT, "requirements.txt")

desc "Install the required packages for Ubuntu"
task :install_requirements do
    sh "sudo dpkg --add-architecture i386"
    sh "sudo apt-get update"
    sh "sudo apt-get install -y $(grep -vE \"^\s*#\" #{REQUIREMENTS_FILE}  | tr \"\n\" \" \")"
end

