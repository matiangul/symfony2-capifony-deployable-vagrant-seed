# Deployment server info
set :application,          "courseo_automatic_deployment"
set :domain,               "54.76.160.169"
set :deploy_to,            "/home/ubuntu/www/courseo_automatic_deployment"
set :app_path,             "app"
set :web_path, 	           "web"
set :model_manager,        "doctrine"
set :maintenance_basename, "maintenance"

set :repository,  "git@github.com:mangulski-neducatio/symfony2-capifony-deployable-vagrant-seed.git"
set :scm,         :git # the best scm system ever
set :branch,      "master"
# set :deploy_via,  :remote_cache # it doesnt clone everything every time is deployed

# more instructions on https://help.github.com/articles/deploying-with-capistrano

role :web,        "54.76.160.169"                         # Your HTTP server, Apache/etc
role :app,        "54.76.160.169"                         # This may be the same as your `Web` server
role :db,         "54.76.160.169", :primary => true       # This is where Symfony2 migrations will run

set :keep_releases,     5
set :shared_files,      ["app/config/parameters.yml"] # This stops us from having to recreate the parameters file on every deploy.
set :shared_children,   [app_path + "/logs", web_path + "/uploads", "vendor"]
set :permission_method, :acl
set :use_composer,      true

set :interactive_mode,  true

# User details for the production server
default_run_options[:pty] = true
set :user, "ubuntu"
set :use_sudo, false
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ["publickey"]
ssh_options[:keys] = ["app/config/key.pem"]

# logger.level = Logger::MAX_LEVEL

before "symfony:composer:install", "deploy:install_app"

# Custom tasks
namespace :deploy do
  task :install_app, :roles => :web do
    run "cd #{ current_release } && ant" # go to current deployed application path and run some script
  end
end
