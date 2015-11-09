//THIS CODE IS UNDER THE GPLv3 LICENSE 
//Check the LICENSE file in the codes top folder.
//Author: n2omatt - n2o.matt@gmail.com
//Enjoy...

//Header.
#include "SpaceShip.h"
//std
#include <iostream>

//Usings.
using namespace std;

//Here we're defining our private class.
class SpaceShip::SpaceShipPrivate 
{
    // Vars //
public:
    int someVar;
    
    // CTOR/DTOR //
public:
    //This isn't needed, I'm defining the DTOR 
    //just to print a message when the Implementation
    //Class gets destructed - So indeed the unique_ptr
    //in the main class are cleaning up this correctly.
    ~SpaceShipPrivate()
    {
        cout << "SpaceShipPrivate::~SpaceShipPrivate()" << endl;
    }

    // Methods //
public:
    //It can be placed outside the class definition too.
    void someCoolMethod() 
    {
        cout << "SpaceShipPrivate::someCoolMethod()" << endl;
        cout << "SpaceShipPrivate::someVar (" << someVar << ")" << endl;
    }
};

// Definition of SpaceShip Stuff..
SpaceShip::SpaceShip() :
    m_pSpaceShipPrivate(new SpaceShipPrivate()) //This will be deleted automagically :).
{
    //Anything...
}

SpaceShip::~SpaceShip()
{
    //Empty...
}

// Public Methods //
void SpaceShip::killAllUglyAliens()
{
    cout << "SpaceShip::killAllUglyAliens()" << endl;
    //Here we're using our private class.
    m_pSpaceShipPrivate->someVar = 10;
    m_pSpaceShipPrivate->someCoolMethod();
}
