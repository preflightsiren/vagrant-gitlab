

$gitlab_dbname  = 'gitlab_prod'
$gitlab_dbuser  = 'labu'
$gitlab_dbpwd   = 'labpass'


class {
  'gitlab':
    git_user          => 'git',
    git_home          => '/home/git',
    git_email         => 'git@example.com',
    git_comment       => 'GIT control version',
    # Default provider for ssh keys is 'source'
    # you can use also   => 'puppet:///modules/gitlab/file'
    # fileserving on http doesn't work yet
    # (http://projects.puppetlabs.com/issues/5783)
    # If you choose ssh_key_provider = 'content'
    # you can use directly => 'ssh-rsa AAA...'
    git_admin_pubkey  => '/tmp/vagrant-puppet/files/gitlab.pub',
    git_admin_privkey => '/tmp/vagrant-puppet/files/gitlab',
    gitolite_sources  => 'https://github.com/gitlabhq/gitolite.git',
    gitolite_branch   => 'gl-v320',
    gitlab_sources    => 'https://github.com/gitlabhq/gitlabhq.git',
    gitlab_branch     => 'stable',

    gitlab_user       => 'gitlab',
    gitlab_home       => '/home/gitlab',
    gitlab_comment    => 'GITLab',

    
    
    #FIXME mysql db not yet created, see https://github.com/sbadia/puppet-gitlab/issues/11
    gitlab_dbtype     => 'mysql',
    gitlab_dbname     => $gitlab_dbname,
    gitlab_dbuser     => $gitlab_dbuser,
    gitlab_dbpwd      => $gitlab_dbpwd,
    ldap_enabled      => false,
}

class { 'mysql::server':
  config_hash => { 'root_password' => 'robot' },
}
database_user { "root@localhost":
  password_hash => mysql_password('robot'),
  require => [Class['mysql::server'],Class['mysql::config']],
}
mysql::db {
  $gitlab_dbname:
    ensure   => 'present',
    charset  => 'utf8',
    user     => $gitlab_dbuser,
    password => $gitlab_dbpwd,
    host     => 'localhost',
    grant    => ['all'],
    require => [Class['mysql::server'],Class['mysql::config']],
}
exec { 'update repository':
      command => '/usr/bin/apt-get update',
}

Exec['update repository'] -> Class['mysql::server'] -> Class['mysql::config'] 
Class['mysql::config'] -> Database_user['root@localhost'] -> Mysql::Db[$gitlab_dbname] 
Mysql::Db[$gitlab_dbname] -> Class['Gitlab::Debian_packages']
