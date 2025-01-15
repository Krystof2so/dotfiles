# Ghostty

**Ghostty** est un émulateur de terminal qui allie rapidité, richesse fonctionnelle et interface native. Bien qu'il existe de nombreux émulateurs de terminal excellents, ils vous obligent tous à choisir entre la vitesse, les fonctionnalités ou les interfaces natives. Ghostty offre les trois. C'est ce que précise Mitchell Hashimoto, l'initiateur du projet.

**Ghostty** est une application native pour **macOS** et **Linux**. Sous **Linux**, l'interface graphique est écrite en **Zig** et utilise l'**API C** de **GTK41**. **Ghostty** utilise des raccourcis qui permettent de respecter les conventions de chaque plateforme.

**Ghostty** s'efforce de fournir un ensemble riche de fonctionnalités utiles au quotidien. Celles-ci peuvent être divisées en deux catégories : les fonctionnalités du terminal et les fonctionnalités de l'application.

## Configuration

**Ghostty** propose des centaines d'options de configuration pour lui donner l'aspect et le comportement que vous souhaitez. Voir la [documentation de référence](https://ghostty.org/docs/config/reference) pour la configuration.  

**Ghostty** est conçu pour fonctionner sans aucune configuration pour la plupart des utilisateurs. **Ghostty** a des valeurs par défaut raisonnables, intègre une police par défaut (**JetBrains Mono**), a des polices intégrées pour les *nerds*, et bien d'autres choses encore.

Actuellement (*version 1.0.1*), la configuration textuelle est la seule façon de configurer **Ghostty**.

Fichier de configuration : `~/dotfiles/ghostty_conf`. La configuration peut toutefois être répartie sur [plusieurs fichiers](https://ghostty.org/docs/config#splitting-into-multiple-files). Recharger le fichier de configuration : `<Ctrl> + <Shift> + <,>`.

**Ghostty** utilise une syntaxe très simple : `clé = valeur`. Les commentaires commencent par un `#` et ne sont valables que sur leur propre ligne. Les lignes vides sont ignorées. Les valeurs vides réinitialisent la configuration à la valeur par défaut (`clé = `). Il est à noter qu'avec **Ghostty** les clés sont toujours en minuscule. Les valeurs peuvent être entre guillemets ou pas : `font-family = "JetBrains Mono"` est identique à `font-family = JetBrains Mono`. Chaque clé de configuration est un drapeau CLI valide lorsque **Ghostty** est lancé à partir de la ligne de commande. Par exemple, la clé `background` peut être définie avec `$ ghostty --background=282c34`.

### La police d'écriture

Les clés de configuration :
- **font-family**
- **font-family-bold**
- **font-family-italic**
- **font-family-bold-italic**

Pour une liste des valeurs possibles : `$ ghostty +list-fonts`

Autres clés :
- **font-style**
- **font-style-bold**
- **font-style-italic**
- **font-style-bold-italic**
- **font-synthetic-style**
- **font-feature**
- **font-size**
- **font-variation**
- **font-variation-bold**
- **font-variation-italic**
- **font-variation-bold-italic**
- **font-codepoint-map**
- **font-thicken** (uniquement sur **macOS**)

### Ajustements

Liste des clés :
- **adjust-cell-width**
- **adjust-cell-height**
- **adjust-font-baseline**
- **adjust-underline-position**
- **adjust-underline-thickness**
- **adjust-strikethrough-position**
- **adjust-strikethrough-thickness**
- etc...


[suite](https://ghostty.org/docs/config/reference)
