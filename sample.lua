local SAMPLES = {}
local HTML = require('html')

SAMPLES.LoremIpsum = 
[[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque bibendum vehicula egestas. Mauris vel ipsum quis libero venenatis sollicitudin et eget tellus. In hac habitasse platea dictumst. Nullam id interdum dui. Suspendisse volutpat mattis leo eu vehicula. Sed non mauris vel velit mollis porttitor lacinia in felis. Morbi posuere eros at diam mattis, non luctus nulla efficitur. Ut gravida scelerisque nunc, a sollicitudin enim finibus vitae.

Etiam quis massa accumsan, egestas felis quis, feugiat mauris. Maecenas sem nulla, tincidunt eu feugiat nec, volutpat non libero. Ut non ex ex. Integer luctus ullamcorper dignissim. Donec eleifend facilisis ligula sit amet luctus. Nunc quam dolor, mollis et orci eu, venenatis consequat urna. Donec et tortor maximus massa tristique lobortis. Phasellus pretium lorem sit amet est vestibulum, quis condimentum justo cursus. Fusce vitae sem et dolor pretium finibus. Proin elementum nec eros et accumsan. Quisque consectetur vitae sapien sed sollicitudin. Integer facilisis venenatis leo, ut ultricies magna accumsan ut. Ut vulputate mi velit, sit amet faucibus augue semper dapibus.

Maecenas consequat accumsan lectus sit amet lacinia. Donec vitae lacinia ipsum, eu sollicitudin elit. Nullam non leo gravida, scelerisque nisi in, ultricies ipsum. Sed lectus dui, molestie sed gravida ut, malesuada at felis. Vestibulum sit amet rhoncus mauris. Proin vehicula consectetur volutpat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque in elit lectus. Etiam posuere sem quis nisi aliquet tristique. Aenean non elit ligula. In cursus risus et lorem fringilla, at congue ante imperdiet. Proin id molestie nisl, in volutpat metus. Phasellus molestie faucibus elementum.

Nullam placerat tincidunt pulvinar. Cras scelerisque leo justo, at maximus dui mattis sit amet. Proin vel libero accumsan, egestas dui a, volutpat velit. Sed mollis egestas interdum. Nullam scelerisque mi ex, id blandit purus iaculis id. Praesent iaculis dolor sit amet velit commodo, sit amet bibendum ex laoreet. Morbi gravida felis a tortor blandit pharetra. Phasellus pellentesque felis nisi, in accumsan mi imperdiet nec. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean rhoncus vehicula rhoncus. Integer id finibus turpis. Proin commodo, velit ut ornare vestibulum, purus leo aliquet neque, id maximus tellus nulla vitae ipsum.

Nulla tincidunt orci sit amet faucibus viverra. Praesent vel auctor augue. Aliquam a enim eu nulla porttitor eleifend sed vel metus. Proin bibendum est condimentum libero porta sodales ut sed justo. Morbi ultrices lectus eget nisl condimentum, et consectetur nulla vulputate. Quisque sagittis massa sit amet mi facilisis cursus. Curabitur diam justo, vestibulum id tempor quis, varius non nunc. Duis non metus vel mi hendrerit consequat sit amet in diam. In hac habitasse platea dictumst.]]

SAMPLES.Trees = 
[[Trees are magnificent, living giants that have graced our planet for millions of years, and they play an integral role in maintaining the balance of our ecosystem. These towering organisms provide us with a multitude of invaluable benefits, both ecological and aesthetic. One of their most crucial roles is in oxygen production. Through the process of photosynthesis, trees absorb carbon dioxide from the atmosphere and release life-sustaining oxygen, making them vital for the air we breathe.

Moreover, trees act as natural carbon sinks, effectively mitigating climate change by storing carbon in their trunks, branches, and roots. This carbon sequestration helps reduce the concentration of greenhouse gases in the atmosphere, thereby slowing the progression of global warming. Trees also contribute to soil stability and erosion prevention by anchoring the earth with their extensive root systems, which can be particularly essential in areas prone to landslides or flooding.

Beyond their environmental benefits, trees enhance our quality of life in numerous ways. Urban trees, in particular, offer shade, reducing temperatures and making cities more comfortable during hot summer months. They improve air quality by filtering out pollutants and particulate matter, creating healthier environments for both humans and wildlife. The presence of trees in urban landscapes can also have a calming and stress-reducing effect, contributing to mental and emotional well-being.

Trees are incredibly diverse, with thousands of species worldwide, each adapted to different climates and ecosystems. This biodiversity offers habitats and sustenance for countless creatures, from birds to insects, and even larger mammals. The relationship between trees and wildlife is symbiotic, as animals disperse seeds and help maintain forest health. It is essential to understand and appreciate the vital role trees play in supporting the rich tapestry of life on Earth, making conservation and reforestation efforts all the more critical.

Finally, trees hold a special place in human culture and history. They have been used for shelter, fuel, and sustenance for generations, serving as a symbol of life and longevity in various traditions. Additionally, they have inspired countless artists, writers, and poets, with their enduring beauty and majestic presence serving as subjects of creative expression throughout the ages. Trees, with their resilience and adaptability, continue to be a source of inspiration and awe, connecting us to the natural world in profound ways.]]

SAMPLES.Roblox =
[[ROBLOX is a popular online gaming platform and game creation system that has captured the imagination of millions of users worldwide. Launched in 2006, it provides a unique and dynamic environment where players can create and share their own games, or immerse themselves in a vast library of user-generated content. The platform is renowned for its user-generated games, known as "experiences," which span a wide range of genres, from adventures and role-playing games to virtual worlds and simulations.

One of the defining features of ROBLOX is its accessibility and versatility. It offers a simple yet robust game creation tool that allows users, known as "developers," to craft their own virtual experiences without needing extensive programming knowledge. This democratization of game development has empowered a diverse community of creators, from amateurs to experienced developers, to bring their ideas to life. The platform's social aspects, such as the ability to chat with friends and join virtual communities, enhance the sense of community and collaboration.

ROBLOX's virtual economy is another notable aspect, with a virtual currency called "Robux" that enables players to buy in-game items, avatar accessories, and other virtual assets. Some developers even monetize their creations by selling game passes and virtual goods, turning their passion for game development into a source of income. This unique blend of social interaction, creative expression, and economic opportunities has contributed to ROBLOX's enduring popularity, making it a favorite destination for gamers of all ages.]]

SAMPLES.GooglePing =
[[PING google.com (142.250.9.113) 56(84) bytes of data.
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=1 ttl=106 time=10.0 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=2 ttl=106 time=8.93 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=4 ttl=106 time=13.6 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=5 ttl=106 time=42.2 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=6 ttl=106 time=8.87 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=7 ttl=106 time=10.3 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=8 ttl=106 time=8.89 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=9 ttl=106 time=8.66 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=10 ttl=106 time=8.94 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=11 ttl=106 time=8.73 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=12 ttl=106 time=9.47 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=13 ttl=106 time=10.2 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=14 ttl=106 time=10.4 ms
64 bytes from yq-in-f113.1e100.net (142.250.9.113): icmp_seq=15 ttl=106 time=8.79 ms
--- google.com ping statistics ---
15 packets transmitted, 14 received, 6.66667% packet loss, time 14039ms
rtt min/avg/max/mdev = 8.658/11.998/42.228/8.476 ms]]

SAMPLES.GooglePing = HTML.VTag("code", {}, SAMPLES.GooglePing:gsub('\n', "<br>\n"))

return SAMPLES