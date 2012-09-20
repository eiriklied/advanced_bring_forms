module ApplicationHelper

  # for specifying a custom title for a view
  # call like this:
  # <% title 'title content' %>
  def title(text)
    content_for :title, text
  end


  DEFAULT_FORM_OPTIONS = {:class => 'span8', :wrapper => true}
  def form_text_field(f, field_name, opts={})
    opts = ApplicationHelper::DEFAULT_FORM_OPTIONS.merge(opts)

    text_field_opts = {:class => "text #{opts[:class]}"}
    text_field_opts[:style] = "width: #{opts[:width]}px;" if opts[:width].present?
    
    str =  ''
    str << "<div class=\"form-row #{opts[:wrapper_class]}\">" if opts[:wrapper]
    str << "<div class=\"form-cell #{error_class_for(f, field_name)}\">" if opts[:wrapper]
    str << f.label(field_name, label_str_for(f.object, field_name, opts), :class => 'separator')
    str << f.text_field(field_name, text_field_opts)
    str << error_messages_for_field(f, field_name) 
    str << '</div>' if opts[:wrapper]
    str << '</div>' if opts[:wrapper]
    
    str.html_safe
  end

  def form_text_area(f, field_name, opts={})
    opts = ApplicationHelper::DEFAULT_FORM_OPTIONS.merge(opts)
  
    text_field_opts = {:class => "text #{opts[:class]}", :class => "text #{opts[:class]}", :rows => 5}
    text_field_opts[:style] = "width: #{opts[:width]}px;" if opts[:width].present?

    str =  ''
    str << '<div class="form-row">' if opts[:wrapper]
    str << "<div class=\"form-cell #{error_class_for(f, field_name)}\">" if opts[:wrapper]
    str << f.label(field_name, label_str_for(f.object, field_name, opts), :class => 'separator')
    str << f.text_area(field_name, text_field_opts)
    str << error_messages_for_field(f, field_name)
    str << '</div>' if opts[:wrapper]
    str << '</div>' if opts[:wrapper]
  
    str.html_safe
  end

  def form_file_field(f, field_name, opts={})
    opts = ApplicationHelper::DEFAULT_FORM_OPTIONS.merge(opts)
    str = ''
    str << '<div class="form-row">' if opts[:wrapper]
    str << "<div class=\"form-cell #{error_class_for(f, field_name)}\">" if opts[:wrapper]
    str << f.label(field_name, label_str_for(f.object, field_name, opts), :class => 'separator')
    str << f.file_field(field_name, :class => "file #{opts[:class]}")
    str << error_messages_for_field(f, field_name)
    str << '</div>' if opts[:wrapper]
    str << '</div>' if opts[:wrapper]

    str.html_safe
  end

  def form_select(f, field_name, values, opts={})
    # 'values' could be an array of arrays: [['Field one text', 'field_1_id'], ['Field 2 text', 'field_2_id']]
    # or something made with options_for_select or options_from_collection_for_select
    opts = ApplicationHelper::DEFAULT_FORM_OPTIONS.merge(opts)
    str = ''
    str << '<div class="form-row">' if opts[:wrapper]
    str << "<div class=\"form-cell #{error_class_for(f, field_name)}\">" if opts[:wrapper]
    str << f.label(field_name, label_str_for(f.object, field_name, opts), :class => 'separator')
    str << f.select(field_name, values, :class => "select #{opts[:class]}")
    str << error_messages_for_field(f, field_name)
    str << '</div>' if opts[:wrapper]
    str << '</div>' if opts[:wrapper]

    str.html_safe
  end

  def form_radio_buttons(f, field_name, values, selected_value, opts={})
    opts = ApplicationHelper::DEFAULT_FORM_OPTIONS.merge(opts)
    str = ''
    str << '<div class="form-row radios">' if opts[:wrapper]
    str << "<div class=\"form-cell #{error_class_for(f, field_name)}\">" if opts[:wrapper]
    str << f.label(field_name, label_str_for(f.object, field_name, opts), :class => 'separator')
    values.each do |value|
      str << '<label>'
      radio_opts = {:class => "radio #{opts[:class]}"}
      radio_opts[:checked] = true if selected_value == value
      str << f.radio_button(field_name, value, radio_opts )
      str << "<span>#{value}</span>"
      str << '</label>'
    end
    str << error_messages_for_field(f, field_name)
    str << '</div>' if opts[:wrapper]
    str << '</div>' if opts[:wrapper]

    str.html_safe
  end

  # for a simple check box!
  # for a group of check boxes, please see form_check_boxes
  def form_check_box(f, field_name, opts={}, checked_value='1', unchecked_value='0')
    opts = ApplicationHelper::DEFAULT_FORM_OPTIONS.merge(opts)
    str = ''
    str << '<div class="form-row checkbox">' if opts[:wrapper]
    str << "<div class=\"form-cell #{error_class_for(f, field_name)}\">" if opts[:wrapper]
    str << f.label(field_name, label_str_for(f.object, field_name, opts), :class => 'separator')
    check_box_opts = {}
    check_box_opts[:checked] = true if opts[:checked]
    str << f.check_box(field_name, check_box_opts, checked_value, unchecked_value)
    str << error_messages_for_field(f, field_name)
    str << '</div>' if opts[:wrapper]
    str << '</div>' if opts[:wrapper]
    str.html_safe
  end

  def form_check_box_in_collection(f, field_name, opts={}, checked_value='1', unchecked_value='0')
    str = ''
    str << '<label class="checkbox in-collection">'
    str << f.check_box(field_name, opts, checked_value, unchecked_value)
    str << "<span>#{label_str_for(f.object, field_name, opts)}</span>"
    str << '</label>'
    str.html_safe
  end


  # just a common way to separate fields in the KP form builder
  def form_separator_field(f, label)
    content_tag :div, :class => 'form-row form-cell separator-row' do
      content_tag :h3, :class => 'style6 separator' do
        label
      end
    end
  end

  def form_label_field(f, label)
    content_tag :label, :class => 'separator form-cell' do
      label
    end
  end

  def error_class_for(f, field_name)
    if f.error_message_on(field_name).present?
      'box-error'
    else
      ''
    end
  end

  def error_messages_for_field(f, field_name)
    str = ''
    if f.error_message_on(field_name).present?
      str << '<label class="error">'
      error_messages = f.object.errors[field_name]
      # even though there might be more error messages on a field its prettier to display only one..
      str << error_messages.first
      str << '</label>'
    end
    str
  end

  def label_str_for(object, field_name, opts={})
    prefix = object.class.to_s.underscore
    label_field_name = opts[:label_key] || field_name
    
    # if someone specified an option :label, this should be used directly
    if opts[:label].present?
      label_str = opts[:label]
    # otherwise use a key and look up in locale yml files
    else
      label_str = t("#{prefix}.#{label_field_name}")
    end

    label_str << ' *' if must_be_present?(object, field_name, opts)
    label_str
  end

  def must_be_present?(object, field_name, opts={})
    # if someone explicitly set the :required option we should use that
    if opts[:required] == false || opts[:required] == true
      return opts[:required]
    else
      object.class.validators_on(field_name).map(&:class).include? ActiveModel::Validations::PresenceValidator
    end
  end

end