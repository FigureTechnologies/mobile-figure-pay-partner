# Figure Pay Partner
Figure Pay Partner is a mobile application built with the purpose of testing deeplinking to Figure Pay without the need of account creation or two-factor authorization login requirements. We have removed the need for account authorization while retaining the same functionality used to deeplink to and from Figure Pay. Since there is no account creation or authorization requirements, mock data is exchanged in place of real, secure account information.

Figure Pay Partner mirrors the Figure Pay app but with limited functionality. Upon running Figure Pay Partner you will be taken a dashboard filled with dummy data simulating a logged in user. 

<p align="center">
    <img src="https://github.com/FigureTechnologies/mobile-figure-pay-partner/blob/main/screenshots/dashboard.png" alt="Dashboard" style="width:200px;">
</p>

Deeplinking to Figure Pay Partner with the correct `path` and `query_parameters` will result in a dialog pop up asking the user to authorize the use of sharing data with the app that issued the deeplink. Selecting **Authorize** will call the `callback_uri` passed through the original deeplink resulting in a deeplink back to the original app.

<p align="center">
    <img src="https://github.com/FigureTechnologies/mobile-figure-pay-partner/blob/main/screenshots/authorization.png" alt="authorization" style="width:200px;">
</p>

Trying to deeplink to Figure Pay Partner with an incorrect `path` or `query_parameters` will result in a dialog pop up with details of the error.

# Installation
Figure Pay Partner is built using Flutter and runs on both iOS and Android devices. Since it is built using Flutter, a Flutter development environment is necessary to build and run this application for iOS and Android.

The Flutter documentation for installing Flutter is quite thorough and we highly recommend following their instructions to setup your environment. The Flutter installation guide can be found [here](https://flutter.dev/docs/get-started/install). If this your first time using Flutter, we suggest following the guide through the **Test drive** section.

We recommend using a Mac for your development machine as it will allow you to run the application on both iOS and Android devices, while Windows machines only allow for Android. 

As far as a preference of IDE, the developers at Figure have had equal success using [Android Studio](https://flutter.dev/docs/development/tools/android-studio) and [VS Studio Code](https://flutter.dev/docs/development/tools/vs-code).

If unable to setup a development environment using Flutter, please contact us and we will send over the built app for Android and iOS. Although we highly recommend setting up the development environment to allow for a better experience experimenting with deeplinking.

# Getting started
Once your Flutter development environment has been configured and `flutter doctor -v` checks out, you are ready to run the Figure Pay Partner app on either a physical or simulated/emulated device. Be sure to run Figure Pay Partner on the same device as the app you are attempting to deeplink from.

## Bundle Identifier
In order to run this on an iOS device, you will need to go into Xcode and change the bundle identifier to be something unique.

The current bundle identifier is set to: `com.example.mobile.figurepaypartner.mobileFigurePayPartner`

Changing that should allow for the creation of a valid provisioning profile using your own Apple developer account.

## iOS Device Version
If using an iOS device running on iOS 13, make sure it is updated to 13.4 at least. 
## Configuration
A configuration file for Figure Pay Partner is located at `lib/config/config.dart`. The values in the configuration file are non-essential to running the app (*however you will be unable to deeplink if a value is not supplied for each key*). These are *quality-of-life* values used to make the simulated experience more realistic. When finally deeplinking to Figure Pay, these values found in `config.dart` will automatically be determined based on user information and the `identity_id` paramenter in the deeplink. Adjust the configuration file for a better experience.

Be sure to edit these values before running the Figure Pay Partner app. If you edit these values while the app is running and attempt to hot reload, the values will not change.
- `app_name` is the name of the app you are deeplinking from. This is the name of your app, not Figure Pay Partner. This is initially set to the value `Partner App`.
- `reference_uuid` is the unique identifier passed back by Figure Pay which is used to retrieve the secure account information for a specific user. The `reference_uuid` returned by Figure Pay Partner will be dummy data. This UUID will be provider by Figure for each partner and will need to be be added to the configuration file (`config.dart`) mentioned above.
## Deeplinking
The deeplink itself can be broken up into multiple parts:\
`{scheme}://{host}/{path}?{query_parameters}`\
Figure Pay and Figure Pay Partner use a **different** `scheme` and `host` to distinguish between the two apps, but use the same `path`. NOTE: `query_parameters` are the same for **Retrieving User Account Metadata** but different for **Managing Invoices**
### Figure Pay Deeplinks
[Retrieving User Account Metadata](https://figuretechnologies.github.io/docs-figurepay-partner-api/getting-user-account).

`figurepay://figure.com/figurepay/getUser?callback_uri={CALLBACK_URI}&identity_id={PARTNER_IDENTITY_UUID}`
- `scheme`: figurepay
- `host`: figure.co<span>m
- `path`: figurepay/getUser
- `query_parameters`: callback_uri={CALLBACK_URI}&identity_id={PARTNER_IDENTITY_UUID}

[Managing Invoices](https://figuretechnologies.github.io/docs-figurepay-partner-api/managing-invoices)

`figurepay://figure.com/figurepay/invoices/{INVOICE_UUID}?callback_uri={CALLBACK_URI}`
- `scheme`: figurepay
- `host`: figure.co<span>m
- `path`: figurepay/invoices/{INVOICE_UUID}
- `query_parameters`: callback_uri={CALLBACK_URI}

### Figure Pay Partner Deeplink
**Retrieving User Account Metadata**

`figurepaypartner://figurepaypartner.com/figurepay/getUser?callback_uri={CALLBACK_URI}&identity_id={PARTNER_IDENTITY_UUID}`
- `scheme`: figurepaypartner
- `host`: figurepaypartner.co<span>m
- `path`: figurepay/getUser
- `query_parameters`: callback_uri={CALLBACK_URI}&identity_id={PARTNER_IDENTITY_UUID}

**Managing Invoices**

NOTE: - For Partner app, `invoice_uuid` is not provided in the path because the actual invoice is paid using the [Partner Simulations - Authorize Transaction]() endpoint from the calling application after returning from the Partner app (via `callback_uri`). The `callback_uri` is called when the "Back to" button is pressed on "Transaction Successful" screen. The `amount` (double) and `app_name` is passed instead to complete the simulated invoice authorization. This data, of course, would normally be retreived via `invoice_uuid` on the Figure Pay app. 

`figurepaypartner://figurepaypartner.com/figurepay/invoices/?app_name={APP_NAME}&amount={AMOUNT}&callback_uri={CALLBACK_URI}`
- `scheme`: figurepaypartner
- `host`: figurepaypartner.co<span>m
- `path`: figurepay/invoices/
- `query_parameters`: app_name={APP_NAME}&amount={AMOUNT}&callback_uri={CALLBACK_URI}
## Scheme and Host
As mentioned in [Deeplinking](#deeplinking), Figure Pay and Figure Pay Partner use a different `scheme` and `host`. This means that while testing deeplinking to and from Figure Pay Partner, you will need to use the `scheme` and `host` listed in [Figure Pay Partner Deeplink](#figure-pay-partner-deeplink).

When your testing with Figure Pay Partner is complete and you are ready to deeplink to Figure Pay, you will need to change your `scheme` and `host` to match what is listed in [Figure Pay Deeplink](#figure-pay-deeplink).

The `path` and `query_parameters`, however, will remain the same.

## Callback Deeplink
The callback deeplink is what Figure Pay Partner and Figure Pay use to deeplink back to the original app (your app). This is provided to us in your initial deeplink as `callback_uri`. When we launch this `callback_uri` we also append `query_paramenters` of our own consisting of a `reference_uuid`. 

This callback will take the form of:\
`{CALLBACK_URI}?reference_uuid={REFERENCE_UUID}`
- `CALLBACK_URI` is the same `callback_uri={CALLBACK_URI}` passed in [Figure Pay Partner Deeplink](#figure-pay-partner-deeplink) and [Figure Pay Deeplink](#figure-pay-deeplink).
- `reference_uuid` is the unique identifier passed back by Figure Pay which is used to retrieve the secure account information for a specific user. In Figure Pay Partner `reference_uuid` is set inside of [config.dart](https://github.com/FigureTechnologies/mobile-figure-pay-partner/blob/main/lib/config/config.dart). More details can be found in the [Configuration](#configuration) section.
## A Note about Hot Reloading
While hot reloading is a powerful tool used with Flutter, it can cause certain issues to arise with the state management system used to code Figure Pay Partner. We advise refraining from hot reloading when building and running Figure Pay Partner to avoid any unintended interactions.
# Transition to Figure Pay
In order to transition to Figure Pay from Figure Pay Partner after testing has concluded, you will need to [change the scheme and host](#change-the-scheme-and-host) and [provide a valid `identity_id`](#provide-a-valid-identity-id).
## Change the Scheme and Host
Since Figure Pay and Figure Pay Partner use a different `scheme` and `host` for their deeplink, you will need to follow the instructions outlined [here](#scheme-and-host) to choose the correct `scheme` and `host` for Figure Pay.
## Provide a Valid `identity_id`
Even though Figure Pay Partner does not use the `identity_id` to retrieve its mock data, we still recommend using the `identity_id` provided to you by Figure as this will be necessary for Figure Pay.
