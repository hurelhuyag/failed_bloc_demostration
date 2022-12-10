import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdg_2022_flutter_101/todos_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Builder(
          builder: (context) {
            final todosCubit = context.watch<TodosCubit>();
            final state = todosCubit.state;
            if (state is TodosInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TodosLoadFailed) {
              return Center(
                child: Text("Error: ${state.message}"),
              );
            }
            debugPrint("State is: $state, ${todosCubit.todos.length}");
            return ListView.builder(
              itemCount: todosCubit.todos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = todosCubit.todos[index];
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text(todo.title),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}