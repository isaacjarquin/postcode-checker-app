# frozen_string_literal: true

require 'sinatra'
require './config/application'

set :root, File.dirname(__FILE__)
set :views, (proc { File.join(root, 'app/views') })

Config::Application.start
