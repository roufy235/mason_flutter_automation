import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
{{#isStateless}}
class {{filename.pascalCase()}} extends StatelessWidget {
  const {{filename.pascalCase()}}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold();
  }
}
{{/isStateless}}
{{^isStateless}}
class {{filename.pascalCase()}} extends StatefulWidget {
  const {{filename.pascalCase()}}({Key? key}) : super(key: key);

  @override
  State<{{filename.pascalCase()}}> createState() => _{{filename.pascalCase()}}State();
}

class _{{filename.pascalCase()}}State extends State<{{filename.pascalCase()}}> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
     return Scaffold();
  }
}
{{/isStateless}}
