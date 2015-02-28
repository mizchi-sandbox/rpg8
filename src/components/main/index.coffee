template = require './template'

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

Hex = React.createClass
  render: ->
    {x, y, r} = @props
    $ 'g', transform: "translate(#{x}, #{y})", [
      $ 'polygon',
        points: hexPoints(r)
        fill:'transparent'
        stroke:'black'
        strokeWidth:1
        onClick: @onClickTile
    ]

  onClickTile: ->
    console.log 'onClickTile'

xyToUv = (x, y) =>
  u = x+(y&1)*0.5
  v = y*0.866025403784
  [u, v]

module.exports = React.createClass
  mixins: [Arda.mixin, require('./actions')]
  render: ->
    size = 32
    $ 'div', className: 'main', [
      $ 'svg', width:640, height: 480, [
        $ 'g', transform: "translate(50,50)",
          _.flatten(for x in _.range(10)
            for y in _.range(8)
              [u, v] = xyToUv(x, y)
              $ Hex,
                x: u*size
                y: v*size
                r: size*0.58
          )
      ]
    ]
