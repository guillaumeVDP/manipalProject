module MusicsHelper
	def hasVideo(music)
		if music.path.split('.')[music.path.split('.').length - 1] == "mp4"
			return true
		else
			return false
		end
	end
end

