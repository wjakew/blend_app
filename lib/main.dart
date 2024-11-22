import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_merger/pdf_merger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Merger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          onPrimary: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'blend'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _files = [];

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _files.addAll(
            result.paths.where((path) => path != null).map((path) => path!));
      });
    }
  }

  void _mergeFiles() async {
    if (_files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No PDF files selected to merge.')),
      );
      return;
    }

    String? savePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Merged PDF',
      fileName: 'merged.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (savePath != null) {
      try {
        // Ensure the output directory exists
        final outputFile = File(savePath);
        if (!await outputFile.parent.exists()) {
          await outputFile.parent.create(recursive: true);
        }

        // Merge the PDFs
        await PdfMerger.mergeMultiplePDF(
            paths: _files, outputDirPath: savePath);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF files merged successfully!')),
        );
      } catch (e) {
        // Handle any errors during the merging process
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error merging files: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.purple,
        actions: [
          TextButton(
            onPressed: _pickFiles,
            child: Row(
              children: const [
                Icon(Icons.add, color: Colors.white),
                SizedBox(width: 4),
                Text('Add PDFs', style: TextStyle(color: Colors.white)),
              ],
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ReorderableListView(
          children: [
            for (int index = 0; index < _files.length; index++)
              Container(
                key: ValueKey(_files[index]),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    _files[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
          ],
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final String item = _files.removeAt(oldIndex);
              _files.insert(newIndex, item);
            });
          },
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          FloatingActionButton(
            onPressed: _mergeFiles,
            tooltip: 'Merge',
            child: const Icon(Icons.merge_type),
          ),
          Positioned(
            bottom: 8,
            child: const Text(
              'Merge!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
