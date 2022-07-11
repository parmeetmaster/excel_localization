# Excel Localization

A tool which automatically generates Flutter localization resources from CSV and Excel files.

This is especially useful as any team member can edit the CSV/Excel file, with the subsequent translations imported into the project via a terminal command. Basic variables (strings and integers) are supported, however neither genders nor plurals are planned to be supported. If you require such functionality, consider using [arb_generator](https://pub.dev/packages/arb_generator).

Note that plugin only works with null safety.

Special thanks for motivation : [Click here](https://animekill.com/ "Click here")

## Getting Started

In order to use the *excel_localization* package, please provide your translations in a CSV or Excel file. For CSV files, delimiters `,` and `;` have been tested to work.

Here you can see samle of csv how user need to arrange data

| keys          | fr                                 | en                           | en_GB                          | hi                            |
| ------------- | ---------------------------------- | ---------------------------- | ------------------------------ | ----------------------------- |
| plainText     | Bonjour le monde!                  | Hello world!                 | Hello world!                   | हैलो वर्ल्ड!                   |
| welcome       | Bienvenu %name$s!                  | Welcome %name$s!             | Welcome %name$s!               | स्वागत%name$s!           |
| favoriteColor | Quelle est votre couleur préférée? | What is your favorite color? | What is your favourite colour? | आपका पसंदीदा रंग कौनसा है? |

Localizations can be specified for a region by appending the country code.

### Add dependency

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
    
dev_dependencies: 
  excel_localization: 
```

Note that *excel_localization* requires dart sdk >= 2.12.

### Define Settings

Settings for *excel_localization* must set in your project's *pubspec.yaml* file. `input_file_path` is the only required parameter.

```yaml
excel_localization:
  input_file_path: "lang.csv"
  output_dir: "lib"
  file_name: "i18n"
  class_name: "I18n"
  delimiter: ","
  start_index: 1
  depend_on_context: true
  use_single_quotes: false
  replace_no_break_spaces: false
  expose_get_string: false
  expose_loca_strings: false
  expose_locale_maps: false
  generate_comments: false
  comment_languages: []
```

| Setting                 | Default | Description                                                                        |
| ----------------------- | ------- | ---------------------------------------------------------------------------------- |
| input_file_path         | N/A     | Required. A path to the input CSV/Excel file.                                      |
| output_dir              | lib     | A directory to generate the output file.                                           |
| file_name               | i18n    | A filename for the generated file.                                                 |
| class_name              | I18n    | A class name for the generated file.                                               |
| delimiter               | ,       | CSV files only: a delimited to separate columns in the input CSV file.             |
| start_index             | 1       | The column index where translations begin (i.e. column index of default language). |
| depend_on_context       | true    | Whether the generated localizations should depend on *BuildContext*                |
| use_single_quotes       | false   | Whether the generated file should use single or double quotes for strings.         |
| replace_no_break_spaces | false   | Whether no break spaces (\u00A0) should be replaced with normal spaces (\u0020).   |
| expose_get_string       | false   | The default value for whether a getString method should be exposed.                |
| expose_loca_strings     | false   | The default value for whether a locaStrings getter should be exposed.              |
| expose_locale_maps      | false   | The default value for whether a localeMaps getter should be exposed.               |
| generate_comments       | false   | Whether documentation comments should be used to display translations.             |
| comment_languages       | []      | Languages that are displayed in the comments. Empty -> All languages are used.     |

### Run package

Make sure that your current working directory is the project root.

```sh
flutter pub get
flutter pub run excel_localization
```

### Update iOS Info.plist

For iOS, *ios/Runner/Info.plist* needs to be updated with an array of the languages that the app will supports:

```plist
<key>CFBundleLocalizations</key>
<array>
  <string>fr</string>
  <string>en</string>
  <string>hi</string>
</array>
```

For more information, see [Internationalizing Flutter apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#appendix-updating-the-ios-app-bundle).

### Use the i18n generated file

The package used your input file in order to generate a file named *file_name* in *output_dir* you provided. The following example uses the default *class_name* I18n with a dependency on *BuildContext*.

Firstly, add the I18nDelegate to your delegates:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   navigatorKey: I18n.languageKey, //<== This is require if you like to call words without context
      localizationsDelegates: [

        const I18nDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: I18nDelegate.supportedLocals,
      home: Home(),
    );
  }
}
```

Then use the generated I18n class!

```dart
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('excel localization sample"'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(I18n.of(context).plainText),
            Text(I18n.of(context).welcome(name: 'Simran')),
            Text(I18n.of(context).favoriteColor),
			// To access variable without con the way is given below just replace of(context) to translate keyword
			// Make sure you add navigatorkey parameter in MaterialApp or GetMaterialApp
			Text(I18n.translate.plainText),
            Text(I18n.translate.welcome(name: 'Simran')),
            Text(I18n.translate.favoriteColor),
          ],
        ),
      ),
    );
  }
```

Please see [example](example/) for more information.

### Material Localizations

Supporting a language (i.e. ga or cy) not included in GlobalMaterialLocalizations requires adding a material localization class and delegate. Although this is out of the scope of this package, a warning is logged to the console during code generation. [More info](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#adding-support-for-a-new-language).

## Rules and functionalities

### Locale

Locales are specified in the top row and are expected to be given in the form `en` or `en_US`.

### Default language

The column at `start_index` is considered the default language. This means that:

1. If this column does not have a value, the loca key instead will be used.
2. If another language does not have translations for a given key, the value of the default language will be used.

### Keys

Each loca key must begin with a lowercase letter, after which any combinations of lowercase, uppercase, digits or underscores are valid.

### Variables

In order to include variables in loca strings, they need to be written in the format `%<VAR NAME>$<VAR TYPE>`. Presently only integers and strings are supported as variable types.

* %myVariable$d (`d` stands for an int)
* %myVariable$s (`s` stands for a String)

All variables are required. Consider the key `welcome` from example. The generated function signature is

```dart
String welcome({
  required String name,
})
```

Note that if the variable's name starts with a number, the generated variable name will be `var<VAR NAME>`. So, for instance, `%1$d` would become `var1`.



### You can also watch youtube Video to understand this plugin
[![](https://github.com/parmeetmaster/excel_localization/blob/master/assets/png/youtube.webp)](https://www.youtube.com/watch?v=kQxZ1N1yb_s&ab_channel=parmeetsingh)


