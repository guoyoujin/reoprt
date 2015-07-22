# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'report'
set :repo_url, 'git@github.com:guoyoujin/reoprt.git'

set :scm, :git
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :rvm_type, :user
# set :rvm_ruby_version, '2.2.2'
set :default_env, { rvm_bin_path: '~/.rvm/bin' }

# Default value for keep_releases is 5
set :keep_releases, 5

set :ssh_options, {
  user: 'gyj',
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: false,
  auth_methods: %w(publickey)
}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
