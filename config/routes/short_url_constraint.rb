class ShortUrlConstraint
  def self.matches? request
    paths = Set.new(ShortUrl.pluck(:transformed_path))

    paths.include?(request.path)
  end
end
