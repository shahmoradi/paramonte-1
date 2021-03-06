%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%%%%   MIT License
%%%%
%%%%   ParaMonte: plain powerful parallel Monte Carlo library.
%%%%
%%%%   Copyright (C) 2012-present, The Computational Data Science Lab
%%%%
%%%%   This file is part of the ParaMonte library.
%%%%
%%%%   Permission is hereby granted, free of charge, to any person obtaining a
%%%%   copy of this software and associated documentation files (the "Software"),
%%%%   to deal in the Software without restriction, including without limitation
%%%%   the rights to use, copy, modify, merge, publish, distribute, sublicense,
%%%%   and/or sell copies of the Software, and to permit persons to whom the
%%%%   Software is furnished to do so, subject to the following conditions:
%%%%
%%%%   The above copyright notice and this permission notice shall be
%%%%   included in all copies or substantial portions of the Software.
%%%%
%%%%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
%%%%   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
%%%%   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
%%%%   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
%%%%   DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
%%%%   OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
%%%%   OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%%%%
%%%%   ACKNOWLEDGMENT
%%%%
%%%%   ParaMonte is an honor-ware and its currency is acknowledgment and citations.
%%%%   As per the ParaMonte library license agreement terms, if you use any parts of
%%%%   this library for any purposes, kindly acknowledge the use of ParaMonte in your
%%%%   work (education/research/industry/development/...) by citing the ParaMonte
%%%%   library as described on this page:
%%%%
%%%%       https://github.com/cdslaborg/paramonte/blob/master/ACKNOWLEDGMENT.md
%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   HeatmapPlot(plotType, dataFrame, resetExternal)
%
%   This is the HeatmapPlot class for generating instances of
%   heatmap plots, built upon MATLAB's builtin function `heatmap()`.
%
%       NOTE
%
%           This is a low-level ParaMonte class and is not meant
%           to be directly instantiated by the user.
%
%       Parameters
%       ----------
%
%           dataFrame
%
%               A MATLAB data Table from which the selected data will be plotted.
%               This is a low-level internal argument and is not meant
%               to be accessed or be provided by the user.
%
%       Attributes
%       ----------
%
%           xcolumns
%
%               Optional property that determines the columns of dataFrame to serve as
%               the x-values. It can have multiple forms:
%
%                   1.  a numeric or cell array of column indices in the input dataFrame.
%                   2.  a string or cell array of column names in dataFrame.Properties.VariableNames.
%                   3.  a cell array of a mix of the above two.
%                   4.  a numeric range.
%
%               Example usage:
%
%                   1.  xcolumns = [7,8,9]
%                   2.  xcolumns = ["SampleLogFunc","SampleVariable1"]
%                   3.  xcolumns = {"SampleLogFunc",9,"SampleVariable1"}
%                   4.  xcolumns = 7:9      # every column in the data frame starting from column #7
%                   5.  xcolumns = 7:2:20   # every other column in the data frame starting from column #7
%
%               WARNING 
%
%                   In all cases, xcolumns must have a length that is either 0, or 1, or equal
%                   to the length of xcolumns. If the length is 1, then xcolumns will be
%                   plotted against data corresponding to each element of xcolumns.
%                   If it is an empty object having length 0, then the default value will be used.
%
%               The default value is the names of all columns of the input dataFrame.
%
%           ycolumns
%
%               Optional property that determines the columns of dataFrame to serve as
%               the y-values. It can have multiple forms:
%
%                   1.  a numeric or cell array of column indices in the input dataFrame.
%                   2.  a string or cell array of column names in dataFrame.Properties.VariableNames.
%                   3.  a cell array of a mix of the above two.
%                   4.  a numeric range.
%
%               Example usage:
%
%                   1.  ycolumns = [7,8,9]
%                   2.  ycolumns = ["SampleLogFunc","SampleVariable1"]
%                   3.  ycolumns = {"SampleLogFunc",9,"SampleVariable1"}
%                   4.  ycolumns = 7:9      # every column in the data frame starting from column #7
%                   5.  ycolumns = 7:2:20   # every other column in the data frame starting from column #7
%
%               WARNING 
%
%                   In all cases, ycolumns must have a length that is either 0, or 1, or equal
%                   to the length of xcolumns. If the length is 1, then ycolumns will be
%                   plotted against data corresponding to each element of ycolumns.
%                   If it is an empty object having length 0, then the default value will be used.
%
%               The default value is the names of all columns of the input dataFrame.
%
%           colormap
%
%               A MATLAB struct() property with two components:
%
%                   1. enabled: logical value. If `true`, the colormap will be applied to the plot
%                   1. values: a string or any other value that the colormap function of MATLAB accepts as input.
%
%               Example usage:
%
%                   1.  colormap.values = "autumn"
%                   1.  colormap.values = "winter"
%
%               If colormap is not provided or is empty, the default will be "autumn".
%
%           colorbar.kws
%
%               A MATLAB struct() whose components' values are passed to MATLAB's colorbar function.
%               If your desired attribute is missing from the fieldnames of colorbar.kws, simply add
%               a new field named as the attribute and assign the desired value to it.
%
%               Example usage:
%
%                   colorbar.enabled = true % add colorbar
%                   colorbar.kws.location = "west"
%
%               If a desired property is missing among the struct fields, simply add the field
%               and its value to colorbar.kws.
%
%               WARNING: keep in mind that MATLAB keyword arguments are case-INsensitive.
%               WARNING: therefore make sure you do not add the keyword as multiple different fields.
%               WARNING: For example, colorbar.kws.color and colorbar.kws.Color are the same,
%               WARNING: and only one of the two will be processed.
%
%           heatmap_kws
%
%               A MATLAB struct() whose fields (with the exception of few, e.g., enabled, singleOptions, ...)
%               are directly passed to the `heatmap()` function of MATLAB.
%
%               Example usage:
%
%                   heatmap.enabled = true; % add heatmap()
%                   heatmap.ColorLimits = [-1 1];
%
%               If a desired property is missing among the struct fields, simply add the field
%               and its value to heatmap.kws.
%
%               WARNING: keep in mind that MATLAB keyword arguments are case-INsensitive.
%               WARNING: therefore make sure you do not add the keyword as multiple different fields.
%               WARNING: heatmap.ColorLimits and heatmap.ColorLimits are the same,
%               WARNING: and only one of the two will be processed.
%
%           title
%
%               A string that is passed to the title() function of MATLAB to add title to the plot.
%               If the property is empty, not title will be added.
%
%           precision
%
%               A numeric scalar value, representing the number of digits after the decimal point
%               for the values that appear in each cell of the heatmap.
%               The default value is not set to anything.
%
%       Superclass Attributes
%       ---------------------
%
%           See the documentation for the BasePlot class
%
%       Returns
%       -------
%
%           An object of HeatmapPlot class
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
classdef HeatmapPlot < BasePlot

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    properties (Access = public)
        title
        xcolumns
        ycolumns
        colormap
        precision
        colorbar
        heatmap
    end

    properties (Access = protected, Hidden)
        xcolnames
        xcolindex
        ycolnames
        ycolindex
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    methods (Hidden)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function resetInternal(self)

            resetInternal@BasePlot(self);
            self.xcolumns = {};
            self.ycolumns = {};

            self.precision = [];

            title = struct();
            title.txt = "";
            title.enabled = true;
            title.kws = struct();
            title.kws.fontSize = 11;
            title.kws.fontWeight = "bold";

            self.heatmap = struct();
            self.heatmap.enabled = true;
            self.heatmap.kws = struct();
            self.heatmap.ColorLimits = [];

            self.colorbar = struct();
            self.colorbar.enabled = true;
            self.colorbar.kws = struct();
            %self.colorbar.label = [];
            %self.colorbar.kws.fontSize = [];
            %self.colorbar.kws.singleOptions = {};

            self.colormap = struct();
            self.colormap.enabled = true;
            self.colormap.values = [];

            self.isdryrun = true;
            self.make();
            self.isdryrun = false;

        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    methods (Access = public)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function self = HeatmapPlot(plotType, dataFrame, resetExternal)
            if nargin<3; resetExternal = []; end
            self = self@BasePlot(plotType, dataFrame, resetExternal);
            if nargin<3; self.resetExternal = @self.resetInternal; end
            self.resetInternal();
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function adjustColorLimits(self,newLimits)
            %
            %   Adjust the limits of the colormap of the heatmap, according to
            %   the user-input value or the default symmetric value.
            %
            %   Parameters
            %   ----------
            %
            %       newLimits (optional)
            %
            %           A vector of two scalar numeric values representing
            %           the new limits of the colorbar.
            %
            %           If newLimits is not given as input, the new limits will be adjusted
            %           so that the colorbar limits extend symmetrically from the
            %           negative absolute maximum value of the current limits to the
            %           positive absolute maximum value of the current limits.
            %
            %   Returns
            %   -------
            %
            %       None
            %
            %   Example
            %   -------
            %
            %       adjustColorLimits([-1 1])
            %
            if ~(isfield(self.currentFig,"heatmap") && isfield(self.currentFig.heatmap,"ColorLimits"))
                if nargin==1
                    dum = max(abs(self.currentFig.heatmap.ColorLimits));
                    newLimits = [-dum dum];
                elseif nargin~=2
                    error   ( newline ...
                            + "The method ``colorLimits()`` takes only one optional argument newLimits. "  ...
                            + "If newLimits is provided as input argument, the ColorLimits property of " ...
                            + "the heatmap plot will be set to newLimits." ...
                            + newline ...
                            );
                end
                self.currentFig.heatmap.ColorLimits = newLimits;
            else
                error(newline + "There is no component ``currentFig.heatmap.ColorLimits`` for this object to adjust the limits." + newline);
            end
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function make(self,varargin)
            %
            %   Generate a plot from the selected columns of the object's dataFrame.
            %
            %   Parameters
            %   ----------
            %
            %       Any property,value pair of the object.
            %       If the property is a struct(), then its value must be given as a cell array,
            %       with consecutive elements representing the struct's property-name,property-value pairs.
            %       Note that all of these property-value pairs can be also directly set directly via the
            %       object's attributes, before calling the make() method.
            %
            %   Returns
            %   -------
            %
            %       None. However, this method causes side-effects by manipulating
            %       the existing attributes of the object.
            %
            %   Example
            %   -------
            %
            %       make("ycolumns",[8])
            %       make("ycolumns",7:10)
            %

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%% parse arguments
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            parseArgs(self,varargin{:})

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if self.isdryrun; return; end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%% set what to plot
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if getVecLen(self.xcolumns)
                [self.xcolnames, self.xcolindex] = getColNamesIndex(self.dfref.Properties.VariableNames,self.xcolumns);
            else
                self.dfref
                self.xcolumns = self.dfref.Properties.VariableNames;
            end
            if getVecLen(self.ycolumns)
                [self.ycolnames, self.ycolindex] = getColNamesIndex(self.dfref.Properties.VariableNames,self.ycolumns);
            else
                self.ycolumns = self.dfref.Properties.RowNames;
            end

            % generate figure and axes if needed

            if self.figure.enabled
                figure_kws_cell = convertStruct2Cell(self.figure.kws,{"enabled","singleOptions"});
                if isfield(self.figure.kws,"singleOptions"); figure_kws_cell = { figure_kws_cell{:} }; end
                self.currentFig.figure = figure( figure_kws_cell{:} );
            else
                set(0, "CurrentFigure", gcf);
                self.currentFig.figure = gcf;
                hold on;
            end

            %%%%%%%%%%%%%%%%%%%%%%%
            % get keyword arguments
            %%%%%%%%%%%%%%%%%%%%%%%

            heatmap_kws_cell = convertStruct2Cell(self.heatmap.kws,{"enabled","ColorLimits","singleOptions"});

            %%%%%%%%%%%%%
            % add heatmap
            %%%%%%%%%%%%%

            if self.heatmap.enabled
                if isempty(self.precision)
                    self.currentFig.heatmap = heatmap( self.xcolnames, self.ycolnames, self.dfref{self.xcolnames,self.ycolnames} );
                elseif isa(self.precision,"numeric")
                    self.currentFig.heatmap = heatmap( self.xcolnames, self.ycolnames, round(self.dfref{self.xcolnames,self.ycolnames},self.precision) );
                end
            end

            self.currentFig.axes = gca;

            if ~isempty(self.heatmap.ColorLimits)
                self.currentFig.heatmap.ColorLimits = self.heatmap.ColorLimits;
            end

            % add line colorbar

            if self.colormap.enabled
                if isempty(self.colormap.values)
                    self.colormap.values = redblue(); % do not put this anywhere before "if self.isdryrun; return; end". This command reuires an existing figure.
                end
                colormap(self.colormap.values);
            end

            if ~self.colorbar.enabled
                %if isempty(self.colorbar.kws.fontSize) || ~isa(self.colorbar.kws.fontSize,"numeric")
                %    self.colorbar.kws.fontSize = self.currentFig.axes.FontSize;
                %end
                %colorbar_kws_cell = convertStruct2Cell(self.colorbar.kws,{"enabled","label","singleOptions"});
                %colorbar(colorbar_kws_cell{:});
                %ylabel(self.currentFig.colorbar,self.colorbar.label,self.colorbar.kws.fontSize, "Interpreter", "none");
            %else
                colorbar("off");
            end

            % add title if needed

            if ~isempty(self.title.enabled)
                title(self.title.txt, convertStruct2Cell(self.title.kws) );
            end

            self.doBasePlotStuff();

        end % function plot

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    end % methods

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end % classdef