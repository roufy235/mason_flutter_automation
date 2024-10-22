import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{filename.pascalCase()}}Notifier extends StateNotifier<{{state}}> {
  final Ref ref;
  {{filename.pascalCase()}}Notifier({required this.ref}) : super(const {{state}}());

}

final {{filename.camelCase()}}NotifierProvider = StateNotifierProvider<{{filename.pascalCase()}}Notifier, {{state}}>((ref) => {{filename.pascalCase()}}Notifier(ref: ref));

