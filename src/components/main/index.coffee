template = require './template'
Terrain = require('mz-terrain')
$ = React.createElement

hexPoints = (r) ->
  PI = Math.PI
  ps = []
  for i in [0..5]
    rx = ~~(r * Math.cos(i*PI/3 + PI/6))
    ry = ~~(r * Math.sin(i*PI/3 + PI/6))
    ps.push [rx, ry]
  ps
    .map ([rx, ry]) -> "#{rx},#{ry}"
    .join(' ')

xyToUv = (x, y) =>
  u = x+(y&1)*0.5
  v = y*0.866025403784
  [u, v]

height2color = (height) ->
  min = -1
  max = 4
  rgb = 0
  h =
    if height < min then min
    else if min < height < max then height
    else
      max
  r = 1 - (h - min)/(max-min)
  "rgb(256, #{~~(r*256)}, #{~~(r*256)}"

Hex = React.createClass
  mixins: [Arda.mixin]
  render: ->
    {x, y, val, discoveryRate, visible} = @props
    [u, v] = xyToUv(x, y)
    size = 32
    u = u*size
    v = v*size
    r = size*0.58

    fillColor =
      if discoveryRate > 0
        height2color(val)
      else if visible
        'gray'
      else
        'black'
    strokeColor = if discoveryRate is 1 then 'green' else 'black'
    # text = "#{~~x}, #{~~y}"
    text = ''+~~(discoveryRate*100)+'%'

    $ 'g', transform: "translate(#{u}, #{v})", key: "hex:#{x},#{y})", [
      $ 'polygon',
        points: hexPoints(r)
        fill: fillColor
        stroke: strokeColor
        strokeWidth: 1
        onMouseUp: if visible then @onClickTile else undefined
        onMouseOver: @onMouseOver
      # $ 'rect',
      # $ 'text',
      #   textAnchor: 'middle'
      #   fontSize: 10
      # , text
    ]
  onMouseOver: ->
    @dispatch 'field:show-tile-info', @props.x, @props.y

  onClickTile: ->
    @dispatch 'field:search-tile', @props.x, @props.y

module.exports = React.createClass
  mixins: [Arda.mixin]
  render: ->
    $ 'div', className: 'main', [
      $ 'div', className: 'container', style: {display: 'flex'}, [
        $ 'div', key: 'fieldContainer', style: {width: '70%'}, [
          $ 'svg',
            width:640
            height: 640
            draggable: true
            style:
              '-webkit-user-select': 'none'
          , [
              $ 'g', transform: "translate(50,50)",
                @props.tiles.map (tile) -> $ Hex, tile
          ]
        ]
        $ 'div',
          key: 'informationContainer',
          style:
            width: '30%'
        , (
            if @props.selectedTile
              [
                $ 'span', {key: 'pos'}, (
                  @props.selectedTile.x + ':' + @props.selectedTile.y
                )
                $ 'hr'
                $ 'span', {key: 'discoveryRate'}, '発見率:'+@props.selectedTile.discoveryRate*100
              ]
              # $ 'hr'
            else
              []
        )
      ]
    ]
