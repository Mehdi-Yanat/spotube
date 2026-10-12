import 'package:args/command_runner.dart';

import 'build/android.dart';
import 'build/ios.dart';

class BuildCommand extends Command {
  @override
  String get description => "Build for different platforms";

  @override
  String get name => "build";

  BuildCommand() {
    addSubcommand(AndroidBuildCommand());
    addSubcommand(IosBuildCommand());
    argParser.addOption(
      "arch",
      abbr: "a",
      defaultsTo: "x86",
      allowed: ["x86", "arm64", "all"],
    );
  }
}
