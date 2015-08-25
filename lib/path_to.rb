require "path_to/version"

class PathTo

  attr_accessor :paths

  def initialize(*paths)
    @paths = Array(paths)
  end

  def path_to(filename)
    paths.each do |path|
      fullpath = File.join(path, filename)
      if File.exists?(fullpath)
        return fullpath
      end
    end
    nil
  end

  # Plural version of path_to
  def paths_to(filenames=[])
    Array(filenames).map{ |filename| path_to(filename) }
  end

  def file(filename, opts={})
    mode, perm, opt = opts[:mode], opts[:perm], opts[:opt]
    File.new(path_to(filename), mode, perm, opt)
  end
end