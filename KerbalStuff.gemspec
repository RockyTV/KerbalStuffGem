# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kerbalstuff/version"

Gem::Specification.new do |s|
	s.name		= 'KerbalStuff'
	s.version	= KerbalStuff::VERSION
	s.summary 	= "KerbalStuff's Ruby API Wrapper"
	s.description = "A simple API wrapper for KerbalStuff"
	s.authors	= ["Alexandre Oliveira"]
	s.email		= 'rockytvbr@gmail.com'
	
	s.files		= `git ls-files`.split("\n")
	s.require_paths = ["lib"]
	
	s.homepage	=
		'https://github.com/RockyTV/KerbalStuffGem'
	s.license	= 'MIT'
	s.extra_rdoc_files = ['README.md']
	s.required_ruby_version = '>= 1.9.3'
end