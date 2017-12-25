require "admiral"

class Savant::Commands::Search < Admiral::Command
  define_help description: "Search for a dependency."

  def run
    puts "Searching..."
  end
end
