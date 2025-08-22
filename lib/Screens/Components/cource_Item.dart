import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/bloc/gpa_cubit.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GpaAppCubit(),
      child: BlocConsumer<GpaAppCubit, GpaAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          GpaAppCubit cubit = GpaAppCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: cubit.courseNameValue,
                    onChanged: (value) {
                      cubit.changeCoursename(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Cource Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 70,
                  child: TextFormField(
                    initialValue: cubit.gradeValue,
                    onChanged: (value) {
                      cubit.changeGradeValue(value);
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0.0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 70,
                  child: TextFormField(
                    initialValue: cubit.unitesValue,
                    onChanged: (value) {
                      cubit.changeUintesValue(value);
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '3',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
