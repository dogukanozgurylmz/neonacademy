import 'package:flutter/material.dart';

class CustomStepperView extends StatefulWidget {
  const CustomStepperView({super.key});

  @override
  State<CustomStepperView> createState() => _CustomStepperViewState();
}

class _CustomStepperViewState extends State<CustomStepperView> {
  int currentStep = 0;
  int stepCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stepper"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stepper(
                physics: const BouncingScrollPhysics(),
                currentStep: currentStep,
                onStepContinue: () {
                  setState(() {
                    if (currentStep < 11) {
                      currentStep += 1;
                      stepCount += 5;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep -= 1;
                      stepCount -= 5;
                    }
                  });
                },
                steps: [
                  Step(
                    title: const Text('Arka Plan'),
                    content: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.pink,
                      child: Text("Step count: $stepCount"),
                    ),
                    isActive: currentStep == 0,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: Text("Step count: $stepCount"),
                        ),
                      ),
                    ),
                    isActive: currentStep == 1,
                  ),
                  Step(
                    title: const Text('Düğmeler'),
                    content: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // İşlemler
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                Text("Step count: $stepCount"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            // İşlemler
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isActive: currentStep == 2,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 3,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 4,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 5,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 6,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 7,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 8,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 9,
                  ),
                  Step(
                    title: const Text('Ayırıcı'),
                    content: Text("Step count: $stepCount"),
                    isActive: currentStep == 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
