Puppet hyperctl Module
======================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-hyperctl.png)](https://travis-ci.org/jhoblitt/puppet-hyperctl)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Usage](#usage)
4. [Limitations](#limitations)
    * [Tested Platforms](#tested-platforms)
5. [Versioning](#versioning)
6. [Support](#support)
7. [Contributing](#contributing)
8. [See Also](#see-also)


Overview
--------

Manages the hyperctl utility for enabling/disabling hyperthreading


Description
-----------


Usage
-----

```puppet
include ::hyperctl
```

```puppet
class { '::hyperctl':
  state => 'enable',
}
```

```puppet
class { '::hyperctl':
  state => 'disable',
}
```

### Convience classes

These classes are simply wrappers largely intended for convience when using an
ENC.

```puppet
include ::hyperctl::enable
```
```puppet
include ::hyperctl::disable
```

Limitations
-----------

### Tested Platforms

* el6.x

Versioning
----------

This module is versioned according to the [Semantic Versioning
2.0.0](http://semver.org/spec/v2.0.0.html) specification.


Support
-------

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-hyperctl/issues)


Contributing
------------

1. Fork it on github
2. Make a local clone of your fork
3. Create a topic branch.  Eg, `feature/mousetrap`
4. Make/commit changes
    * Commit messages should be in [imperative tense](http://git-scm.com/book/ch5-2.html)
    * Check that linter warnings or errors are not introduced - `bundle exec rake lint`
    * Check that `Rspec-puppet` unit tests are not broken and coverage is added for new
      features - `bundle exec rake spec`
    * Documentation of API/features is updated as appropriate in the README
    * If present, `beaker` acceptance tests should be run and potentially
      updated - `bundle exec rake beaker`
5. When the feature is complete, rebase / squash the branch history as
   necessary to remove "fix typo", "oops", "whitespace" and other trivial commits
6. Push the topic branch to github
7. Open a Pull Request (PR) from the *topic branch* onto parent repo's `master` branch


See Also
--------

* [`hyperctl`](https://github.com/jhoblitt/hyperctl)
