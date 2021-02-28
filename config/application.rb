# frozen_string_literal: true

require './config/folder_loader'

module Config
  # When the applications start it loads all the folders of the project
  class Application
    def self.start
      Config::FolderLoader.new.load
    end
  end
end
