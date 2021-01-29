<?php
namespace Deployer;

require 'recipe/drupal8.php';

// Project name
set('application', 'my_project');

// Project repository
set('repository', 'https://github.com/aalshukri/DevOps-Drupal-Deploy-TEST');

// [Optional] Allocate tty for git clone. Default value is false.
set('git_tty', true); 

// Shared files/dirs between deploys 
add('shared_files', []);
add('shared_dirs', []);

// Writable dirs by web server 
add('writable_dirs', []);


// Hosts

host('project.com')
    ->set('deploy_path', '~/{{application}}');    
    
// Tasks

task('test', function () {
    writeln('Hello world');
});


task('build', function () {
    run('cd {{release_path}} && build');
});

// [Optional] if deploy fails automatically unlock.
after('deploy:failed', 'deploy:unlock');

