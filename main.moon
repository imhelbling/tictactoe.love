version = "v0.1"

Board = require "lib.board"
Cell = require "lib.cell"
Button = require "lib.button"




love.window.setTitle "LAN Tic-Tac-Toe (#{version})"
window_width, window_height, flags = love.window.getMode!
-- window is currently 800 wide by 600 high

player_piece = "o"

turn = "o"



board_size = window_height*3/4

board_pos_x = (window_width - board_size)/2
board_pos_y = (window_height - board_size)/2

mouse_x, mouse_y = love.mouse.getPosition!

export board = Board board_pos_x, board_pos_y, board_size

export mute_music_btn = Button "mute music", (window_width - 117), (window_height - 80), 82, 20

export mute_sfx_btn = Button "mute sfx", (window_width - 100), (window_height - 50), 65, 20

x_wins = false
o_wins = false

airhorn_played = false



music = love.audio.newSource "audio/clair_delune.mp3", "stream"

click = love.audio.newSource "audio/click1.mp3", "static"
click\setVolume 0.5

airhorn = love.audio.newSource "audio/airhorn.mp3", "static"
airhorn\setVolume 0.3

reset = ->
    airhorn\stop!
    x_wins = false
    o_wins = false
    airhorn_played = false
    board.a1.has_x = false
    board.a2.has_x = false
    board.a3.has_x = false
    board.b1.has_x = false
    board.b2.has_x = false
    board.b3.has_x = false
    board.c1.has_x = false
    board.c2.has_x = false
    board.c3.has_x = false
    board.a1.has_o = false
    board.a2.has_o = false
    board.a3.has_o = false
    board.b1.has_o = false
    board.b2.has_o = false
    board.b3.has_o = false
    board.c1.has_o = false
    board.c2.has_o = false
    board.c3.has_o = false
    board.a1.has_piece = false
    board.a2.has_piece = false
    board.a3.has_piece = false
    board.b1.has_piece = false
    board.b2.has_piece = false
    board.b3.has_piece = false
    board.c1.has_piece = false
    board.c2.has_piece = false
    board.c3.has_piece = false


get_cell_for = (given_cell) ->
    board\cell_at given_cell



moused_over = (given_cell) ->
    cell = get_cell_for given_cell

    if mouse_x > cell.x - board_size/6 and
        mouse_x < cell.x + board_size/6 and
        mouse_y > cell.y - board_size/6 and
        mouse_y < cell.y + board_size/6

        return true



left_clicked = ->
    love.mouse.isDown 1

right_clicked = ->
    love.mouse.isDown 2



check_for_winner = ->
    -- a1, a2, a3
    if board.a1.has_x and board.a2.has_x and board.a3.has_x
        x_wins = true
    -- b1, b2, b3
    if board.b1.has_x and board.b2.has_x and board.b3.has_x
        x_wins = true
    -- c1, c2, c3
    if board.c1.has_x and board.c2.has_x and board.c3.has_x
        x_wins = true
    -- a1, b1, c1
    if board.a1.has_x and board.b1.has_x and board.c1.has_x
        x_wins = true
    -- a2, b2, c2
    if board.a2.has_x and board.b2.has_x and board.c2.has_x
        x_wins = true
    -- a3, b3, c3
    if board.a3.has_x and board.b3.has_x and board.c3.has_x
        x_wins = true
    -- a1, b2, c3
    if board.a1.has_x and board.b2.has_x and board.c3.has_x
        x_wins = true
    -- a3, b2, c1
    if board.a3.has_x and board.b2.has_x and board.c1.has_x
        x_wins = true



    -- a1, a2, a3
    if board.a1.has_o and board.a2.has_o and board.a3.has_o
        o_wins = true
    -- b1, b2, b3
    if board.b1.has_o and board.b2.has_o and board.b3.has_o
        o_wins = true
    -- c1, c2, c3
    if board.c1.has_o and board.c2.has_o and board.c3.has_o
        o_wins = true
    -- a1, b1, c1
    if board.a1.has_o and board.b1.has_o and board.c1.has_o
        o_wins = true
    -- a2, b2, c2
    if board.a2.has_o and board.b2.has_o and board.c2.has_o
        o_wins = true
    -- a3, b3, c3
    if board.a3.has_o and board.b3.has_o and board.c3.has_o
        o_wins = true
    -- a1, b2, c3
    if board.a1.has_o and board.b2.has_o and board.c3.has_o
        o_wins = true
    -- a3, b2, c1
    if board.a3.has_o and board.b2.has_o and board.c1.has_o
        o_wins = true

check_cell = (given_cell) ->
    cell = get_cell_for given_cell
    if (moused_over given_cell) and (left_clicked!)
        
        unless cell.has_piece
            click\stop!
            click\play!

        love.graphics.print "left-clicked on cell "..given_cell, 100, 40
        
        if (player_piece) == "x" and not cell.has_piece
            cell.has_piece = true
            cell.has_o = false
            cell.has_x = true
        elseif (player_piece) == "o" and not cell.has_piece
            cell.has_piece = true
            cell.has_x = false
            cell.has_o = true

    if (moused_over given_cell) and (right_clicked!)

        unless cell.has_piece
            click\stop!
            click\play!

        love.graphics.print "right-clicked on cell "..given_cell, 100, 40
        
        if (player_piece) == "x" and not cell.has_piece
            cell.has_piece = true
            cell.has_x = false
            cell.has_o = true
        elseif (player_piece) == "o" and not cell.has_piece
            cell.has_piece = true
            cell.has_o = false
            cell.has_x = true

    


love.load = ->
    music\play!

love.update = (dt) ->
    mouse_x, mouse_y = love.mouse.getPosition!

    if (mute_music_btn\moused_over mouse_x, mouse_y) and left_clicked!
        if mute_music_btn.pressed = false
            mute_music_btn.pressed = true
        else 
            mute_music_btn.pressed = false

    unless x_wins or o_wins        
        check_cell "a1"
        check_cell "a2"
        check_cell "a3"
        check_cell "b1"
        check_cell "b2"
        check_cell "b3"
        check_cell "c1"
        check_cell "c2"
        check_cell "c3"

        check_for_winner!

    if love.keyboard.isDown "space"
        reset!



    if (x_wins or o_wins) and not airhorn_played
        airhorn\stop!
        airhorn\play!
        airhorn_played = true



love.draw = ->
    love.graphics.setBackgroundColor 5, 5, 5
    love.graphics.setColor 255, 255, 255

    -- window outline
    love.graphics.rectangle "line", 1, 1, 798, 598

    -- window dimensions
    love.graphics.print "window width:    "..window_width, 10, 10
    love.graphics.print "window height:  "..window_height, 10, 25

    -- cursor position
    love.graphics.print "cursor x: "..mouse_x, 10, 50
    love.graphics.print "cursor y: "..mouse_y, 10, 65



    -- mute music buttom
    mute_music_btn\draw!

    -- mute sfx button
    mute_sfx_btn\draw!


    if x_wins
        love.graphics.setColor 100, 100, 255
        love.graphics.print "Player 'X' wins!", 10, 550, 0, 3
    elseif o_wins
        love.graphics.setColor 255, 100, 0
        love.graphics.print "Player 'O' wins!", 10, 550, 0, 3
    else 
        love.graphics.setColor 255, 255, 255



    if x_wins
        love.graphics.setColor 255, 100, 0
    elseif o_wins
        love.graphics.setColor 100, 100, 255
    else 
        love.graphics.setColor 255, 255, 255


    board\render2!

    if board.a1.has_x
        board\place "x", "a1"
    if board.a2.has_x
        board\place "x", "a2"
    if board.a3.has_x
        board\place "x", "a3"

    if board.b1.has_x
        board\place "x", "b1"
    if board.b2.has_x
        board\place "x", "b2"
    if board.b3.has_x
        board\place "x", "b3"

    if board.c1.has_x
        board\place "x", "c1"
    if board.c2.has_x
        board\place "x", "c2"
    if board.c3.has_x
        board\place "x", "c3"



    if board.a1.has_o
        board\place "o", "a1"
    if board.a2.has_o
        board\place "o", "a2"
    if board.a3.has_o
        board\place "o", "a3"

    if board.b1.has_o
        board\place "o", "b1"
    if board.b2.has_o
        board\place "o", "b2"
    if board.b3.has_o
        board\place "o", "b3"

    if board.c1.has_o
        board\place "o", "c1"
    if board.c2.has_o
        board\place "o", "c2"
    if board.c3.has_o
        board\place "o", "c3"



    


    