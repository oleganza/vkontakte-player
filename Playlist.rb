require 'fileutils'
require 'thread'
module Vkontakte
  class Playlist
    include Enumerable
    
    def initialize(list, threads = 2)
      @loader = Loader.new(threads)
      @list = list
    end
    
    def size
      @list.size
    end
    
    def each(&blk)
      @list.each(&blk)
    end
    
    def to_a
      @list
    end
    
    def folder
      File.expand_path("~/Music/Vkontakte")
    end
    
    def update_files
      i = 0
      FileUtils.mkdir_p(folder)
      each do |audio|
        path = audio.file_name(folder)
        unless File.exist?(path)
          i+=1
          @loader.push(audio.url, path)
        end
      end
      @loader.join
      i
    end
    
    def update_itunes
      itunes = itunes_instance
      
      p itunes.sources.select{|s|s.name == "Library"}.first
      p((itunes.methods - Object.new.methods).sort)
      track = itunes.add("http://www.kernel.org/pub/linux/kernel/SillySounds/english.au")
      p track
      p((track.methods - Object.new.methods).sort)
    end
    
    def itunes_instance
      return @itunes if @itunes
      OSX.require_framework 'ScriptingBridge'
      @itunes = OSX::SBApplication.applicationWithBundleIdentifier_("com.apple.iTunes")
    end
  end
  
  
  class Loader
    attr_accessor :threads, :queue
    def initialize(threads = 5)
      @queue = Queue.new
      @threads = Array.new(threads) do 
        Thread.new(@queue) do |q|
          while 1
            task = q.shift
            break if task == :break
            url, path = task
            path0 = File.join(File.dirname(path), %{.#{File.basename(path)}})
            cmd = %{wget "#{url}" -O "#{path0}" -q}
            #puts %{>> #{cmd}}
            if system(cmd)
              FileUtils.mv(path0, path)
            end
          end
        end
      end
    end
    
    def push(url, path)
      @queue.push([url, path])
      self
    end
    
    def join
      (@threads.size*2).times do
        @queue.push :break
      end
      @threads.each do |t|
        t.join
      end
      self
    end
  end
  
end
