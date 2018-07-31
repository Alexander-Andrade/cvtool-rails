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
    send_file CvPdf.new(@cv).to_pdf,
              filename: "cv.pdf",
              type: "application/pdf",
              disposition: "inline"
  end

  def render_cv_html
    render template: "home/show", layout: 'cv', locals: { cv: @cv }
  end

end
