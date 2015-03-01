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
  "rgb(#{~~(r*256)}, #{~~(r*256)}, 256"

Hex = React.createClass
  render: ->
    {x, y, val} = @props
    [u, v] = xyToUv(x, y)
    size = 16
    u = u*size
    v = v*size
    r = size*0.58

    fillColor = height2color(val)
    $ 'g', transform: "translate(#{u}, #{v})", key: "hex:#{x},#{y})", [
      # $ 'text', textAnchor: 'middle', fontSize: 10, "#{~~x}, #{~~y}"
      $ 'polygon',
        points: hexPoints(r)
        fill: fillColor
        stroke:'black'
        strokeWidth:1
        onMouseUp: @onClickTile
    ]
  onClickTile: ->
    console.log 'pos', @props.x, @props.y

module.exports = React.createClass
  mixins: [Arda.mixin, require('./actions')]
  render: ->
    $ 'div', className: 'main', [
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
