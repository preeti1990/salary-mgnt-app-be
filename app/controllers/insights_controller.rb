class InsightsController < ApplicationController
  def index
    render json: {}, status: :bad_request and return unless params[:country].present?
    salaries = SalaryInsights.new(country: params[:country]).country_stats
    render json: salaries, status: :ok
  end

  def job_title_stats
    render json: {}, status: :bad_request and return unless params[:country].present? && params[:job_title].present?
    stats = SalaryInsights.new(country: params[:country]).job_title_stats(params[:job_title])
    render json: stats, status: :ok
  end
end