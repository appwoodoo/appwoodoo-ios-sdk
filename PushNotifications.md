# Appwoodoo iOS push notification service

`v1.1`

At Appwoodoo our goal is to help mobile developers to write successful applications easier, faster and more maintaneable. Since enabling push notifications can be a massive pain, we implemented an easier way to solve this issue in only a couple of minutes. Before doing anything please check this list to see if you’re missing something and then dive in.

_What do I need?_

- Valid apple developer account.
- Keep in mind, that push notifications won’t work in a simulator, you have to use a real device to test.

## I. SSL Certificate

To obtain a new certificate, go to the [Certificates, Identifiers & Profiles](https://developer.apple.com/account/ios/identifiers/bundle/bundleList.action) on Apple's developer portal and click on the plus button to add a new one.

Make sure to choose `Explicit App ID` and add a valid bundle ID, otherwise you won't be able to receive push notifications. Check `Push Notifications` on the bottom and click on `Submit`.

Now select the `App ID` you've just created and click on `Edit` and scroll down to the `Push Notifications` section. You need to request a certificate. Open `Keychain Access` on your computer and select `Certificate Assistant` > `Request a Certificate From a Certificate Authority`.

Enter your `Email` and a `Common Name`, leave the `CA Email` field empty and select `Saved to disk`. Click Continue and save the certificate.

Go back to the `Developer Portal` and click on the `Create Certificate` button. Hit `Continue`, choose your `.CSR` file and click on `Generate`. Download your certificate, double-click on it and you're ready to go.

## II. Provisioning

You need a development provision profile to test, so go to the [Provisioning profiles](https://developer.apple.com/account/ios/profile/profileList.action?type=limited) section in `Member Center` and add a new development profile with the plus button.

Click `Continue`, select your `App ID`, select the certificates and devices you want to enable, give it a name and click on `Generate`, download it and double-click on it.

Go to `Xcode`, update your build settings to use the previously created profile and run your application on a real device. Your application should start and ask your permission to send you notifications.

## III. Appwoodoo setup

### 1. APNS setup

Once you have a valid certificate, you can fill the APN service details under [your application's page on Appwoodoo](http://www.appwoodoo.com/woodoo/apps/).

1. Name

Pick any name, that you prefer.

2. Certificate

You need to create a .pem file from the `aps_development.cer` file that you've created in the I. step. You can do this by entering the following in a terminal window.

```sh
$ cd ~/Desktop
$ openssl x509 -in aps_development.cer -inform der -out ApsDevCert.pem
```

You need to copy&paste the .pem file's content like this:

```
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
```

3. Private key

You need to open `Keychain Access` again, and choose the `Keys` section under `Categories` on the left side. Find the private key that has a valid `Apple Development iOS Push Services` certificate in it, which matches your bundle ID.

Select both the private key and the certificate, click on them with the right button and select `Export 2 items...`. Save it as `Certificates.p12` and enter a passphrase. Don't forget this phrase, you will need it in a minute. Open up terminal again and run the following commands.

```sh
$ cd ~/Desktop
$ openssl pkcs12 -in Certificates.p12 -out pushcert.pem -nodes -clcerts
```

You need to copy&paste the .pem file's content like this:

```
-----BEGIN ENCRYPTED PRIVATE KEY-----
...
-----END ENCRYPTED PRIVATE KEY-----
```

4. Passphrase

You need to enter the passphrase you've been using earlier to create the .p12 file.

### 2. Sending notifications

Navigate to [your application's page on Appwoodoo](http://www.appwoodoo.com/woodoo/apps/) again. Under notifications, you can click on `Add Notification`. Select the `Service` and play around with the different settings and hit `Save`. Now open it from the list and click on the `Push now!` button when you want to send out the notification.

## IV. Application setup

You need to register for remote notification types first, so that the OS knows you’re about to receive push notifications. You can do this in the `application:didFinishLaunchingWithOptions:` function.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
/**
* Push notification support
* Registering for user notifications
*/
#ifdef __IPHONE_8_0
UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge) categories:nil];
[[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
UIRemoteNotificationType types = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
[[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
#endif

return YES;
}
```

Additionally, you need to implement the following method, too.

```
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
[application registerForRemoteNotifications];
}
#endif
```

To check whether registration was successful, you need to implement the following delegate functions.

```objective-c
/**
* Push notification support
* Gets called if registering was successful
*/

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];

/**
* Push notification support
* Registers the device token for the given APPKey
*/
[Woodoo registerDeviceToken:@"5a59f5f1d0aa96a88db25b670b1bcda0978d580de63258f7d910e5e85c2df338" forAPPKey:@"xVAB30pUHD57QxM4ZB1pBYNlh8BMngbK"];
}

/**
* Push notification support
* Gets called if registering was unsuccessful
*/

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
NSLog(@"Registering for push notifications did fail with error: %@", error.localizedDescription);
}
```

As you can see, if the registration was successful, you need to call the `Woodoo:registerDeviceToken:forAPPKey:` method with the returned device token to make sure Appwoodoo knows the given device's identifier, otherwise it couldn't push remote notifications to it.

To test if everything works, you can receive notifications by implementing the following method. Push one based on the III./2. section.

```objective-c
/**
* Push notification support
* Gets called if the application received a remote notification
*/

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
NSLog(@"Remote notification received successfully");

UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great" message:@"Remote notification received successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
[alert show];
}
```

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
