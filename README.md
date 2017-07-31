## JointDB
[![CircleCI](https://circleci.com/gh/orthodoc/jointdb/tree/master.svg?style=svg)](https://circleci.com/gh/orthodoc/jointdb/tree/master)[![codecov.io](https://codecov.io/github/orthodoc/jointdb/coverage.svg?branch=master)](https://codecov.io/github/orthodoc/jointdb?branch=master) [![Code Climate](https://codeclimate.com/github/orthodoc/jointdb/badges/gpa.svg)](https://codeclimate.com/github/orthodoc/jointdb) [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT) [![Dependency Status](https://david-dm.org/lathonez/clicker/status.svg)](https://david-dm.org/orthodoc/jointdb) [![devDependency Status](https://david-dm.org/lathonez/clicker/dev-status.svg)](https://david-dm.org/orthodoc/jointdb#info=devDependencies)[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)


## Install

You need to be running [the latest node LTS](https://nodejs.org/en/download/) or newer

```bash
git clone https://github.com/orthodoc/jointdb.git
cd jointdb
npm install
npm start         # start the application (ionic serve)
```

Running as root? You probably shouldn't be. If you need to: `npm run postinstall` before `npm start`. [clicker#111](https://github.com/lathonez/clicker/issues/111) for more info.

## Run Unit Tests
```bash
npm test          # run unit tests
```

## Run E2E
```
npm run e2e
```

## Blog Topics

* [Unit testing walkthrough](http://lathonez.com/2017/ionic-2-unit-testing/)
* [E2E testing walkthrough](http://lathonez.com/2017/ionic-2-e2e-testing/)
* [Removing assets from the APK](http://lathonez.com/2016/cordova-remove-assets/)

## Contribute
* PRs are welcome.
* Follow [conventional commits](https://conventionalcommits.org/) and [semantic versioning](http://semver.org/#summary)
* To commit your code use: `npm run commit` or `git-cz`

## Help

* If you can't get it working, raise an issue

## Acknowledgements

* This started out as a fork of [Clicker](https://github.com/lathonez/clicker) project by [lathonez](https://github.com/lathonez) and would not be possible without it. The entire credit for setting up the testing framework goes to him and other project contributors.

## Changelog

See the changelog [here](https://github.com/orthodoc/jointdb/blob/master/CHANGELOG.md)

## Updated for:

* **@angular/*:** 4.1.3
* **@angular/cli:**: 1.1.2
* **@ionic-angular:** 3.4.2
