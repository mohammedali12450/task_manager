abstract class UserScreenEvents {}

class UpdateStartEvent extends UserScreenEvents {
  final String name;
  final String job;
  final int userId;

  UpdateStartEvent({required this.name,required this.job,required this.userId});
}

class CreateStartEvent extends UserScreenEvents {
  final String name;
  final String job;
  CreateStartEvent({required this.name,required this.job});
}