var Terrain = require('mz-terrain');
import d = require('./defs')
import T = require('./tile');

function toGameTile(tile) {
  return {
    x: tile.x,
    y: tile.y,
    val: tile.val,
    discoveryRate: 0,
    visible: false
  }
}

class Field {
  tiles: T.Tile[];

  constructor(){
    var terrain = new Terrain(4, 1);
    terrain.generate();
    this.tiles = terrain.toArray().map(toGameTile);

    var ix = _.sample(_.range(0, terrain.size-1));
    var iy = _.sample(_.range(0, terrain.size-1));
    var initialTile: T.Tile = _.find(this.tiles, (t) => t.x === ix && t.y === iy);
    initialTile.discoveryRate = 1;
    initialTile.visible = true;
  }

  getTilesArround(x, y): T.Tile[] {
    var tiles = [];
    var searchPath;
    if(y % 2 === 1) {
      searchPath = [
              [0, -1], [+1, -1],
          [-1, 0],        [+1, 0],
              [0, +1], [+1, +1]
      ];
    } else {
      searchPath = [
              [-1, -1], [0, -1],
          [-1, 0],        [+1, 0],
              [-1, +1], [0, +1]
      ];
    }
    searchPath.map(p => {
      var neibor = _.find(this.tiles, (t) =>
        t.x === x+p[0] && t.y === y+p[1]);
      if(neibor) tiles.push(neibor);
    });
    return tiles;
  }

  public getViewArround(x, y) {
    this.getTilesArround(x, y)
    .map(tile => {
      //tile.discoveryRate = 0.8;*/
      tile.visible = true;
    });
  }

  public getTile(x: number, y: number): T.Tile {
    return _.find(this.tiles, (t) => t.x === x && t.y === y);
  }

  public search(x, y) {
    var tile = _.find(this.tiles, (t) => t.x === x && t.y === y);
    //if(tile.discoveryRate > 0)*/
    tile.discoveryRate = Math.min(tile.discoveryRate+0.1, 1);

    if(tile.discoveryRate === 1) {
      this.getViewArround(tile.x, tile.y)
    }
  }
}

export = Field;
