# app/models/post.rb
# Ce fichier définit une classe Post dans le dossier des modèles de l'application.

class Post
  # Définition de la classe Post.

  include Moderable
  # Inclusion du module Moderable. Cela signifie que toutes les méthodes définies dans Moderable sont maintenant disponibles comme méthodes d'instance dans la classe Post.

  # Attributs de la classe Post
  attr_accessor :taxt, :language
  # Définition des accesseurs pour les attributs "taxt" et "language". Cela signifie que vous pouvez obtenir et définir ces attributs avec les méthodes "taxt" et "taxt=", et "language" et "language=".

  def initialize(taxt, language)
    # Définition de la méthode d'initialisation de la classe. Cette méthode est appelée lorsque vous créez une nouvelle instance de la classe avec Post.new(taxt, language).

    @taxt = taxt
    @language = language
    # Ces deux lignes définissent les attributs "taxt" et "language" de l'instance à partir des arguments passés à la méthode d'initialisation.

    @is_accepted = nil 
    # Initialisation de l'attribut "is_accepted" à nil. Cet attribut sera utilisé pour stocker le résultat de la modération du contenu.

    moderate_content 
    # Appel de la méthode "moderate_content" qui est définie dans le module Moderable. Cette méthode modère le contenu du post.

  end

  # Logique spécifique à la classe Post
  # Ici, vous pouvez ajouter toute logique spécifique à la classe Post.
end