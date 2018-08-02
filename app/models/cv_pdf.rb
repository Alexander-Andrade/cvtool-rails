require 'render_anywhere'
require 'tempfile'

# JSON.parse(File.new(Rails.root.join('public', 'data.json').to_s).read)
# --margin-top 0.75in --margin-right 0.75in --margin-bottom 0.75in --margin-left 0.75in

class CvPdf
  include RenderAnywhere

  def initialize(cv)
    @cv = cv
  end

  def to_pdf
    begin
      header = header_file

      kit = PDFKit.new(
          cv_body,
          :header_html => header.path
      )

      cv = Tempfile.new(['cv', '.pdf'])
      # kit.to_file("#{Rails.root}/public/cv.pdf")
      kit.to_file(cv.path)
    ensure
      # header.unlink
    end
    cv
  end

  # private

  def cv_body
    render template: "home/show", layout: 'cv', locals: { cv: @cv }
  end

  def cv_header
    render template: "home/_header", layout: 'cv', locals: { cv: @cv }
  end

  def header_file
    header = Tempfile.new(['header', '.html'])
    header.write(cv_header)
    header.close
    header
  end
end