Gem::Specification.new do |s|
  s.name = %q{htmlentities}
  s.version = "4.0.0"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Battley"]
  s.cert_chain = nil
  s.date = %q{2007-03-15}
  s.email = %q{pbattley@gmail.com}
  s.extra_rdoc_files = ["README.txt", "History.txt", "COPYING.txt"]
  s.files = ["lib/htmlentities.rb", "lib/htmlentities/html4.rb", "lib/htmlentities/legacy.rb", "lib/htmlentities/string.rb", "lib/htmlentities/xhtml1.rb", "test/entities_test.rb", "test/html4_test.rb", "test/legacy_test.rb", "test/roundtrip_test.rb", "test/string_test.rb", "test/test_all.rb", "test/xhtml1_test.rb", "README.txt", "History.txt", "COPYING.txt"]
  s.has_rdoc = true
  s.homepage = %q{http://htmlentities.rubyforge.org/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A module for encoding and decoding (X)HTML entities.}
  s.test_files = ["test/test_all.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if current_version >= 3 then
    else
    end
  else
  end
end
