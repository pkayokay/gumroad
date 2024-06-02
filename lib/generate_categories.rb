class GenerateCategories
  def self.call
    [
      {
        name: "3D",
        slug: "3d",
      },
      {
        name: "Design",
        slug: "design",
      },
      {
        name: "Audio",
        slug: "audio",
      },
      {
        name: "Tech",
        slug: "tech",
      },
      {
        name: "Business",
        slug: "business",
      },
      {
        name: "Finance",
        slug: "finance",
      },
      {
        name: "Comics & Graphic Novels",
        slug: "comics-and-graphic-novels",
      },
      {
        name: "Fitness",
        slug: "Fitness",
      },
    ].each do |category|
      Category.find_or_create_by!(slug: category[:slug], name: category[:name])
    rescue
      next
    end
  end
end