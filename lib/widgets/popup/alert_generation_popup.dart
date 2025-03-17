import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';
import 'package:vigilant_vision/widgets/textfield/customTextfield.dart';

class AlertGenerationPopup extends StatefulWidget {
  const AlertGenerationPopup(
      {super.key,
      required this.title,
      this.location,
      this.alertClass,
      this.peopleDetected,
      this.action,
      required this.buttonText});

  final String title;
  final String? location;
  final String? alertClass;
  final int? peopleDetected;
  final String? action;
  final String buttonText;

  @override
  _AlertGenerationPopupState createState() => _AlertGenerationPopupState();
}

class _AlertGenerationPopupState extends State<AlertGenerationPopup> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController peopleDetectedController = TextEditingController();
  late TextEditingController alertActionController = TextEditingController();
  late TextEditingController customLocationController = TextEditingController();

  String? selectedLocation;
  String? selectedClass;
  bool isCustomLocation = false;

  final List<String> locationOptions = ["LocationA", "LocationB", "Other"];
  final List<String> classOptions = [
    "Crowd",
    "Smoke",
    "Queue",
    "Masks",
    "General"
  ];

  @override
  void initState() {
    super.initState();

    if (widget.location != null && locationOptions.contains(widget.location)) {
      selectedLocation = widget.location;
      isCustomLocation = false;
    } else {
      selectedLocation = "Other"; // Force "Other" selection
      isCustomLocation = true;
      customLocationController.text =
          widget.location ?? ""; // Store custom location
    }

    selectedClass = widget.alertClass;
    peopleDetectedController =
        TextEditingController(text: widget.peopleDetected?.toString() ?? "");
    alertActionController = TextEditingController(text: widget.action ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ClrUtils.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: ClrUtils.icon, width: 3),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: SizeCons.getWidth(context) * 0.9,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: widget.title,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: ClrUtils.textFifth,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: "Alert Location",
                  fontWeight: FontWeight.w500,
                  color: ClrUtils.textFourth,
                ),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  items: locationOptions.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                      isCustomLocation = value == "Other";
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ClrUtils.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ClrUtils.textTertiary),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? "Please select a location" : null,
                ),
                if (isCustomLocation) ...[
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: customLocationController,
                    hintText: "Enter custom location...",
                    validator: (value) {
                      if (isCustomLocation &&
                          (value == null || value.isEmpty)) {
                        return "Please enter a location";
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 10),
                CustomText(
                  text: "Alert Class",
                  fontWeight: FontWeight.w500,
                  color: ClrUtils.textFourth,
                ),
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  items: classOptions.map((alertClass) {
                    return DropdownMenuItem(
                      value: alertClass,
                      child: Text(alertClass),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClass = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ClrUtils.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ClrUtils.textTertiary),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? "Please select an alert class" : null,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: "People Detected",
                  fontWeight: FontWeight.w500,
                  color: ClrUtils.textFourth,
                ),
                CustomTextField(
                  controller: peopleDetectedController,
                  hintText: "Enter number...",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: "Action",
                  fontWeight: FontWeight.w500,
                  color: ClrUtils.textFourth,
                ),
                CustomTextField(
                  controller: alertActionController,
                  hintText: "Enter action to take...",
                  validator: (value) => value == null || value.isEmpty
                      ? "Action is required"
                      : null,
                ),
                const SizedBox(height: 22),
                CustomButton(
                    text: widget.buttonText,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String location = isCustomLocation
                            ? customLocationController.text
                            : selectedLocation ?? "Unknown";
                        String alertClass = selectedClass ?? "General";
                        String peopleCount =
                            peopleDetectedController.text.isNotEmpty
                                ? peopleDetectedController.text
                                : "0";
                        String action = alertActionController.text;

                        print(
                            "Alert Generated:\nLocation: $location\nClass: $alertClass\nPeople: $peopleCount\nAction: $action");
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
