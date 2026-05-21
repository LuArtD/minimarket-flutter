import 'package:flutter/material.dart';

// ========== COLORES CLAROS ==========
class AppColorsLight {
  static const Color primary = Color(0xFF33A57F);
  static const Color primaryContainer = Color(0xFFC5E9DC);
  static const Color secondary = Color(0xFF4A7B6E);
  static const Color secondaryContainer = Color(0xFFCCE8E1);
  static const Color tertiary = Color(0xFF5B8A77);
  static const Color surface = Color.fromARGB(255, 255, 252, 252);
  static const Color surfaceVariant = Color(0xFFEFE9E9);
  static const Color background = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB3261E);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color onSurfaceVariant = Color(0xFF49454E);
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFC4C7C5);
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  static const Color accent = Color(0xFFE75050);
}

// ========== COLORES OSCUROS ==========
class AppColorsDark {
  static const Color primary = Color(0xFF44AA88);
  static const Color primaryContainer = Color(0xFF2D7F62);
  static const Color secondary = Color(0xFFC1DED7);
  static const Color secondaryContainer = Color(0xFF35574D);
  static const Color tertiary = Color(0xFFB8CCBE);
  static const Color surface = Color(0xFF252525);
  static const Color surfaceVariant = Color(0xFF3F3F3F);
  static const Color background = Color(0xFF1A1A1A);
  static const Color error = Color(0xFFF2B8B5);
  static const Color onPrimary = Color(0xFF003D2F);
  static const Color onSurface = Color(0xFFF4EFF4);
  static const Color onSurfaceVariant = Color(0xFFCAC4CF);
  static const Color outline = Color(0xFF938F99);
  static const Color outlineVariant = Color(0xFF49454E);
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  static const Color accent = Color(0xFFAD3D3D);
}

// ========== TEMA CLARO ==========
ThemeData light = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColorsLight.primary,
    onPrimary: AppColorsLight.onPrimary,
    primaryContainer: AppColorsLight.primaryContainer,
    onPrimaryContainer: AppColorsLight.primary,
    secondary: AppColorsLight.secondary,
    onSecondary: Colors.white,
    secondaryContainer: AppColorsLight.secondaryContainer,
    onSecondaryContainer: AppColorsLight.secondary,
    tertiary: AppColorsLight.tertiary,
    onTertiary: Colors.white,
    error: AppColorsLight.error,
    onError: Colors.white,
    surface: AppColorsLight.surface,
    onSurface: AppColorsLight.onSurface,
    surfaceContainerHighest: AppColorsLight.surfaceVariant,
    outline: AppColorsLight.outline,
    outlineVariant: AppColorsLight.outlineVariant,
  ),
  scaffoldBackgroundColor: AppColorsLight.background,

  // ========== ESTILOS DE TEXTO ==========
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColorsLight.onSurface,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColorsLight.onSurface,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColorsLight.onSurface,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColorsLight.onSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColorsLight.onSurface,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColorsLight.onSurface,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColorsLight.onSurface,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColorsLight.onSurface,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColorsLight.onSurfaceVariant,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColorsLight.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColorsLight.onSurface,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColorsLight.onSurfaceVariant,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColorsLight.primary,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColorsLight.onSurfaceVariant,
    ),
  ),

  // ========== APP BAR ==========
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsLight.primary,
    foregroundColor: AppColorsLight.onPrimary,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColorsLight.onPrimary,
    ),
    iconTheme: IconThemeData(color: AppColorsLight.onPrimary),
  ),

  // ========== CARDS ==========
  cardTheme: CardThemeData(
    color: AppColorsLight.surface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ========== BOTONES ==========
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsLight.primary,
      foregroundColor: AppColorsLight.onPrimary,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColorsLight.primary,
      side: BorderSide(color: AppColorsLight.primary, width: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColorsLight.primary,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
  ),

  // ========== INPUT FIELDS ==========
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColorsLight.surfaceVariant,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColorsLight.outline, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColorsLight.outlineVariant, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColorsLight.primary, width: 2),
    ),
    labelStyle: TextStyle(color: AppColorsLight.onSurfaceVariant),
    hintStyle: TextStyle(color: AppColorsLight.onSurfaceVariant),
  ),

  // ========== OTROS COMPONENTES ==========
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColorsLight.primary,
    foregroundColor: AppColorsLight.onPrimary,
    elevation: 6,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColorsLight.surfaceVariant,
    selectedColor: AppColorsLight.primary,
    labelStyle: TextStyle(color: AppColorsLight.onSurface),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  // ========== SCAFFOLD ==========
  bottomAppBarTheme: BottomAppBarThemeData(
    color: AppColorsLight.surface,
    elevation: 4,
    padding: EdgeInsets.symmetric(horizontal: 8),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColorsLight.surface,
    selectedItemColor: AppColorsLight.primary,
    unselectedItemColor: AppColorsLight.onSurfaceVariant,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColorsLight.primary,
    contentTextStyle: TextStyle(color: AppColorsLight.onPrimary),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    behavior: SnackBarBehavior.floating,
  ),

  // ========== DRAWER ==========
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColorsLight.surface,
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
    ),
  ),

  // ========== DIALOG ==========
  dialogTheme: DialogThemeData(
    backgroundColor: AppColorsLight.surface,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColorsLight.onSurface,
    ),
    contentTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColorsLight.onSurface,
    ),
  ),

  // ========== TAB BAR ==========
  tabBarTheme: TabBarThemeData(
    labelColor: AppColorsLight.onPrimary,
    unselectedLabelColor: AppColorsLight.onPrimary.withValues(alpha: 0.6),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColorsLight.onPrimary, width: 3),
    ),
    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
);

// ========== TEMA OSCURO ==========
ThemeData dark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColorsDark.primary,
    onPrimary: AppColorsDark.onPrimary,
    primaryContainer: AppColorsDark.primaryContainer,
    onPrimaryContainer: AppColorsDark.primary,
    secondary: AppColorsDark.secondary,
    onSecondary: Colors.black,
    secondaryContainer: AppColorsDark.secondaryContainer,
    onSecondaryContainer: AppColorsDark.secondary,
    tertiary: AppColorsDark.tertiary,
    onTertiary: Colors.black,
    error: AppColorsDark.error,
    onError: Colors.black,
    surface: AppColorsDark.surface,
    onSurface: AppColorsDark.onSurface,
    surfaceContainerHighest: AppColorsDark.surfaceVariant,
    outline: AppColorsDark.outline,
    outlineVariant: AppColorsDark.outlineVariant,
  ),
  scaffoldBackgroundColor: AppColorsDark.background,

  // ========== ESTILOS DE TEXTO ==========
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColorsDark.onSurface,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColorsDark.onSurface,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColorsDark.onSurface,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.onSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.onSurface,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.onSurface,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.onSurface,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.onSurface,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.onSurfaceVariant,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColorsDark.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColorsDark.onSurface,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColorsDark.onSurfaceVariant,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.primary,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColorsDark.onSurfaceVariant,
    ),
  ),

  // ========== APP BAR ==========
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsDark.primary,
    foregroundColor: AppColorsDark.onPrimary,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.onPrimary,
    ),
    iconTheme: IconThemeData(color: AppColorsDark.onPrimary),
  ),

  // ========== CARDS ==========
  cardTheme: CardThemeData(
    color: AppColorsDark.surface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ========== BOTONES ==========
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsDark.primary,
      foregroundColor: AppColorsDark.onPrimary,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColorsDark.primary,
      side: BorderSide(color: AppColorsDark.primary, width: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColorsDark.primary,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
  ),

  // ========== INPUT FIELDS ==========
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColorsDark.surfaceVariant,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColorsDark.outline, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColorsDark.outlineVariant, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColorsDark.primary, width: 2),
    ),
    labelStyle: TextStyle(color: AppColorsDark.onSurfaceVariant),
    hintStyle: TextStyle(color: AppColorsDark.onSurfaceVariant),
  ),

  // ========== OTROS COMPONENTES ==========
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColorsDark.primary,
    foregroundColor: AppColorsDark.onPrimary,
    elevation: 6,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColorsDark.surfaceVariant,
    selectedColor: AppColorsDark.primary,
    labelStyle: TextStyle(color: AppColorsDark.onSurface),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  // ========== SCAFFOLD ==========
  bottomAppBarTheme: BottomAppBarThemeData(
    color: AppColorsDark.surface,
    elevation: 4,
    padding: EdgeInsets.symmetric(horizontal: 8),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColorsDark.surface,
    selectedItemColor: AppColorsDark.primary,
    unselectedItemColor: AppColorsDark.onSurfaceVariant,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColorsDark.primary,
    contentTextStyle: TextStyle(color: AppColorsDark.onPrimary),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    behavior: SnackBarBehavior.floating,
  ),

  // ========== DRAWER ==========
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColorsDark.surface,
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
    ),
  ),

  // ========== DIALOG ==========
  dialogTheme: DialogThemeData(
    backgroundColor: AppColorsDark.surface,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.onSurface,
    ),
    contentTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColorsDark.onSurface,
    ),
  ),

  // ========== TAB BAR ==========
  tabBarTheme: TabBarThemeData(
    labelColor: AppColorsDark.onPrimary,
    unselectedLabelColor: AppColorsDark.onPrimary.withValues(alpha: 0.6),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColorsDark.onPrimary, width: 3),
    ),
    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
);
