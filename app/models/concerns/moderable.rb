# app/models/concerns/moderable.rb
# Ce fichier est un module de préoccupation (concern) dans Rails, qui est une façon de rendre le code plus modulaire.

require 'net/http'
require 'json'
# Ces deux lignes importent les bibliothèques nécessaires pour faire des requêtes HTTP et pour manipuler les données JSON.

module Moderable
  extend ActiveSupport::Concern
  # Ceci définit un nouveau module appelé "Moderable". "extend ActiveSupport::Concern" est une spécificité de Rails qui permet d'ajouter des méthodes d'instance et de classe à un module.

  included do
    attr_accessor :is_accepted
  end
  # "included do" est une méthode de ActiveSupport::Concern qui est exécutée lorsque le module est inclus dans une autre classe. Ici, elle ajoute un accesseur pour l'attribut "is_accepted".

  def moderate_content
    # Cette méthode est utilisée pour modérer le contenu.

    if taxt.present? && language.present?
      # Vérifie si les attributs "taxt" et "language" sont présents.

      moderation_result = call_moderation_api(taxt, language)
      # Appelle l'API de modération avec "taxt" et "language" comme arguments.

      self.is_accepted = moderation_result ? true : false
      # Si le résultat de l'API de modération est vrai, alors "is_accepted" est défini à vrai, sinon il est défini à faux.
    end
  end

  def call_moderation_api(text, language)
    # Cette méthode appelle l'API de modération.

    encoded_text = URI.encode_www_form_component(text)
    encoded_language = URI.encode_www_form_component(language)
    # Ces deux lignes encodent "text" et "language" pour qu'ils puissent être utilisés dans une URL.

    uri = URI("https://moderation.logora.fr/predict?text=#{encoded_text}&language=#{encoded_language}")
    # Crée une nouvelle URI avec le texte et la langue encodés.

    response = Net::HTTP.get_response(uri)
    # Fait une requête GET à l'URI et stocke la réponse.

    if response.is_a?(Net::HTTPSuccess)
      # Vérifie si la réponse est un succès.

      result = JSON.parse(response.body)
      # Parse le corps de la réponse en JSON.

      return result["prediction"] > 0.5
      # Si la prédiction est supérieure à 0.5, retourne vrai, sinon retourne faux.
    else
      Rails.logger.error("Error calling moderation API: #{response.message}")
      # Si la réponse n'est pas un succès, enregistre une erreur avec le message de la réponse.

      return false
      # Retourne faux.
    end
  rescue => e
    Rails.logger.error("Error calling moderation API: #{e.message}")
    # Si une exception est levée lors de l'appel à l'API, enregistre une erreur avec le message de l'exception.

    return false
    # Retourne faux.
  end
end