require "admiral"
require "./commands/*"

class Savant::Main < Admiral::Command
  define_help

  register_sub_command init, Commands::Initialize
  register_sub_command search, Commands::Search

  def run
    puts help
  end
end

Savant::Main.run
