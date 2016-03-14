require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
lib_master = File.expand_path("../../lib/mgt", __FILE__)
$LOAD_PATH.unshift(lib_master) unless $LOAD_PATH.include?(lib_master)
require "util"

