import 'package:bloc_implements/classes/person.dart';
import 'package:bloc_implements/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/person_cubit.dart';

final _person = Person(
  name: 'Guilherme Fernandes dos Santos',
  year: 23,
  height: 1.90,
);

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(
          create: (_) => CounterCubit(),
        ),
        BlocProvider<PersonCubit>(
          create: (_) => PersonCubit(_person),
        ),
      ],
      child: _MyHomePageView(),
    );
  }
}

class _MyHomePageView extends StatelessWidget {
  const _MyHomePageView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final styleSmall = textTheme.bodySmall;
    final styleStrong = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    final controllerName = TextEditingController();
    final controllerYear = TextEditingController();
    final controllerHeight = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<PersonCubit, Person>(builder: (
      context,
      person,
    ) {
      return Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              person.name.toUpperCase(),
              style: styleStrong,
            ),
          ),
          body: BlocBuilder<CounterCubit, int>(
            builder: (context, count) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          style: styleSmall,
                          children: [
                            TextSpan(
                              text: context.read<CounterCubit>().guigas,
                            ),
                            TextSpan(
                              text: 'Year: ',
                            ),
                            TextSpan(
                              text: person.year.toString(),
                              style: styleStrong,
                            ),
                            TextSpan(
                              text: '\nHeight: ',
                            ),
                            TextSpan(
                              text: person.height.toString(),
                              style: styleStrong,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'I\'m contacting',
                            ),
                            Text(
                              (count).toString(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          spacing: 8,
                          children: [
                            TextFormDefault(
                              hintText: 'Name',
                              controller: controllerName,
                            ),
                            TextFormDefault(
                              hintText: 'Year',
                              controller: controllerYear,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            TextFormDefault(
                              hintText: 'Height',
                              controller: controllerHeight,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            TextFormWord(),

                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final person = Person(
                            name: controllerName.text,
                            year: int.tryParse(controllerYear.text) ?? 0,
                            height: double.tryParse(controllerHeight.text) ?? 0,
                          );

                          context.read<PersonCubit>().changePerson(
                                person,
                              );
                        },
                        child: Text(
                          'data',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            tooltip: 'Increment',
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      );
    });
  }
}

class TextFormDefault extends StatelessWidget {
  const TextFormDefault({
    super.key,
    this.style,
    this.inputFormatters,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  final TextStyle? style;
  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final styleSmall = textTheme.bodySmall;
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
      ),
      validator: validator,
      style: style ?? styleSmall,
    );
  }
}
class TextFormWord extends StatelessWidget {
  const TextFormWord({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final styleSmall = textTheme.bodySmall;
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        hintText: 'texto',
      ),
      style:  styleSmall,
    );
  }
}
