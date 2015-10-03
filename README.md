# Appwoodoo iOS SDK

`v1.1.2`

Configure iOS apps remotely without resubmitting to the Apple Store: enable extra features, send push notifications, conduct A/B tests or control any other behaviour from the air.

In this package you will find the open source Appwoodoo iOS SDK together with an example app to try it all out. (Scroll down to see how.)

## Install

1. Install with [Cocoa Pods](https://cocoapods.org/)

Put the following line to your `Podfile` and run `pod install`.

```ruby
pod 'Appwoodoo', '~> 1.1.2'
```

2. Alternatively: drag&drop

We designed our framework's installation to be really fast and easy. Save the `Appwoodoo.framework` folder to your project's directory, simply drag&drop it to Xcode and let the IDE do the rest.

Insert the following import to the header of the class where you want to use it.

```objective-c
#import <Appwoodoo/Woodoo.h>
```

If you take a closer look at the `Appwoodoo.framework` folder's content, you will see two public header files. The first one is `Woodoo.h`, this class should be more than enough for everything you want to do. But we decieded to let `WoodooSettingsHandler.h` to be public, too, in case you want to manually remove or save new settings to your application.

## Integrating the SDK

### Quick start

The best way is to download our Example app. You are going to need your Appwoodoo `APP Key`, please find this on [your app's settings page](http://www.appwoodoo.com/woodoo/apps/) (you may need to [sign up first](http://www.appwoodoo.com/)). Once you have it, paste it to the Example application's `AppDelegate.m` file.

```objective-c
NSString *const APPKey = @"<INSERT_YOUR_APP_KEY_HERE>";
```

Don't forget to add some `Remote settings` while you're on the application's page as well. To retrieve these settings in the app, you can choose between the following options.

#### 1. TakeOff with notification observer

Every single time, when Appwoodoo downloaded your settings, it automatically fires an event called `"WoodooArrived"`, which you can listen to like this:

```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWoodooArrived:) name:@"WoodooArrived" object:nil];
```

You can ask Appwoodoo to download your settings with the following command. You have to change `<YOUR_APP_KEY>` to your App key.

```objective-c
[Woodoo takeOff:<YOUR_APP_KEY>];
```

Don't forget to implement the notification handler as well. Once your settings are downloaded, you can access them with the `[Woodoo getSettings]` call.


```objective-c
/**
* Appwoodoo downloaded your settings - notification handler
*/

- (void)onWoodooArrived:(NSNotification *)notification {
// Do something with your settings.
}
```

#### 2. TakeOff with callback method

The other option is to set a callback method, which Appwoodoo will call once it finished downloading. You can use it like below. Of course, you have to change `<YOUR_APP_KEY>` to your App key here, too.

```objective-c
[Woodoo takeOff:<YOUR_APP_KEY> target:self selector:@selector(woodooCallback:)];
```

Don't forget to implement that method as well.

```objective-c
/**
* Appwoodoo downloaded your settings - callback handler
*/

- (void)woodooCallback:(id *)sender {
// Do something with your settings.
}
```

#### 3. Logging

You can turn logging on/off in Appwoodoo with the `Woodoo:setHideLogs:` call.

```objective-c
/**
* Turn Appwoodoo logging on/off
*/
[Woodoo setHideLogs:NO];
```

### Push notifications

At Appwoodoo our goal is to help mobile developers to write successful applications easier, faster and more maintaneable. Since enabling push notifications can be a massive pain, we implemented an easier way to solve this issue in only a couple of minutes. For details please read the detailed [documentation of Appwoodoo iOS push notification service](http://www.appwoodoo.com/help/ios-push-notifications/)

## About

Appwoodoo is a free service, proudly built by [Tamas Dancsi](http://www.tamasdancsi.com/) and [Richard Dancsi](http://www.wimagguc.com/).

Please feel free to contribute: push back your improvements, or just send an e-mail to info-AT-appwoodoo.com with your ideas and suggestions.

Built in [Google Campus](http://www.campuslondon.com/) of London, [Betahaus](http://www.betahaus.de/) of Berlin and in several parks and cafes of Vienna.

## License

Licensed under The MIT License (MIT)

Copyright (c) 2015 Appwoodoo ([appwoodoo.com](www.appwoodoo.com))

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
