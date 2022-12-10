import 'package:dio/dio.dart';
import 'package:gdg_2022_flutter_101/todo.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://todos.st.zeent.tech/api")
abstract class RestClient {

  static RestClient? _instance;

  static Future<RestClient> get() async {
    return _instance ??= RestClient(
      Dio()
        ..options.headers = {
          "Accept": "application/json",
          "Content-Type": "application/json",
        }
        ..options.connectTimeout = 2000
    );
  }

  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/todos")
  Future<List<Todo>> all();

  @GET("/todos/{id}")
  Future<Todo> byId(int id);

  @POST("/todos")
  Future<void> create(@Body() Todo todo);

  @PATCH("/todos/{id}")
  Future<void> update(@Path("id") int id, @Body() Todo todo);

  @DELETE("/todos/{id}")
  Future<void> delete(@Path("id") int id);
}