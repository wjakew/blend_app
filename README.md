# blend_app
## PDF Merger Application

## Overview
The PDF Merger application allows users to select multiple PDF files and merge them into a single PDF document. The application features a user-friendly interface with drag-and-drop functionality, a list view for managing selected files, and a gradient background for an appealing visual experience.

## Features
- **Select PDF Files**: Users can select multiple PDF files from their device using a file picker.
- **Merge PDFs**: The application merges the selected PDF files into a single document.
- **Reorder Files**: Users can reorder the selected files before merging.
- **Gradient Background**: The app features a visually appealing purple-black gradient background.

## Technology Stack
- **Flutter**: The application is built using the Flutter framework for cross-platform mobile development.
- **Dart**: The programming language used for developing the application.
- **File Picker**: A package used to select files from the device.
- **PDF Merger**: A package used to merge multiple PDF files into one.
- **Path Provider**: A package used to access the file system for saving the merged PDF.

## Installation

### Prerequisites
- Flutter SDK installed on your machine.
- An IDE such as Android Studio, Visual Studio Code, or IntelliJ IDEA.

### Steps to Run the Application
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Install the dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

## Usage
1. Launch the application on your device or emulator.
2. Tap the "Add PDFs" button to select PDF files from your device.
3. Reorder the selected files if necessary by dragging them in the list.
4. Tap the "Merge!" button to merge the selected PDF files.
5. Choose a location and name for the merged PDF file when prompted.

## Contributing
Contributions are welcome! If you have suggestions or improvements, please create a pull request or open an issue.

## License
This project is licensed under the MIT License.

## Acknowledgments
- Special thanks to the authors of the packages used in this project.