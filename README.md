# Bind module for Puppet

[![Puppet Forge](http://img.shields.io/puppetforge/v/panaceya/bind.svg)](https://forge.puppetlabs.com/panaceya/bind)
[![Build Status](https://travis-ci.org/panaceya/puppet-bind.png?branch=master)](https://travis-ci.org/panaceya/puppet-bind)

**Manages bind configuration under Debian / Ubuntu and CentOS.**

This module is provided by Panaceya, and forked from [Camptocamp](http://www.camptocamp.com/), because him not support CentOS.
This is very bad, but I plan to fully support CentOS.

## Exec paths

In order to not have any path problem, you should add the following line in
some globally included .pp file:

    Exec {
      path => '/some/relevant/path:/some/other:...',
    }

For example:

    Exec {
      path => '/bin:/sbin:/usr/sbin:/usr/bin',
    }


## Classes

* bind

### bind

This class must be declared before using the definitions in this module.

## Definitions

* bind::a
* bind::generate
* bind::mx
* bind::record
* bind::zone

### bind::a

Creates an A record (or a series thereof).

    bind::a { 'Hosts in example.com':
      ensure    => 'present',
      zone      => 'example.com',
      ptr       => false,
      hash_data => {
        'host1' => { owner => '192.168.0.1', },
        'host2' => { owner => '192.168.0.2', },
      },
    }

### bind::generate

Creates a $GENERATE directive for a specific zone

    bind::generate {'a-records':
      zone        => 'test.tld',
      range       => '2-100',
      record_type => 'A',
      lhs         => 'dhcp-$', # creates dhcp-2.test.tld, dhcp-3.test.tld …
      rhs         => '10.10.0.$', # creates IP 10.10.0.2, 10.10.0.3 …
    }

### bind::mx

Creates an MX record.

    bind::mx {'mx1':
      zone     => 'domain.ltd',
      owner    => '@',
      priority => 1,
      host     => 'mail.domain.ltd',
    }


### bind::record

Creates a generic record (or a series thereof).

    bind::record {'CNAME foo.example.com':
      zone        => 'foo.example.com',
      record_type => 'CNAME',
      hash_data   => {
        'ldap'      => { owner => 'ldap.internal', },
        'voip'      => { owner => 'voip.internal', },
      }
    }

### bind::zone

Creates a zone.

    bind::zone {'test.tld':
      zone_contact => 'contact.test.tld',
      zone_ns      => 'ns0.test.tld',
      zone_serial  => '2012112901',
      zone_ttl     => '604800',
      zone_origin  => 'test.tld',
    }

### bind::key 

Creates a key for dynamic zones.
The 'secret' value is the key generated by dnssec-keygen.

    bind::key { 'key_dyn.test.tld':
        ensure => present,
        secret => 'xUjDQqpBHao/o7mR2dza2/Tv2DQVo9pEuMfMwhdfzeaEFZAvwA='
    }

    bind::zone {'dyn.test.tld':
      zone_contact => 'contact.test.tld',
      zone_ns      => 'ns0.test.tld',
      zone_serial  => '2012112901',
      zone_ttl     => '604800',
      zone_origin  => 'dyn.test.tld',
      is_dynamic   => true,
      allow_update => ['key_dyn.test.tld']
    }

## Contributing

Please report bugs and feature request using [GitHub issue
tracker](https://github.com/panaceya/puppet-bind/issues).

For pull requests, it is very much appreciated to check your Puppet manifest
with [puppet-lint](https://github.com/panaceya/puppet-bind/issues) to follow the recommended Puppet style guidelines from the
[Puppet Labs style guide](http://docs.puppetlabs.com/guides/style_guide.html).

## License

Copyright (c) 2013 <mailto:puppet@camptocamp.com> All rights reserved.
Copyright (c) 2014 <mailto:gt.admin@rcstar.net> All rights reserved.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

