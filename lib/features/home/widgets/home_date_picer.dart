import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:taskati/core/styles/app_colors.dart';

class HomeDatePicer extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const HomeDatePicer({super.key, required this.onDateSelected});

  @override
  State<HomeDatePicer> createState() => _HomeDatePicerState();
}

class _HomeDatePicerState extends State<HomeDatePicer> {
  final DatePickerController _controller = DatePickerController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      _controller.jumpToSelection();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now().subtract(const Duration(days: 30)),
      height: 90,
      width: 64,
      initialSelectedDate: DateTime.now(),
      selectionColor: AppColors.primaryColor,
      selectedTextColor: Colors.white,
      calendarType: CalendarType.gregorianDate,
      controller: _controller,
      onDateChange: (date) {
  setState(() {
    selectedDate = date;
  });

  widget.onDateSelected(date); 
},
    );
  }
}
