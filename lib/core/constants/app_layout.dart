abstract final class AppLayout {
  AppLayout._();

  /// Largeur maximale du contenu principal.
  static const double contentMaxWidth = 1200;

  /// Largeur optimale pour les contenus de lecture.
  static const double readingMaxWidth = 760;

  /// Largeur de la colonne principale du feed.
  static const double feedMaxWidth = 720;

  /// Largeur des panneaux secondaires.
  static const double sidePanelWidth = 320;

  /// Largeur minimale avant affichage multi-colonnes.
  static const double multiColumnMinWidth = 1100;

  /// Largeur minimale confortable pour un layout desktop.
  static const double desktopContentMinWidth = 1024;
}
