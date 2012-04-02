class SemestersController < ApplicationController
  before_filter :authenticate_administrator!
  inherit_resources
  defaults finder: :find_using_slug
end
