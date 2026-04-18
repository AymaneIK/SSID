# Flutter Project Explanation: SSID Mobile App

This document explains everything you need to know about the Flutter application we built for your SSID project. It breaks down what Flutter is, what every folder does, and how the files connect to each other.

---

## 1. What is Flutter?

**Flutter** is a framework developed by Google that allows you to build applications for multiple platforms (iOS, Android, Web, Windows, etc.) using a single programming language called **Dart**. 

Instead of using traditional UI components from each operating system, Flutter draws every single pixel on the screen itself. This gives us immense flexibility to create customized, highly-styled interfaces (like the green medical layout from your design) that look identical on an iPhone and a Samsung Galaxy.

### Key Concepts in Flutter:
- **Widgets:** Everything you see on a Flutter screen is a "Widget". A button is a widget, text is a widget, a layout column is a widget, and even the entire screen itself is a widget. We build the app by putting widgets inside other widgets (like a tree).
- **Stateful vs Stateless Widgets:** 
  - *StatelessWidget:* A screen or component that never changes its appearance after it is drawn (e.g., a simple text label or an icon).
  - *StatefulWidget:* A screen or component that can change dynamically (e.g., a checkbox, a screen with a tab bar, or a search bar where you type).

---

## 2. Project Folder Structure

Inside the `mobile_app/` folder, you will find several standard Flutter directories. The most important one is the **`lib`** folder, which contains 100% of the code we wrote for the application.

Here is what the other main folders do:
- **`android / ios / macos / windows / web`**: These folders are generated automatically by Flutter. They contain the native code to launch the app on those specific platforms. You almost never need to touch these manually.
- **`pubspec.yaml`**: This is the configuration file for the app. It tracks the project name, version, and external libraries (dependencies) we need to download, like `fl_chart` (for graphs), `google_fonts` (for typography), and `iconsax_flutter` (for icons).

---

## 3. The `lib/` Directory (Where the magic happens)

The `lib` folder is organized into a modular architecture. This keeps the code clean, readable, and easy to maintain as the project grows.

### Step-by-Step File Explanations:

#### A. Entry Point: `lib/main.dart`
This is the starting point of the entire application. When the app launches, it looks for the `main()` function in this file. 
- **What it does:** It sets up the primary application window, applies the global "Theme" (colors and fonts), and then tells the app to display the `AppShell` as the first screen.

#### B. Navigation: `lib/navigation/app_shell.dart`
This acts as the main container for the app's user interface. 
- **What it does:** It holds the `BottomNavBar` (the menu at the bottom) and uses something called an `IndexedStack` to keep all the pages loaded in memory. When you tap a button on the bottom bar, the shell instantly switches the visible screen between the Dashboard, Profile, and Directory.

#### C. Core Components: `lib/core/`
This directory holds reusable logic, models, and styling that are shared across the entire app. It prevents us from writing the same code twice.
- **`theme/app_theme.dart`**: This is the visual rulebook. It defines all the exact color codes (like your specific `#4A7C59` primary green), the background colors, font styles (Inter), and the shape styles for the rounded cards.
- **`models/*.dart`**: These files (`doctor.dart`, `patient.dart`, `hospital.dart`, `medical_record.dart`) define the "blueprint" for the data. Since we don't have a real backend connected yet, these files also contain `mock()` data—hardcoded pretend data so we can see what the UI looks like with real text.
- **`widgets/*.dart`**: Reusable mini-components. For example, `section_header.dart` is the title text with a "Détails" button. Since this header design is used on multiple pages, we made it a reusable widget here.

#### D. Features (The Modules): `lib/features/`
This represents the core modules implemented so far based on the *Cahier des Charges*. The architecture is designed to be easily expandable when adding the remaining modules in the future. Currently, the following core features are fully built:

**1. `dashboard/` (Dashboard et Analyse)**
- **`dashboard_page.dart`**: The main assembly line for the home screen. It stacks all the widgets vertically in a scrollable list.
- **`widgets/health_summary_card.dart`**: The small, square cards showing Heart Rate, Oxygen, etc.
- **`widgets/weekly_chart.dart`**: Draws the interactive sleep tracking bar chart using the `fl_chart` library.
- **`widgets/trend_card.dart`**: Calculates and displays whether a specific health metric (like weight) is going up or down.

**2. `medical_profile/` (Profil Médical)**
- **`medical_profile_page.dart`**: Handles the patient's medical dossier layout.
- **`widgets/personal_info_card.dart`**: The top section showing the patient's name, avatar, and ID.
- **`widgets/medical_data_card.dart`**: The grid cards that show quick data (Cholesterol, Blood Type) with mini-graphs.
- **`widgets/*_card.dart` (Medications, History, Lab Results)**: These are designed as expandable "accordions" showing the files from the patient's record.

**3. `medical_directory/` (Répertoire Médical Public)**
- **`medical_directory_page.dart`**: The most complex screen. It manages its own internal state, meaning it listens to the search bar and the category tabs (`Médecins` vs `Hôpitaux`) and actively filters the lists of data accordingly.
- **`widgets/search_bar_widget.dart`**: A customized text input field that listens for typing to perform searches.
- **`widgets/specialty_chips.dart`**: The horizontal scrolling buttons (Cardiologie, Pédiatrie) used for filtering the doctors list.
- **`widgets/doctor_card.dart` & `hospital_card.dart`**: Complex highly-styled cards that layout all the specific information like the doctor's name, specialty, schedule, rating, and visual badges indicating if a hospital has an emergency room.

---

## 4. How Everything Connects (The Flow)

If a user opens the app and searches for a doctor, here is exactly what the code is doing behind the scenes:

1. **`main.dart`** starts the app and loads **`app_shell.dart`**.
2. **`app_shell.dart`** looks at the bottom navigation bar and sees that the user clicked the third icon, so it brings **`medical_directory_page.dart`** to the front of the screen.
3. The directory page looks into **`lib/core/models/doctor.dart`** to fetch the list of all available doctors.
4. When the user types in the **`search_bar_widget.dart`**, the directory page receives that text and instantly filters the list of doctors to only show matches.
5. The page then uses the **`doctor_card.dart`** widget to draw a beautiful visual representation for each remaining doctor in the filtered list, applying the colors defined in **`app_theme.dart`**.

This modular architecture makes the project robust, scalable, and easy to connect to a real backend database in the future!
