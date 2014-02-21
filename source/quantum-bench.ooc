
use quantum, dye
import quantum/[world, collisions]

import dye/[core, app, math, primitives]

import math/Random

QuantumBench: class extends App {

    world: World

    init: func {
        super("Quantum Benchmark", 1280, 720)
        dye setClearColor(Color black())
    }

    setup: func {
        world = World new()

        obstacle := AABBShape new(1280, 5)
        obstacle pos set!(1280 * 0.5, 0)
        world addShape(obstacle)

        baseX := 1280 * 0.5
        baseY := 200

        for (i in 0..15) {
            for (j in -10..10) {
                MyBox new(this, baseX + j * 45, baseY + i * 45)
            }
        }
    }

    update: func {
        world collide(0.5)
        world step(0.5)
    }

}

MyBox: class {
    app: QuantumBench

    init: func (=app, x, y: Float) {
        size := vec2(32, 32)
        pos := vec2(x, y)

        box := AABBShape new(size x, size y)
        body := Body new(box)
        body pos set!(x, y)
        app world addBody(body)

        rect := GlRectangle new(size)
        rect color r = Random randInt(0, 255)
        rect color g = Random randInt(0, 255)
        rect color b = Random randInt(0, 255)
        rect opacity = 0.4
        rect pos = body pos
        app dye add(rect)
    }
}

main: func {
    app := QuantumBench new()
    app run(120.0)
}

