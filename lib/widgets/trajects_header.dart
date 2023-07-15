import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sendatrack/widgets/custom_date_range_picker.dart';
import '../constant.dart';
import 'package:sendatrack/widgets/example.dart';
import 'package:sendatrack/controllers/headerTraject.dart';

class TrajectsHeader extends StatefulWidget {
  final String? headerName;
  const TrajectsHeader({required this.headerName, super.key});
  @override
  State<TrajectsHeader> createState() => _TrajectsHeaderState();
}

class _TrajectsHeaderState extends State<TrajectsHeader> {
  late FilterHeaderController controller = Get.put(FilterHeaderController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.headerName ?? "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            const Gap(10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                foregroundColor: Colors.black54,
                shadowColor: Colors.transparent,
                elevation: 0.0,
              ).copyWith(
                elevation: ButtonStyleButton.allOrNull(0.0),
              ),
              child: const Text('Filter',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const DropDownListExample();
                    });
              },
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              color: Colors.grey,
              onPressed: () {
                showCustomDateRangePicker(
                  context,
                  dismissible: true,
                  minimumDate:
                      DateTime.now().subtract(const Duration(days: 50000)),
                  maximumDate: DateTime.now().add(const Duration(days: 50000)),
                  endDate: controller.endDate,
                  startDate: controller.startDate,
                  backgroundColor: Colors.white,
                  primaryColor: kDarkBlue,
                  onApplyClick: (start, end) {
                    controller.endDate = end;
                    controller.startDate = start;
                    controller.isSavedTime.value =
                        !controller.isSavedTime.value;
                    debugPrint(
                        'debug: $controller.startDate  + $controller.endDate');
                  },
                  onCancelClick: () {
                    controller.endDate = null;
                    controller.startDate = null;
                    controller.isSavedTime.value =
                        !controller.isSavedTime.value;
                  },
                );
              },
            ),
            // const SizedBox(
            //   width: 5,
            // ),
            TextButton(
              onPressed: () {},
              child: Text(
                controller.castDate(controller.startDate, controller.endDate),
                style: const TextStyle(
                  fontSize: 16,
                  color: kDarkBlue,
                  height: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
