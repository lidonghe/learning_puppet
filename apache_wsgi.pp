class {'apache':
    default_vhost       => false,
    default_mods        => false,
    default_confd_files => false,
    mpm_module          => 'prefork', 
}

include 'apache::mod::wsgi'
include 'apache::mod::php'
apache::vhost{'apache_vhost':
    port => '80',
    docroot => '/var/www',
    wsgi_script_aliases => { '/wsgi' => '/var/www/wsgi/code.py' },
    aliases => [
        {
            alias => '/wsgi/static', 
            path => '/var/www/wsgi/static/',
        },
    ]
}
