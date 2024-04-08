abstract class NavigationEvents {}

class NavigateEvent extends NavigationEvents{
  final int pageNumber;

  NavigateEvent({required this.pageNumber});
}