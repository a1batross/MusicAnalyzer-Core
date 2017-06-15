/*
 * Copyright (C) 2006-2016  Music Technology Group - Universitat Pompeu Fabra
 * Copyright (C) 2017 a1batross
 *
 * This file is part of Essentia and MusicAnalyzer-Core
 *
 * Essentia is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation (FSF), either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the Affero GNU General Public License
 * version 3 along with this program.  If not, see http://www.gnu.org/licenses/
 */

#pragma once
#ifndef MAIN_H
#define MAIN_H

#include <string>
#include <vector>

namespace ma
{
int analyzeToFile( const std::string inputFile, const std::string profileFile, const std::string outputFile );
int classifyToFile( const std::string analyzeFile, const std::string profileFile, const std::string outputFile );
}
#endif // MAIN_H
