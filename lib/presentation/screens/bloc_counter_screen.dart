import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app_course/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const _BlocCounterView(),
    );
  }
}

class _BlocCounterView extends StatelessWidget {
  const _BlocCounterView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (CounterBloc counterBloc) => Text(
            'Bloc Counter: ${counterBloc.state.transactionCount}',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // context.read<CounterBloc>().add(CounterReset());
              context.read<CounterBloc>().resetCounter();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: Center(
        child: context.select(
          (CounterBloc counterBloc) => Text(
            'Counter Value: ${counterBloc.state.counter}',
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => increseCounterBy(context, value: 3),
            heroTag: '1',
            child: const Text('+3'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () => increseCounterBy(context, value: 2),
            heroTag: '2',
            child: const Text('+2'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () => increseCounterBy(context, value: 1),
            heroTag: '3',
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }

  void increseCounterBy(BuildContext context, {int value = 1}) {
    // context.read<CounterBloc>().add(CounterIncreased(value: value));
    context.read<CounterBloc>().increseBy(value);
  }
}
