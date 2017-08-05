module ApplicationHelper
  def markdown(text)
    return markdown_renderer.render(text).html_safe
  end

  private

  def markdown_renderer
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      autolink: true,
      tables: true,
      underline: true,
      highlight: true
    )
  end
end
