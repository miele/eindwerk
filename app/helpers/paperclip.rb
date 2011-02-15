module Paperclip
  # Handles grayscale conversion of images that are uploaded.
  class Grayscale < Processor

    def initialize file, options = {}, attachment = nil
      super
      @format = File.extname(@file.path)
      @basename = File.basename(@file.path, @format)
    end

     def make  
       src = @file
       dst = Tempfile.new([@basename, @format])
       dst.binmode

       begin
         parameters = []
         parameters << ":source"
         parameters << "-colorspace Gray"
         parameters << ":dest"

         parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

         success = Paperclip.run("convert", parameters, :source => "#{File.expand_path(src.path)}[0]", :dest => File.expand_path(dst.path))
       rescue PaperclipCommandLineError => e
         raise PaperclipError, "There was an error during the grayscale conversion for #{@basename}" if @whiny
       end

       dst
     end

  end
end
