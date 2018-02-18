/* eslint no-console:0 */

import 'normalize.css';

import '../public/stylesheets/public';
import '../components/ProjectSearchForm';

var componentRequireContext = require.context("components", true)
var ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)