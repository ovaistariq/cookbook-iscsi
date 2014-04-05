name 'iscsi'
maintainer 'Eric G. Wolfe'
maintainer_email 'wolfe21@marshall.edu'
license 'Apache 2.0'
description 'Installs configures open-iscsi for storage arrays'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'
depends 'multipath'
depends 'sysctl'

%w(redhat centos scientific amazon oracle).each do |os|
  supports os, '>= 5.0'
end
