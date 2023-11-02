# DearDiary Project with Flutter and Hive

## Overview

The **DearDiary** project is a simple mobile application developed using the Flutter framework and powered by the Hive database. The purpose of this application is to provide users with a digital diary where they can record their daily experiences, thoughts, and emotions, along with the option to rate their day. It supports all the basic CRUD (Create, Read, Update, Delete) operations to manage diary entries effectively.

## Features

The **DearDiary** app offers the following features:

1. **Create Entry:** Users can create new diary entries, documenting their daily experiences. They can write about what happened, how they felt, and other relevant details. Additionally, users can rate their day on a scale from 1 to 5, indicating their overall satisfaction.

2. **Read Entries:** Users can view and read their previously recorded diary entries. The entries are displayed in a chronological order, allowing users to reminisce about past days.

3. **Update Entry:** Users have the ability to edit and update their existing diary entries. This feature is useful for correcting mistakes or adding more details to past entries.

4. **Delete Entry:** Users can delete entries that they no longer wish to keep in their diary. This ensures that the diary remains clutter-free and only contains the most meaningful content.

5. **Data Persistence:** The app uses Hive as its local database to store diary entries. Hive is a fast and efficient NoSQL database for Flutter, ensuring that the user's data is securely stored on their device.

6. **User-Friendly Interface:** The app is designed with a user-friendly and intuitive interface, making it easy for users to navigate and interact with their diary entries.

## Technologies Used

The **DearDiary** app leverages the following technologies:

- **Flutter:** A popular open-source framework for building natively compiled applications for mobile, web, and desktop from a single codebase.

- **Hive:** A lightweight and efficient NoSQL database for Flutter that allows for fast data storage and retrieval.

- **Dart:** The programming language used for developing Flutter applications.

## Installation

To run the **DearDiary** app, follow these steps:

1. Clone or download the project repository from GitHub.
2. Make sure you have Flutter and Dart installed on your system.
3. Open a terminal in the project directory and run `flutter pub get` to install the project's dependencies.
4. Connect an Android or iOS device to your computer or use an emulator.
5. Run the app using `flutter run`.

## Usage

1. **Creating an Entry:** After launching the app, click on the "Create Entry" button to start writing about your day. Don't forget to rate it!
2. **Viewing Entries:** Click on the "View Entries" button to see your previously recorded diary entries.
3. **Updating an Entry:** In the "View Entries" screen, tap on the entry you want to update and click the "Edit" button.
4. **Deleting an Entry:** While viewing entries, swipe left on the entry you want to delete and confirm the action.
5. **Searching Entries:** Use the search feature to find specific entries by keywords, date, or rating.

## Conclusion

The **DearDiary** project is a simple yet effective Flutter app that allows users to keep a digital diary with ease. With its CRUD operations, user-friendly interface, and data persistence through Hive, it provides a convenient way to document daily experiences and emotions. Whether you want to reflect on the past, remember joyful moments, or track personal growth, **DearDiary** is your perfect digital companion.

<video src="demo.mp4" controls="controls" width="300" height="700">