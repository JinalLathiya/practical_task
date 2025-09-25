# Practical Task

### Development Environment

* Dart Sdk: >= 3.9.0
* Flutter Sdk: >= 3.35.0

### Prerequisite for running app

For generating Execute required json serialization, database & dependency injection files, run below command in root
directory of project:

```shell
dart run build_runner build -d
``` 

For generating localization files run below commands in root directory of project:

```shell
flutter pub global activate intl_utils
flutter pub global run intl_utils:generate
``` 
