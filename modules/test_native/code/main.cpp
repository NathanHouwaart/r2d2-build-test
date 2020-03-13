#include <iostream>

int main( void ){	
  std::cout << "this is working now\n\n\n" ;


  std::cout << "what is your name?\n";
  std::string name;

  std::cin >> name;

  std::cout << "Welcome " << name << "!\n";


  return 0;
}