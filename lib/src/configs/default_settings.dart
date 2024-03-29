/// A class of default settings for the package
class DefaultSettings {
  /// The default output directory
  static const outputDirectory = 'lib';

  /// The default class name
  static const className = 'I18n';

  /// The default (output) filename
  static const fileName = 'i18n';

  /// The default field delimiter for CSV file
  static const delimiter = ',';

  /// The default index where the loca should be parsed from.
  /// Assumes the csv is in the format: keys | fr | en | de etc.
  static const startIndex = 1;

  /// The default value for whether the generated code should depend on context
  static const dependOnContext = true;

  /// The default value for whether the generated code should use single or double quotes for strings.
  /// Single is default for Dart but user may wish to use double to avoid needing to escape \' etc.
  static const useSingleQuotes = false;

  /// The default value for whether the generated code should replace no break spaces (\u00A0) with normal spaces (\u0020)
  static const replaceNoBreakSpaces = false;

  /// The default value for whether a getString method should be exposed
  static const exposeGetString = false;

  /// The default value for whether a locaStrings getter should be exposed
  static const exposeLocaStrings = false;

  /// The default value for whether a localeMaps getter should be exposed
  static const exposeLocaleMaps = false;

  /// The default value for whether comments containing the translation should be included in the generated code
  static const generateComments = false;

  /// The default value for which languages to use in the generated comments. Defaults to all languages.
  static const commentLanguages = <String>[];
}
