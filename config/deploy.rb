require 'mina/deploy'
require 'mina/git'

set :application_name, 'cms'
set :domain, '46.101.146.201'
set :deploy_to, '/var/www/html'
set :repository, 'https://github.com/designrubenz/cms.git'
set :branch, 'master'
set :user, 'cms'

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push('wp-content/uploads', 'wp-content/gallery')
set :shared_files, fetch(:shared_files, []).push('wp-config.php')

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  command %[mkdir -p "#{fetch(:deploy_to)}/shared/wp-content/uploads"]
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end
end
