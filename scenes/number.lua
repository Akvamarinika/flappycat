Number = {}
Number.__index = Number

function Number:create(x0, y0, ordinal, image, num) 
	local number = {}
    setmetatable(number, Number)

	number.image = image
    number.val = num

    if self.val == 1 then
        number.location = Vector:create(x0 + (ordinal - 1) * number.image:getWidth(), y0 )	 -- x0 + ...
    else
        number.location = Vector:create(x0 + (ordinal - 1) * (number.image:getWidth() + 2), y0 )	 -- x0 + ...
   end
	

	return number
end



function Number:draw()

    --вывод цифры:
    love.graphics.draw(self.image, self.location.x, self.location.y)
    
end