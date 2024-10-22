import 'package:fpdart/fpdart.dart';

class {{filename.pascalCase()}}UseCase implements UseCase<{{leftDataClass}}, {{rightDataClass}}, {{parameter}}> {
  final {{repository}} {{repository.camelCase()}};
  {{filename.pascalCase()}}UseCase({required this.{{repository.camelCase()}}});

  @override
  Future<Either<{{leftDataClass}}, {{rightDataClass}}>> call({{parameter}} params) async {
    return {{repository.camelCase()}};
  }

}
