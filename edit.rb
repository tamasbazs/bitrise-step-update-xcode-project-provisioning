#!/usr/bin/env ruby

require 'xcodeproj'

$xcode_xcodeproj_file = ENV['xcode_xcodeproj_file']
$project_target = ENV['project_target']
$code_sign_style = ENV['code_sign_style']
$development_team = ENV['development_team']
$code_sign_identity = ENV['code_sign_identity']
$provisioning_profile_specifier = ENV['provisioning_profile_specifier']
$dry_run = (ENV['dry_run'].to_s == "yes")

project = Xcodeproj::Project.open($xcode_xcodeproj_file)

def getTarget(project, name)
	project.targets.each do |target|
		if target.name == name
			return target
		end
	end
	return nil
end

def getBuildSettings(target, name)
	target.build_configurations.each do |build_configurations|
		if build_configurations.name == name
			return build_configurations.build_settings
		end
	end
	return nil
end

def getBuildSettingsStrings(project, target_name, configuration_name)

	target = getTarget(project, target_name)
	settings = getBuildSettings(target, configuration_name)

	result = ""
	result += "Build Configuration: " + configuration_name + "\n"
	result += "CODE_SIGN_STYLE: " + settings["CODE_SIGN_STYLE"].to_s + "\n"
	result += "DEVELOPMENT_TEAM: " + settings["DEVELOPMENT_TEAM"].to_s + "\n"
	result += "CODE_SIGN_IDENTITY: " + settings["CODE_SIGN_IDENTITY"].to_s + "\n"
	result += "PROVISIONING_PROFILE_SPECIFIER: " + settings["PROVISIONING_PROFILE_SPECIFIER"].to_s
	return result
end

def printAllBuildSettings(project, target_name)

	puts "-----------------------------"
	puts "Target: " + target_name
	target = getTarget(project, $project_target)
	target.build_configurations.each do |build_configurations|
		puts
		puts getBuildSettingsStrings(project, target_name, build_configurations.name)
	end
	puts "-----------------------------"
end

puts "\# Original Settings:"

printAllBuildSettings(project, $project_target)


target = getTarget(project, $project_target)
target.build_configurations.each do |build_configurations|
	configSettings = build_configurations.build_settings
	configSettings["CODE_SIGN_STYLE"] = $code_sign_style
	configSettings["DEVELOPMENT_TEAM"] = $development_team
	if configSettings["CODE_SIGN_IDENTITY"]
		configSettings["CODE_SIGN_IDENTITY"] = $code_sign_identity
	end
	if configSettings["CODE_SIGN_IDENTITY[sdk=macosx*]"]
		configSettings["CODE_SIGN_IDENTITY[sdk=macosx*]"] = $code_sign_identity
	end
	if configSettings["PROVISIONING_PROFILE_SPECIFIER"]
		configSettings["PROVISIONING_PROFILE_SPECIFIER"] = $provisioning_profile_specifier
	end
	if configSettings["PROVISIONING_PROFILE_SPECIFIER[sdk=macosx*]"]
		configSettings["PROVISIONING_PROFILE_SPECIFIER[sdk=macosx*]"] = $provisioning_profile_specifier
	end
end

puts
puts "\# Changed Settings" + ($dry_run ? " (Dry-run preview. setting not saved)" : "") + ":"

printAllBuildSettings(project, $project_target)

if !$dry_run
	project.save
end
