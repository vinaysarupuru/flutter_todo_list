# Flutter Todo List

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Flutter Version](https://img.shields.io/badge/Flutter-%5E3.7.2-blue.svg)](https://flutter.dev/)
[![Riverpod](https://img.shields.io/badge/Riverpod-%5E2.6.1-purple.svg)](https://riverpod.dev/)

A modern, feature-rich Todo List application built with Flutter and Riverpod. Keep track of your tasks with a beautiful, responsive interface that works across all platforms. This project is open source and welcomes contributions from the community.

## ✨ Features

- ✅ Create, read, update, and delete todos
- 🌓 Dark/Light theme support
- 🕒 Timestamp for each todo
- 📱 Cross-platform (iOS, Android, Web, Desktop)
- 💾 State management with Riverpod
- ⚡ Fast and responsive UI

## 🛠️ Tech Stack

- **Framework**: Flutter ^3.7.2
- **State Management**: flutter_riverpod ^2.6.1
- **Utilities**: 
  - uuid: ^4.5.1 (Unique IDs)
  - intl: ^0.20.2 (Date formatting)
  - file_picker: ^10.0.0 (File operations)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/vinaysarupuru/flutter_todo_list.git
```

2. Navigate to the project directory
```bash
cd flutter_todo_list
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart           # Entry point
├── models/            
│   └── todo_entity.dart # Todo data model
├── providers/          
│   ├── theme_provider.dart  # Theme state management
│   └── todo_provider.dart   # Todo state management
├── screens/           
│   └── todo_list_screen.dart # Main todo list screen
└── widgets/           
    └── todo_item_widget.dart # Individual todo item widget
```

## 📱 Screenshots

[Coming Soon]

## ⚙️ Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  file_picker: ^10.0.0
  intl: ^0.20.2
  uuid: ^4.5.1
```

## 🤝 Contributing

We love your input! We want to make contributing to Flutter Todo List as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

### Development Process

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Any Contributions You Make Will Be Under the MIT License

When you submit code changes, your submissions are understood to be under the same [MIT License](http://choosealicense.com/licenses/mit/) that covers the project. Feel free to contact the maintainers if that's a concern.

### Report Bugs Using GitHub's [Issue Tracker](https://github.com/vinaysarupuru/flutter_todo_list/issues)

We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/vinaysarupuru/flutter_todo_list/issues/new); it's that easy!

### Write Bug Reports With Detail, Background, and Sample Code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### MIT License Summary

- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Private use
- ❌ Liability
- ❌ Warranty

## 🔒 Security Policy

### Reporting a Vulnerability

If you discover a security vulnerability within Flutter Todo List, please send an e-mail to the maintainers. All security vulnerabilities will be promptly addressed.

## 🤝 Code of Conduct

### Our Pledge

We as members, contributors, and leaders pledge to make participation in our community a harassment-free experience for everyone, regardless of age, body size, visible or invisible disability, ethnicity, sex characteristics, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Riverpod for efficient state management
- All contributors who help improve this project
- The open source community for continuous inspiration and support
