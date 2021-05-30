require "fileutils"
PROJECT_ROOT_PATH = File.expand_path(File.dirname(__FILE__))
REQUIREMENTS_FILE = File.join(PROJECT_ROOT_PATH, "requirements.txt")
ACTIVE_PROJECT_FILE = File.join(PROJECT_ROOT_PATH, ".active_project")
PETALINUX_SRC = "petalinux-src"
PETALINUX_SRC_PATH = File.join(PROJECT_ROOT_PATH, PETALINUX_SRC)

def active_project
    if File.file?(ACTIVE_PROJECT_FILE)
        return File.read(ACTIVE_PROJECT_FILE).split[0]
    end
    raise "No active project selected.  Select one using 'rake set_project[<PROJECT_NAME>]'"
end

def active_project_path
    return File.join(PETALINUX_SRC_PATH, active_project)
end

task :test_petalinux_environment do
    raise "ERROR: Petalinux environment is not defined. Did you remember to 'source' it? See the readme for details." if ENV["PETALINUX"].nil?
end

desc "Select the active Petalinux project set_project[zynq-ultrascale-bsp]"
task :set_project, [:project_name] do |t, args|
    File.write(ACTIVE_PROJECT_FILE, args[:project_name])
end

desc "Get the name of the current active project"
task :get_project do
    puts "The currect active project is '#{active_project}'"
end

desc "Install the required packages for Ubuntu"
task :install_requirements do
    sh "sudo dpkg --add-architecture i386"
    sh "sudo apt-get update"
    sh "sudo apt-get install -y $(grep -vE \"^\s*#\" '#{REQUIREMENTS_FILE}'  | tr \"\n\" \" \")"
end

desc "Create the selected petalinux project in the #{PETALINUX_SRC} directory"
task :create_project => :test_petalinux_environment do
    Dir.chdir(PETALINUX_SRC_PATH) do
        sh "petalinux-create -t project -n '#{active_project}' --template zynqMP"
    end
end

desc "Import the XSA file hardware configruation"
task :import_hardware, [:xsa_file] => :test_petalinux_environment do |t, args|
    xsa_file = File.expand_path(args[:xsa_file])
    Dir.chdir(active_project_path) do
        sh "petalinux-config --get-hw-description '#{xsa_file}' --silentconfig"
    end
end

desc "Run the Linux kernel config utility"
task :kernel_config => :test_petalinux_environment do 
    Dir.chdir(active_project_path) do
        sh "petalinux-config"
    end
end

desc "Build the petalinux project"
task :build_release => :test_petalinux_environment do 
    Dir.chdir(active_project_path) do
        sh "petalinux-build"
        sh "petalinux-package --boot --u-boot --format BIN"
    end
end