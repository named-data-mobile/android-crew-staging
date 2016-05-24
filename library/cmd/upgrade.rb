require_relative '../exceptions.rb'
require_relative '../formulary.rb'


module Crew

  def self.upgrade(args)
    if args.length > 0
      raise CommandRequresNoArguments
    end

    install_latest(Formulary.utilities)
    install_latest(Formulary.packages)
  end

  # private

  def self.install_latest(formulary)
    names = []
    formulas = []
    formulary.each do |formula|
      if formula.installed?
        lr = formula.releases.last
        if not lr.installed? or (lr.installed_crystax_version < lr.crystax_version)
          formulas << formula
          names << last_release_name(formula)
        end
      end
    end

    if formulas.size > 0
      puts "Will install: #{names.join(', ')}"
      formulas.each { |formula| formula.install }
    end
  end

  def self.last_release_name(formula)
    last_release = formula.releases.last
    "#{formula.name}:#{last_release.version}:#{last_release.crystax_version}"
  end
end
