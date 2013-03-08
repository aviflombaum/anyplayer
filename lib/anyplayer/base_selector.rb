class Anyplayer::BaseSelector < Anyplayer::Selector
  prepend Anyplayer::Cacher::Selector
  prepend Anyplayer::Voter::Selector
end
