# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
 User.create(email:"admin@gmail.com", role:"admin", password:"Admin@123")
 User.create(email:"user@gmail.com", role:"user", password:"User@123")
