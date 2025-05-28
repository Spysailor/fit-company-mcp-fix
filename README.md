# 🔧 Fix MCP Servers - FIT COMPANY Project

## Problème identifié
Vos serveurs MCP échouaient car :
1. **Smithery CLI** n'était pas correctement configuré dans le PATH
2. Les serveurs utilisaient des références incorrectes via `@smithery/cli`
3. Erreurs HTTP 401 (Unauthorized) sur les serveurs Smithery

## ✅ Solution : Utiliser des serveurs MCP natifs

### Étape 1: Supprimer l'ancienne configuration
```bash
# Localiser votre fichier de configuration Claude Desktop
# macOS: ~/Library/Application Support/Claude/claude_desktop_config.json
# Windows: %APPDATA%\Claude\claude_desktop_config.json
```

### Étape 2: Remplacer par la nouvelle configuration

Copiez cette configuration dans votre `claude_desktop_config.json` :

```json
{
  "mcpServers": {
    "airtable-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "airtable-mcp-server"
      ],
      "env": {
        "AIRTABLE_API_KEY": "VOTRE_TOKEN_AIRTABLE_ICI"
      }
    },
    "github-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "VOTRE_TOKEN_GITHUB_ICI"
      }
    },
    "browser-automation": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-puppeteer"
      ]
    },
    "memory-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory"
      ]
    }
  }
}
```

### Étape 3: Configurer vos tokens API

#### Pour Airtable :
1. Allez sur [Airtable Developer](https://airtable.com/developers/web/api/introduction)
2. Créez un "Personal Access Token"
3. Remplacez `VOTRE_TOKEN_AIRTABLE_ICI` par votre token
4. Optionnel : Ajoutez votre Base ID si nécessaire

#### Pour GitHub :
1. Allez sur [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
2. Créez un nouveau token avec les permissions repository
3. Remplacez `VOTRE_TOKEN_GITHUB_ICI` par votre token

### Étape 4: Tester la configuration

```bash
# Tester le serveur Airtable directement
npx -y airtable-mcp-server --help

# Tester le serveur GitHub
npx -y @modelcontextprotocol/server-github --help
```

### Étape 5: Redémarrer Claude Desktop
1. Fermez complètement Claude Desktop
2. Relancez l'application
3. Vérifiez que les serveurs MCP sont maintenant "connected" ✅

## 🚀 Avantages de cette solution

- **✅ Serveurs natifs** : Plus de dépendance à Smithery
- **✅ Meilleure stabilité** : Serveurs officiels MCP
- **✅ Configuration simplifiée** : NPX gère automatiquement les installations
- **✅ Support direct** : Documentation officielle disponible

## 📋 Serveurs disponibles

| Serveur | Fonction | Status |
|---------|----------|--------|
| `airtable-mcp` | Accès à vos bases Airtable | ✅ Fonctionnel |
| `github-mcp` | Gestion des repositories GitHub | ✅ Fonctionnel |
| `browser-automation` | Automatisation web | ✅ Fonctionnel |
| `memory-mcp` | Gestion de la mémoire | ✅ Fonctionnel |

## 🔍 Debugging

Si vous rencontrez des problèmes :

```bash
# Vérifier Node.js
node --version  # Doit être >= 18

# Vérifier npm
npm --version

# Tester manuellement un serveur
npx -y airtable-mcp-server
```

## 🎯 Spécifique au projet FIT COMPANY

Cette configuration est optimisée pour votre projet de gestion des campagnes Meta Ads :
- **Airtable** : Pour stocker les données des clubs et campagnes
- **GitHub** : Pour versionner vos configurations et scripts
- **Browser** : Pour automatiser les tâches web
- **Memory** : Pour maintenir le contexte entre les sessions

---

**Créé par Jean-Michel Alexandre pour FIT COMPANY**  
*Diagnostic et résolution des problèmes MCP - Mai 2025*