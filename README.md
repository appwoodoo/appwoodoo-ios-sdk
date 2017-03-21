# Appwoodoo iOS SDK

`v3.2.0`

Appwoodoo is the simplest way to add an admin panel to existing or new apps, to edit their content.

## Quick start

To see the example app at work, open the `Example` folder, run a Cocoapods update and then run the app using XCode on any device or emulator.

   ![example app](Docs/example_app.png)

## Features:

* [Rich-text pages: stories, news, terms and conditions pages](http://www.appwoodoo.com/docs/ios_stories_and_pages/)
* [Remote settings and A/B tests](http://www.appwoodoo.com/docs/ios_quick_start/)
* [Push notifications](http://www.appwoodoo.com/docs/ios_push_notifications/)
* Dialogs & scheduled pop-ups
* Photos & galleries (coming soon)

## Usage

Adding Appwoodoo to any iOS app is as simple as adding this one line to your Cocoapods Podfile:

### Podfile

```ruby
platform :ios, '8.0'
use_frameworks!

target 'Example' do
  pod 'Appwoodoo', '~> 3.2.0'
end
```

See the [full documentation](http://www.appwoodoo.com/docs/ios_quick_start/) here (or check out the Example app's code for details).

## Recent version highlights

* `3.2.0`: Initial Dialogs feature
* `3.0.1`: Initial StoryWall feature
* `2.6.0`: Support for notification sounds

## About

Feel free to open tickets on this package or change the code in any way. You can also send an e-mail to info-AT-appwoodoo.com with your ideas and suggestions.

Copyright (c) 2013-2017 Appwoodoo ([appwoodoo.com](www.appwoodoo.com))