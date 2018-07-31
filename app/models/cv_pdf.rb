require "render_anywhere"

# JSON.parse(File.new(Rails.root.join('public', 'data.json').to_s).read)

class CvPdf
  include RenderAnywhere

  def initialize(cv)
    @cv = cv
  end

  def to_pdf
    puts as_html
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/cv.pdf")
  end

  private

  def as_html
    render template: "home/show", layout: 'cv', locals: { cv: @cv }
  end
end