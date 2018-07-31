require "render_anywhere"

# JSON.parse(File.new(Rails.root.join('public', 'data.json').to_s).read)
# --margin-top 0.75in --margin-right 0.75in --margin-bottom 0.75in --margin-left 0.75in

class CvPdf
  include RenderAnywhere

  def initialize(cv)
    @cv = cv
  end

  def to_pdf
    kit = PDFKit.new(
        as_html,
        page_size: 'A4',
        viewport_size: '1024x768'
    )

    kit.to_file("#{Rails.root}/public/cv.pdf")
  end

  private

  def as_html
    render template: "home/show", layout: 'cv', locals: { cv: @cv }
  end
end