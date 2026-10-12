import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:process_run/shell_run.dart';

class InstallDependenciesCommand extends Command {
  @override
  String get description => "Install platform dependencies";

  @override
  String get name => "install-dependencies";

  InstallDependenciesCommand() {
    argParser.addOption(
      "platform",
      abbr: "p",
      allowed: [
        "ios",
        "android",
      ],
      mandatory: true,
    );
  }

  @override
  FutureOr? run() async {
    final shell = Shell();

    switch (argResults!.option("platform")) {
      case "ios":
        await shell.run(
          """
          rustup target add aarch64-apple-ios
          """,
        );
        break;
      case "android":
        await shell.run(
          """
          sudo apt-get update -y
          sudo apt-get install -y clang cmake ninja-build pkg-config make python3-pip python3-setuptools
          """,
        );
        break;
      default:
        break;
    }
  }
}
