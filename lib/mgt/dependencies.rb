class Object
  def self.const_missing(const)
    require const.to_s.to_snake_case
    Object.const_get(const)
  end

  def to_constant
    Object.const_get(self)
  end

  def to_plural
    gsub!(/([^aeiouy]|qu)y$/i, '\1ies')
    gsub!(/(ss|z|ch|sh|x)$/i, '\1es')
    gsub!(/(is)$/i, "es")
    gsub!(/(f|fe)$/i, "ves")
    gsub!(/(ex|ix)$/i, "ices")
    gsub!(/(a)$/i, "ae")
    gsub!(/(um|on)$/i, "a")
    gsub!(/(us)$/i, "i")
    gsub!(/(eau)$/i, "eaux")
    gsub!(/([^saeix])$/i, '\1s')
  end
end
