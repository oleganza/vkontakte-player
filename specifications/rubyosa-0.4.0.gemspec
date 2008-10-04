Gem::Specification.new do |s|
  s.name = %q{rubyosa}
  s.version = "0.4.0"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Laurent Sansonetti"]
  s.cert_chain = nil
  s.date = %q{2007-04-11}
  s.default_executable = %q{rdoc-osa}
  s.description = %q{RubyOSA is a bridge that connects Ruby to the Apple Event Manager, automatically populating the API according to the target application's scriptable definition.}
  s.email = %q{lsansonetti@apple.com}
  s.executables = ["rdoc-osa"]
  s.extensions = ["extconf.rb"]
  s.files = ["README", "COPYRIGHT", "AUTHORS", "extconf.rb", "src/rbosa.c", "src/rbosa.h", "src/rbosa_conv.c", "src/rbosa_sdef.c", "src/rbosa_err.c", "src/lib/rbosa.rb", "src/lib/rbosa_properties.rb", "sample/Finder/show_desktop.rb", "sample/iChat/uptime.rb", "sample/iTunes/control.rb", "sample/iTunes/fade_volume.rb", "sample/iTunes/inspect.rb", "sample/QuickTime/play_all.rb", "sample/misc/sdef.rb", "sample/BBEdit/unix_script.rb", "sample/TextEdit/hello_world.rb", "sample/iChat/image.rb", "sample/iTunes/artwork.rb", "sample/Mail/get_selected_mail.rb", "sample/AddressBook/inspect.rb", "sample/iTunes/tag_genre_lastfm.rb", "data/rubyosa/rdoc_html.rb", "sample/Photoshop/new_doc.rb", "sample/Photoshop/new_doc_with_text.rb", "sample/iTunes/name_that_tune.rb", "bin/rdoc-osa"]
  s.homepage = %q{http://rubyosa.rubyforge.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{rubyosa}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A Ruby/AppleEvent bridge.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if current_version >= 3 then
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 0.3.8"])
    else
      s.add_dependency(%q<libxml-ruby>, [">= 0.3.8"])
    end
  else
    s.add_dependency(%q<libxml-ruby>, [">= 0.3.8"])
  end
end
