#ifndef GUARD_concatenate_h
#define GUARD_concatenate_h

#include <string>
#include <vector>

std::vector<std::string> hcat(const std::vector<std::string>&,
			      const std::vector<std::string>&);
std::vector<std::string> vcat(const std::vector<std::string>&,
			      const std::vector<std::string>&);

#endif
