# Tutoriel complet — de `feat/begin` au projet AfricaTrip terminé

> Ce tutoriel te prend par la main, fichier par fichier, du squelette initial
> (branche `feat/begin`) jusqu'à l'application complète (branche `master`).
> Chaque étape se termine par une vérification et un commit de **4 fichiers maximum**.
> Tu peux le suivre dans l'ordre sans rien sauter : chaque lot compile.

---

## Sommaire

1. [Ce que tu vas construire](#1-ce-que-tu-vas-construire)
2. [Préparer l'environnement et la branche](#2-préparer-lenvironnement-et-la-branche)
3. [Lot 1 — Thème et widgets de base](#3-lot-1--thème-et-widgets-de-base-4-fichiers)
4. [Lot 2 — Modèles et widgets de vol](#4-lot-2--modèles-et-widgets-de-vol-3-fichiers)
5. [Lot 3 — Boarding pass et QR code](#5-lot-3--boarding-pass-et-qr-code-2-fichiers)
6. [Lot 4 — Écran de recherche](#6-lot-4--écran-de-recherche-1-fichier)
7. [Lot 5 — Historique et profil](#7-lot-5--historique-et-profil-2-fichiers)
8. [Lot 6 — Accueil, navigation et `main.dart`](#8-lot-6--accueil-navigation-et-maindart-4-fichiers)
9. [Lot 7 — Tests](#9-lot-7--tests-1-fichier)
10. [Vérifier et comparer avec la solution](#10-vérifier-et-comparer-avec-la-solution)
11. [Dépannage](#11-dépannage)
12. [Pour aller plus loin](#12-pour-aller-plus-loin)
13. [Checklist finale](#13-checklist-finale)

---

## 1. Ce que tu vas construire

Application mobile de réservation de vols inspirée du design « CitiLink / AfricaTrip » :

| Écran | Rôle |
| --- | --- |
| **Home** | Salutation, recherche, filtres (Flight/Hotel/Bus/Car), destinations populaires, barre de navigation |
| **Search** | Route USA → IDN, sélection de date, liste de billets |
| **Boarding Pass** | Billet détaillé avec QR code, sièges, terminal, porte |
| **History** | Liste des billets passés |
| **Profile** | Profil utilisateur et options |

### Arborescence finale

```text
lib/
├── main.dart
├── theme/
│   └── app_theme.dart
├── models/
│   └── travel_models.dart
├── widgets/
│   ├── circle_icon_button.dart
│   ├── network_photo.dart
│   ├── app_search_field.dart
│   ├── flight_route_row.dart
│   ├── ticket_card.dart
│   ├── qr_code_view.dart
│   ├── destination_card.dart
│   └── app_bottom_nav.dart
└── views/
    ├── home/
    │   └── home_screen.dart
    ├── search/
    │   └── search_screen.dart
    ├── boarding/
    │   └── boarding_pass_screen.dart
    ├── history/
    │   └── history_screen.dart
    └── profile/
        └── profile_screen.dart
```

### Conventions du tutoriel

- **Un lot = au maximum 4 fichiers = un commit.**
- Après chaque lot : `flutter analyze`, puis aperçu visuel si possible.
- Les tests ne seront lancés qu'au lot 7 (le test d'origine est celui du template Flutter et échoue exprès).
- Le code est fourni **intégralement** : tu peux le recopier, le lire, puis le modifier.

---

## 2. Préparer l'environnement et la branche

### 2.1 Vérifier Flutter

```bash
flutter --version
flutter doctor
```

### 2.2 Créer la branche de travail

On ne travaille **jamais** directement sur `feat/begin` : elle doit rester l'état initial intact.

```bash
git switch feat/begin
git switch -c feat/complete
```

Vérifie que tu es bien sur la nouvelle branche :

```bash
git branch --show-current
# feat/complete
```

### 2.3 Installer les dépendances et lancer

```bash
flutter pub get
flutter run -d windows
```

Si Windows n'est pas disponible :

```bash
flutter run -d chrome
```

Ou liste les appareils :

```bash
flutter devices
```

### 2.4 Commandes utiles pendant le développement

| Touche / commande | Effet |
| --- | --- |
| `r` | Hot reload (garde l'état) |
| `R` | Hot restart (recharge tout) |
| `q` | Quitter |
| `flutter analyze` | Analyse statique |
| `flutter test` | Lance les tests |
| `flutter format .` | Formate le code |

> Tu peux créer les dossiers dans ton IDE (VS Code, Android Studio) ou avec
> PowerShell : `New-Item -ItemType Directory -Force lib/theme, lib/models, ...`

---

## 3. Lot 1 — Thème et widgets de base (4 fichiers)

**Objectif :** poser les couleurs du design et fabriquer quatre briques réutilisables.
Aucun écran ne change encore : c'est normal.

### 3.1 `lib/theme/app_theme.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color background = Color(0xFFF7F4EC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cream = Color(0xFFF1ECE0);
  static const Color creamDark = Color(0xFFE8E2D3);
  static const Color lime = Color(0xFFB9DA4B);
  static const Color green = Color(0xFF5B8C32);
  static const Color dark = Color(0xFF17380F);
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF8C8C84);
  static const Color dotted = Color(0xFFB8B3A5);
}

class AppTheme {
  const AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lime,
      primary: AppColors.dark,
      surface: AppColors.surface,
    ),
    splashFactory: InkSparkle.splashFactory,
  );
}
```

**À comprendre :**

- `AppColors` est une « classe de constantes ». Le constructeur privé `const AppColors._();`
  empêche de l'instancier : on l'utilise uniquement via `AppColors.lime`, etc.
- `Color(0xFFB9DA4B)` : `FF` = opacité maximale, puis rouge, vert, bleu en hexadécimal.
- `ThemeData` centralise l'apparence globale. `ColorScheme.fromSeed` génère une palette
  cohérente à partir d'une couleur de base.
- `scaffoldBackgroundColor` évite de répéter la couleur crème dans chaque `Scaffold`.
- `useMaterial3` active Material 3.

### 3.2 `lib/widgets/circle_icon_button.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 46,
    this.backgroundColor = AppColors.surface,
    this.iconColor = AppColors.textPrimary,
    this.iconSize = 22,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
```

**À comprendre :**

- Un bouton réutilisable avec des valeurs par défaut, surchargeables (`size`, `icon`, couleurs).
- `Material` fournit la surface et l'effet d'ondulation ; `InkWell` capte le tap.
  Sans ancêtre `Material`, Flutter lève l'erreur `No Material widget found`.
- `shape: CircleBorder()` + `clipBehavior: Clip.antiAlias` = cercle parfait, ondulation
  qui ne déborde pas.
- `super.key` permet à Flutter d'identifier le widget dans l'arbre.
- `VoidCallback?` : le bouton peut être désactivé si `onTap` vaut `null`.

### 3.3 `lib/widgets/network_photo.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

class NetworkPhoto extends StatelessWidget {
  const NetworkPhoto({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => const _PhotoFallback(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const _PhotoFallback();
      },
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9DBB78), Color(0xFF3E6B3A)],
        ),
      ),
      child: Center(
        child: Icon(Icons.landscape_rounded, color: Colors.white38, size: 42),
      ),
    );
  }
}
```

**À comprendre :**

- `Image.network` charge une image depuis Internet.
- `BoxFit.cover` remplit la zone en gardant les proportions (recadrage si besoin).
- `errorBuilder` est **indispensable** : sans réseau, ou dans les tests widget, un appel
  HTTP échoue et l'image planterait l'écran.
- `loadingBuilder` affiche le fallback pendant le chargement.
- `_PhotoFallback` est privé (préfixe `_`) : il ne sert qu'à ce fichier.

### 3.4 `lib/widgets/app_search_field.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.hintText = 'Search here...',
    this.onTap,
  });

  final String hintText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(40),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                size: 22,
                color: AppColors.textPrimary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hintText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**À comprendre :**

- Ce n'est **pas** un `TextField` : le design montre un champ cliquable qui ouvre l'écran
  de recherche. Un `Text` + `InkWell` suffit.
- `Expanded` autour du texte lui donne toute la largeur restante.
- Le fond blanc et le rayon de 40 donnent la pilule du design.

### 3.5 Vérification du lot 1

```bash
flutter analyze
```

Attendu : `No issues found!`

Lance `flutter run` : l'écran reste celui du squelette initial. C'est normal, car
aucun de ces fichiers n'est encore utilisé.

### 3.6 Commit du lot 1

```bash
git add lib/theme/app_theme.dart lib/widgets/circle_icon_button.dart lib/widgets/network_photo.dart lib/widgets/app_search_field.dart
git commit -m "feat(ui): ajoute le theme et les widgets de base"
```

---

## 4. Lot 2 — Modèles et widgets de vol (3 fichiers)

**Objectif :** créer les données de démonstration, la ligne de route avec pointillés et la
carte de billet réutilisable.

### 4.1 `lib/models/travel_models.dart`

**Crée le fichier et colle :**

```dart
class Destination {
  const Destination({
    required this.imageUrl,
    required this.location,
    required this.title,
  });

  final String imageUrl;
  final String location;
  final String title;
}

class FlightTicket {
  const FlightTicket({
    required this.airline,
    required this.originCode,
    required this.originCity,
    required this.destinationCode,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureDay,
    required this.arrivalDay,
    required this.seats,
    required this.terminal,
    required this.gate,
  });

  final String airline;
  final String originCode;
  final String originCity;
  final String destinationCode;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;
  final String departureDay;
  final String arrivalDay;
  final String seats;
  final String terminal;
  final String gate;
}

const List<Destination> popularDestinations = [
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
    location: 'Laut Aegea',
    title: 'Lake Pukaki',
  ),
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800&q=80',
    location: 'Gunung Gede',
    title: 'Auckland',
  ),
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
    location: 'Bali',
    title: 'Nusa Penida',
  ),
  Destination(
    imageUrl:
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80',
    location: 'Lombok',
    title: 'Mount Rinjani',
  ),
];

const List<FlightTicket> availableTickets = [
  FlightTicket(
    airline: 'CitiLink Airline',
    originCode: 'USA',
    originCity: 'Chicago',
    destinationCode: 'IDN',
    destinationCity: 'Jakarta',
    departureTime: '4:30 PM',
    arrivalTime: '5:19 AM',
    departureDay: 'Sun, 5 Feb',
    arrivalDay: 'Mon, 5 Feb',
    seats: '18B, 18C',
    terminal: 'G32',
    gate: '9',
  ),
  FlightTicket(
    airline: 'CitiLink Airline',
    originCode: 'USA',
    originCity: 'Chicago',
    destinationCode: 'IDN',
    destinationCity: 'Jakarta',
    departureTime: '7:45 PM',
    arrivalTime: '8:34 AM',
    departureDay: 'Sun, 5 Feb',
    arrivalDay: 'Mon, 5 Feb',
    seats: '21A, 21B',
    terminal: 'G12',
    gate: '4',
  ),
  FlightTicket(
    airline: 'CitiLink Airline',
    originCode: 'USA',
    originCity: 'Chicago',
    destinationCode: 'IDN',
    destinationCity: 'Jakarta',
    departureTime: '11:10 PM',
    arrivalTime: '11:59 AM',
    departureDay: 'Sun, 5 Feb',
    arrivalDay: 'Mon, 5 Feb',
    seats: '7C, 7D',
    terminal: 'G28',
    gate: '12',
  ),
];
```

**À comprendre :**

- Tous les champs sont `final` : les objets sont immuables. On remplace un billet plutôt
  que de le modifier.
- `required` force à fournir chaque paramètre nommé.
- Les listes `const` sont des données de démo. Plus tard, elles viendront d'une API,
  mais l'UI n'aura pas à changer si tu conserves les mêmes classes.
- Deux classes dans un même fichier, c'est acceptable pour un petit projet ; on pourrait
  les séparer dans `destination.dart` et `flight_ticket.dart`.

### 4.2 `lib/widgets/flight_route_row.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FlightRouteRow extends StatelessWidget {
  const FlightRouteRow({
    super.key,
    required this.originCode,
    required this.originCity,
    required this.destinationCode,
    required this.destinationCity,
    this.dashColor = AppColors.dotted,
    this.codeColor = AppColors.textPrimary,
    this.cityColor = AppColors.textSecondary,
    this.planeBackground = AppColors.green,
    this.compact = false,
  });

  final String originCode;
  final String originCity;
  final String destinationCode;
  final String destinationCity;
  final Color dashColor;
  final Color codeColor;
  final Color cityColor;
  final Color planeBackground;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final codeStyle = TextStyle(
      fontSize: compact ? 18 : 22,
      fontWeight: FontWeight.w800,
      color: codeColor,
      letterSpacing: 0.2,
    );
    final cityStyle = TextStyle(
      fontSize: compact ? 10 : 11,
      fontWeight: FontWeight.w500,
      color: cityColor,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(originCode, style: codeStyle),
              const SizedBox(height: 2),
              Text(originCity, style: cityStyle),
            ],
          ),
        ),
        SizedBox(
          width: compact ? 78 : 96,
          child: Row(
            children: [
              Expanded(child: _DashedLine(color: dashColor)),
              Container(
                width: compact ? 28 : 34,
                height: compact ? 28 : 34,
                decoration: BoxDecoration(
                  color: planeBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.flight_rounded,
                  size: compact ? 15 : 18,
                  color: Colors.white,
                ),
              ),
              Expanded(child: _DashedLine(color: dashColor)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(destinationCode, style: codeStyle),
              const SizedBox(height: 2),
              Text(destinationCity, style: cityStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(color),
      child: const SizedBox(height: 1),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    const dash = 4.0;
    const gap = 4.0;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset((x + dash).clamp(0, size.width), size.height / 2),
        paint,
      );
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
```

**À comprendre :**

- `Row` avec deux `Expanded` (gauche/droite) et une zone centrale de largeur fixe.
  Les codes (`USA`, `IDN`) restent grands, les villes plus discrètes.
- `CrossAxisAlignment.end` aligne le côté destination à droite.
- **`CustomPainter`** dessine la ligne pointillée :
  - `Canvas.drawLine` trace un segment ;
  - une boucle `while` avance de `dash + gap` à chaque itération ;
  - `clamp(0, size.width)` évite de dépasser la zone ;
  - `shouldRepaint` ne redessine que si la couleur change.
- Le cercle avec l'avion est un `Container` de forme `BoxShape.circle`.
- `compact` permettra de réduire la taille dans un autre contexte.

### 4.3 `lib/widgets/ticket_card.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../models/travel_models.dart';
import '../theme/app_theme.dart';
import 'flight_route_row.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket, this.onTap});

  final FlightTicket ticket;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cream,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 9),
              color: AppColors.creamDark,
              child: Text(
                ticket.airline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
              child: Column(
                children: [
                  FlightRouteRow(
                    originCode: ticket.originCode,
                    originCity: ticket.originCity,
                    destinationCode: ticket.destinationCode,
                    destinationCity: ticket.destinationCity,
                    planeBackground: AppColors.dark,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _TimeColumn(
                          day: ticket.departureDay,
                          time: ticket.departureTime,
                          alignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Expanded(
                        child: _TimeColumn(
                          day: ticket.arrivalDay,
                          time: ticket.arrivalTime,
                          alignment: CrossAxisAlignment.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.green,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: _Info(label: 'Seats', value: ticket.seats),
                  ),
                  Expanded(
                    child: _Info(
                      label: 'Terminal',
                      value: ticket.terminal,
                      centered: true,
                    ),
                  ),
                  Expanded(
                    child: _Info(
                      label: 'Gate',
                      value: ticket.gate,
                      trailing: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeColumn extends StatelessWidget {
  const _TimeColumn({
    required this.day,
    required this.time,
    required this.alignment,
  });

  final String day;
  final String time;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          time,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.label,
    required this.value,
    this.centered = false,
    this.trailing = false,
  });

  final String label;
  final String value;
  final bool centered;
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    final alignment = trailing
        ? CrossAxisAlignment.end
        : centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
```

**À comprendre :**

- La carte est un `Material` crème + `InkWell` : toute la surface est cliquable.
- `Column` empile trois zones : bandeau compagnie, corps, bandeau vert.
- Le corps réutilise `FlightRouteRow` : aucune duplication de la route.
- Les horaires utilisent deux `Expanded` pour se répartir la largeur.
- `_TimeColumn` et `_Info` sont privés et paramétrés (`alignment`, `centered`, `trailing`).
- `Colors.white.withValues(alpha: 0.75)` rend le texte blanc à 75 % d'opacité.
  (L'ancienne méthode `withOpacity` est dépréciée dans les versions récentes.)
- Le ternaire imbriqué choisit l'alignement. On pourrait écrire un `switch`, mais ce
  ternaire reste lisible ici.

### 4.4 Vérification du lot 2

```bash
flutter analyze
```

Attendu : aucun problème. Rien n'est encore affiché, mais tout compile.

### 4.5 Commit du lot 2

```bash
git add lib/models/travel_models.dart lib/widgets/flight_route_row.dart lib/widgets/ticket_card.dart
git commit -m "feat(flight): ajoute le modele et les widgets de vol"
```

---

## 5. Lot 3 — Boarding pass et QR code (2 fichiers)

**Objectif :** dessiner un faux QR sans dépendance externe et construire le billet
détaillé avec sa perforation.

### 5.1 `lib/widgets/qr_code_view.dart`

**Crée le fichier et colle :**

```dart
import 'dart:math';

import 'package:flutter/material.dart';

class QrCodeView extends StatelessWidget {
  const QrCodeView({super.key, this.size = 190});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: const _QrPainter(),
    );
  }
}

class _QrPainter extends CustomPainter {
  const _QrPainter();

  static const int _modules = 25;

  bool _isFinder(int x, int y, int originX, int originY) {
    final dx = x - originX;
    final dy = y - originY;
    if (dx < 0 || dy < 0 || dx > 6 || dy > 6) return false;
    final outer = dx == 0 || dy == 0 || dx == 6 || dy == 6;
    final inner = dx >= 2 && dx <= 4 && dy >= 2 && dy <= 4;
    return outer || inner;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final module = size.width / _modules;
    final random = Random(1337);

    bool inFinderZone(int x, int y) {
      return _isFinder(x, y, 0, 0) ||
          _isFinder(x, y, _modules - 7, 0) ||
          _isFinder(x, y, 0, _modules - 7) ||
          (x <= 7 && y <= 7) ||
          (x >= _modules - 8 && y <= 7) ||
          (x <= 7 && y >= _modules - 8);
    }

    for (var y = 0; y < _modules; y++) {
      for (var x = 0; x < _modules; x++) {
        if (inFinderZone(x, y)) continue;
        if (random.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(x * module, y * module, module, module),
            paint,
          );
        }
      }
    }

    for (final origin in [
      const Offset(0, 0),
      Offset(_modules - 7, 0),
      Offset(0, _modules - 7),
    ]) {
      final ox = origin.dx.toInt();
      final oy = origin.dy.toInt();
      canvas.drawRect(
        Rect.fromLTWH(
          ox * module,
          oy * module,
          module * 7,
          module * 7,
        ),
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = module,
      );
      canvas.drawRect(
        Rect.fromLTWH(
          (ox + 2) * module,
          (oy + 2) * module,
          module * 3,
          module * 3,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_QrPainter oldDelegate) => false;
}
```

**À comprendre :**

- Un vrai QR code encode des données. Ici, on dessine un **motif décoratif crédible**,
  sans dépendance : c'est suffisant pour la maquette.
- La grille fait 25 × 25 modules. Chaque module noir est un carré de côté
  `size.width / 25`.
- `Random(1337)` : la graine fixe garantit le même motif à chaque exécution.
- Les trois « finder patterns » (grands carrés des coins) sont dessinés à part :
  - un carré extérieur en contour (`PaintingStyle.stroke`) ;
  - un carré intérieur plein.
- `inFinderZone` empêche le motif aléatoire d'écraser ces zones.
- `shouldRepaint => false` : le motif ne change jamais, inutile de redessiner.

> Pour un QR réel scannable, utilise le package `qr_flutter` (`QrImageView`).

### 5.2 `lib/views/boarding/boarding_pass_screen.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../../models/travel_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/flight_route_row.dart';
import '../../widgets/qr_code_view.dart';

class BoardingPassScreen extends StatelessWidget {
  const BoardingPassScreen({super.key, required this.ticket});

  final FlightTicket ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.close_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Boarding Pass',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  CircleIconButton(
                    icon: Icons.download_rounded,
                    iconSize: 21,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                child: Column(
                  children: [
                    _BoardingPassTicket(ticket: ticket),
                    const SizedBox(height: 22),
                    Material(
                      color: AppColors.dark,
                      borderRadius: BorderRadius.circular(30),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {},
                        child: const SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Save and Download',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BoardingPassTicket extends StatelessWidget {
  const _BoardingPassTicket({required this.ticket});

  final FlightTicket ticket;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: AppColors.cream,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Citilink',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          color: AppColors.green,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'ID',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            '13SAKF3891',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  FlightRouteRow(
                    originCode: ticket.originCode,
                    originCity: ticket.originCity,
                    destinationCode: ticket.destinationCode,
                    destinationCity: ticket.destinationCity,
                    codeColor: AppColors.dark,
                    cityColor: AppColors.textSecondary,
                    planeBackground: AppColors.green,
                  ),
                  const SizedBox(height: 20),
                  const _InfoGrid(
                    items: [
                      _InfoItem('Boarding time', '4:30 PM'),
                      _InfoItem('Departure', '09:00 AM'),
                      _InfoItem('Arrival Time', '05:19 AM'),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const _InfoGrid(
                    items: [
                      _InfoItem('Passenger', 'Budiarti Rohman'),
                      _InfoItem('Date', '17 Mar 2025', end: true),
                    ],
                  ),
                ],
              ),
            ),
            const _Perforation(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26),
              child: QrCodeView(size: 188),
            ),
            Container(
              color: AppColors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: _PassInfo(label: 'Seats', value: ticket.seats),
                  ),
                  Expanded(
                    child: _PassInfo(
                      label: 'Terminal',
                      value: ticket.terminal,
                      centered: true,
                    ),
                  ),
                  Expanded(
                    child: _PassInfo(
                      label: 'Gate',
                      value: ticket.gate,
                      trailing: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem {
  const _InfoItem(this.label, this.value, {this.end = false});

  final String label;
  final String value;
  final bool end;
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.items});

  final List<_InfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Expanded(
            child: Column(
              crossAxisAlignment: item.end
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PassInfo extends StatelessWidget {
  const _PassInfo({
    required this.label,
    required this.value,
    this.centered = false,
    this.trailing = false,
  });

  final String label;
  final String value;
  final bool centered;
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    final alignment = trailing
        ? CrossAxisAlignment.end
        : centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _Perforation extends StatelessWidget {
  const _Perforation();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: double.infinity,
      child: CustomPaint(painter: const _PerforationPainter()),
    );
  }
}

class _PerforationPainter extends CustomPainter {
  const _PerforationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final dashPaint = Paint()
      ..color = AppColors.dotted
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    const dash = 5.0;
    const gap = 5.0;
    var x = 14.0;
    while (x < size.width - 14) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset((x + dash).clamp(0, size.width - 14), size.height / 2),
        dashPaint,
      );
      x += dash + gap;
    }

    final notchPaint = Paint()..color = AppColors.background;
    final radius = size.height / 2;
    canvas.drawCircle(Offset(0, size.height / 2), radius, notchPaint);
    canvas.drawCircle(Offset(size.width, size.height / 2), radius, notchPaint);
  }

  @override
  bool shouldRepaint(_PerforationPainter oldDelegate) => false;
}
```

**À comprendre :**

- Le `Scaffold` est structuré comme un écran réel : en-tête fixe, contenu scrollable.
- `_BoardingPassTicket` est privé : seul cet écran l'utilise.
- `_InfoItem` est une petite classe de données (label, valeur, alignement à droite).
  On l'utilise dans une liste `const`, par exemple `_InfoItem('Date', '17 Mar 2025', end: true)`.
- `_InfoGrid` parcourt les items avec une **collection-for** (`for (final item in items)`)
  directement dans la liste `children`.
- **La perforation :** le `CustomPaint` dessine des tirets, puis deux cercles de la couleur
  du *fond de l'écran* (`AppColors.background`) aux deux extrémités. Comme le billet est
  enveloppé dans un `ClipRRect`, ces cercles sont rognés en demi-lunes : on obtient l'effet
  « ticket détachable ».
- Le QR et les encoches sont deux `CustomPainter` distincts : une responsabilité par classe.
- `SafeArea` évite que l'en-tête passe sous la barre de statut.

### 5.3 Aperçu sans casser l'accueil

Le plus simple : modifie temporairement `lib/main.dart` (le fichier existe déjà) :

```dart
import 'package:africatrip/models/travel_models.dart';
import 'package:africatrip/views/boarding/boarding_pass_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BoardingPassScreen(ticket: availableTickets.first),
  ),
);
```

Hot restart (`R`), admire le billet, puis **remets** le contenu d'origine de `main.dart`
(ou ignore cette étape : elle n'est utile que pour voir le rendu isolément).

### 5.4 Vérification du lot 3

```bash
flutter analyze
```

### 5.5 Commit du lot 3

```bash
git add lib/widgets/qr_code_view.dart lib/views/boarding/boarding_pass_screen.dart
git commit -m "feat(boarding): ajoute le boarding pass et le QR code"
```

---

## 6. Lot 4 — Écran de recherche (1 fichier)

**Objectif :** assembler la carte de route, le sélecteur de dates et la liste des billets.
Cet écran est le premier à utiliser un `StatefulWidget`.

### 6.1 `lib/views/search/search_screen.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../../models/travel_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/flight_route_row.dart';
import '../../widgets/ticket_card.dart';
import '../boarding/boarding_pass_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedDate = 2;

  static const List<({String weekday, String day})> _dates = [
    (weekday: 'Sun', day: '12'),
    (weekday: 'Mon', day: '13'),
    (weekday: 'Tue', day: '14'),
    (weekday: 'Wed', day: '16'),
    (weekday: 'Thu', day: '17'),
    (weekday: 'Fri', day: '18'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Search',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  CircleIconButton(icon: Icons.more_horiz_rounded, onTap: () {}),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RouteCard(onSearch: () {}),
                    const SizedBox(height: 26),
                    const Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: List.generate(_dates.length, (index) {
                          final date = _dates[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index == _dates.length - 1 ? 0 : 10,
                            ),
                            child: _DateChip(
                              weekday: date.weekday,
                              day: date.day,
                              selected: index == _selectedDate,
                              onTap: () =>
                                  setState(() => _selectedDate = index),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      '${availableTickets.length + 5} Tickets Found',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (final ticket in availableTickets)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: TicketCard(
                          ticket: ticket,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  BoardingPassScreen(ticket: ticket),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteCard extends StatelessWidget {
  const _RouteCard({required this.onSearch});

  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const FlightRouteRow(
            originCode: 'USA',
            originCity: 'Chicago',
            destinationCode: 'IDN',
            destinationCity: 'Jakarta',
            codeColor: AppColors.dark,
            cityColor: Color(0xFF4E5A34),
            dashColor: Color(0xFF6F7F45),
            planeBackground: AppColors.dark,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(26),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onSearch,
                    child: const SizedBox(
                      height: 52,
                      child: Center(
                        child: Text(
                          'Search flights',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleIconButton(
                icon: Icons.swap_horiz_rounded,
                size: 52,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({
    required this.weekday,
    required this.day,
    required this.selected,
    required this.onTap,
  });

  final String weekday;
  final String day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.lime : AppColors.cream,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weekday,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: selected
                      ? AppColors.dark
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                day,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.dark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**À comprendre :**

- **`StatefulWidget`** : l'écran doit mémoriser la date sélectionnée. Le `State` contient
  `_selectedDate`, et `setState` déclenche un nouveau rendu.
- **Records** `({String weekday, String day})` : une structure anonyme nommée, idéale pour
  des données locales. Accès : `date.weekday`, `date.day`.
- `List.generate` construit les puces à partir de la liste.
- `SingleChildScrollView(scrollDirection: Axis.horizontal)` permet de faire défiler les
  dates sans débordement.
- `Clip.none` autorise l'ondulation à dépasser légèrement du scroll (esthétique).
- `'${availableTickets.length + 5} Tickets Found'` : interpolation de chaîne. Le `+ 5`
  est une astuce de démo pour afficher « 8 Tickets Found » comme le design (3 vrais
  billets + 5 fictifs). En production, remplace par un vrai compteur.
- `for (final ticket in availableTickets) Padding(...)` : collection-for dans `children`,
  plus concis qu'un `ListView.builder` pour une petite liste fixe.
- La navigation passe l'objet `ticket` à `BoardingPassScreen` : pas d'état global.
- Le titre est centré grâce à `Expanded` + `textAlign: TextAlign.center` entre deux
  boutons de largeur identique (46 px).

### 6.2 Aperçu isolé

Modifie temporairement `main.dart` :

```dart
import 'package:africatrip/views/search/search_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SearchScreen(),
  ),
);
```

Vérifie :
- le clic sur une date change bien le cercle lime ;
- le clic sur une carte de billet ouvre le Boarding Pass ;
- la flèche retour ramène à l'écran précédent.

Puis restaure `main.dart`.

### 6.3 Commit du lot 4

```bash
git add lib/views/search/search_screen.dart
git commit -m "feat(search): ajoute la recherche de vols et la liste des billets"
```

---

## 7. Lot 5 — Historique et profil (2 fichiers)

**Objectif :** deux écrans secondaires. History prouve que `TicketCard` est réutilisable,
Profile introduit une liste d'options.

### 7.1 `lib/views/history/history_screen.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../../models/travel_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/ticket_card.dart';
import '../boarding/boarding_pass_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 46),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                children: [
                  const Text(
                    'Your trips',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  for (final ticket in availableTickets)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: TicketCard(
                        ticket: ticket,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => BoardingPassScreen(ticket: ticket),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**À comprendre :**

- `ListView` gère le scroll et construit ses enfants à la demande.
- Aucun nouveau widget de billet : on réutilise `TicketCard`.
- Le `SizedBox(width: 46)` à droite équilibre le bouton retour et centre le titre.

### 7.2 `lib/views/profile/profile_screen.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/circle_icon_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<({IconData icon, String label})> _options = [
    (icon: Icons.person_outline_rounded, label: 'Personal information'),
    (icon: Icons.credit_card_rounded, label: 'Payment methods'),
    (icon: Icons.notifications_none_rounded, label: 'Notifications'),
    (icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 46),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                children: [
                  Center(
                    child: Container(
                      width: 92,
                      height: 92,
                      decoration: const BoxDecoration(
                        color: AppColors.lime,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'BR',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Center(
                    child: Text(
                      'Budiarti Rohman',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'budiarti.rohman@mail.com',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < _options.length; i++)
                          _OptionTile(
                            icon: _options[i].icon,
                            label: _options[i].label,
                            showDivider: i != _options.length - 1,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    required this.showDivider,
  });

  final IconData icon;
  final String label;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Icon(icon, size: 21, color: AppColors.textPrimary),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          if (showDivider)
            const Divider(height: 1, indent: 54, color: AppColors.creamDark),
        ],
      ),
    );
  }
}
```

**À comprendre :**

- `_options` est une liste de records `(icon: ..., label: ...)` : pas de classe inutile.
- La collection-for avec index permet de savoir si l'élément est le dernier
  (`showDivider: i != _options.length - 1`).
- `_OptionTile` combine une ligne (`Row`) et un `Divider` conditionnel (`if (showDivider)`).
- `indent: 54` aligne le séparateur après l'icône, pas sous elle.

### 7.3 Commit du lot 5

```bash
git add lib/views/history/history_screen.dart lib/views/profile/profile_screen.dart
git commit -m "feat(profile): ajoute l'historique et le profil"
```

---

## 8. Lot 6 — Accueil, navigation et `main.dart` (4 fichiers)

**Objectif :** assembler tout ce qui précède dans l'écran d'accueil, brancher la navigation
et appliquer le thème global.

> C'est seulement maintenant que `home_screen.dart` peut importer `SearchScreen`,
> `HistoryScreen` et `ProfileScreen`. Si tu l'avais créé plus tôt, tu aurais eu des
> erreurs « URI doesn't exist ».

### 8.1 `lib/widgets/destination_card.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import 'network_photo.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.title,
    this.onTap,
  });

  final String imageUrl;
  final String location;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            NetworkPhoto(url: imageUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                  stops: [0.45, 1],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.28),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_outward_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 12,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**À comprendre :**

- `Stack` empile trois couches : photo → dégradé sombre → textes.
- `StackFit.expand` force la photo à remplir la carte.
- Le dégradé noir en bas rend le texte blanc lisible quelle que soit l'image.
  `stops: [0.45, 1]` : transparent jusqu'à 45 %, puis noir.
- Les éléments sont placés avec `Positioned` (coin haut droit, bas).
- `overflow: TextOverflow.ellipsis` + `maxLines: 1` évitent la casse sur les petits écrans.

### 8.2 `lib/widgets/app_bottom_nav.dart`

**Crée le fichier et colle :**

```dart
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.public_rounded,
    Icons.schedule_rounded,
    Icons.person_outline_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Material(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(37),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 74,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: List.generate(_icons.length, (index) {
                final selected = index == currentIndex;
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () => onTap(index),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: selected ? 48 : 44,
                        height: selected ? 48 : 44,
                        decoration: BoxDecoration(
                          color: selected ? AppColors.lime : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _icons[index],
                          size: 22,
                          color: selected
                              ? AppColors.dark
                              : Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
```

**À comprendre :**

- `ValueChanged<int>` est un type de fonction `void Function(int)`. Le parent décide
  de ce qui se passe au clic.
- `Material` entoure la barre pour que les `InkWell` aient une surface d'ondulation
  (sinon : `No Material widget found`).
- `AnimatedContainer` anime la taille et la couleur du cercle sélectionné.
- Chaque item est un `Expanded` : les 4 icônes se répartissent équitablement la largeur.

### 8.3 `lib/views/home/home_screen.dart`

**Remplace tout le contenu du fichier par :**

```dart
import 'package:flutter/material.dart';

import '../../models/travel_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_search_field.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/destination_card.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openSearch(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 19,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Indonesia',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                        const Spacer(),
                        CircleIconButton(
                          icon: Icons.notifications_none_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Good Morning,',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Budiarti 👋',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: AppSearchField(
                            onTap: () => _openSearch(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleIconButton(
                          icon: Icons.tune_rounded,
                          size: 56,
                          onTap: () => _openSearch(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const _CategorySelector(),
                    const SizedBox(height: 24),
                    const Text(
                      'Popular Destinations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: popularDestinations.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.82,
                          ),
                      itemBuilder: (context, index) {
                        final destination = popularDestinations[index];
                        return DestinationCard(
                          imageUrl: destination.imageUrl,
                          location: destination.location,
                          title: destination.title,
                          onTap: () => _openSearch(context),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const _HomeBottomNav(),
          ],
        ),
      ),
    );
  }
}

class _CategorySelector extends StatefulWidget {
  const _CategorySelector();

  @override
  State<_CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<_CategorySelector> {
  int _selectedIndex = 0;

  static const List<({IconData icon, String label})> _categories = [
    (icon: Icons.flight_takeoff_rounded, label: 'Flight'),
    (icon: Icons.hotel_rounded, label: 'Hotel'),
    (icon: Icons.directions_bus_rounded, label: 'Bus'),
    (icon: Icons.directions_car_filled_rounded, label: 'Car'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final category = _categories[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == _categories.length - 1 ? 0 : 10,
            ),
            child: _CategoryChip(
              icon: category.icon,
              label: category.label,
              selected: index == _selectedIndex,
              onTap: () => setState(() => _selectedIndex = index),
            ),
          );
        }),
      ),
    );
  }
}

class _HomeBottomNav extends StatefulWidget {
  const _HomeBottomNav();

  @override
  State<_HomeBottomNav> createState() => _HomeBottomNavState();
}

class _HomeBottomNavState extends State<_HomeBottomNav> {
  int _selectedIndex = 0;

  Future<void> _onTap(int index) async {
    if (index == 0) return;

    setState(() => _selectedIndex = index);

    final Widget page = switch (index) {
      1 => const SearchScreen(),
      2 => const HistoryScreen(),
      _ => const ProfileScreen(),
    };

    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );

    if (!mounted) return;
    setState(() => _selectedIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomNav(currentIndex: _selectedIndex, onTap: _onTap);
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : AppColors.textPrimary;

    return Material(
      color: selected ? AppColors.green : AppColors.cream,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17, color: foreground),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**À comprendre :**

- **Architecture :** `HomeScreen` reste un **`StatelessWidget`** : il ne porte aucun
  état. Les deux zones interactives sont des sous-widgets privés **stateful** :
  `_CategorySelector` (chip sélectionné) et `_HomeBottomNav` (onglet actif).
  Chaque `setState` ne reconstruit que sa petite zone, pas tout l'accueil.
- **Structure globale :** `SafeArea` → `Column` → `Expanded` (contenu scrollable) +
  `_HomeBottomNav` (fixe en bas). La nav ne défile pas avec le contenu.
- **`SingleChildScrollView`** permet à l'accueil de défiler sur les petits écrans.
- **En-tête :** une `Row` avec localisation à gauche et bouton notification à droite
  (`Spacer` pousse les deux extrémités).
- **Salutation :** deux `Text` séparés pour avoir deux styles sur deux lignes.
- **Recherche :** `AppSearchField` dans un `Expanded` + bouton filtre de 56 px.
- **Chips :** `_CategorySelector` contient la liste `_categories` (records) et
  `_selectedIndex`. `List.generate` construit les chips ; `setState` met à jour
  l'index ; le chip sélectionné devient vert avec texte blanc.
  `mainAxisSize: MainAxisSize.min` évite que le chip prenne toute la largeur.
- **Grille :**
  - `crossAxisCount: 2` → deux colonnes ;
  - `shrinkWrap: true` + `NeverScrollableScrollPhysics` → la grille prend la hauteur de
    son contenu et ne gère pas son propre scroll (sinon conflit avec le parent) ;
  - `childAspectRatio: 0.82` → cartes légèrement plus hautes que larges.
- **Navigation :**
  - `_openSearch(context)` empile `SearchScreen` (le `BuildContext` est passé en
    paramètre car `HomeScreen` est stateless).
  - `_HomeBottomNav` gère lui-même l'onglet actif et utilise un `switch` **expression**
    pour choisir la page.
  - `await Navigator.push` attend le retour.
  - `if (!mounted) return;` évite `setState() after dispose` : après un `await`, le
    widget peut ne plus exister. **C'est un réflexe fondamental.**
  - On remet `_selectedIndex` à 0 au retour pour que l'icône Home soit à nouveau
    sélectionnée.

### 8.4 `lib/main.dart`

**Remplace tout le contenu par :**

```dart
import 'package:africatrip/theme/app_theme.dart';
import 'package:africatrip/views/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Africa Trip',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}
```

**À comprendre :**

- `MaterialApp` est la racine : thème, titre, navigation.
- `debugShowCheckedModeBanner: false` retire le bandeau « DEBUG » du design.
- `theme: AppTheme.light` applique les couleurs du lot 1 à toute l'application.
- `home: const HomeScreen()` définit l'écran de démarrage.

### 8.5 Vérification complète

```bash
flutter analyze
flutter run -d windows
```

**Parcours à tester :**

1. L'accueil affiche salutation, recherche, 4 chips, 4 destinations, barre du bas.
2. Le champ de recherche (ou une carte destination) ouvre **Search**.
3. Une date différente s'illumine au clic.
4. Une carte de billet ouvre **Boarding Pass** avec QR et détails.
5. Le bouton retour revient à l'écran précédent.
6. La barre du bas ouvre Search / History / Profile.
7. Aucune rayure jaune d'overflow, aucune erreur dans la console.

### 8.6 Commit du lot 6

```bash
git add lib/widgets/destination_card.dart lib/widgets/app_bottom_nav.dart lib/views/home/home_screen.dart lib/main.dart
git commit -m "feat(home): implemente l'ecran d'accueil complet"
```

---

## 9. Lot 7 — Tests (1 fichier)

**Objectif :** remplacer le test du template Flutter (qui vérifie un compteur inexistant)
par deux tests qui décrivent réellement l'application.

### 9.1 `test/widget_test.dart`

**Remplace tout le contenu par :**

```dart
import 'package:africatrip/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen shows greeting and destinations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Good Morning,'), findsOneWidget);
    expect(find.text('Budiarti 👋'), findsOneWidget);
    expect(find.text('Popular Destinations'), findsOneWidget);
    expect(find.text('Lake Pukaki'), findsOneWidget);
  });

  testWidgets('Search field opens the search screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Search here...'));
    await tester.pumpAndSettle();

    expect(find.text('Select Date'), findsOneWidget);
    expect(find.textContaining('Tickets Found'), findsOneWidget);
  });
}
```

**À comprendre :**

- `testWidgets` exécute le test dans un environnement Flutter simulé (pas besoin
  d'émulateur).
- `tester.pumpWidget(const MyApp())` construit l'application comme au démarrage.
- `find.text('...')` cherche un texte **exact**.
- `find.textContaining('Tickets Found')` cherche une sous-chaîne : indispensable pour
  « 8 Tickets Found », car le nombre change.
- `tester.tap(...)` simule un appui.
- `tester.pumpAndSettle()` attend la fin des animations et transitions (navigation).
- `findsOneWidget` vérifie qu'il existe exactement un widget correspondant ;
  `findsNothing` vérifie l'absence.
- En test, les requêtes réseau des images échouent (HTTP 400). C'est `errorBuilder`
  du lot 1 qui empêche l'écran de planter. Sans lui, ces tests échoueraient.

### 9.2 Lancer les tests

```bash
flutter test
```

Attendu :

```text
00:00 +0: Home screen shows greeting and destinations
00:00 +1: Search field opens the search screen
00:01 +2: All tests passed!
```

### 9.3 Commit du lot 7

```bash
git add test/widget_test.dart
git commit -m "test: ajoute les tests de l'accueil et de la recherche"
```

---

## 10. Vérifier et comparer avec la solution

### 10.1 Vérification finale

```bash
flutter analyze
flutter test
```

Attendu : `No issues found!` et `All tests passed!`.

### 10.2 Comparer ta branche avec `master`

```bash
git diff feat/complete master --stat
```

- Si la commande n'affiche **rien** : ton arbre est identique à la solution.
- Si elle affiche des fichiers : compare-les un par un, par exemple :

```bash
git diff feat/complete master -- lib/widgets/ticket_card.dart
```

Rappel de lecture d'un diff :

- lignes précédées de `-` : présentes dans `master` mais absentes chez toi ;
- lignes précédées de `+` : présentes chez toi mais absentes dans `master`.

> L'ordre ou le découpage des commits peut différer de `master` sans que ce soit un
> problème : seul l'arbre final doit correspondre.

### 10.3 Les différentes façons de récupérer le travail complet

**A. Rester sur ta branche d'apprentissage** (recommandé) : continue à coder, puis
compare avec `master` comme ci-dessus.

**B. Voir directement la solution :**

```bash
git switch master
```

**C. Créer une branche propre depuis la solution :**

```bash
git switch -c feat/from-master master
```

**D. Copier la solution dans ta branche actuelle** (écrase tes fichiers) :

```bash
git restore --source=master -- lib test
git commit -m "feat: applique la solution complete"
```

> L'option D est destructive : elle remplace `lib/` et `test/` par les versions de
> `master`. À n'utiliser que si tu veux abandonner ta version.

### 10.4 Nettoyage éventuel

Si tu as créé une branche d'essai dont tu ne veux plus :

```bash
git switch feat/complete
git branch -d feat/essai
```

(`-d` refuse la suppression si la branche n'est pas fusionnée ; `-D` force.)

---

## 11. Dépannage

| Symptôme | Cause probable | Solution |
| --- | --- | --- |
| `No Material widget found` | `InkWell` sans ancêtre `Material` | Envelopper dans `Material` |
| Rayures jaunes / noires « overflow » | Contenu trop large ou trop haut | `SingleChildScrollView`, `Expanded`, `ellipsis`, `childAspectRatio` |
| `Vertical viewport was given unbounded height` | `ListView` ou `GridView` dans une `Column` | `shrinkWrap: true` + `NeverScrollableScrollPhysics` |
| `setState() called after dispose` | `setState` après un `await` | Ajouter `if (!mounted) return;` |
| Image grise / erreur réseau | URL inaccessible ou test | `errorBuilder` + fallback |
| Le thème ne s'applique pas | Hot reload insuffisant | Hot **restart** (`R`) |
| `URI doesn't exist` | Import d'un fichier pas encore créé | Respecter l'ordre des lots |
| Test échoue sur « 8 Tickets Found » | `find.text` est exact | `find.textContaining` |
| Les dates ne changent pas de couleur | Oubli de `setState` | Mettre à jour dans un `setState` |
| La barre du bas ne revient pas à Home | Index non réinitialisé | Remettre `_selectedIndex = 0` après le `pop` (dans `_HomeBottomNavState`) |
| `Target of URI hasn't been generated` | `flutter pub get` non lancé | `flutter pub get` |
| Icônes cassées | `uses-material-design` absent | Vérifier `pubspec.yaml` (`uses-material-design: true`) |

### Erreurs de compilation fréquentes

- **Oubli d'import** : `Text`, `Column`, `Icons` viennent de `package:flutter/material.dart`.
- **Mauvais chemin relatif** : depuis `lib/views/home/`, un widget est dans
  `../../widgets/...` (deux niveaux au-dessus), un modèle dans `../../models/...`.
- **Const incorrect** : un widget `const` ne peut pas contenir une valeur non constante.
  Si Flutter se plaint, retire `const` sur le widget parent.

---

## 12. Pour aller plus loin

Une fois le tutoriel terminé, voici des améliorations naturelles :

1. **Images locales** : télécharge les photos dans `assets/images/`, déclare
   `assets:` dans `pubspec.yaml`, remplace `Image.network` par `Image.asset`.
2. **Vraie recherche** : remplace `AppSearchField` par un `TextField`, ajoute un bouton
   de soumission, un état `loading`, une gestion d'erreur et un appel HTTP
   (`package:http` ou `dio`).
3. **État global** : quand les données viennent d'une API, utilise `Riverpod`,
   `Provider` ou `Bloc` au lieu de `setState`.
4. **Navigation avancée** : `go_router` pour des routes nommées et des deep links.
5. **Vrai QR** : package `qr_flutter` (`QrImageView(data: ...)`).
6. **Persistance** : `shared_preferences` ou `hive` pour sauvegarder les billets.
7. **Polices** : `google_fonts` pour se rapprocher du design (prévoir un fallback
   hors ligne).
8. **Responsive** : `LayoutBuilder` et `MediaQuery` au lieu des dimensions fixes.
9. **Thème sombre** : ajouter `darkTheme` et `themeMode` dans `MaterialApp`.
10. **Tests plus poussés** : tests de navigation, tests de widgets isolés,
    `golden tests` pour comparer des captures.
11. **Accessibilité** : `Semantics`, contrastes suffisants, tailles de texte adaptatives.
12. **Internationalisation** : `flutter_localizations` + fichiers ARB.

---

## 13. Checklist finale

- [ ] Branche `feat/complete` créée depuis `feat/begin`
- [ ] Lot 1 commité (thème + 3 widgets)
- [ ] Lot 2 commité (modèles + route + billet)
- [ ] Lot 3 commité (QR + boarding pass)
- [ ] Lot 4 commité (recherche)
- [ ] Lot 5 commité (historique + profil)
- [ ] Lot 6 commité (accueil + nav + `main.dart`)
- [ ] Lot 7 commité (tests)
- [ ] `flutter analyze` → aucun problème
- [ ] `flutter test` → 2 tests passés
- [ ] Navigation Home → Search → Boarding Pass fonctionnelle
- [ ] Navigation Home → History / Profile fonctionnelle
- [ ] `HomeScreen` est un `StatelessWidget` (état dans `_CategorySelector` et `_HomeBottomNav`)
- [ ] Aucun overflow visuel
- [ ] `git diff feat/complete master --stat` → vide
- [ ] Chaque commit contient au maximum 4 fichiers
- [ ] Chaque message de commit décrit ce qui a été fait

---

## Annexe — Mémo Git

```bash
# État et historique
git status
git log --oneline --graph --all
git branch

# Branches
git switch feat/begin          # changer de branche
git switch -c feat/complete    # créer + changer
git branch -d nom              # supprimer une branche fusionnée

# Commits par lot
git add fichier1 fichier2
git commit -m "type(scope): description"

# Comparer
git diff                       # non indexé
git diff --staged              # indexé
git diff feat/complete master  # différence entre deux branches
git show master:lib/main.dart  # afficher une version d'un fichier

# Récupérer une version
git restore --source=master -- lib test
git restore fichier.dart       # annuler les modifications non indexées
```

### Convention de message

```text
type(scope): description courte à l'infinitif

Types courants :
- feat     : nouvelle fonctionnalité
- fix      : correction de bug
- refactor : réorganisation sans changement de comportement
- test     : ajout/modification de tests
- docs     : documentation
- chore    : tâches techniques (config, dépendances)
- style    : formatage uniquement
```

Exemples utilisés dans ce tutoriel :

```text
feat(ui): ajoute le theme et les widgets de base
feat(flight): ajoute le modele et les widgets de vol
feat(boarding): ajoute le boarding pass et le QR code
feat(search): ajoute la recherche de vols et la liste des billets
feat(profile): ajoute l'historique et le profil
feat(home): implemente l'ecran d'accueil complet
test: ajoute les tests de l'accueil et de la recherche
```

---

**Fin du tutoriel.** Tu es maintenant capable de reconstruire l'application complète,
de comprendre chaque widget et de comparer ton travail avec la branche `master`.

