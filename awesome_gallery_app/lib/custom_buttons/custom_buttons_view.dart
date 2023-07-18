import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class CustomButtonsView extends StatefulWidget {
  const CustomButtonsView({super.key});

  @override
  State<CustomButtonsView> createState() => _CustomButtonsViewState();
}

const List<String> list = <String>['Yedek Çağır', 'Kasabalıları uyar'];

class _CustomButtonsViewState extends State<CustomButtonsView>
    with SingleTickerProviderStateMixin {
  String dropdownValue = list.first;
  Color currentColor = Colors.purple;
  bool isNull = true;
  bool isShake = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buttons"),
      ),
      body: Center(
        child: Column(
          children: [
            _customDropdownButton(),
            _customImageButton(context),
            _customColorizeButton(),
            _customIsActiveButtom(),
            ShakeWidget(
              duration: const Duration(milliseconds: 100),
              shakeConstant: ShakeHardConstant1(),
              autoPlay: isShake ? true : false,
              enableWebMouseHover: true,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isShake = !isShake;
                  });
                },
                child: Text('Shake Button'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _customIsActiveButtom() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isNull = !isNull;
            });
          },
          child: Text(!isNull ? "Pasif yap" : "Aktif yap"),
        ),
        ElevatedButton(
          onPressed: isNull ? null : () {},
          child: Text(isNull ? "Aktif değil" : "Aktif"),
        ),
      ],
    );
  }

  GestureDetector _customColorizeButton() {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          currentColor = Colors.yellow;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          currentColor = Colors.purple;
        });
      },
      onTapCancel: () {
        setState(() {
          currentColor = Colors.purple;
        });
      },
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: currentColor,
        ),
        child: Text(
          'Vurgulanan Düğme',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  SizedBox _customImageButton(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Günlük özel teklifler'),
                    ],
                  ),
                ),
              );
            },
          );
        },
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                width: 2,
                color: Colors.blue,
              )),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.red.withOpacity(0.5),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://picsum.photos/1000/1000',
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  'Ortadaki Yazı',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> _customDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
