import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdg_2022_flutter_101/rest_client.dart';
import 'package:gdg_2022_flutter_101/todo.dart';
import 'package:meta/meta.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(const TodosInitial()) {
    debugPrint("TodosCubit init");
    load();
  }

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  load() async {
    final restClient = await RestClient.get();
    try {
      final _todos = await restClient.all();
      debugPrint("Todos Loaded: ${_todos.length}");
      emit(TodosLoaded(_todos));
    } on DioError catch (e) {
      debugPrint("load all todos failed $e");
      emit(TodosLoadFailed(e.message));
    }
  }
}
