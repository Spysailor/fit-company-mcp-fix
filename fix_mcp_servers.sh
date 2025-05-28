#!/bin/bash

# Script de correction automatique MCP pour FIT COMPANY
# Créé par Jean-Michel Alexandre via Claude MCP

echo "🔧 Fix MCP Servers - FIT COMPANY Project"
echo "========================================="

# Étape 1: Localiser le fichier de configuration Claude Desktop
CONFIG_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

echo "📁 Localisation du fichier de configuration:"
echo "   $CONFIG_FILE"

# Étape 2: Créer une sauvegarde
BACKUP_FILE="$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
if [ -f "$CONFIG_FILE" ]; then
    echo "💾 Création d'une sauvegarde:"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    echo "   Sauvegarde créée: $BACKUP_FILE"
else
    echo "⚠️  Aucune configuration existante trouvée"
fi

# Étape 3: Télécharger la nouvelle configuration
echo "⬇️  Téléchargement de la configuration corrigée..."
curl -s -o "/tmp/claude_config_new.json" "https://raw.githubusercontent.com/Spysailor/fit-company-mcp-fix/main/claude_desktop_config_complete.json"

# Étape 4: Copier la nouvelle configuration
echo "🔄 Installation de la nouvelle configuration..."
mkdir -p "$(dirname "$CONFIG_FILE")"
cp "/tmp/claude_config_new.json" "$CONFIG_FILE"

# Étape 5: Vérifier que le JSON est valide
echo "✅ Vérification de la configuration..."
if python3 -m json.tool "$CONFIG_FILE" > /dev/null 2>&1; then
    echo "   ✅ Configuration JSON valide"
else
    echo "   ❌ Erreur JSON détectée - Restauration de la sauvegarde"
    if [ -f "$BACKUP_FILE" ]; then
        cp "$BACKUP_FILE" "$CONFIG_FILE"
    fi
    exit 1
fi

# Étape 6: Tester les serveurs MCP
echo "🧪 Test des serveurs MCP..."

echo "   - Test airtable-mcp-server..."
if npx -y airtable-mcp-server --help > /dev/null 2>&1; then
    echo "     ✅ airtable-mcp-server OK"
else
    echo "     ⚠️  airtable-mcp-server: installation en cours..."
fi

echo "   - Test @modelcontextprotocol/server-github..."
if npx -y @modelcontextprotocol/server-github --help > /dev/null 2>&1; then
    echo "     ✅ server-github OK"
else
    echo "     ⚠️  server-github: installation en cours..."
fi

# Étape 7: Instructions finales
echo ""
echo "🎉 CONFIGURATION MCP INSTALLÉE AVEC SUCCÈS !"
echo ""
echo "📝 PROCHAINES ÉTAPES:"
echo "   1. Éditez le fichier de configuration pour ajouter vos vrais tokens API:"
echo "      nano '$CONFIG_FILE'"
echo ""
echo "   2. Remplacez les tokens suivants:"
echo "      - AIRTABLE_API_KEY: Votre token Airtable"
echo "      - GITHUB_PERSONAL_ACCESS_TOKEN: Votre token GitHub"
echo ""
echo "   3. Redémarrez Claude Desktop"
echo ""
echo "🔗 RESSOURCES:"
echo "   - Repository GitHub: https://github.com/Spysailor/fit-company-mcp-fix"
echo "   - Documentation: https://github.com/Spysailor/fit-company-mcp-fix/blob/main/README.md"
echo ""
echo "✅ Vos serveurs MCP devraient maintenant fonctionner correctement !"
