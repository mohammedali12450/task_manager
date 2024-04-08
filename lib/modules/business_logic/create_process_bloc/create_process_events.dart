
import '../user_screen_bloc/user_screen_events.dart';

class CreateStartEvent extends UserScreenEvents {
  final String name;
  final String job;
  CreateStartEvent({required this.name,required this.job});
}