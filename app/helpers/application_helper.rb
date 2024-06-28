module ApplicationHelper
    def icon(name, options = {})
        classes = options.delete(:class) { '' }
        content_tag(:i, '', class: "fa fa-#{name} #{classes}", **options)
    end
end
