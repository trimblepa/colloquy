
Plonk = do ->

  # bs specific validation callbacks
  # cribbed from gist 2909552
  # Todo: when dos becomes uno

  _.extend Backbone.Validation.callbacks,
    valid: (view, attr, selector) ->
      control = view.$('['+selector+'='+attr+']')
      group = control.parents(".control-group")
      group.removeClass("error")
      group.find(".help-inline.error-message").remove()

    invalid: (view, attr, error, selector) ->
      control = view.$('['+selector+'='+attr+']')
      group = control.parents(".control-group")
      group.addClass("error")
      if group.find(".help-inline").length == 0
        group.find(".controls").append("<span class=\"help-inline error-message\"></span>")
      target = group.find(".help-inline")
      target.text(error)

  class Item extends Backbone.Model
    initialize: ->
      @view = new ItemView {model: @}
    # Todo: just walk away slowly from bbvalid
    validate: (attrs) =>
      if !attrs.name
        @set 'error', 'this cannot work', {silent: true}
        'this cannot work'

  class ItemView extends Backbone.View
    tagName: 'tr'
    events:
      'click #zapp': 'delete'
    delete: =>
      @model.to_delete = true
      # Todo: doesnot this defeat the whole purpose?
      @model.collection.changed()
      @$el.remove()
    render: =>
      $(@el).html ich[@model.collection.view.name+'_item'](@model.toJSON())
      @

  class Items extends Backbone.Collection
    model: Item
    initialize: (models,options) ->
      @url = '/events'
      @view = options.view
      @on 'reset', options.view.render
      @on 'add', @changed
      @fetch()
    persist: =>
      @each (item) =>
        if item.to_delete
          item.destroy()
        else if item.isNew()
          item.save [], {silent: true}
      # Todo: wait and fetch?
      # Todo: would call disable_buttons here
      #       but willnot work for multicollection
      #       musst understand bb event bs
      false
    changed: =>
      @view.appo.enable_buttons()

  class ItemsView extends Backbone.View
    initialize: (options) ->
      @name = options.name
      @appo = options.appo
      @collection = new Items([],{view: @})
      console.log options
    events:
      'click button#add': 'create'
    # Todo: factor how?
    create: =>
      # Todo: sveltize the comprehension
      new_obj = {}
      new_obj[i.name] = i.value for i in @$el.find('form').serializeArray()
      m = new Item new_obj
      tmpl = @name+'_add_item'
      if m.isValid()
        @collection.add m
        @$el.find('table tbody').append(m.view.render().el)
        @$el.find('form').replaceWith ich[tmpl]()
      else
        @$el.find('form').replaceWith ich[tmpl](m.toJSON())
      false
    render: =>
      @$el.empty()
      @$el.append ich[@name+'_items_table']()
      @collection.each (v,k,l) =>
        @$el.find('table tbody').append(v.view.render().el)
      @$el.append ich[@name+'_add_item']()

  ITV: ItemsView

