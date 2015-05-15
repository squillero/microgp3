/***********************************************************************\ 
|                                                                       |
| BriefFormatter.h                                                      |
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

/**
 * @file BriefFormatter.h
 * Definition of the BriefFormatter class.
 * @see BriefFormatter.cc
 */

#ifndef HEADER_UGP3_LOG_BRIEFFORMATTER
/** Defines that this file has been included */
#define HEADER_UGP3_LOG_BRIEFFORMATTER

#include <sstream>
#include <iomanip>
#include <string>

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "Formatter.h"

/**
 * ugp3 namespace
 */
namespace ugp3
{

/**
 * ugp3::log namespace
 */
namespace log
{

class Record;

 /**
  * @class BriefFormatter
  * Allows to write a string representation of a Record object in a brief format.
  * @see Record
  * @see Formatter
  * @see ExtendedFormatter
  * @see PlainFormatter
  * @see XmlFormatter
  */
class BriefFormatter : public Formatter
{
public:
    /** Type of the xml schema used. Usefull to know what type of the Formatter object is instantiated. */
    static const std::string XML_SCHEMA_TYPE;

    // Methods of the Formatter class
    const std::string format(const Record& record) const;
    virtual const std::string& getType() const;
};

inline const std::string& BriefFormatter::getType() const
{
    return XML_SCHEMA_TYPE;
}

}

}

#endif