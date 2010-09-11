// Copyright (C) 2007  Sam Peterson <peabodyenator@gmail.com>

// This file is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2, or (at your option)
// any later version.
// 
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

////////////////////////////////////////////////////////////////////////

// I wrote this game of hangman in C++ when I was bored one day.  I hope
// somebody enjoys it.

#include <ctime>
#include <limits>
#include <cstdlib>
#include <cctype>
#include <iostream>
#include <set>
#include <string>
#include <vector>
#include <utility>
#include <cerrno>
#include <fstream>
#include <getopt.h>

using namespace std;

// globals
string dictionary_file = "/usr/share/dict/words";
size_t minimum_word_size = 8;

vector< string > board;
vector< pair < pair<size_t, size_t>, char > > body;
set< char > used_letters;
string word;
string word_letters;
vector < string > dictionary;

// normalize case
inline void TOLOWER(string& st)
{
  for(size_t i = 0; i < st.size(); i++)
    st[i] = tolower(st[i]);
}

// deal with bad input
inline void check_cin()
{
  if (!cin)
  {
    if (cin.eof())
      exit(EXIT_SUCCESS);
    cin.clear();
    cin.ignore(numeric_limits<streamsize>::max(), '\n');
  }
} // end check_cin

void build_dictionary()
{
  ifstream dict(dictionary_file.c_str());
  if (!dict)
  {
    perror("Could not open dictionary");
    exit(EXIT_FAILURE);
  }

  string current_word;
  while(dict >> current_word)
  {
    TOLOWER(current_word);
    if (current_word.size() >= minimum_word_size)
      dictionary.push_back(current_word);
  } // end while
} // end build_dictionary

void fill_place_holders()
{
  for (size_t i = 0; i < word.size(); i++)
    word_letters.append("-");
}

void pick_word()
{
  size_t picked_word = rand() % dictionary.size();
  word = dictionary.at(picked_word);
} // end pick_word

void print_board()
{
  vector< string >::iterator it;
  for (it = board.begin(); it != board.end(); it++)
    cout << *it << endl;

  cout << endl << endl << "word: " << word_letters << endl
       << "used: ";
  set < char >::iterator set_it;
  for (set_it = used_letters.begin(); set_it != used_letters.end(); set_it++)
    cout << *set_it << " ";
  cout << endl;
} // end print_board

void initialize_board_and_body()
{
  // board
  board.push_back("-----");
  board.push_back("    |");
  board.push_back("    |");
  board.push_back("    |");
  board.push_back("    |");
  board.push_back("   /|\\");

  // body coordinates
  body.push_back(make_pair(make_pair(4,3), '\\'));
  body.push_back(make_pair(make_pair(4,1), '/'));
  body.push_back(make_pair(make_pair(3,2), '|'));
  body.push_back(make_pair(make_pair(2,3), '\\'));
  body.push_back(make_pair(make_pair(2,2), '|'));
  body.push_back(make_pair(make_pair(2,1), '/'));
  body.push_back(make_pair(make_pair(1,2), '0'));
}

void add_part()
{
  if (!body.size())
  {
    cout << "You hang for minutes in a painful, suffocating death." << endl;
    cout << "You should have realized it was this: " << word << endl;
    exit(EXIT_SUCCESS);
  }

  pair< pair<size_t, size_t>, char> part = body.back();
  body.pop_back();
  board[part.first.first][part.first.second] = part.second;
} // end add_part

void do_turn()
{
  char letter;
  check_cin();
  cout << "Enter a letter: ";
  cin >> letter;
  letter = tolower(letter);

  while (used_letters.find(letter) != used_letters.end() || !isalpha(letter))
  {
    cout << "Bad letter." << endl;
    cout << "Enter a letter: ";
    check_cin();
    cin >> letter;
    letter = tolower(letter);
  } // end while

  used_letters.insert(letter);
  bool found = false;
  for (size_t i = 0; i < word.size(); i++)
  {
    if (word[i] == letter)
    {
      word_letters[i] = letter;
      found = true;
    }
  } // end for

  if (word_letters.find("-") == string::npos)
  {
    cout << "That's right! " << word << "!" << endl
         << "Congratulations!  You avoided the hangman's noose." << endl;
    exit(EXIT_SUCCESS);
  }

  if (!found)
    add_part();
} // end do_turn

void do_usage()
{
  cout << "Usage: hangman [options]" << endl
       << "Options:" << endl
       << "\t-w user_word" << endl
       << "\t-f dictionary_file" << endl
       << "\t-l minimum_word_length" << endl
       << "Default dict file is " << dictionary_file
       << " with minimum word length of " << minimum_word_size << endl;
  exit(EXIT_FAILURE);
}

bool USER_WORD = false;

int main(int argc, char *argv[])
{
  // seed random number generator
  srand(time(NULL));

  // check options
  if (argc > 1)
  {
    char c;
    while ((c = getopt(argc, argv, "w:f:l:h")) != -1)
    {
      switch(c)
      {
        case 'w':
          word = optarg;
          TOLOWER(word);
          USER_WORD = true;
          for (size_t i = 0; i < word.size(); i++)
          {
            if (!isalpha(word[i]))
            {
              cerr << "Bad characters in given word." << endl;
              exit(EXIT_FAILURE);
            }
          } // end for
          break;
        case 'f':
          dictionary_file = optarg;
          break;
        case 'l':
          minimum_word_size = atoi(optarg);
          break;
        case 'h':
          do_usage();
      } // end switch
    } // end while
  }

  if (!USER_WORD)
  {
    cout << "Choosing a word, please wait..." << endl;
    build_dictionary();
    pick_word();
  } // end if

  fill_place_holders();
  initialize_board_and_body();
  print_board();

  while (true)
  {
    do_turn();
    print_board();
  }

  return EXIT_SUCCESS;
} // end main
