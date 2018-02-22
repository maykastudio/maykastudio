/* eslint no-console:0 */

import 'normalize.css';
import '../vendor/evil-icons/evil-icons';

import '../public/stylesheets/public';

import '../components/ProjectSearchForm';
import '../components/Project';

var componentRequireContext = require.context("components", true)
var ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)

_ = require('lodash');