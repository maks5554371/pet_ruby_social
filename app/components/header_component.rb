class HeaderComponent < ViewComponent::Base
  def initialize(current_user:)
    @current_user = current_user
  end

  def nav_link_class(path)
    base = "px-4 py-2 rounded-lg transition-colors p-2 duration-200 font-medium flex items-center space-x-2 bg-[#393e46] hover:bg-[#393e46]/50"

    if current_page?(path)
      "#{base} bg-[#ffd369] text-[#222831] hover:bg-[#ffd369]/50"
    else
      "#{base} text-white hover:text-white"
    end
  end
end
