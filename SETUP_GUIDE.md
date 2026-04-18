# Guide d'Installation et de Lancement - SSID Project

Ce guide vous explique étape par étape comment installer Flutter, télécharger le projet et lancer l'application mobile SSID (Smart System for Integrated Data).

---

## 1. Prérequis Système
Avant de commencer, assurez-vous d'avoir :
- Un ordinateur (Windows, macOS ou Linux).
- Une connexion Internet stable.
- Un éditeur de code recommandé : [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio).

---

## 2. Comment installer Flutter
Flutter est le framework utilisé pour cette application. Voici comment l'installer :

### Étape A : Télécharger le SDK Flutter
1. Rendez-vous sur la page officielle : [flutter.dev/docs/get-started](https://docs.flutter.dev/get-started/install).
2. Choisissez votre système d'exploitation (ex: Windows).
3. Téléchargez le pack d'installation `.zip` le plus récent.
4. Extrayez le fichier dans un dossier stable (ex: `C:\src\flutter`). **Ne l'installez pas dans un dossier système comme C:\Program Files.**

### Étape B : Configurer les Variables d'Environnement (Path)
1. Dans la barre de recherche Windows, tapez "Environnement" et choisissez **Modifier les variables d'environnement système**.
2. Cliquez sur **Variables d'environnement**.
3. Dans "Variables utilisateur", cherchez la variable **Path** et cliquez sur **Modifier**.
4. Cliquez sur **Nouveau** et ajoutez le chemin vers le dossier `bin` de Flutter (ex: `C:\src\flutter\bin`).
5. Validez tout et redémarrez votre terminal (PowerShell ou CMD).

### Étape C : Vérifier l'installation
Ouvrez votre terminal et tapez :
```bash
flutter doctor
```
Cela vous indiquera s'il manque des composants (comme Android SDK ou Visual Studio). Suivez les instructions affichées pour corriger les éventuels problèmes.

---

## 3. Comment télécharger le projet
Vous pouvez télécharger le projet directement depuis GitHub.

1. Installez **Git** si vous ne l'avez pas encore : [git-scm.com](https://git-scm.com/downloads).
2. Créez un dossier sur votre PC pour le projet.
3. Ouvrez un terminal dans ce dossier et tapez :
   ```bash
   git clone https://github.com/AymaneIK/SSID.git
   ```
4. Naviguez dans le dossier du projet :
   ```bash
   cd SSID
   ```

---

## 4. Comment lancer l'application
Une fois que Flutter est installé et que vous avez téléchargé le code :

### Étape 1 : Préparation
Allez dans le dossier de l'application mobile :
```bash
cd mobile_app
```

### Étape 2 : Récupérer les dépendances
Tapez la commande suivante pour télécharger les bibliothèques nécessaires :
```bash
flutter pub get
```

### Étape 3 : Lancer l'application
Vous pouvez lancer l'application sur différents supports :

- **Sur le Web (Lancement rapide) :**
  ```bash
  flutter run -d chrome
  ```

- **Sur un Émulateur ou Mobile Réel :**
  Connectez votre téléphone ou lancez un émulateur, puis tapez :
  ```bash
  flutter run
  ```

---

## 5. Ce dont vous avez besoin pour le lancement
Pour que l'application fonctionne parfaitement avec toutes les fonctionnalités récentes :
- **Flutter SDK version >= 3.11.4**.
- **Dart SDK version >= 3.11.4**.
- Les fichiers d'assets (comme `map_mockup.png`) doivent être présents dans le dossier `assets/`.
- Accès Internet pour charger les polices Google Fonts et les éventuelles données distantes.

---

> [!TIP]
> Si vous utilisez **VS Code**, installez l'extension officielle **Flutter** pour pouvoir lancer l'application en appuyant simplement sur `F5`.
