[![Build Status](https://travis-ci.org/pidjay/AdvancedCollectionView.svg)](https://travis-ci.org/pidjay/AdvancedCollectionView)
[![Version](http://img.shields.io/badge/version-0.2-red.svg?style=flat)](https://github.com/pidjay/AdvancedCollectionView)
[![codecov](https://codecov.io/gh/pidjay/AdvancedCollectionView/branch/master/graph/badge.svg)](https://codecov.io/gh/pidjay/AdvancedCollectionView)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)](https://github.com/pidjay/AdvancedCollectionView)

# AdvancedCollectionView

AdvancedCollectionView is a set of classes to help you handle the power of the collection view.

## Features

- [x] Basic data source
- [x] Composed data source
- [x] Segmented data source
- [x] Selectively animate items on data source update
- [x] Pinnable header
- [x] Sticky header
- [ ] Stretchable header
- [ ] Row & line spacing
- [ ] Section background color

If you have an idea for a new feature, please create a [new issue](https://github.com/pidjay/AdvancedCollectionView/issues/new).

## Requirements

### Build

Xcode 7, iOS 8 SDK or later

### Runtime

iOS 8.0

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate AdvancedCollectionView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "pidjay/AdvancedCollectionView" ~> 0.2
```

Run `carthage update` to build the framework and drag the built `AdvancedCollectionView.framework` into your Xcode project.

## FAQ

#### Can I use any kind of layout with AdvancedCollectionView?

Sadly, no. The purpose of this library is to give more flexibility than with UICollectionViewFlowLayout, not to make a silver bullet to create any kind of layout.

#### When are features X, Y and Z going to be released?

I don't know. I'm working on this project on my free time and as such I cannot commit on any kind of schedule. But if you feel like it, you could take matters into your own hands and do a pull request.

#### Should I upgrade the framework to the latest version?

AdvancedCollectionView is using Semantic Versioning and as such it follows specific guidelines for adding, deprecating or removing new features, but also when making incompatible changes in the API. So, as long as the release is not MAJOR (first number in the version changing), you should be safe. You can read more about it on [semver.org](http://semver.org).
