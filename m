Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9868751849C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiECMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiECMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:55:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421081EEE1;
        Tue,  3 May 2022 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651582306; x=1683118306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WX6XFwDnmHmpDEaYBGqBQvPfcxBsdxudi3zrPKmjFJA=;
  b=V9bUy+jLpOu/0KEJoTsYzW5ZssELHirqG4IPT4Ys+CWgE3iqJ9he3QYU
   NB4kiGmMus94gDaXposepCDE6kMU8w4ZUyMAdZA/MjwV5az0vIs1umPrV
   OucaNw95Zo0xRgycFr5kOauBLP0td47UCqGP2tZhmfORpjUk+nEuxlT+r
   YUfmPJsxwmUtTCUzvvb0Owhr/GbzIEHWwsN2sGlTvVKzx6czGUYLpGw2J
   slbWYyz+sbcBT308h0PnbhAk5z+w3vXXg0bfSHtOnmHV7BYCheZhMTHVt
   yS+miw1YMvY9sNRwA2xztE2lihxirm0DrcEusQB6tlNl+38r6BSiP8VG/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267060710"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267060710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 05:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="547492780"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2022 05:51:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nls0E-000ATS-7R;
        Tue, 03 May 2022 12:51:42 +0000
Date:   Tue, 3 May 2022 20:51:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc:     kbuild-all@lists.01.org, khilman@baylibre.com,
        abailon@baylibre.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] thermal/core: Rename thermal_zone_device to
 thermal_zone
Message-ID: <202205032051.rSqUYbp8-lkp@intel.com>
References: <20220426221523.3056696-2-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426221523.3056696-2-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on sre-power-supply/for-next linus/master v5.18-rc5]
[cannot apply to rafael-pm/thermal next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-OF-rework/20220427-061937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220503/202205032051.rSqUYbp8-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/72a43d27b527d58caee73e164c22f25afe773669
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-OF-rework/20220427-061937
        git checkout 72a43d27b527d58caee73e164c22f25afe773669
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/power/supply/ab8500_btemp.c: In function 'ab8500_btemp_periodic_work':
>> drivers/power/supply/ab8500_btemp.c:288:39: error: passing argument 1 of 'thermal_zone_get_temp' from incompatible pointer type [-Werror=incompatible-pointer-types]
     288 |         ret = thermal_zone_get_temp(di->tz, &bat_temp);
         |                                     ~~^~~~
         |                                       |
         |                                       struct thermal_zone_device *
   In file included from drivers/power/supply/ab8500_btemp.c:29:
   include/linux/thermal.h:389:48: note: expected 'struct thermal_zone *' but argument is of type 'struct thermal_zone_device *'
     389 | int thermal_zone_get_temp(struct thermal_zone *tz, int *temp);
         |                           ~~~~~~~~~~~~~~~~~~~~~^~
   drivers/power/supply/ab8500_btemp.c: In function 'ab8500_btemp_probe':
>> drivers/power/supply/ab8500_btemp.c:727:16: error: assignment to 'struct thermal_zone_device *' from incompatible pointer type 'struct thermal_zone *' [-Werror=incompatible-pointer-types]
     727 |         di->tz = thermal_zone_get_zone_by_name("battery-thermal");
         |                ^
   cc1: some warnings being treated as errors


vim +/thermal_zone_get_temp +288 drivers/power/supply/ab8500_btemp.c

1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  264  
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  265  /**
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  266   * ab8500_btemp_periodic_work() - Measuring the temperature periodically
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  267   * @work:	pointer to the work_struct structure
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  268   *
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  269   * Work function for measuring the temperature periodically
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  270   */
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  271  static void ab8500_btemp_periodic_work(struct work_struct *work)
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  272  {
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  273  	int interval;
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  274  	int bat_temp;
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  275  	struct ab8500_btemp *di = container_of(work,
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  276  		struct ab8500_btemp, btemp_periodic_work.work);
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  277  	/* Assume 25 degrees celsius as start temperature */
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  278  	static int prev = 25;
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  279  	int ret;
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  280  
f6271b4fb1d5ce drivers/power/ab8500_btemp.c        Jonas Aaberg        2012-02-27  281  	if (!di->initialized) {
f6271b4fb1d5ce drivers/power/ab8500_btemp.c        Jonas Aaberg        2012-02-27  282  		/* Identify the battery */
f6271b4fb1d5ce drivers/power/ab8500_btemp.c        Jonas Aaberg        2012-02-27  283  		if (ab8500_btemp_id(di) < 0)
f6271b4fb1d5ce drivers/power/ab8500_btemp.c        Jonas Aaberg        2012-02-27  284  			dev_warn(di->dev, "failed to identify the battery\n");
f6271b4fb1d5ce drivers/power/ab8500_btemp.c        Jonas Aaberg        2012-02-27  285  	}
f6271b4fb1d5ce drivers/power/ab8500_btemp.c        Jonas Aaberg        2012-02-27  286  
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  287  	/* Failover if a reading is erroneous, use last meausurement */
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29 @288  	ret = thermal_zone_get_temp(di->tz, &bat_temp);
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  289  	if (ret) {
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  290  		dev_err(di->dev, "error reading temperature\n");
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  291  		bat_temp = prev;
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  292  	} else {
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  293  		/* Convert from millicentigrades to centigrades */
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  294  		bat_temp /= 1000;
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  295  		prev = bat_temp;
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  296  	}
2b0e7ac0841b39 drivers/power/supply/ab8500_btemp.c Linus Walleij       2022-01-29  297  
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  298  	/*
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  299  	 * Filter battery temperature.
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  300  	 * Allow direct updates on temperature only if two samples result in
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  301  	 * same temperature. Else only allow 1 degree change from previous
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  302  	 * reported value in the direction of the new measurement.
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  303  	 */
2c4c40ac0052ea drivers/power/ab8500_btemp.c        Rupesh Kumar        2012-08-22  304  	if ((bat_temp == di->prev_bat_temp) || !di->initialized) {
2c4c40ac0052ea drivers/power/ab8500_btemp.c        Rupesh Kumar        2012-08-22  305  		if ((di->bat_temp != di->prev_bat_temp) || !di->initialized) {
2c4c40ac0052ea drivers/power/ab8500_btemp.c        Rupesh Kumar        2012-08-22  306  			di->initialized = true;
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  307  			di->bat_temp = bat_temp;
297d716f6260cc drivers/power/ab8500_btemp.c        Krzysztof Kozlowski 2015-03-12  308  			power_supply_changed(di->btemp_psy);
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  309  		}
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  310  	} else if (bat_temp < di->prev_bat_temp) {
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  311  		di->bat_temp--;
297d716f6260cc drivers/power/ab8500_btemp.c        Krzysztof Kozlowski 2015-03-12  312  		power_supply_changed(di->btemp_psy);
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  313  	} else if (bat_temp > di->prev_bat_temp) {
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  314  		di->bat_temp++;
297d716f6260cc drivers/power/ab8500_btemp.c        Krzysztof Kozlowski 2015-03-12  315  		power_supply_changed(di->btemp_psy);
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  316  	}
908fe8d6a575e2 drivers/power/ab8500_btemp.c        Hakan Berg          2012-07-17  317  	di->prev_bat_temp = bat_temp;
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  318  
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  319  	if (di->events.ac_conn || di->events.usb_conn)
b0284de05e07d5 drivers/power/ab8500_btemp.c        Lee Jones           2012-11-30  320  		interval = di->bm->temp_interval_chg;
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  321  	else
b0284de05e07d5 drivers/power/ab8500_btemp.c        Lee Jones           2012-11-30  322  		interval = di->bm->temp_interval_nochg;
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  323  
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  324  	/* Schedule a new measurement */
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  325  	queue_delayed_work(di->btemp_wq,
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  326  		&di->btemp_periodic_work,
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  327  		round_jiffies(interval * HZ));
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  328  }
1f855824757efa drivers/power/ab8500_btemp.c        Arun Murthy         2012-02-29  329  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
