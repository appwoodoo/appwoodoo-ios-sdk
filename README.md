# AppWoodoo iOS SDK

`v1.0`

Configure iOS apps remotely without resubmitting it to the Apple Store: enable extra features, conduct A/B tests or control any other behaviour from the air. __We give you the server and the tools, for free__.

In this package you will find the open source AppWoodoo iOS SDK together with an example app to try it all out. (Scroll down to see how.)

## Install

We designed our framework's installation to be really fast and easy. Save the `AppWoodoo.framework` folder to your projects directory, then simply drag&drop it to Xcode, and let the IDE do the rest. You can find it in the `AppWoodoo.framework.zip`.

After this add the following import to the header of the class where you want to use it.

`#import <AppWoodoo/Woodoo.h>`

If you take a closer look at the `Appwoodoo.framework` folder's content, you will see two public header files. The first one is `Woodoo.h`, this class should be more than enough for everything you want to do. But we decieded to let `WoodooSettingsHandler.h` to be public, too, in case you want to manually remove or save new settings to your application. If you want to take a deeper look into how it works, the source is available in the `Source` folder, too.

## Integrating the SDK

### Quick start

The best way is to download our Example app. Don't forget, that you are going to need your App key, you can find this on [your app's settings page](http://www.appwoodoo.com/woodoo/apps/). And of course don't forget to add some remote settings to your app. After you have all of those, you can choose between the following options.

#### 1. TakeOff with notification observer

Every single time, when AppWoodoo downloaded your settings, it automatically fires an event called `"WoodooArrived"`, which you can listen to like this:

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWoodooArrived:) name:@"WoodooArrived" object:nil];

You can ask AppWoodoo to download your settings with the following command. You have to change `<YOUR_APP_KEY>` to your App key.

    [Woodoo takeOff:<YOUR_APP_KEY>];

After that, please don't forget to implement the notification handler.

    /**
     * Woodoo arrived notification handler
     */
    
    - (void)onWoodooArrived:(NSNotification *)notification
    {
        if (![notification.name isEqualToString:@"WoodooArrived"]) {
            return;
        }
    
        // Do something with your settings.
    }

#### 2. TakeOff with callback method

The other option is to set a callback method, which AppWoodoo will launch after it finished downloading. You can use it like below. Of course, you have to change `<YOUR_APP_KEY>` to your App key here, too.

    [Woodoo takeOff:<YOUR_APP_KEY> target:self selector:@selector(woodooCallback:)];

After that, please don't forget to implement that method.

    /**
     * Woodoo downloaded callback handler
     */
    
    - (void)woodooCallback:(id *)sender
    {
        // Do something with your settings.
    }

## About

AppWoodoo is a free service, proudly built by [Tamas Dancsi](http://www.tamasdancsi.com/) and [Richard Dancsi](http://www.wimagguc.com/).

Please feel free to contribute: push back your improvements, or just send an e-mail to info-AT-appwoodoo.com with your ideas and suggestions.

Built in [Google Campus](http://www.campuslondon.com/) of London, [Betahaus](http://www.betahaus.de/) of Berlin and in several parks and cafes of Vienna.

## Lincese

Lincesed under The MIT License (MIT)

Copyright (c) 2013 AppWoodoo ([appwoodoo.com](www.appwoodoo.com))

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
