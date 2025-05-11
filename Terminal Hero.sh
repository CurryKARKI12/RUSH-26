#!/bin/bash
# TERMINAL HERO - Jeu éducatif Bash

# Objectif : Apprendre les commandes terminal en s'amusant

# 1. INITIALISATION =================================
clear  # Efface l'écran pour un démarrage propre

# Affichage ASCII Art pour le titre

echo "Bienvenue dans votre aventure en ligne de commande !"
echo ""

# 1.1 DEMANDE DU NOM ================================
echo "─── CONFIGURATION DU JOUEUR ───────────────────"

while true; do
    read -p "Entrez votre prénom (20 lettres max) : " player_name
    
    # Nettoyage de la saisie
    player_name=$(echo "$player_name" | tr -d ' ' | tr -d '[:digit:]')  # Supprime espaces et chiffres
    
    # Validation
    if [[ -z "$player_name" ]]; then
        echo "⚠ Erreur : Vous devez entrer un nom"
    elif [[ ${#player_name} -gt 20 ]]; then
        echo "⚠ Erreur : 20 caractères maximum"
    else
        # Formatage : Première lettre en majuscule
        player_name=$(echo "${player_name^}")
        break  # Sort de la boucle si le nom est valide
    fi
done

# 1.2 PRÉPARATION DU JEU ============================
echo ""
echo "─── PRÉPARATION ───────────────────────────────"

# Création du dossier de sauvegarde s'il n'existe pas
if [ ! -d "game_saves" ]; then
    mkdir game_saves
    echo "✓ Dossier 'game_saves' créé avec succès"
else
    echo "✓ Dossier 'game_saves' déjà présent"
fi

# 2. JEU PRINCIPAL ==================================
score=0  # Initialisation du score total

echo ""
echo "==============================================="
echo "            DÉBUT DE L'AVENTURE"
echo "==============================================="
echo ""

# 2.1 NIVEAU 1 - ECHO ===============================
echo "==============================================="
echo "          NIVEAU 1 : AFFICHAGE DE TEXTE"
echo "==============================================="
echo ""
echo "But : Apprendre à afficher du texte dans le terminal"
echo "Points possibles : 1 point"
echo ""

read -p "Quelle commande affiche 'Hello, World!' ? " reponse

# Vérification de la réponse (accepte plusieurs formats)
if [[ "$reponse" =~ ^echo(\ )+[\"\']?Hello,[\ ]+World![\"\']?$ ]]; then
    echo ""
    echo "✓ Bravo $player_name ! Bonne réponse : echo 'Hello, World!'"
    ((score++))  # Ajoute 1 point au score
    echo "→ Vous gagnez 1 point ! Score actuel : $score/6"
else
    echo ""
    echo "✘ Presque ! La bonne réponse était : echo 'Hello, World!'"
    echo "→ Score actuel : $score/6"
fi

# 2.2 NIVEAU 2 - DATE ===============================
echo ""
echo ""
echo "==============================================="
echo "          NIVEAU 2 : MANIPULATION DE DATE"
echo "==============================================="
echo ""
echo "But : Comprendre comment formater l'heure actuelle"
echo "Points possibles : 2 points"
echo ""

current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Quelle commande donne ce format :"
echo "$current_time"

read -p "Votre réponse : " reponse

if [[ "$reponse" == "date '+%Y-%m-%d %H:%M:%S'" ]]; then
    echo ""
    echo "✓ Excellent $player_name ! Vous maîtrisez la commande date"
    ((score+=2))  # Ajoute 2 points au score
    echo "→ Vous gagnez 2 points ! Score actuel : $score/6"
else
    echo ""
    echo "✘ Voici la solution : date '+%Y-%m-%d %H:%M:%S'"
    echo "→ Score actuel : $score/6"
fi

# 2.3 NIVEAU 3 - FICHIERS ===========================
echo ""
echo ""
echo "==============================================="
echo "          NIVEAU 3 : GESTION DE FICHIERS"
echo "==============================================="
echo ""
echo "But : Apprendre à manipuler les fichiers"
echo "Points possibles : 3 points"
echo ""

echo "Création d'un fichier secret à deviner"
secret_file="game_saves/piscine_${player_name}_$(date '+%Y').txt"
echo "Fichier personnel pour $player_name" > "$secret_file"

echo "Devinez le nom du fichier créé :"
ls game_saves  # Affiche le contenu du dossier

read -p "Nom complet du fichier : " reponse

if [ -f "game_saves/$reponse" ]; then
    echo ""
    echo "✓ Incroyable $player_name ! Vous avez trouvé : $(basename "$secret_file")"
    ((score+=3))  # Ajoute 3 points au score
    echo "→ Vous gagnez 3 points ! Score actuel : $score/6"
    rm "$secret_file"  # Supprime le fichier temporaire
else
    echo ""
    echo "✘ Le fichier était : $(basename "$secret_file")"
    echo "→ Score actuel : $score/6"
fi

# 3. RÉSULTATS FINAUX ===============================
echo ""
echo ""
echo "==============================================="
echo "             RÉSULTATS FINAUX"
echo "==============================================="
echo ""
echo "Score final de $player_name : $score/6"
echo ""

# Message personnalisé selon le score
if [ $score -eq 6 ]; then
    echo "🌟🌟🌟 PERFORMANCE PARFAITE 🌟🌟🌟"
    echo "Vous êtes un véritable Terminal Hero !"
elif [ $score -ge 4 ]; then
    echo "🌟🌟 BONNE PERFORMANCE 🌟🌟"
    echo "Quelques révisions et vous serez parfait !"
elif [ $score -ge 2 ]; then
    echo "🌟 DÉBUT PROMETTEUR 🌟"
    echo "Continuez à pratiquer !"
else
    echo "💪 COURAGE !"
    echo "Le terminal est un outil puissant qui s'apprend avec le temps."
fi

# Sauvegarde des résultats
echo "$(date '+%Y-%m-%d %H:%M') - $player_name : $score/6" >> game_saves/scores.log
echo ""
echo "Votre score a été sauvegardé dans game_saves/scores.log"
echo ""
echo "Merci d'avoir joué, $player_name ! À bientôt pour de nouvelles aventures."
echo ""

exit 0  # Fin du script avec code de succès