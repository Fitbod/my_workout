module ActiveAdmin
  module Views
    class Footer < Component

      def build(*args)
        super :id => "footer"
        super :style => "text-align: right;"

        div do
          small "Built by: "
          a "fitbod", href: "https://github.com/fitbod/"
        end
      end
    end
  end
end
