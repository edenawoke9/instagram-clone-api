# Creating users
user1 = User.create(username: 'john_doe', email: 'john@example.com', password: 'password123')
user2 = User.create(username: 'jane_smith', email: 'jane@example.com', password: 'password123')
user3 = User.create(username: 'bob_jones', email: 'bob@example.com', password: 'password123')

# Creating messages for user1 (sent and received)
Message.create(sender: user1, receiver: user2, content: 'Hey, how are you?')
Message.create(sender: user1, receiver: user3, content: 'Hello, long time no see!')
Message.create(sender: user2, receiver: user1, content: 'I am good, how about you?')
Message.create(sender: user3, receiver: user1, content: 'Hi, hope everything is fine!')

# Creating messages for user2 (sent and received)
Message.create(sender: user2, receiver: user1, content: 'I am good, how about you?')
Message.create(sender: user2, receiver: user3, content: 'Hey Bob, what’s up?')
Message.create(sender: user3, receiver: user2, content: 'Hey Jane, everything is good!')

puts "Seed data created successfully."
