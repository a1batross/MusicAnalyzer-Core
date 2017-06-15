/*
 * Copyright (C) 2006-2016  Music Technology Group - Universitat Pompeu Fabra
 *
 * This file is part of Essentia
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

// Streaming extractor designed for high-level (classifier-based) analysis of
// music collections.

//#include <essentia/streaming/algorithms/poolstorage.h>
//#include <essentia/essentiautil.h>
#include "essentia/algorithm.h"
#include "essentia/algorithmfactory.h"
#include "essentia/pool.h"
#include "extractor_music/MusicExtractor.h"
#include <gaia2/gaia.h>

#include "main.h"

using namespace std;
using namespace essentia;
using namespace essentia::standard;


int ma::classifyToFile(const string analyzeFile, const string profileFile, const string outputFile)
{
	MusicExtractor *extractor = new MusicExtractor();
	essentia::standard::Algorithm* yamlInput = EssentiaFactory<essentia::standard::Algorithm>::create(
		"YamlInput",
		"filename", analyzeFile,
		"format", "json");
	int result;

	try
	{
		Pool pool;

		extractor->setExtractorOptions( profileFile );
		extractor->loadSVMModels();

		yamlInput->output("pool").set(pool);
		yamlInput->compute();

		// apply SVM models and save
		extractor->computeSVMDescriptors(pool);

		pool.removeNamespace("lowlevel");
		pool.removeNamespace("rhythm");
		pool.removeNamespace("tonal");
		pool.removeNamespace("metadata");

		extractor->mergeValues(pool);
		extractor->outputToFile(pool, outputFile);
		result = 0;
	}
	catch( const EssentiaException& e )
	{
		cerr << e.what() << endl;
		result = 1;
	}

	delete yamlInput;
	delete extractor;
	return result;
}

int ma::analyzeToFile(const string inputFile, const string profileFile, const string outputFile)
{
	// Returns: 1 on essentia error
	//          2 if there are no tags in the file
	int result;
	MusicExtractor *extractor = new MusicExtractor();
	try
	{
		cout.precision(10); // TODO ????


		extractor->setExtractorOptions(profileFile);
		extractor->mergeValues(extractor->results);

		result = extractor->compute(inputFile);

		if (result > 0)
			cerr << "Quitting early." << endl;
		else
			extractor->outputToFile(extractor->stats, outputFile);
	}
	catch (EssentiaException& e)
	{
		cerr << e.what() << endl;
		result = 1;
	}

	delete extractor;

	return result;
}

