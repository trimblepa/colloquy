
Plonk = do ->

  # bs specific validation callbacks
  # cribbed from gist 2909552
  # Todo: factor elsewhere

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
    validation:
      name: {required: true}

  class ItemView extends Backbone.View
    tagName: 'tr'
    events:
      'click #zapp': 'delete'
    delete: =>
      @model.to_delete = true
      @$el.remove()
    render: =>
      $(@el).html ich[@model.collection.view.name+'_item'](@model.toJSON())
      @

  class EditItemView extends Backbone.View
    initialize: (options) ->
      Backbone.Validation.bind @
    events:
      'click button#add': 'create'
    create: =>
      new_obj = {colloquy_id: @collection.view.parent_id}
      new_obj[i.name] = i.value for i in @$el.find('form').serializeArray()
      if @model.set new_obj
        @collection.add @model
        @collection.view.$el.find('table tbody').append(@model.view.render().el)
        @model = new Item
        @render()
      else
        console.log 'invalid'
      false
    render: =>
      @$el.html ich[@collection.view.name+'_add_item'](@model.toJSON())
      @

  class Items extends Backbone.Collection
    model: Item
    initialize: (models,options) ->
      @url = options.url
      @view = options.view
      @on 'reset', options.view.render
      @fetch({data: {colloquy_id: @view.parent_id}})
    persist: =>
      @each (item) =>
        if item.to_delete
          item.destroy()
        else if item.isNew()
          item.save [], {silent: true}
      # Todo: wait and fetch?
      false

  class ItemsView extends Backbone.View
    initialize: (options) ->
      @parent_id = $('body').attr('id')
      @name = options.name
      @appo = options.appo
      @collection = new Items([],{view: @, url: options.url})
      @edv = new EditItemView {model: new Item, collection: @collection}
    render: =>
      @$el.empty()
      @$el.append ich[@name+'_items_table']()
      @collection.each (v,k,l) =>
        @$el.find('table tbody').append(v.view.render().el)
      @$el.append @edv.render().el

  ITV: ItemsView

