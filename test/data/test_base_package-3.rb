require_relative "#{Global::NDK_DIR}/../data/test_base_package_methods.rb"

class TestBasePackage < BasePackage

  include MultiVersion

  desc "Test Base Package"

  release version: '1', crystax_version: 2
  release version: '2', crystax_version: 2
  release version: '3', crystax_version: 2

  include TestBasePackageMethods
end
