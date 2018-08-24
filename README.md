# Yes Order App
# Multiple Model Redux

Flutter code example implemented by redux apply to multiple model.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

## Database : Firebase

## Feature
- Product list
- Order history list
- Order detail list
- Add product for mock data
- Cutoff stock

## Dependencies
- Firebase
- Firebase Sign in
- Redux

## Getting Run
1. Setup Flutter
2. Clone the repo
- git clone https://github.com/taipower/multiplemodel_redux.git
- cd multiplemodel_redux
3. Setup Firebase
- You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
Once your Firebase instance is created, you'll need to enable anonymous authentication.
- Go to the Firebase Console for your new instance.
- Click "Authentication" in the left-hand menu.
- Click the "sign-in method" tab.
- Click "Anonymous" and enable it.
3.1 Running on Android
- Create an app within your Firebase instance for Android, with package name com.taipower.multiplemodelredux .
- Download google-services.json . 
- place google-services.json into multiplemodel_redux/android/app/.
3.2 Running on IOS
- Create an app within your Firebase instance for iOS, with package name com.yourcompany.news
- Follow instructions to download GoogleService-Info.plist, and place it into newsbuzz/ios/Runner in XCode
- Open newsbuzz/ios/Runner/Info.plist. Locate the CFBundleURLSchemes key. The second item in the array value of this key is specific to the Firebase instance. Replace it with the value for REVERSED_CLIENT_ID from GoogleService-Info.plist
4. Run the app
Goto root project run
$ flutter run
5. Play App
- Add product for Mock Data click setting => Add your product
- For payment credit card number 4242424242424242 is successful, other is fail

## Run Unit Test
- Goto root project run
- flutter test

## Reference
- https://github.com/MSzalek-Mobile/weight_tracker/tree/master
- https://github.com/roughike/inKino
