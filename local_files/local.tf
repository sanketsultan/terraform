resource "local_file" "pets" {
  filename = "pets.txt"
  content  = "Dog\nCat\nFish\nBird\nHamster"
  file_permission = 0700
  
}