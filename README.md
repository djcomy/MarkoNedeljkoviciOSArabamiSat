# Arabami Sat 

Project made for final coding challenge

Hello, this project is a sample project for a car gallery. It should allow user to Login with custom made Username and password, or grant a login via GoogleSignIn. From the main window user can upload a new car with an image and different kind of information. Once user add a car, navigation should head it back to main view where UICollectionView is implemented to show added cars. Once use clicks to chosen car, it should show detailed information to the user. Application should work in offline mode, as Realm library is implemented to store data localy, and if there is not internet connection, application should show cars anyway.

-------------------------------------------------------------

Commits:
1. Initial commit.
2. User Login/Google override login with allowing to enter to the main screen.
3. Bulding main screen UI and functions. Adding extensions for the view. Making MVVM, custom Cell for UICollectionView. Making AddNewCarController, and sending data to Firebase Storage/Firestore. Fetching data into UICollectionView. Adding additional CocoaPods neaded.
4. Little bit of refactoring

-------------------------------------------------------------
////TODO: 

1. Check why realm won't present data in UIViewController from stored database (some data is showing in car details VC). 
2. Add additional login (Facebook)
3. Implement swipe side menu from left side. Some other options should be implemented, as well User's photo in circle on top of it.
4. Add more possible info for the cars

-------------------------------------------------------------

Cocoapods used: 

Firebase
Firebase/Auth
Firebase/Database
Firebase/Firestore
Firebase/Storage'
Firebase/Crashlyti
Firebase/Analytics
GoogleSignIn'
RealmSwift
---------------------------------------------

