# DearDiary Project with Flutter, Firebase Authentication, and Cloud Firestore

## Overview

The **DearDiary** project is a mobile application developed using the Flutter framework and powered by Firebase Authentication and Cloud Firestore. The purpose of this application is to provide users with a digital diary where they can record their daily experiences, thoughts, and emotions, along with the option to rate their day. It supports all the basic CRUD (Create, Read, Update, Delete) operations to manage diary entries effectively, now with comprehensive user authentication features, including account creation and password reset.

## Features

The **DearDiary** app offers the following features:

1. **User Authentication:** Users can create an account, log in, and reset their password securely using Firebase Authentication. This ensures that each user's diary entries are private and accessible only to them.

2. **Account Creation:** New users can easily create an account by providing their email and a secure password.

3. **Login:** Existing users can log in using their registered email and password.

4. **Password Reset:** Users can reset their password by providing their email, receiving a password reset link in their inbox, and setting a new password.

5. **Create Entry:** Authenticated users can create new diary entries, documenting their daily experiences. They can write about what happened, how they felt, and other relevant details. Additionally, users can rate their day on a scale from 1 to 5, indicating their overall satisfaction.

6. **Read Entries:** Users can view and read their previously recorded diary entries. The entries are displayed in a chronological order, allowing users to reminisce about past days.

7. **Update Entry:** Users have the ability to edit and update their existing diary entries. This feature is useful for correcting mistakes or adding more details to past entries.

8. **Delete Entry:** Users can delete entries that they no longer wish to keep in their diary. This ensures that the diary remains clutter-free and only contains the most meaningful content.

9. **Data Persistence:** The app uses Firebase Cloud Firestore to securely store diary entries in the cloud. This ensures that users' data is available from anywhere and remains safe even if they change devices.

10. **User-Friendly Interface:** The app is designed with a user-friendly and intuitive interface, making it easy for users to navigate and interact with their diary entries.

## Technologies Used

The **DearDiary** app leverages the following technologies:

- **Flutter:** A popular open-source framework for building natively compiled applications for mobile, web, and desktop from a single codebase.

- **Firebase Authentication:** Firebase provides secure and easy-to-implement user authentication, ensuring data privacy for each user, including account creation and password reset.

- **Firebase Cloud Firestore:** Firebase Cloud Firestore is a NoSQL cloud database that allows for efficient data storage and retrieval with real-time synchronization.

- **Dart:** The programming language used for developing Flutter applications.

## Installation

To run the **DearDiary** app, follow these steps:

1. Clone or download the project repository from GitHub.
2. Make sure you have Flutter and Dart installed on your system.
3. Set up a Firebase project on the Firebase Console (https://console.firebase.google.com/).
4. Configure your Flutter project to use Firebase by adding your project's configuration files (google-services.json for Android and GoogleService-Info.plist for iOS) to the project's root directory.
5. Open a terminal in the project directory and run `flutter pub get` to install the project's dependencies.
6. Connect an Android or iOS device to your computer or use an emulator.
7. Run the app using `flutter run`.

## Usage

1. **User Authentication:**

   - Upon launching the app, users can create a new account by clicking on the "Create Account" button and providing their email and a secure password.
   - Existing users can log in with their registered email and password.
   - Users can reset their password by providing their email, receiving a password reset link in their inbox, and setting a new password.

2. **Creating an Entry:** After authenticating, click on the "Create Entry" button to start writing about your day. Don't forget to rate it!

3. **Viewing Entries:** Click on the "View Entries" button to see your previously recorded diary entries.

4. **Updating an Entry:** In the "View Entries" screen, tap on the entry you want to update and click the "Edit" button.

5. **Deleting an Entry:** While viewing entries, swipe left on the entry you want to delete and confirm the action.

6. **Searching Entries:** Use the search feature to find specific entries by keywords, date, or rating.

## Conclusion

The **DearDiary** project is a comprehensive Flutter app that allows users to keep a digital diary with the added benefits of Firebase Authentication and Cloud Firestore. With its CRUD operations, user-friendly interface, and cloud-based data storage, it provides a convenient way to document daily experiences and emotions securely. Whether you want to reflect on the past, remember joyful moments, or track personal growth, **DearDiary** is your perfect digital companion with enhanced privacy and accessibility, including account management and password reset functionality.

<div>
<image src="assets/ss2.png" width="200" highet="100">
<image src="assets/ss1.png" width="200" highet="100">
