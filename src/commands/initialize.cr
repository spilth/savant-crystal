require "admiral"

class Savant::Commands::Initialize < Admiral::Command
  define_help description: "Initialize a project."

  define_argument artifact : String,
    description: "Artifact ID",
    required: true

  define_flag language : String,
    description: "Programming Language",
    long: language,
    short: l,
    required: true

  define_flag group : String,
    default: "com.example",
    long: group,
    short: g

  def run
    java_9_archetype = {
      "group" => "org.spilth",
      "artifact" => "java9-minimal-quickstart",
      "version" => "1.0.0"
    }

    java_8_archetype = {
      "group" => "org.spilth",
      "artifact" => "java8-minimal-quickstart",
      "version" => "1.0.0"
    }

    kotlin_archetype = {
      "group" => "org.jetbrains.kotlin",
      "artifact" => "kotlin-archetype-jvm",
      "version" => "1.1.51"
    }

    archetype = nil

    case flags.language
    when "java8"
      archetype = java_8_archetype
    when "kotlin"
      archetype = kotlin_archetype
    else
      archetype = java_9_archetype
    end

    maven_arguments = "archetype:generate --batch-mode -DgroupId=#{flags.group} -DartifactId=#{arguments.artifact} -DarchetypeGroupId=#{archetype["group"]} -DarchetypeArtifactId=#{archetype["artifact"]} -DarchetypeVersion=#{archetype["version"]} -Dmaven.multiModuleProjectDirectory=\$MAVEN_HOME"

    puts "\u001B[32mCreating project '" + arguments.artifact + "'...\u001B[0m"

    Process.run("mvn", maven_arguments.split(" "))

    puts "Project created in directory " + arguments.artifact
  end
end
