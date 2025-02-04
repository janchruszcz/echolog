module ProjectsHelper
  def project_status_color(status)
    case status.to_sym
    when :not_started
      "bg-gray-100 text-gray-800"
    when :in_progress
      "bg-blue-100 text-blue-800"
    when :under_review
      "bg-yellow-100 text-yellow-800"
    when :completed
      "bg-green-100 text-green-800"
    end
  end
end
