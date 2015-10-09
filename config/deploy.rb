# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'gassy'
set :user, 'gassy'

set :repo_url, 'git@github.com:jocyvan/gassy.git'

set :use_sudo, false

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:user)}/rails_apps/#{fetch(:application)}"          # Where on the server your app will be deployed
# set :deploy_via, :copy
set :tmp_dir, "/home/#{fetch(:user)}/rails_apps/#{fetch(:application)}/tmp"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


set :default_environment, {
  'GIT_SSL_NO_VERIFY' => "true",
  'GEM_HOME'          => "/home/#{fetch(:user)}/ruby/gems",
  'GEM_PATH'          => "/home/#{fetch(:user)}/ruby/gems:/usr/local/ruby20/lib64/ruby/gems"
}

# Bundler
set :bundle_dir, "/home/#{fetch(:user)}/rails_apps/#{fetch(:application)}/shared/bundle"
set :bundle_flags, "--deployment"


namespace :deploy do
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  task :start do
    on roles(:app) do
      execute "rm -rf /home/#{fetch(:user)}/public_html; ln -s #{current_path}/public /home/#{fetch(:user)}/public_html"
      execute "cd #{shared_path}; mkdir files"
      execute "ln -nfs #{shared_path}/files #{current_path}/public/files"
      execute "touch #{current_path}/tmp/restart.txt"
    end
  end

  task :restart do
    on roles(:app) do
      execute "ln -nfs #{shared_path}/files #{current_path}/public/files"
      execute "touch #{current_path}/tmp/restart.txt"
    end
  end
end
