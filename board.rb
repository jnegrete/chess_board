#!/usr/bin/env ruby

class Board
  def initialize
    @matrix = Array.new(8) { |i| Array.new(8) { |j| i * 8 + j + 1 } }
  end

  def get_square_color(n)
    i = (n / 8.0).ceil.even?
    j = n.even?
    return j unless i

    !j
  end

  def is_valid_number(n)
    n.positive? && n < 65
  end

  def positions_same_color(a, b)
    a == b
  end

  def get_indexes(n)
    y = (n / 8.0).ceil
    x = n % 8
    x = 8 if x.zero?
    x - 1, y - 1
  end

  def diagonal_up_from(x, y, diagonal)
    while x > 0 && y > 0 do
      x -= 1
      y -= 1
      diagonal.push(@matrix[y][x])
    end
  end

  def diagonal_down_from(x, y, diagonal)
    while x < 7 && y < 7 do
      x += 1
      y += 1
      diagonal.push(@matrix[y][x])
    end
  end

  def inv_diagonal_up_from(x, y, diagonal)
    while x < 7 && y > 0 do
      x += 1
      y -= 1
      diagonal.push(@matrix[y][x])
    end
  end

  def inv_diagonal_down_from(x, y, diagonal)
    while x > 0 && y < 7 do
      x -= 1
      y += 1
      diagonal.push(@matrix[y][x])
    end
  end

  def get_diagonal_from(n)
    x1, y1 = get_indexes(n)
    diagonal = [n]
    # up
    diagonal_up_from(x1, y1, diagonal)
    # down
    diagonal_down_from(x1, y1, diagonal)
    return diagonal
  end

  def get_inverted_diagonal_from(n)
    x1, y1 = get_indexes(n)
    diagonal = [n]
    # up
    inv_diagonal_up_from(x1, y1, diagonal)
    # down
    inv_diagonal_down_from(x1, y1, diagonal)
    return diagonal
  end

  def get_diagonals_intersection(a, b)
    diagonal = get_diagonal_from(a)
    inv_diagonal = get_inverted_diagonal_from(b)
    return intersection = diagonal & inv_diagonal
  end

  def bishop_move(a, b)
    is_valid_number(a)
    is_valid_number(b)
    same_color = positions_same_color(get_square_color(a), get_square_color(b))
    unless is_valid_number(a) || is_valid_number(b) || same_color
      return 'invalid muvement'
    end

    if get_diagonal_from(a).include?(b) || get_inverted_diagonal_from(a).include?(b)
      return "you need one muvement from #{a} to #{b}"
    end

    intersection = get_diagonals_intersection(a, b)
    intersection = get_diagonals_intersection(b, a) unless intersection.any?
    "two movements, from #{a} to #{intersection[0]} and then to #{b}"
  end
end

b = Board.new()
puts b.bishop_move(1, 64)
puts b.bishop_move(15, 38)
puts b.bishop_move(58, 21)
