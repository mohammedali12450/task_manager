abstract class PaginationEvents {}

class PaginationFetchEvent extends PaginationEvents {
  final int limit;
  final int skip;
  PaginationFetchEvent({required this.limit,required this.skip});
}