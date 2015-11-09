//THIS CODE IS UNDER THE GPLv3 LICENSE 
//Check the LICENSE file in the codes top folder.
//Author: n2omatt - n2o.matt@gmail.com
//Enjoy...

//std
#include <memory> //unique_ptr. 

class SpaceShip 
{
    // Inner Types //
private:
    class SpaceShipPrivate; //Don't make it visible to anyone.

    // CTOR/DTOR //
public:
    SpaceShip();
    ~SpaceShip();

    // Public Methods //
public:
    void killAllUglyAliens();

    // iVars //
private:
    //We don't want mess with the memory mangement by ourselves, 
    //so the unique_ptr, but as pointed in the blog post, 
    //we must declare explicity the Desctructor **AND DEFINE IT 
    //IN THE .cpp FILE**
    std::unique_ptr<SpaceShipPrivate> m_pSpaceShipPrivate; 
};
