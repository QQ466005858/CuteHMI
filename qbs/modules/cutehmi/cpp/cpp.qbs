/**
  This module provides common C++ settings to be used accross Product items.
  */
Module {
//<qbs-cutehmi.cpp-1.workaround target="Qbs" cuase="missing">
// Qbs does not allow Export within Module items. Because of that modules can not export C++ include paths. Workaround is to provide
// a property containing include paths to export (which can be accessed by Module items) and use this property in a product export.
	/**
	  List of include paths to be exported by a product.
	  */
	property stringList exportedIncludePaths: []
//</qbs-cutehmi.cpp-1.workaround>

	Depends { name: "cpp" }

	Properties {
		condition: !qbs.buildVariant.contains("debug")
		cpp.defines: outer.concat(["CUTEHMI_NDEBUG", "QT_NO_DEBUG_OUTPUT"])
	}

	Properties {
		condition: qbs.targetOS.contains("linux")
		cpp.linkerFlags: ["--no-undefined"]
	}

	cpp.defines: ["QT_DEPRECATED_WARNINGS"]

	cpp.cxxLanguageVersion: "c++14"
}

//(c)C: Copyright © 2019-2020, Michał Policht <michal@policht.pl>. All rights reserved.
//(c)C: This file is a part of CuteHMI.
//(c)C: CuteHMI is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//(c)C: CuteHMI is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.
//(c)C: You should have received a copy of the GNU Lesser General Public License along with CuteHMI.  If not, see <https://www.gnu.org/licenses/>.
