# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2@l33nkme'
#set :rvm_type, :user

# bundler bootstrap
require 'bundler/capistrano'

# main details
set :application, "l33nkme"
set :user, 'l33nkme'
set :domain, 'l33nk.me'
set :applicationdir, '~/Apps/L33nkMe'
role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run


# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = '%w(/home/l33nkme/.ssh/id_rsa)'
set :deploy_to, applicationdir
set :deploy_via, :export
# set :deploy_via, :remote_cache

# repo details
set :scm, :git
set :repository,  "ssh://#{user}@#{domain}/~/Apps/repos/#{application}.git"
set :git_enable_submodules, 1


# tasks

namespace :rvm do
  desc 'Trust rvmrc file'
  task :trust_rvmrc do
    run "rvm rvmrc trust #{latest_release}"
  end
end

load 'deploy/assets'

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release - not used"
  task :symlink_shared, :roles => :app do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
after "deploy:update_code", "rvm:trust_rvmrc"

after 'deploy:update_code', 'deploy:symlink_shared'
