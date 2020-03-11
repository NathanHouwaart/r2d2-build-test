#include <hwlib.hpp>

int main() {
    hwlib::wait_ms(2000);
    // kill the watchdog
    WDT->WDT_MR = WDT_MR_WDDIS;

    while (true) {
        hwlib::cout << "hello world" << hwlib::endl;
        hwlib::wait_ms(2000);
    }
}