import 'package:chopper/chopper.dart';

abstract class PaymentServices extends ChopperService {

  
@ChopperApi(baseUrl: 'https://jsonplaceholder.typicode.com/posts')
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  Future<Response> getPost(@Path('id') int id);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

}


// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.


