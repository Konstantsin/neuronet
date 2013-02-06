require 'Qt4'
require 'matrix'

class Matrix
  def set i, j, v
    @rows[i][j] = v
  end
end

%W(model support view).each do |folder|
  Dir["./#{folder}/*.rb"].each { |file| require file }
end