import 'package:awesome_gallery_app/custom_alert/alert_dialog_view.dart';
import 'package:awesome_gallery_app/custom_buttons/custom_buttons_view.dart';
import 'package:awesome_gallery_app/custom_container/custom_container_view.dart';
import 'package:awesome_gallery_app/custom_datatable/custom_datatable_view.dart';
import 'package:awesome_gallery_app/custom_scroll/custom_scroll_view.dart';
import 'package:awesome_gallery_app/custom_search/custom_search_view.dart';
import 'package:awesome_gallery_app/custom_segment/custom_segment_view.dart';
import 'package:awesome_gallery_app/custom_slider/custom_slider_view.dart';
import 'package:awesome_gallery_app/custom_switch/custom_switch_view.dart';
import 'package:awesome_gallery_app/custom_tabbar/custom_tabbar_view.dart';
import 'package:awesome_gallery_app/custom_textfield/custom_textfield_view.dart';
import 'package:awesome_gallery_app/linear_progress/linear_progress_view.dart';
import 'package:awesome_gallery_app/page_control/page_control_view.dart';
import 'package:awesome_gallery_app/picker/picker_view.dart';
import 'package:awesome_gallery_app/progress/progress_view.dart';
import 'package:awesome_gallery_app/stack_views/stack_view.dart';
import 'package:flutter/material.dart';

import 'custom_gridview/custom_gridview_page.dart';
import 'custom_listview/custom_listview_page.dart';
import 'custom_stepper/custom_stepper_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomNavigateButton(
                navigate: CustomContainerView(),
                text: "Container",
              ),
              const CustomNavigateButton(
                navigate: CustomButtonsView(),
                text: "Buttons",
              ),
              const CustomNavigateButton(
                navigate: CustomTextFieldView(),
                text: "Textfield",
              ),
              const CustomNavigateButton(
                navigate: CustomSliderView(),
                text: "Slider",
              ),
              const CustomNavigateButton(
                navigate: CustomSwitchView(),
                text: "Switch",
              ),
              const CustomNavigateButton(
                navigate: CustomStepperView(),
                text: "Stepper",
              ),
              const CustomNavigateButton(
                navigate: PageControlView(),
                text: "Page Control",
              ),
              const CustomNavigateButton(
                navigate: CustomSegmentView(),
                text: "Segmented Control",
              ),
              const CustomNavigateButton(
                navigate: AlertDialogView(),
                text: "Alert Dialog",
              ),
              const CustomNavigateButton(
                navigate: ProgressView(),
                text: "Circular Progress",
              ),
              const CustomNavigateButton(
                navigate: LinearProgressView(),
                text: "Linear Progress",
              ),
              const CustomNavigateButton(
                navigate: StackView(),
                text: "Stack Views",
              ),
              const CustomNavigateButton(
                navigate: CustomScrollsView(),
                text: "Scroll View",
              ),
              const CustomNavigateButton(
                navigate: CustomTabbarView(),
                text: "Tabbar",
              ),
              const CustomNavigateButton(
                navigate: PickerView(),
                text: "Picker",
              ),
              CustomNavigateButton(
                navigate: CustomDataTableView(),
                text: "DataTable",
              ),
              const CustomNavigateButton(
                navigate: CustomSearchView(),
                text: "SearchBar",
              ),
              const CustomNavigateButton(
                navigate: CustomGridViewPage(),
                text: "GridView",
              ),
              CustomNavigateButton(
                navigate: CustomListViewPage(),
                text: "ListView",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNavigateButton extends StatelessWidget {
  final Widget navigate;
  final String text;
  const CustomNavigateButton({
    super.key,
    required this.navigate,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => navigate,
        ));
      },
      child: Text(text),
    );
  }
}
