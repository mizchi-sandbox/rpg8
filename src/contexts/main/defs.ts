export interface Props {
}

import Field = require('./field');
import T = require('./tile');

export interface State {
  field: Field;
  selectedTile?: T.Tile;
}

export interface ComponentProps {
  tiles: T.Tile[];
  selectedTile?: T.Tile;
}
