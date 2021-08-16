package;

import mazes.RecursiveBacktracker.Direction;
import kha.math.Vector3;

enum Wall {
    Top;
    Bottom;
    Front;
    Back;
    Left;
    Right;
}

class GenerateMazeMesh {
    
    public var vertices:Array<Float> = [];
    public var indices:Array<Int> = [];
    public var normals:Array<Float> = [];
    public var uvs:Array<Float> = [];
    var index = 0;
    var wallHeight = 1.0;
    var tileSize = 1;

    public function new(grid:Array<Array<Int>>, xLength:Int, zLength:Int, height:Int, tileSize:Int) {
        wallHeight = height;
        this.tileSize = tileSize;
        for (x in 0...xLength-1) {
			for (y in 0...zLength-1) {
                if(grid[x][y] == 0){
                    createWalls(x*tileSize, y*tileSize, [Bottom]);
                    continue;
                }
                var walls:Array<Wall> = checkNeighbour(grid, xLength, zLength, x, y);
                walls.push(Top);
                createWalls(x*tileSize, y*tileSize, walls);
			}
		}
    }

    function createWalls(x:Int, y:Int, walls:Array<Wall>) {
        for (wall in walls){
            switch (wall){
                case Top: createTopBottomWall(true, x, y);
                case Bottom: createTopBottomWall(false, x, y);
                case Front: createFrontWall(true, x, y);
                case Back: createFrontWall(false, x, y);
                case Left: createLeftRightWall(true, x, y);
                case Right: createLeftRightWall(false, x, y);
            }
        }
    }

    function createTopBottomWall(top:Bool, x:Int, y:Int) {
        var n = 1.0;
        var a = wallHeight;
        if(!top){
            a = 0.0;
        }
        vertices.push(x);          vertices.push(a); vertices.push(y);
        vertices.push(x);          vertices.push(a); vertices.push(y+tileSize);
        vertices.push(x+tileSize); vertices.push(a); vertices.push(y);

        vertices.push(x+tileSize); vertices.push(a); vertices.push(y);
        vertices.push(x);          vertices.push(a); vertices.push(y+tileSize);
        vertices.push(x+tileSize); vertices.push(a); vertices.push(y+tileSize);

        normals.push(0.0); normals.push(n); normals.push(0.0);
        normals.push(0.0); normals.push(n); normals.push(0.0);
        normals.push(0.0); normals.push(n); normals.push(0.0);
        normals.push(0.0); normals.push(n); normals.push(0.0);
        normals.push(0.0); normals.push(n); normals.push(0.0);
        normals.push(0.0); normals.push(n); normals.push(0.0);

        uvs.push(x/tileSize);            uvs.push(y/tileSize);
        uvs.push(x/tileSize);            uvs.push((y+tileSize)/tileSize);
        uvs.push((x+tileSize)/tileSize); uvs.push(y/tileSize);

        uvs.push((x+tileSize)/tileSize); uvs.push(y/tileSize);
        uvs.push(x/tileSize);            uvs.push((y+tileSize)/tileSize);
        uvs.push((x+tileSize)/tileSize); uvs.push((y+tileSize)/tileSize);

        indices.push(index);
        indices.push(index+1);
        indices.push(index+2);
        indices.push(index+3);
        indices.push(index+4);
        indices.push(index+5);
        index += 6;
    }
    
    function createLeftRightWall(left:Bool, x:Int, y:Int) {
        var n = 1.0;
        var l = 1.0*tileSize;
        if(left){
            l = 0.0;
            n = -1.0;
        }

        if(!left){// Clock-wise
            vertices.push(x);          vertices.push(0.0);        vertices.push(l+y);
            vertices.push(x+tileSize); vertices.push(0.0);        vertices.push(l+y);
            vertices.push(x+tileSize); vertices.push(wallHeight); vertices.push(l+y);

            vertices.push(x);          vertices.push(0.0);        vertices.push(l+y);
            vertices.push(x+tileSize); vertices.push(wallHeight); vertices.push(l+y);
            vertices.push(x);          vertices.push(wallHeight); vertices.push(l+y);
            
            uvs.push(x/tileSize);            uvs.push((y+tileSize)/tileSize);
            uvs.push((x+tileSize)/tileSize); uvs.push((y+tileSize)/tileSize);
            uvs.push((x+tileSize)/tileSize); uvs.push((y-wallHeight)/tileSize);

            uvs.push(x/tileSize);            uvs.push((y+tileSize)/tileSize);
            uvs.push((x+tileSize)/tileSize); uvs.push((y-wallHeight)/tileSize);
            uvs.push(x/tileSize);            uvs.push((y-wallHeight)/tileSize);
        }else{// Counter-clockwise
            vertices.push(x+tileSize); vertices.push(0.0);        vertices.push(l+y);
            vertices.push(x);          vertices.push(0.0);        vertices.push(l+y);
            vertices.push(x+tileSize); vertices.push(wallHeight); vertices.push(l+y);

            vertices.push(x+tileSize);  vertices.push(wallHeight); vertices.push(l+y);
            vertices.push(x);           vertices.push(0.0);        vertices.push(l+y);
            vertices.push(x);           vertices.push(wallHeight); vertices.push(l+y);

            uvs.push((x-tileSize)/tileSize); uvs.push((y+tileSize)/tileSize);
            uvs.push(x/tileSize);            uvs.push((y+tileSize)/tileSize);
            uvs.push((x-tileSize)/tileSize); uvs.push((y-wallHeight)/tileSize);

            uvs.push((x-tileSize)/tileSize); uvs.push((y-wallHeight)/tileSize);
            uvs.push(x/tileSize);            uvs.push((y+tileSize)/tileSize);
            uvs.push(x/tileSize);            uvs.push((y-wallHeight)/tileSize);
        }

        normals.push(0.0); normals.push(0.0); normals.push(n);
        normals.push(0.0); normals.push(0.0); normals.push(n);
        normals.push(0.0); normals.push(0.0); normals.push(n);
        normals.push(0.0); normals.push(0.0); normals.push(n);
        normals.push(0.0); normals.push(0.0); normals.push(n);
        normals.push(0.0); normals.push(0.0); normals.push(n);

        indices.push(index);
        indices.push(index+1);
        indices.push(index+2);
        indices.push(index+3);
        indices.push(index+4);
        indices.push(index+5);
        index += 6;
    }

    function createFrontWall(front:Bool, x:Int, y:Int) {
        var f = 1.0*tileSize;
        var n = 1.0;
        if(!front){
            f = 0.0;
            n = -1.0;
        }
        if(front){
            vertices.push(x+f); vertices.push(0.0);        vertices.push(y);
            vertices.push(x+f); vertices.push(wallHeight); vertices.push(y);
            vertices.push(x+f); vertices.push(0.0);        vertices.push(y+tileSize);
    
            vertices.push(x+f); vertices.push(wallHeight); vertices.push(y);
            vertices.push(x+f); vertices.push(wallHeight); vertices.push(y+tileSize);
            vertices.push(x+f); vertices.push(0.0);        vertices.push(y+tileSize);

            uvs.push(y/tileSize);            uvs.push(1.0);
            uvs.push(y/tileSize);            uvs.push(-wallHeight/tileSize);
            uvs.push((y-tileSize)/tileSize); uvs.push(1.0);

            uvs.push(y/tileSize);            uvs.push(-wallHeight/tileSize);
            uvs.push((y-tileSize)/tileSize); uvs.push(-wallHeight/tileSize);
            uvs.push((y-tileSize)/tileSize); uvs.push(1.0);

        }else{
            vertices.push(x+f); vertices.push(0.0);        vertices.push(y);
            vertices.push(x+f); vertices.push(0.0);        vertices.push(y+tileSize);
            vertices.push(x+f); vertices.push(wallHeight); vertices.push(y);
    
            vertices.push(x+f); vertices.push(wallHeight); vertices.push(y+tileSize);
            vertices.push(x+f); vertices.push(wallHeight); vertices.push(y);
            vertices.push(x+f); vertices.push(0.0);        vertices.push(y+tileSize);

            uvs.push(y/tileSize);            uvs.push(1.0);
            uvs.push((y+tileSize)/tileSize);            uvs.push(1.0);
            uvs.push(y/tileSize); uvs.push(-wallHeight/tileSize);

            uvs.push((y+tileSize)/tileSize);            uvs.push(-wallHeight/tileSize);
            uvs.push(y/tileSize); uvs.push(-wallHeight/tileSize);
            uvs.push((y+tileSize)/tileSize); uvs.push(1.0);
        }

        normals.push(n); normals.push(0.0); normals.push(0.0);
        normals.push(n); normals.push(0.0); normals.push(0.0);
        normals.push(n); normals.push(0.0); normals.push(0.0);
        normals.push(n); normals.push(0.0); normals.push(0.0);
        normals.push(n); normals.push(0.0); normals.push(0.0);
        normals.push(n); normals.push(0.0); normals.push(0.0);

        indices.push(index);
        indices.push(index+1);
        indices.push(index+2);
        indices.push(index+3);
        indices.push(index+4);
        indices.push(index+5);
        index += 6;
    }

    static function checkNeighbour(grid:Array<Array<Int>>, w:Int, h:Int, x:Int, y:Int) {
        var dir:Array<Wall> = [];
        if(y - 1 > 0 && grid[x][y - 1] == 0) dir.push(Left);
        if(y + 1 < h - 1 && grid[x][y + 1] == 0) dir.push(Right);
        if(x + 1 < w - 1 && grid[x + 1][y] == 0) dir.push(Front);
        if(x - 1 > 0 && grid[x - 1][y] == 0) dir.push(Back);
        return dir;
    }

    static function checkWall(grid:Array<Array<Int>>, w:Int, h:Int, x:Int, y:Int):Array<Direction> {
        var dir:Array<Direction> = [];
        if(y - 2 > 0 && grid[x][y - 1] == 1) dir.push(North);
        if(y + 2 < h - 1 && grid[x][y + 1] == 1) dir.push(South);
        if(x + 2 < w - 1 && grid[x + 1][y] == 1) dir.push(East);
        if(x - 2 > 0 && grid[x - 1][y] == 1) dir.push(West);
        return dir;
    }
}