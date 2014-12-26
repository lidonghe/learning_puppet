class {'apache':
    default_vhost       => false,
    default_mods        => false,
    default_confd_files => false,
    mpm_module          => 'prefork', 
}

include 'apache::mod::wsgi'
include 'apache::mod::php'

apache::vhost{'eclipsupd':
    port => '80',
    docroot => '/var/www',
    wsgi_script_aliases => {
        '/wsgi' => '/var/www/wsgi/code.py' ,
        '/svnlog' => '/var/www/svnlog/ldap_handler.py',
        '/ILItfChg' => '/var/www/ILItfChg/wsgi_handler.py',
    },
    aliases => [
        {
            alias => '/wsgi/static', 
            path => '/var/www/wsgi/static/',
        },
        {
            alias => '/svnlog/static',
            path => '/var/www/svnlog/static',
        },
        {
            alias => '/static', 
            path => '/var/www/ILItfChg/static',
        },
    ],
}
package{'python-ldap':
    ensure => present,
}
package{'python-mysqldb':
    ensure => present,
}
file{'/var/www/svnlog':
    ensure => 'link',
    target => '/home/lidong/dist/svnlog',
}
file{'/var/www/ILItfChg':
    ensure => 'link',
    target => '/home/lidong/dist/ILItfChg',
}

