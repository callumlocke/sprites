require 'sprites/sprite'

module Sprites
  class Sprites
    def initialize
      @sprites = Hash.new do |sprites, name|
        sprites[name] = Sprite.new(name)
      end
    end

    def [](sprite_identifier)
      @sprites[sprite_identifier]
    end

    def clear
      @sprites.clear
    end

    def empty?
      @sprites.empty?
    end

    def count
      @sprites.size
    end

    def add(*args, &blk)
      name = sprite_name(*args)
      @sprites[name].define(*args, &blk)
    end

    private

    def sprite_name(*args)
      return args.first if args.first.is_a?(Symbol)

      path = case args.first
      when String
        args.first
      when Hash
        # This is for when sprite is used like,
        # sprite 'path_to_sprite' => 'path_to_stylesheet', :option => value
        args.first.find {|k,v| k.is_a?(String)}.first
      end

      File.basename(path, File.extname(path)).intern
    end
  end
end
