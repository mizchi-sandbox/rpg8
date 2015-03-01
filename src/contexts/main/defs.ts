export interface Props {
}

export interface Tile {
  x: number;
  y: number;
  val: number;
}

export interface State {
  tiles: Tile[];
}

export interface ComponentProps {
  tiles: Tile[]
}
