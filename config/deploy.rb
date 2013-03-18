require "rvm/capistrano"

set :application, "cardsys"
set :repository,  "git@github.com:cmingxu/cardsys.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "42.96.173.64"                          # Your HTTP server, Apache/etc
role :app, "42.96.173.64"                          # This may be the same as your `Web` server
role :db,  "42.96.173.64", :primary => true # This is where Rails migrations will run
role :db,  "42.96.173.64"

set :user, "deploy"
set :password, "xuchunming123"

set :use_sudo, false

set :deploy_to, "/home/deploy/code/#{application}"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
#
default_run_options[:pty] = true


namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end


  task :start do
    sudo "/opt/nginx/sbin/nginx"
  end

  task :stop do
    sudo "/opt/nginx/sbin/nginx -s stop"
  end

  task :update_bundle do
    run "cd #{release_path} && bundle install"
  end
end

after "deploy:update_code", "deploy:update_bundle"

namespace :db do
  task :db_config, :except => { :no_release => true }, :role => :app do
    run "cp -f #{release_path}/config/database.template #{release_path}/config/database.yml"
  end
end

after "deploy:update_code", "db:db_config"

