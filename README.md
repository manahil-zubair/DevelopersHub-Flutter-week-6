# DevelopersHub Flutter Internship - Week 6 Task & Final Project

This is my final project for the sixth week of the mobile development internship. The main focus was to refactor our previous application using the Provider package for robust state management and add professional UI/UX final enhancements.

## What I Did This Week

- **State Management with Provider:** Completely eliminated `setState` by refactoring the task management app to utilize the `Provider` package to handle all state changes globally.

- **Optimized Folder Architecture:** Restructured the project into a professional directory structure containing separate folders for `models`, `providers`, and `screens` to separate presentation from business logic.
- **Custom Splash Screen Animations:** Enhanced the startup flow using an `AnimationController` to run smooth `FadeTransition` and `ScaleTransition` animations while asynchronously loading tasks from disk.

- **Real-time Statistics Dashboard:** Built a responsive statistics row displaying Pending, Completed, and Total counts that update dynamically using Provider's reactive getters.

- **Interactive UI/UX Transitions:** Added satisfying micro-interactions, including `AnimatedContainer` for task card color shifts, `AnimatedSwitcher` for swapping checkbox states, and `AnimatedDefaultTextStyle` for crossing out completed tasks.

- **Improved Task Deletion & Undo:** Designed a custom SnackBar with an "Undo" action that automatically dismisses after 5 seconds using `persist: false` and instantly clears active SnackBars if multiple tasks are deleted consecutively.

## Concepts Used

- **Provider & ChangeNotifier:** Employed as the unified state manager to handle real-time UI rebuilds efficiently across different screens.

- **Single Source of Truth:** Centralized the application’s state within `TaskProvider` so that the stats dashboard, task cards, and deletion history are always in perfect sync.

- **Explicit & Implicit Animations:** Implemented visual feedback for users utilizing `AnimationController`, `Tween` mapping, transitions, and implicit Flutter animation widgets.

- **Asynchronous Local Storage Integration:** Combined `SharedPreferences` with the Provider initialization sequence to load offline task data seamlessly during the splash screen transition.

- **Clean Code & Separation of Concerns:** Decoupled data models (`task_model.dart`), local storage operations (`storage.dart`), business logic (`task_provider.dart`), and visual screens.

## How to Run

1. Clone the repository
2. Navigate to the project folder
3. Install dependencies by running `flutter pub get`
4. Open VS Code or Android Studio, connect your phone or start an emulator, and press the green Run button.

## Author

- **Name:** Manahil Zubair
- **Intern ID:** DHC-5322
- **Program:** DevelopersHub Flutter Internship
