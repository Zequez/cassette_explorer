dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'webrick'
require 'yaml'
require 'erb'
require 'listen'
require 'optparse'
require 'ostruct'
require 'base64'

require "cassette_explorer/version"
require "cassette_explorer/page"
require "cassette_explorer/reader"
require "cassette_explorer/template"
require "cassette_explorer/server"

module CassetteExplorer
  ROOT = Pathname.new(__dir__) + '..'
end
