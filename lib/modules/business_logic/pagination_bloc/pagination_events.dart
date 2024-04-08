abstract class PaginationEvents {}

class PaginationFetchEvent extends PaginationEvents {
  final int pageNumber;
  PaginationFetchEvent({required this.pageNumber});
}