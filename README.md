# AppWoodoo iOS SDK 1.0

## About Appwoodoo

AppWoodo helps to make A/B testing a lot easier for you. It lets to download remote settings right into your app, so you don't have to change anything in your code and there's no need to create multiple builds for the same version.

## Install

We designed our framework's installation to be really fast and easy. Save the `AppWoodoo.framework` folder to your projects directory, then simply drag&drop it to Xcode, and let the IDE do the rest. You can find it in the `AppWoodoo.framework.zip`.

After this add the following import to the header of the class where you want to use it.

`#import <AppWoodoo/Woodoo.h>`

## Documentation

If you take a closer look at the `Appwoodoo.framework` folder's content, you will see two public header files. The first one is `Woodoo.h`, this class should be more than enough for everything you want to do. But we decieded to let `WoodooSettingsHandler.h` to be public, too, in case you want to manually remove or save new settings to your application. If you want to take a deeper look into how it works, the source is available in the `Source` folder, too.

#### Where do I start?

The best way is to download our Example app. Don't forget, that you are going to need your App key, you can find this on [your app's settings page](http://www.appwoodoo.com/woodoo/apps/). And of course don't forget to add some remote settings to your app. After you have all of those, you can choose between the following options.

#### 1. TakeOff with notification observer

Every single time, when AppWoodoo downloaded your settings, it automatically fires an event called `"WoodooArrived"`, which you can listen to like this:

`[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWoodooArrived:) name:@"WoodooArrived" object:nil];`

You can ask AppWoodoo to download your settings with the following command. You have to change `<YOUR_APP_KEY>` to your App key.

`[Woodoo takeOff:<YOUR_APP_KEY>];`

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

`[Woodoo takeOff:<YOUR_APP_KEY> target:self selector:@selector(woodooCallback:)];`

After that, please don't forget to implement that method.

    /**
     * Woodoo downloaded callback handler
     */
    
    - (void)woodooCallback:(id *)sender
    {
        // Do something with your settings.
    }
