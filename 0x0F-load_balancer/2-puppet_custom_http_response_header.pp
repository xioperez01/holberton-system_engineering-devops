# creating a custom HTTP header response with Puppet.

exec { 'exec0':
  cmd => 'sudo sudo apt-get update -y',
  path    => ['/usr/bin', '/bin'],
  return => [0,1]
}

exec { 'exec1':
  require => Exec['exec0'],
  cmd => 'sudo apt-get install nginx -y',
  path    => ['/usr/bin', '/bin'],
  return => [0,1]
}

exec { 'exec2':
  require => Exec['exec1'],
  cmd => 'sudo sed -i "s/server_name _;/server_name _;\n\tadd_header X-Served-By \$hostname;/" /etc/nginx/sites-enabled/default',
  path    => ['/usr/bin', '/bin'],
  return => [0,1]
}

exec { 'exec3':
  require => Exec['exec2'],
  cmd => 'sudo service nginx start',
  path    => ['/usr/bin', '/bin', '/usr/sbin'],
  return => [0,1]
}
