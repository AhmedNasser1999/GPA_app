import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/bloc/gpa_cubit.dart';

class CourseItem extends StatefulWidget {
  final String? initialName;
  final String? initialGrade;
  final String? initialUnits;
  final int index;

  const CourseItem({
    Key? key,
    this.initialName,
    this.initialGrade,
    this.initialUnits,
    required this.index,
  }) : super(key: key);

  @override
  State<CourseItem> createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  late TextEditingController nameController;
  late TextEditingController gradeController;
  late TextEditingController unitsController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName ?? '');
    gradeController = TextEditingController(text: widget.initialGrade ?? '');
    unitsController = TextEditingController(text: widget.initialUnits ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    gradeController.dispose();
    unitsController.dispose();
    super.dispose();
  }

  void saveData() {
    final cubit = BlocProvider.of<GpaAppCubit>(context);
    final name = nameController.text;
    final grade = double.tryParse(gradeController.text) ?? 0.0;
    final units = int.tryParse(unitsController.text) ?? 0;
    
    cubit.updateCourse(widget.index, name, grade, units);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GpaAppCubit, GpaAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  saveData();
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: gradeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Grade',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        saveData();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: unitsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Units',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        saveData();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
