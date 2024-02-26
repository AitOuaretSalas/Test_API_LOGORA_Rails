# test/models/concerns/moderable_test.rb
# Ce fichier est un fichier de test pour le module Moderable.

require 'test_helper'
# Importe le fichier test_helper, qui est généralement utilisé pour configurer l'environnement de test.


class ModerableTest < ActiveSupport::TestCase
  # Définit une nouvelle classe de test qui hérite de ActiveSupport::TestCase. ActiveSupport::TestCase est une classe de base pour les tests dans Rails.

  test "should set is_accepted after moderation" do
    # Définit un nouveau test. Le test vérifie que l'attribut "is_accepted" est défini après la modération.

    post = Post.new("Text to moderate", "en")
    # Crée une nouvelle instance de la classe Post avec le texte "Text to moderate" et la langue "en".

    post.moderate_content
    # Appelle la méthode "moderate_content" sur l'instance de Post. Cette méthode est définie dans le module Moderable et modère le contenu du post.

    assert_not_nil post.is_accepted
    # Vérifie que l'attribut "is_accepted" de l'instance de Post n'est pas nil. Si "is_accepted" est nil, le test échoue.
  end
end