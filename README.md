# Student Management App

A Flutter and Firebase training project for managing student records through a simple mobile interface.

## Features

- Email and password authentication
- Google sign-in
- Account registration and password recovery
- Add and view student records
- Browse a student list and open detailed profiles
- Firebase Authentication and Cloud Firestore integration

## Tech stack

- Flutter and Dart
- Firebase Authentication
- Cloud Firestore
- Google Sign-In
- Google Fonts

## Project structure

The main implementation is organized under `lib/coded/`:

- `main_page.dart` — authentication entry point
- `login.dart` and `RegisterPage.dart` — sign-in and registration flows
- `forgotpasswordpage.dart` — password recovery
- `studentlistpage.dart` — student directory
- `student_detailspage.dart` — student details
- `addastudent.dart` — student creation form

## Run locally

1. Install Flutter and clone the repository.
2. Create your own Firebase project and configure it for the platforms you plan to run.
3. Replace the sample Firebase configuration in `lib/shared/constants.dart` with your project settings.
4. Install dependencies:

   ```bash
   flutter pub get
   ```

5. Start the app:

   ```bash
   flutter run
   ```

## Context

This project was completed as part of mentor training and focuses on practicing Flutter UI development, navigation, authentication, and Firebase-backed data flows.
