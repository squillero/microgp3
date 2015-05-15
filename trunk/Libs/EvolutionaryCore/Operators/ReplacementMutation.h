/***********************************************************************\
|                                                                       |
| ReplacementMutationOperator.h                                         |
|                                                                       |
| This file is part of MicroGP v3 (ugp3)                                |
| http://ugp3.sourceforge.net/                                          |
|                                                                       |
| Copyright (c) 2002-2015 Giovanni Squillero                            |
|                                                                       |
|-----------------------------------------------------------------------|
|                                                                       |
| This program is free software; you can redistribute it and/or modify  |
| it under the terms of the GNU General Public License as published by  |
| the Free Software Foundation, either version 3 of the License, or (at |
| your option) any later version.                                       |
|                                                                       |
| This program is distributed in the hope that it will be useful, but   |
| WITHOUT ANY WARRANTY; without even the implied warranty of            |
| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU      |
| General Public License for more details                               |
|                                                                       |
|***********************************************************************'
| $Revision: 644 $
| $Date: 2015-02-23 14:50:30 +0100 (Mon, 23 Feb 2015) $
\***********************************************************************/

#ifndef HEADER_UGP3_CORE_REPLACEMENTMUTATIONOPERATOR
#define HEADER_UGP3_CORE_REPLACEMENTMUTATIONOPERATOR

#include "Operators/Mutation.h"

namespace ugp3
{
	namespace core
	{
        /** The Replacement Mutation Operator. It replace a node with a new node. 
			One or more nodes could be replaced.
			Only nodes that refer to generic macro could be replaced.*/
		class ReplacementMutationOperator : public MutationOperator
		{
		public:
			ReplacementMutationOperator();

			/** It generates new individuals. They are saved in outChildren. outChildren may be empty if
				operator is failed. Only nodes that refer to generic macro could be replaced.
				If sigma is > 0.0, two or more node could be replaced, otherwise only one. Do not remove
				attachFloatingEdges function!
				@param parameters parameters of the population on which the operator is applicated
				@param outChildren Vector of the new individuals. In this case, vector size must be 1.*/
			virtual void generate(const std::vector< Individual* >& parents,
                          std::vector< Individual* >& outChildren,
                          IndividualPopulation& population) const;

			/** Gets the name of the operator.
				@return The name of the operator.*/
			virtual const std::string getName() const;

			/** Gets the acronym of the operator.
				@return The acronym of the operator.*/
			virtual const std::string getAcronym() const;

			/** Gets the complete operator description.
				@return Operator description.
			*/
			virtual const std::string getDescription() const;
 
    virtual Category getCategory() { return DEFAULT_ON; }

                public: // Xml methods
                        virtual bool hasParameters() const;
                        virtual void writeXml(std::ostream& output) const;
                        virtual void readXml(const xml::Element& element);
		};

                inline bool ReplacementMutationOperator::hasParameters() const
                {
                  return false;
                }

                inline void ReplacementMutationOperator::writeXml(std::ostream& output) const
                {}

                inline void ReplacementMutationOperator::readXml(const xml::Element& element)
                {}
	}
}


#endif