abstract class MyTodosEvents {}

class GetMyTodosStartEvent extends MyTodosEvents {
  int? userId;
  GetMyTodosStartEvent({this.userId});
}