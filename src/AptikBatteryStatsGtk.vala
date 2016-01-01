/*
 * AptikBatteryStatsGtk.vala
 *
 * Copyright 2015 Tony George <teejee2008@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 *
 */

using GLib;
using Gtk;
using Gee;
using Json;

using TeeJee.Logging;
using TeeJee.FileSystem;
using TeeJee.JSON;
using TeeJee.ProcessManagement;
using TeeJee.GtkHelper;
using TeeJee.Multimedia;
using TeeJee.System;
using TeeJee.Misc;

public class AptikBatteryStatsGtk : GLib.Object{

	public static int main (string[] args) {
		set_locale();

		Gtk.init(ref args);

		App = new Main(args, true);
		parse_arguments(args);

		var window = new BatteryStatsWindow ();
		window.destroy.connect(Gtk.main_quit);
		window.show_all();

		//start event loop
		Gtk.main();

		App.exit_app();

		return 0;
	}

	private static void set_locale(){
		Intl.setlocale(GLib.LocaleCategory.MESSAGES, AppShortName);
		Intl.textdomain(GETTEXT_PACKAGE);
		Intl.bind_textdomain_codeset(GETTEXT_PACKAGE, "utf-8");
		Intl.bindtextdomain(GETTEXT_PACKAGE, LOCALE_DIR);
	}

	public static bool parse_arguments(string[] args){
		//parse options
		for (int k = 1; k < args.length; k++) // Oth arg is app path
		{
			switch (args[k].down()){
				case "--debug":
					LOG_DEBUG = true;
					break;
				case "--help":
				case "--h":
				case "-h":
					log_msg(help_message());
					exit(0);
					return true;
				default:
					//unknown option - show help and exit
					log_error(_("Unknown option") + ": %s".printf(args[k]));
					log_msg(help_message());
					exit(1);
					return false;
			}
		}

		return true;
	}

	public static string help_message(){
		string msg = "\n" + AppName + " v" + AppVersion + " by Tony George (teejee2008@gmail.com)" + "\n";
		msg += "\n";
		msg += _("Syntax") + ": %s [options]\n".printf(AppShortName);
		msg += "\n";
		msg += _("Options") + ":\n";
		msg += "\n";
		msg += "  --debug      " + _("Print debug information") + "\n";
		msg += "  --h[elp]     " + _("Show all options") + "\n";
		msg += "\n";
		return msg;
	}
}
