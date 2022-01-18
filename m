Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4135E492473
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbiARLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:15:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:28111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239081AbiARLOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642504476; x=1674040476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xQi163KJjlYgR18//Jlrzf8p7hvZ8Mx+IeaBZ6jNBM4=;
  b=cl0viiWgHHqm0qa9WKUAW09/a5gMpqzfWTJZNiBWJcuny1Zf8UfgGcOR
   8R/DaqeUyDoLuwk6BPeWApgn7Xnv8cQwyVljR45akVnS2cdDACJNNG/h0
   kthzGWIXzsZ4RFvlo1r8cFEKjsCMAguwwIUupIDBY6/miF9jXjgYBXmkz
   dUj8ubm1Xahvi2GH9Oa8Aek3NEQwF+Fvj5CQRsdTP5wgZ01hcGntrpKL9
   YoTEzXSGyIzpniVjeLhZvZIcatVExxePgUAxpF3iBcWv+KE/pLqhGAHl0
   /eVyalsKfVFAIWsS4s3I/PlhJ5rNczs65TJU2AApNasz7EmQXaWbuYq5c
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="242352802"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="242352802"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="474733049"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2022 03:14:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9mRa-000CVC-19; Tue, 18 Jan 2022 11:14:30 +0000
Date:   Tue, 18 Jan 2022 19:14:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drivers/power/supply/ab8500_fg.c:2243:75: warning: variable 'b' set
 but not used
Message-ID: <202201181843.hXuoA1vS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3a8b6a1e70c37702054ae3c7c07ed828435d8ee
commit: 2a5f41830aadc2d7f4145eae49381133da5df2a3 power: supply: ab8500: Standardize voltages
date:   8 weeks ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220118/202201181843.hXuoA1vS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a5f41830aadc2d7f4145eae49381133da5df2a3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2a5f41830aadc2d7f4145eae49381133da5df2a3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/power/supply/ drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/supply/ab8500_fg.c: In function 'ab8500_fg_get_ext_psy_data':
>> drivers/power/supply/ab8500_fg.c:2243:75: warning: variable 'b' set but not used [-Wunused-but-set-variable]
    2243 |                                         const struct ab8500_battery_type *b;
         |                                                                           ^


vim +/b +2243 drivers/power/supply/ab8500_fg.c

13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2167  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2168  static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2169  {
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2170  	struct power_supply *psy;
ea32cea140f644 drivers/power/ab8500_fg.c        Andy Shevchenko     2016-03-17  2171  	struct power_supply *ext = dev_get_drvdata(dev);
ea32cea140f644 drivers/power/ab8500_fg.c        Andy Shevchenko     2016-03-17  2172  	const char **supplicants = (const char **)ext->supplied_to;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2173  	struct ab8500_fg *di;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2174  	union power_supply_propval ret;
ea32cea140f644 drivers/power/ab8500_fg.c        Andy Shevchenko     2016-03-17  2175  	int j;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2176  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2177  	psy = (struct power_supply *)data;
297d716f6260cc drivers/power/ab8500_fg.c        Krzysztof Kozlowski 2015-03-12  2178  	di = power_supply_get_drvdata(psy);
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2179  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2180  	/*
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2181  	 * For all psy where the name of your driver
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2182  	 * appears in any supplied_to
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2183  	 */
ea32cea140f644 drivers/power/ab8500_fg.c        Andy Shevchenko     2016-03-17  2184  	j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
ea32cea140f644 drivers/power/ab8500_fg.c        Andy Shevchenko     2016-03-17  2185  	if (j < 0)
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2186  		return 0;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2187  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2188  	/* Go through all properties for the psy */
297d716f6260cc drivers/power/ab8500_fg.c        Krzysztof Kozlowski 2015-03-12  2189  	for (j = 0; j < ext->desc->num_properties; j++) {
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2190  		enum power_supply_property prop;
297d716f6260cc drivers/power/ab8500_fg.c        Krzysztof Kozlowski 2015-03-12  2191  		prop = ext->desc->properties[j];
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2192  
15077fc1f78488 drivers/power/ab8500_fg.c        Krzysztof Kozlowski 2015-03-12  2193  		if (power_supply_get_property(ext, prop, &ret))
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2194  			continue;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2195  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2196  		switch (prop) {
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2197  		case POWER_SUPPLY_PROP_STATUS:
297d716f6260cc drivers/power/ab8500_fg.c        Krzysztof Kozlowski 2015-03-12  2198  			switch (ext->desc->type) {
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2199  			case POWER_SUPPLY_TYPE_BATTERY:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2200  				switch (ret.intval) {
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2201  				case POWER_SUPPLY_STATUS_UNKNOWN:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2202  				case POWER_SUPPLY_STATUS_DISCHARGING:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2203  				case POWER_SUPPLY_STATUS_NOT_CHARGING:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2204  					if (!di->flags.charging)
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2205  						break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2206  					di->flags.charging = false;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2207  					di->flags.fully_charged = false;
ea4024017831d6 drivers/power/ab8500_fg.c        Marcus Cooper       2013-01-11  2208  					if (di->bm->capacity_scaling)
ea4024017831d6 drivers/power/ab8500_fg.c        Marcus Cooper       2013-01-11  2209  						ab8500_fg_update_cap_scalers(di);
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2210  					queue_work(di->fg_wq, &di->fg_work);
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2211  					break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2212  				case POWER_SUPPLY_STATUS_FULL:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2213  					if (di->flags.fully_charged)
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2214  						break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2215  					di->flags.fully_charged = true;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2216  					di->flags.force_full = true;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2217  					/* Save current capacity as maximum */
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2218  					di->bat_cap.max_mah = di->bat_cap.mah;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2219  					queue_work(di->fg_wq, &di->fg_work);
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2220  					break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2221  				case POWER_SUPPLY_STATUS_CHARGING:
ea4024017831d6 drivers/power/ab8500_fg.c        Marcus Cooper       2013-01-11  2222  					if (di->flags.charging &&
ea4024017831d6 drivers/power/ab8500_fg.c        Marcus Cooper       2013-01-11  2223  						!di->flags.fully_charged)
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2224  						break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2225  					di->flags.charging = true;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2226  					di->flags.fully_charged = false;
ea4024017831d6 drivers/power/ab8500_fg.c        Marcus Cooper       2013-01-11  2227  					if (di->bm->capacity_scaling)
ea4024017831d6 drivers/power/ab8500_fg.c        Marcus Cooper       2013-01-11  2228  						ab8500_fg_update_cap_scalers(di);
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2229  					queue_work(di->fg_wq, &di->fg_work);
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2230  					break;
c6ef5234efc076 drivers/power/supply/ab8500_fg.c Ma Feng             2019-12-19  2231  				}
b51883d47d37c3 drivers/power/supply/ab8500_fg.c Gustavo A. R. Silva 2021-07-13  2232  				break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2233  			default:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2234  				break;
c6ef5234efc076 drivers/power/supply/ab8500_fg.c Ma Feng             2019-12-19  2235  			}
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2236  			break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2237  		case POWER_SUPPLY_PROP_TECHNOLOGY:
297d716f6260cc drivers/power/ab8500_fg.c        Krzysztof Kozlowski 2015-03-12  2238  			switch (ext->desc->type) {
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2239  			case POWER_SUPPLY_TYPE_BATTERY:
1a793a10899487 drivers/power/ab8500_fg.c        Rajkumar Kasirajan  2012-05-30  2240  				if (!di->flags.batt_id_received &&
2d3559a50ad6d2 drivers/power/supply/ab8500_fg.c Linus Walleij       2021-11-20  2241  				    (di->bm->bi.technology !=
e5dff305ab5c53 drivers/power/supply/ab8500_fg.c Linus Walleij       2021-11-20  2242  				     POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
484a9cc3dcb867 drivers/power/supply/ab8500_fg.c Linus Walleij       2021-07-13 @2243  					const struct ab8500_battery_type *b;
c34a61b4e7a996 drivers/power/ab8500_fg.c        Anton Vorontsov     2012-03-14  2244  
e5dff305ab5c53 drivers/power/supply/ab8500_fg.c Linus Walleij       2021-11-20  2245  					b = di->bm->bat_type;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2246  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2247  					di->flags.batt_id_received = true;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2248  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2249  					di->bat_cap.max_mah_design =
22be8d77c80dca drivers/power/supply/ab8500_fg.c Linus Walleij       2021-11-20  2250  						di->bm->bi.charge_full_design_uah;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2251  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2252  					di->bat_cap.max_mah =
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2253  						di->bat_cap.max_mah_design;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2254  
2a5f41830aadc2 drivers/power/supply/ab8500_fg.c Linus Walleij       2021-11-20  2255  					di->vbat_nom_uv =
2a5f41830aadc2 drivers/power/supply/ab8500_fg.c Linus Walleij       2021-11-20  2256  						di->bm->bi.voltage_max_design_uv;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2257  				}
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2258  
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2259  				if (ret.intval)
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2260  					di->flags.batt_unknown = false;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2261  				else
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2262  					di->flags.batt_unknown = true;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2263  				break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2264  			default:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2265  				break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2266  			}
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2267  			break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2268  		case POWER_SUPPLY_PROP_TEMP:
297d716f6260cc drivers/power/ab8500_fg.c        Krzysztof Kozlowski 2015-03-12  2269  			switch (ext->desc->type) {
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2270  			case POWER_SUPPLY_TYPE_BATTERY:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2271  				if (di->flags.batt_id_received)
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2272  					di->bat_temp = ret.intval;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2273  				break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2274  			default:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2275  				break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2276  			}
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2277  			break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2278  		default:
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2279  			break;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2280  		}
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2281  	}
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2282  	return 0;
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2283  }
13151631b5bd06 drivers/power/ab8500_fg.c        Arun Murthy         2012-02-29  2284  

:::::: The code at line 2243 was first introduced by commit
:::::: 484a9cc3dcb867813fca62f6443c1e77a1ae3c27 power: supply: ab8500: Drop abx500 concept

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Sebastian Reichel <sebastian.reichel@collabora.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
