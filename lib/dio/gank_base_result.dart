import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';

class GankIoBaseListResult<T> {
  int page;
  int page_count;
  int status;
  int total_counts;
  List<T> data;

  GankIoBaseListResult(
      {this.page, this.page_count, this.status, this.total_counts, this.data});

  factory GankIoBaseListResult.fromJson(Map<String, dynamic> json) {
    return GankIoBaseListResult(
      page: json["page"],
      page_count: json["page_count"],
      status: json["status"],
      total_counts: json["total_counts"],
      data: List.of(json["data"])
          .map((i) => JsonConvert.fromJsonAsT<T>(i) /* can't generate it properly yet */)
          .toList(),
    );
  }
//

}
