import subscriber = require('./subscriber');
import d = require('./defs')
var Terrain = require('mz-terrain');

function toGameTile(tile) {
  return tile;
}

class MainContext extends Arda.Context<d.Props, d.State, d.ComponentProps> {
  static component = require('../../components/main');
  static subscribers = [
    subscriber
  ];

  public initState(props){
    var terrain = new Terrain(5, 1);
    terrain.generate();
    var tiles = terrain.toArray().map(toGameTile);
    return {tiles: tiles};
  }

  public expandComponentProps(props, state): d.ComponentProps{
    return {
      tiles: state.tiles
    };
  }
}

export = MainContext;
