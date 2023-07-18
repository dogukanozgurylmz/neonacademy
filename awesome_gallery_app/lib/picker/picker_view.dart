import 'dart:io';

import 'package:awesome_gallery_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:image_picker/image_picker.dart';

class PickerView extends StatefulWidget {
  const PickerView({super.key});

  @override
  State<PickerView> createState() => _PickerViewState();
}

class _PickerViewState extends State<PickerView> {
  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: FlutterLogo(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Doğukan Özgür Yılmaz',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            const Text(
              '23 years old',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),
                );
              },
              child: const Text('Select Photo'),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryPage extends StatefulWidget {
  GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ImagePicker _imagePicker = ImagePicker();
  File image = File("");

  Future<void> _selectPhoto(BuildContext context) async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File file = File(pickedImage.path);
      if (file.existsSync()) {
        setState(() {
          image = file;
        });
      } else {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load selected image.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image.path == "" ? const SizedBox.shrink() : Image.file(image),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectPhoto(context),
              child: const Text('Select Photo from Gallery'),
            ),
            const SizedBox(height: 16),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FontPage(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right),
            ),
          ],
        ),
      ),
    );
  }
}

class FontPage extends StatefulWidget {
  const FontPage({super.key});

  @override
  State<FontPage> createState() => _FontPageState();
}

class _FontPageState extends State<FontPage> {
  String _selectedFont = "Roboto";

  TextStyle? _selectedFontTextStyle;

  final List<String> _myGoogleFonts = [
    "Abril Fatface",
    "Aclonica",
    "Alegreya Sans",
    "Architects Daughter",
    "Archivo",
    "Archivo Narrow",
    "Bebas Neue",
    "Bitter",
    "Bree Serif",
    "Bungee",
    "Cabin",
    "Cairo",
    "Coda",
    "Comfortaa",
    "Comic Neue",
    "Cousine",
    "Croissant One",
    "Faster One",
    "Forum",
    "Great Vibes",
    "Heebo",
    "Inconsolata",
    "Josefin Slab",
    "Lato",
    "Libre Baskerville",
    "Lobster",
    "Lora",
    "Merriweather",
    "Montserrat",
    "Mukta",
    "Nunito",
    "Offside",
    "Open Sans",
    "Oswald",
    "Overlock",
    "Pacifico",
    "Playfair Display",
    "Poppins",
    "Raleway",
    "Roboto",
    "Roboto Mono",
    "Source Sans Pro",
    "Space Mono",
    "Spicy Rice",
    "Squada One",
    "Sue Ellen Francisco",
    "Trade Winds",
    "Ubuntu",
    "Varela",
    "Vollkorn",
    "Work Sans",
    "Zilla Slab",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("font"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Pick a font (with a screen)'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FontPicker(
                        recentsCount: 10,
                        onFontChanged: (font) {
                          setState(() {
                            _selectedFont = font.fontFamily;
                            _selectedFontTextStyle = font.toTextStyle();
                          });
                          debugPrint(
                            "${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
                          );
                        },
                        googleFonts: _myGoogleFonts,
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Pick a font (with a dialog)'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: SizedBox(
                            width: double.maxFinite,
                            child: FontPicker(
                              showInDialog: true,
                              initialFontFamily: 'Anton',
                              onFontChanged: (font) {
                                setState(() {
                                  _selectedFont = font.fontFamily;
                                  _selectedFontTextStyle = font.toTextStyle();
                                });
                                debugPrint(
                                  "${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
                                );
                              },
                              googleFonts: _myGoogleFonts,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Pick a font: ',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.arrow_drop_down_sharp),
                        hintText: _selectedFont,
                        border: InputBorder.none,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FontPicker(
                              onFontChanged: (font) {
                                setState(() {
                                  _selectedFont = font.fontFamily;
                                  _selectedFontTextStyle = font.toTextStyle();
                                });
                                debugPrint(
                                  "${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
                                );
                              },
                              googleFonts: _myGoogleFonts,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Font: $_selectedFont',
                              style: _selectedFontTextStyle,
                            ),
                            Text(
                              'The quick brown fox jumped',
                              style: _selectedFontTextStyle,
                            ),
                            Text(
                              'over the lazy dog',
                              style: _selectedFontTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_circle_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  DateTime _selectedDate = DateTime(2023);

  Future<void> _onDateSelected(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });

      age(); // Yaş hesaplamasını tetikle
    }
  }

  int age() {
    DateTime now = DateTime.now();
    int yearsDifference = now.year - _selectedDate.year;

    // Doğum günü geçmediyse bir yaş azalt
    if (now.month < _selectedDate.month ||
        (now.month == _selectedDate.month && now.day < _selectedDate.day)) {
      yearsDifference--;
    }

    return yearsDifference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select your age:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onDateSelected(context),
              child: const Text('Pick Age'),
            ),
            const SizedBox(height: 16),
            Text(
              _selectedDate != null ? age().toString() : 'No date selected',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ColorPage(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  Color selectedColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        title: const Text('Color Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Change Background Color',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (value) {
                  setState(() {
                    selectedColor = value;
                  });
                },
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right),
            ),
          ],
        ),
      ),
    );
  }
}
