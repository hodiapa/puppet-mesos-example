class profile::zookeeper {
  #include ::java
  #include ::jdk_oracle
  include profile::oracle_java8
  class { '::zookeeper':
    #require => Class['java'],
    #require => Class['jdk_oracle'],
    require => Class['profile::oracle_java8']
  }
  contain '::zookeeper'
}
