# Deployment server info
set :application,          "APP_NAME"
set :domain,               "PRODUCTION_SERVER_IP"
set :deploy_to,            "ABSOLUTE_PATH_ON_SERVER"
set :app_path,             "app"
set :web_path, 	           "web"
set :model_manager,        "doctrine"
set :maintenance_basename, "maintenance"

# SCM info
set :repository,  "CLONE_URL_TO_REPOSITORY"
set :scm,         :git # the best scm system ever
set :branch,      "BRANCH_NAME"
# set :deploy_via,  :remote_cache # it doesnt clone everything every time is deployed

# more instructions on https://help.github.com/articles/deploying-with-capistrano

role :web,        "PRODUCTION_SERVER_IP"                         # Your HTTP server, Apache/etc
role :app,        "PRODUCTION_SERVER_IP"                         # This may be the same as your `Web` server
role :db,         "PRODUCTION_SERVER_IP", :primary => true       # This is where Symfony2 migrations will run
 
# General config stuff
set :keep_releases,     10
set :shared_files,      ["app/config/parameters.yml"] # This stops us from having to recreate the parameters file on every deploy.
set :shared_children,   [app_path + "/logs", web_path + "/uploads", "vendor"]
set :permission_method, :acl
set :use_composer,      true

# Confirmations will not be requested from the command line.
set :interactive_mode,  true

# User details for the production server
set :user, "USERNAME"
set :use_sudo, false
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa_USERNAME")] # private key created in installation instruction

# Uncomment this if you need more verbose output from Capifony
# logger.level = Logger::MAX_LEVEL

# Run migrations before warming the cache
# before "symfony:cache:warmup", "symfony:doctrine:migrations:migrate"

# Custom tasks
namespace :deploy do
  task :install_app, :roles => :web do
    run "cd #{ current_path } && ant install-dev" # go to current deployed application path and run some script
  end
end

after "deploy", "deploy:install_app"
