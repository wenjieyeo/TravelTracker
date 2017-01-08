Prerequisites
--------------------

This app runs on iOS 9.0 and above devices, these step-by-step instructions are written for Xcode 8.2. If you are using a previous version of Xcode, you may want to update before starting.


Get the source from Github
--------------------

Please download [Github app for Mac OS X](http://mac.github.com/)

Please login with your credentials with this app.

Please go to [TravelTracker](https://github.com/wenjieyeo/TravelTracker), you could find “Clone in Desktop”. Once you installed the Github app, it will open the app on your local and direct you to clone the source from github.com.


Installation via Cocoapods
--------------------

Step 1: Download CocoaPods
---------------

> You could check out [Introduction to CocoaPods](http://www.raywenderlich.com/12139/introduction-to-cocoapods) instead of this step.

[CocoaPods](http://cocoapods.org) is the dependency manager for Objective-C projects. It has thousands of libraries and can help you scale your projects elegantly.

CocoaPods is distributed as a ruby gem, and is installed by running the following commands in Terminal.app:

    $ sudo gem install cocoapods
    $ pod setup --verbose

> Depending on your Ruby installation, you may not have to run as `sudo` to install the cocoapods gem.

Step 2: Xcode workspace with CocoaPods
---------------

Now we need to generate workspace of our project using CocoaPods.

Project dependencies to be managed by CocoaPods are specified in a file called `Podfile`. You could find the Podfile at the top level directory. Please run the following command at the top level directory of the project in Terminal.app:


    $ pod install --verbose

After done, you could find TravelTracker.xcworkspace in the top level directory. Please use this file instead of TravelTracker.xcodeproj.

Thanks for following this guide!!!