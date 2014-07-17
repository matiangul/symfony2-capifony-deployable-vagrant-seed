# Deployment server info
set :application,          "courseo_automatic_deployment"
set :domain,               "ec2-54-76-160-169.eu-west-1.compute.amazonaws.com"
set :deploy_to,            "/home/staging/www/courseo_automatic_deployment"
set :app_path,             "app"
set :web_path, 	           "web"
set :model_manager,        "doctrine"
set :maintenance_basename, "maintenance"

# SCM info
set :repository,  "git@github.com:mangulski-neducatio/symfony2-capifony-deployable-vagrant-seed.git"
set :scm,         :git # the best scm system ever
set :branch,      "master"
# set :deploy_via,  :remote_cache # it doesnt clone everything every time is deployed

# more instructions on https://help.github.com/articles/deploying-with-capistrano

role :web,        "ec2-54-76-160-169.eu-west-1.compute.amazonaws.com"                         # Your HTTP server, Apache/etc
role :app,        "ec2-54-76-160-169.eu-west-1.compute.amazonaws.com"                         # This may be the same as your `Web` server
role :db,         "ec2-54-76-160-169.eu-west-1.compute.amazonaws.com", :primary => true       # This is where Symfony2 migrations will run
 
# General config stuff
set :keep_releases,     5
set :shared_files,      ["app/config/parameters.yml"] # This stops us from having to recreate the parameters file on every deploy.
set :shared_children,   [app_path + "/logs", web_path + "/uploads", "vendor"]
set :permission_method, :acl
set :use_composer,      true

# Confirmations will not be requested from the command line.
set :interactive_mode,  true

# User details for the production server
default_run_options[:pty] = true
set :user, "staging"
set :use_sudo, false
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ["publickey"]
ssh_options[:keys] = ["key.pem"]
# ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa_USERNAME")] # private key created in installation instruction

# Uncomment this if you need more verbose output from Capifony
logger.level = Logger::MAX_LEVEL

# Run migrations before warming the cache
# before "symfony:cache:warmup", "symfony:doctrine:migrations:migrate"
before "deploy:install_app"

# Custom tasks
namespace :deploy do
  task :install_app, :roles => :web do
    run "cd #{ current_release } && ant" # go to current deployed application path and run some script
  end
  task :done do
    run "echo \"Zrobione\""
  end
end

after "deploy", "deploy:done"
