#include "ostream"

#define CATCH_CONFIG_MAIN
#include <catch.hpp>


TEST_CASE( "Catch native docker test", "Boolean expression"){
    int x = 1;
    int y = 1;

    REQUIRE( x == y );
}