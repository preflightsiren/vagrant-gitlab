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
  }

