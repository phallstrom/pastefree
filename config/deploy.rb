set :application, "pastefree"
set :scm, :git
set :repository,  "/git/#{application}.git"
set :local_repository, "gutsy:/git/#{application}.git"
set :deploy_to, "/home/philip/apps/#{application}"
set :runner, "philip"
set :use_sudo, false

set :keep_releases, 2
set :lsws_cmd, "sudo /usr/local/lsws/bin/lswsctrl"

set :deploy_via, :remote_cache
set :git_enable_submodules, 1

role :app, "gutsy.pjkh.com"
role :web, "gutsy.pjkh.com"
role :db,  "gutsy.pjkh.com", :primary => true, :no_release => true

namespace :deploy do

  desc "Start LiteSpeed Web Server."
  task :start, :roles => :app do
    as = fetch(:runner, "app")
    via = fetch(:run_method, :sudo)
    invoke_command "#{lsws_cmd} start", :via => via, :as => as
  end

  desc "Stop LiteSpeed Web Server."
  task :stop, :roles => :app do
    as = fetch(:runner, "app")
    via = fetch(:run_method, :sudo)
    invoke_command "#{lsws_cmd} stop", :via => via, :as => as
  end

  desc "Restart LiteSpeed Web Server."
  task :restart, :roles => :app do
    as = fetch(:runner, "app")
    via = fetch(:run_method, :sudo)
    invoke_command "#{lsws_cmd} restart", :via => via, :as => as
  end

end
