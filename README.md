# 📱 Loyalty Card Storage App

A modern Flutter application for storing and managing loyalty cards digitally. Built with Flutter and Firebase, featuring a clean Material 3 design and secure authentication.

## ✨ Features

- 🔐 **Secure Authentication**
  - Email/Password authentication
  - Real-time validation
  - Error handling
  - Loading state management

- 💳 **Card Management**
  - Add new loyalty cards
  - View card details
  - Update existing cards
  - Delete unwanted cards

- 🎨 **Modern UI/UX**
  - Material 3 design
  - Smooth animations
  - Responsive layout
  - Dark/Light theme support
  - Google Fonts integration

- 🔄 **Data Persistence**
  - Local storage with Hive
  - Firebase integration
  - Real-time updates

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK (3.0.0 or higher)
- Firebase account
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/Kunj-Mori/Loyalty-Card-Storage-App-.git
cd Loyalty-Card-Storage-App-
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Firebase**
   - Create a new Firebase project
   - Add Android/iOS apps in Firebase console
   - Download and place the `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) in the respective directories
   - Enable Email/Password authentication in Firebase console

4. **Run the app**
```bash
flutter run
```

## 🛠️ Technical Stack

- **Frontend**: Flutter
- **State Management**: Flutter Bloc
- **Backend**: Firebase
- **Local Storage**: Hive
- **Authentication**: Firebase Auth
- **UI Components**: Material 3, Google Fonts
- **Animations**: Flutter Animate

## 📂 Project Structure

```
lib/
├── bloc/           # State management
├── models/         # Data models
├── screens/        # UI screens
├── services/       # Business logic
├── widgets/        # Reusable components
└── main.dart       # Entry point
```

## 🔧 Configuration

### Environment Setup

1. **Firebase Configuration**
   - Update Firebase configuration in `firebase_options.dart`
   - Enable required Firebase services in Firebase console

2. **Local Storage**
   - Hive adapters are automatically initialized
   - Data is stored in local device storage

### Build Commands

- **Debug Build**
```bash
flutter build apk --debug
```

- **Release Build**
```bash
flutter build apk --release
```

- **Web Build**
```bash
flutter build web
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors who helped in the development

## 📱 Screenshots

[Add your app screenshots here]

## 📞 Contact

Kunj Mori - [GitHub](https://github.com/Kunj-Mori)

Project Link: [https://github.com/Kunj-Mori/Loyalty-Card-Storage-App-](https://github.com/Kunj-Mori/Loyalty-Card-Storage-App-)
