# DonaldDump
iOS App - Quotes of dumbest things trump said, with push notifications(The Daily Dump)from a OneSignal server. Quotes are parsed from a restful API: [Tronald Dump](https://www.tronalddump.io)

## Installation for Push notifications

### Requirements 
* Must be a paid [registered apple developer](https://developer.apple.com)
* Must have an iOS device running iOS10+ for rich notification support

#### STEP 1 
* On first launch (only) of application, an AppID instance token is printed in the console. 
* Replace this token in Appdelegate.swift

#### STEP 2
* Register and follow the steps for settings up iOS SDK at [Onesignal.com](https://documentation.onesignal.com/docs/ios-sdk-setup)
  - note: You will need to generate push notification certificates

