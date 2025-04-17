## Auteurs
Martin Hugo
Strippoli Jules
Couly Guilhem

# TV Shows App
 Cinemzaz est une application mobile développée avec Flutter permettant aux utilisateurs de découvrir des séries télévisées populaires, de rechercher des séries et de consulter leurs détails. L'application utilise l'API publique d’Episodate.
## Fonctionnalités
 - Recherche de séries par nom
 - Affichage paginé des séries populaires 
 - Navigation vers un écran de détails
 - Affichage complet des informations d'une série (titre, image, description) 
## Technologies utilisées
 - http (pour utiliser l’API REST)
 - Flutter 
 - provider + ChangeNotifier (gestion d’état)
 - Navigator (navigation entre écrans) 
## API utilisée
 - Endpoint recherche :     https://www.episodate.com/api/search?q=:name&page=:page
 - Endpoint séries populaires :     https://www.episodate.com/api/mostpopular?page=:page  
 - Endpoint détails :     https://www.episodate.com/api/show-details?q=:id 

## Contraintes
 - Interface responsive et fluide
 - Affichage d’un indicateur de chargement pendant les requêtes
 - Gestion des cas d’erreurs (pas de résultat, erreur API, etc.)
## Livrables
 
 - Application Flutter fonctionnelle avec deux pages :
 - Liste des séries avec recherche
 - Détail d’une série sélectionnée
 - Documentation (README)
