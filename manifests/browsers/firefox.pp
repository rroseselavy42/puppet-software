# firefox.pp
# Install Firefox for OS X or Ubuntu
# http://www.mozilla.org/en-US/firefox/new
#

class software::browsers::firefox (
  $ensure  = $software::params::software_ensure,
  $version = $software::params::firefox_version,
  $url     = $software::params::firefox_url,
) inherits software::params {

  validate_string($ensure)

  case $::operatingsystem {
    'Darwin': {
      validate_string($version)
      validate_string($url)

      package { "Firefox-${version}":
        ensure   => $ensure,
        provider => appdmg,
        source   => $url,
      }
    }
    'Ubuntu': {
      package { 'firefox':
        ensure => $ensure,
      }
    }
    default: {
      fail("The ${name} class is not supported on ${::operatingsystem}.")
    }
  }

}
