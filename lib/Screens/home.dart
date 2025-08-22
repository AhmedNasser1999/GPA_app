import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/Screens/Components/button.dart';
import 'package:gpa/bloc/gpa_cubit.dart';

class GBAHome extends StatelessWidget {
  const GBAHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GpaAppCubit(),
      child: BlocConsumer<GpaAppCubit, GpaAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          GpaAppCubit cubit = GpaAppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15.0),
                    Text(
                      'Number Of Courses : ${cubit.gpaItems.length}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          width: 100,
                          onPressed: () {
                            cubit.removeItem();
                          },
                          color: Colors.indigo,
                          buttonText: 'CLEAR',
                        ),
                        const SizedBox(width: 70.0),
                        Button(
                          width: 100,
                          onPressed: () {
                            cubit.addItem();
                          },
                          color: Colors.indigo,
                          buttonText: 'ADD',
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Text('Course Name')),
                          Text('Grade'),
                          SizedBox(width: 45.0),
                          Text('Units'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.gpaItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10.0),
                        itemBuilder: (context, index) => cubit.gpaItems[index],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'GPA : 0.000',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Button(
                      buttonText: 'CALCULATE',
                      onPressed: () {},
                      width: 200.0,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
