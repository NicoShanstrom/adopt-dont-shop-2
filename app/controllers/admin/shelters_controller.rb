class Admin::SheltersController < ApplicationController
    def index
        @shelters = Shelter.reverse_abc
        @pending_shelters = Shelter.pending_shelters
    end
end