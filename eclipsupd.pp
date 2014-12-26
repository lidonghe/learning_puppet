class {'apache':
    default_vhost       => false,
    default_mods        => false,
    default_confd_files => false,
    mpm_module          => 'prefork', 
}

include 'apache::mod::wsgi'
include 'apache::mod::php'
include 'apache::mod::autoindex'
apache::vhost{'eclipsupd':
    port => '80',
    docroot => '/var/www',
    directories => [
        {
            path => '/var/www', 
            allow => 'from all',
        },
        {
            path => '/var/www/IPALight_SCM/report/CI/', 
            allow => 'from all',
            options => ['Indexes'],
        },
    ],
    wsgi_script_aliases => {
        '/wsgi' => '/var/www/wsgi/code.py' ,
        '/svnlog' => '/var/www/svnlog/ldap_handler.py',
        '/ILItfChg' => '/var/www/ILItfChg/wsgi_handler.py',
        '/urlmap' =>  '/var/www/urlmap/urlmap.py/',
        '/data' =>  '/var/www/urlmap/urlmap.py/',
        '/lrc' => '/var/www/urlmap/urlmap.py/',
        '/correctiontool' => '/var/www/correctiontool/web/correctiontool.py/',
        '/Classic_ipa_dashboard' => '/var/www/ClassicIpaDashboard/wsgi_handler.py',
        '/ILCIdashboard' => '/var/www/ILCIdashboard/wsgi_handler.py',
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
        {
            alias => '/ILCIdashboard/dashboardstatic', 
            path => '/var/www/ILCIdashboard/dashboardstatic',
        },
        {
            alias => '/Classic_ipa_dashboard/cipastatic', 
            path => '/var/www/Classic_ipa_dashboard/cipastatic',
        },
        {
            alias => '/correctiontool/static', 
            path => '/var/www/correctiontool/web/static/',
        },
        {
            alias => '/lrc/static', 
            path => '/var/www/urlmap/static/',
        },
        {
            alias => '/IPALight_SCM/report/CI/', 
            path => '/var/www/IPALight_SCM/report/CI/',
        },
    ],
}

class{'python':
    version    => 'system',
    pip        => true,
    dev        => true,
}
package{'libmysqlclient-dev':
    ensure => present,
}
python::pip{'django':
    pkgname => 'django',
    ensure => '1.3.7',
    proxy => 'http://10.144.1.10:8080',
}
python::pip{'python-ldap':
    ensure => present,
    proxy => 'http://10.144.1.10:8080',
}
python::pip{'mysql-python':
    ensure => present,
    proxy => 'http://10.144.1.10:8080',
}
python::pip{'pyofc2':
    ensure => present,
    proxy => 'http://10.144.1.10:8080',
}
file{'/var/www/svnlog':
    ensure => 'link',
    target => '/home/lidong/dist/svnlog',
}
file{'/var/www/ILItfChg':
    ensure => 'link',
    target => '/home/lidong/dist/ILItfChg',
}
file{'/var/www/urlmap':
    ensure => 'link', 
    target => '/home/lidong/dist/urlmap',
}
file{'/var/www/IPALight_SCM':
    ensure => 'link', 
    target => '/home/lidong/dist/IPALight_SCM',
}
file{'/var/www/ILCIdashboard':
    ensure => 'link', 
    target => '/home/lidong/dist/ILCIdashboard',
}
file{'/var/www/correctiontool':
    ensure => 'link', 
    target => '/home/lidong/dist/correctiontool',
}
file{'/var/www/ClassicIpaDashboard':
    ensure => 'link', 
    target => '/home/lidong/dist/ClassicIpaDashboard',
}




