# Remove ActionController::Base.benchmark call
class ActionView::PartialTemplate
  def render
    @handler.render(self)
  end
end