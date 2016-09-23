# config valid only for current version of Capistrano
require 'capistrano/ext/multistage' 

set :stages, %w(production)
set :default_stage, "production" 

set :application, 'myproject.py'
set :user, 'root'
set :use_sudo, false

# setup repo details
set :scm, :git
set :repository, 'git@github.com:rborges01/projeto-python.git'
set :deploy_to, "/root/myproject/" 

# how many old releases do we want to keep
set :keep_releases, 2

namespace :deploy do

  after :finishing, 'deploy:cleanup'

  task :finalize_update do
  end

  task :restart do
	restart_pythonserver
  end

  desc "Restart do PythonServer" 
  task :restart_pythonserver , :roles => :app  do
    sudo '/etc/init.d/pythonserver stop'
    sudo '/etc/init.d/pythonserver start'
  end
end
