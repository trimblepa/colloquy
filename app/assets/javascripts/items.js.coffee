
$ ->

  # bs specific validation callbacks
  # cribbed from gist 2909552

  _.extend Backbone.Validation.callbacks,
    valid: (view, attr, selector) ->
      control = view.$('['+selector+'='+attr+']')
      group = control.parents(".control-group")
      group.removeClass("error")
      group.find(".help-inline.error-message").remove()

    invalid: (view, attr, error, selector) ->
      console.log view, attr, error, selector
      control = view.$('['+selector+'='+attr+']')
      group = control.parents(".control-group")
      group.addClass("error")
      if group.find(".help-inline").length == 0
        group.find(".controls").append("<span class=\"help-inline error-message\"></span>")
      target = group.find(".help-inline")
      target.text(error)

  # define top level app

  class Colloquy extends Backbone.Model
    urlRoot: '/colloquies'
    validation:
      name: {required: true}
    nickname: 'colloquy'

  class ColloquyView extends Backbone.View
    initialize: ->
      @model = new Colloquy {id: $('body').attr('id')}
      # Todo: error callback
      @model.fetch success: =>
        @render()
      Backbone.Validation.bind @
    el: $('#uppo')
    persist: =>
      new_obj = {}
      new_obj[i.name] = i.value for i in @$el.find('form').serializeArray()
      @model.save new_obj
      false
    render: =>
      @$el.empty()
      @$el.append ich.app_controls(@model.toJSON())

  class AppView extends Backbone.View
    initialize: ->
      @collview = new ColloquyView
      @isv = new Plonk.ITV {appo: @, el: '#items', name: 'event'}
      @render()
    el: $('#appo')
    events:
      'click button#save': 'persist'
    persist: =>
      @collview.persist()
      @isv.collection.persist()
      false
    render: =>
      @$el.empty()
      @$el.append ich.app_buttons()

  # go!

  window.apv = new AppView

#  window.posts_view = new ItemsView
#    url: '/posts'
#    el: $('#posts'),
#    default_obj: {title: 'New One', body: 'I like js.'}
#    save_obj: ->
#      body: $('#body').val(),
#      title: $('#title').val()
#    show_tmpl: (data) -> ich.rule(data)
#    edit_tmpl: (data) -> ich.edit(data)
#  window.post = new Items [],
#    name: 'post'
#    comparator: (i) ->
#      -i.get 'pub_date'


