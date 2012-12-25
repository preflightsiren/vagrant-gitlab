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
      gitlab_sources    => 'https://github.com/gitlabhq/gitlabhq.git',
      gitlab_user       => 'gitlab',
      gitlab_home       => '/home/gitlab',
      gitlab_comment    => 'GITLab',
      gitlab_dbtype     => 'mysql',
      gitlab_branch     => 'stable',
      db_user           => 'root',
      db_password       => 'robot',
      admin_user        => 'admin',
      admin_password    => 'password',
      admin_name        => 'bobot',
      admin_email       => 'bobot@gmail.com',
      ldap_enabled       => true,
      ldap_host          => '9msn.net',
      ldap_base          => 'OU=Accounts,DC=9msn,DC=net',
      ldap_uid           => 'sAMAccountName',
      ldap_port          => '389',
      ldap_method        => 'plain',
      ldap_bind_dn       => '',
      ldap_bind_password => '',
  }

class { 'mysql::server':
  config_hash => { 'root_password' => 'robot' },
}
database_user { "root@localhost":
  password_hash => mysql_password('robot'),
  require => Class['mysql::server'],
}
# exec { 'apt-get update':
#       command => '/usr/bin/apt-get update',
# }

Exec['apt-get update'] -> Class['mysql::server'] -> Class['mysql::config'] -> Class['gitlab']