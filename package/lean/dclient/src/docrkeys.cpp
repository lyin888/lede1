#include "docr.h"

void DOcr::_setKeys()
{
    m_value.push_back('0');
    m_keys.push_back("000111000"
                      "011111110"
                      "011000110"
                      "110000011"
                      "110000011"
                      "110000011"
                      "110000011"
                      "110000011"
                      "110000011"
                      "110000011"
                      "011000110"
                      "011111110"
                      "000111000");

    m_value.push_back('1');
    m_keys.push_back("000111000"
                      "011111000"
                      "011111000"
                      "000011000"
                      "000011000"
                      "000011000"
                      "000011000"
                      "000011000"
                      "000011000"
                      "000011000"
                      "000011000"
                      "011111111"
                      "011111111");

    m_value.push_back('2');
    m_keys.push_back("011111000"
                      "111111100"
                      "100000110"
                      "000000110"
                      "000000110"
                      "000001100"
                      "000011000"
                      "000110000"
                      "001100000"
                      "011000000"
                      "110000000"
                      "111111110"
                      "111111110");

    m_value.push_back('3');
    m_keys.push_back("011111000"
                      "111111110"
                      "100000110"
                      "000000110"
                      "000001100"
                      "011111000"
                      "011111100"
                      "000001110"
                      "000000110"
                      "000000110"
                      "100001110"
                      "111111100"
                      "011111000");

    m_value.push_back('4');
    m_keys.push_back("000001100"
                      "000011100"
                      "000011100"
                      "000111100"
                      "001101100"
                      "001101100"
                      "011001100"
                      "011001100"
                      "111111111"
                      "111111111"
                      "000001100"
                      "000001100"
                      "000001100");

    m_value.push_back('5');
    m_keys.push_back("111111110"
                      "111111110"
                      "110000000"
                      "110000000"
                      "110000000"
                      "111110000"
                      "111111100"
                      "000001110"
                      "000000110"
                      "000000110"
                      "100001110"
                      "111111100"
                      "011111000");

    m_value.push_back('6');
    m_keys.push_back("000111100"
                      "001111110"
                      "011000010"
                      "011000000"
                      "110000000"
                      "110111100"
                      "111111110"
                      "111000111"
                      "110000011"
                      "110000011"
                      "011000111"
                      "011111110"
                      "000111100");

    m_value.push_back('7');
    m_keys.push_back("011111111"
                      "011111111"
                      "000000011"
                      "000000010"
                      "000000110"
                      "000001100"
                      "000001000"
                      "000011000"
                      "000010000"
                      "000110000"
                      "000110000"
                      "001100000"
                      "001100000");

    m_value.push_back('8');
    m_keys.push_back("001111100"
                      "011111110"
                      "011000110"
                      "011000110"
                      "011100100"
                      "001111100"
                      "001111100"
                      "011001110"
                      "110000011"
                      "110000011"
                      "111000111"
                      "011111110"
                      "001111100");

    m_value.push_back('9');
    m_keys.push_back("001111000"
                      "011111110"
                      "111000110"
                      "110000011"
                      "110000011"
                      "111000111"
                      "011111111"
                      "001111011"
                      "000000011"
                      "000000110"
                      "010000110"
                      "011111100"
                      "001111000");
}
