require "mgt"
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "controllers")
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "models")
module Neski
  class Application < Mgt::Application
  end
end
