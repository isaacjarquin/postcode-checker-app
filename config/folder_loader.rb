# frozen_string_literal: true

module Config
  # Iterates over the folders and load every file before the server start.
  class FolderLoader
    def load
      app_folders.each do |folder|
        Dir[folder].sort.each do |file|
          require file
        end
      end
    end

    private

    def app_folders
      [
        './app/controllers/**/*.rb',
        './app/models/**/*.rb'
      ]
    end
  end
end
