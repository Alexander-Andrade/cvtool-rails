class HomeController < ApplicationController

  def show
    @cv = JSON.parse(File.new(Rails.root.join('public', 'data.json').to_s).read)

    respond_to do |format|
      format.pdf { send_cv_pdf }
      format.html { render_cv_html }
    end
  end

  private

  def send_cv_pdf
    begin
      cv_pdf = CvPdf.new(@cv).to_pdf
      # send_file cv_pdf,
      #           filename: "cv.pdf",
      #           type: "application/pdf",
      #           disposition: "inline"
      send_file cv_pdf, filename: 'cv.pdf', type: 'application/pdf', disposition: 'inline'
    ensure
      # cv_pdf.unlink
    end
  end

  def render_cv_html
    render template: "home/show", layout: 'cv', locals: {cv: @cv }
  end

end
