class LaravelErrorResponse {
  String? message;

  LaravelErrorResponse({this.message});

  static LaravelErrorResponse fromJson(Map<String, dynamic> json) {
    final errorMessages = <LaravelErrorResponse>[];
    json.forEach((key, value) {
      if (key == "data") {
        Map<String, dynamic> map = Map<String, dynamic>.from(json[key]);
        map.forEach((mapKey, value) {
          errorMessages.add(LaravelErrorResponse(message: map[mapKey][0]));
        });
      }
    });
    return errorMessages.first;
  }
}
