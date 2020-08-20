local audio = {}

audio.powerOff = love.audio.newSource("audio/poweroff.ogg", "static")

function audio.check(name)
    return audio[name]
end

function audio.stop(name)
    if name then
        if not audio.check(name) then
            love.audio.stop()
        else
            audio[name]:stop()
        end
    else
        love.audio.stop()
    end

    return audio
end

function audio.play(name)
    if not audio.check(name) then
        print("Failed to play " .. name .. ": does not exist!")
        return
    end

    audio[name]:play()

    return audio
end

return audio
