######################################################################
# Automatically generated by qmake (2.01a) Mon Oct 1 21:57:46 2012
######################################################################

TEMPLATE = app

TARGET = ugp3-gui 

QT += widgets

QMAKE_CXXFLAGS += -std=c++11

DEPENDPATH += 	. \ 
		../../ \
		../../Libs/Constraints \
		../../Libs/EvolutionaryCore \
		../../Libs/EvolutionaryCore/Operators \
		../../Libs/EvolutionaryCore/OperatorSelectors \
		../../Libs/Graph \
		../../Libs/Log \
		../../Libs/Shared \
		../../Libs/Shared/Exceptions \
		../../Libs/XmlParser/

INCLUDEPATH += 	. \
		../../ \
		../../Libs/Constraints \
		../../Libs/EvolutionaryCore \
		../../Libs/EvolutionaryCore/Operators \
		../../Libs/EvolutionaryCore/OperatorSelectors \
		../../Libs/Graph \
		../../Libs/Log \
		../../Libs/Shared \
		../../Libs/Shared/Exceptions \
		../../Libs/XmlParser

LIBS +=		-L../../Libs/XmlParser/ \
		-L../../Libs/Shared/ \
		-L../../Libs/Log/ \
		-L../../Libs/Graph/ \
		-L../../Libs/Constraints/ \
		-L../ugp3/ \
		-L../../Libs/EvolutionaryCore/ \
		-Wl,--start-group ../../Libs/EvolutionaryCore/libEvolutionaryCore.a ../ugp3/libFrontendCommon.a ../../Libs/Constraints/libConstraints.a ../../Libs/Graph/libGraph.a ../../Libs/XmlParser/libXmlParser.a ../../Libs/Shared/libShared.a ../../Libs/Log/libLog.a -Wl,--end-group
		
# Input

FORMS += 	ugp3.ui \
		ugp3-selectOperators.ui

HEADERS =	XmlHighlighter.h \
		CodeEditor.h \
		MicroGPSelectOperators.h \
		MicroGPMainWindow.h

SOURCES = 	XmlHighlighter.cpp \
		CodeEditor.cpp \
		MicroGPSelectOperators.cpp \
		MicroGPMainWindow.Constraints.cpp \
		MicroGPMainWindow.Population.cpp \
		MicroGPMainWindow.Evolution.cpp \
		MicroGPMainWindow.cpp \
		main.cpp