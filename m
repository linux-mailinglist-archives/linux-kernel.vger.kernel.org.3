Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66705483B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiADFI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:08:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:19023 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbiADFIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641272905; x=1672808905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kd7kPaEys7pVyFrc4dzzcm+OIGBKf71UGWsh1Rxd8TY=;
  b=F4LqnDw6B2TkDwoeHX9ATMfNnhZ6YPi4q6YMzzphIgHGUixBlpm2foUt
   pX60vb0OrEx42yFdQeqWkoFfye4kOjTTMXoFBt6fEuS+1x6zd88zUvc0B
   Gt2FcInJY9bvWU9ifQWCeqw72rTs0HV7CwqIAsjYZwNIYgPgld+5pKeDZ
   28MtAgq6w7f9hgcJnvDBGiXIh+N3NdZqNfNmrz7FAGRW14twb1HhxVlyc
   sHwFVrneltvz6SHWeEe0sDh9cXZ5kDsYgV57wKhtvG9gMGLyMa5fbtERi
   +0OW5dWCGFwTV3VipisiecSXiArUvHPi187JqqiFzWcw6qsqDCaR6LuS4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242112778"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="242112778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 21:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="573903933"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2022 21:08:23 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4c3b-000EiN-A5; Tue, 04 Jan 2022 05:08:23 +0000
Date:   Tue, 4 Jan 2022 13:07:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [sre-power-supply:for-next 11/28]
 drivers/power/supply/ab8500_btemp.c:527:35: warning: variable 'i' is
 uninitialized when used here
Message-ID: <202201041301.z9yQzYjF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
head:   25fd330370ac40653671f323acc7fb6db27ef6fe
commit: e5dff305ab5c539320f1e30db44604e9977c3504 [11/28] power: supply: ab8500: Use only one battery type
config: arm-randconfig-r001-20220103 (https://download.01.org/0day-ci/archive/20220104/202201041301.z9yQzYjF-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b50fea47b6c454581fce89af359f3afe5154986c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?id=e5dff305ab5c539320f1e30db44604e9977c3504
        git remote add sre-power-supply https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
        git fetch --no-tags sre-power-supply for-next
        git checkout e5dff305ab5c539320f1e30db44604e9977c3504
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/power/supply/ab8500_btemp.c:527:35: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
                            di->bm->bat_type->resis_high, i);
                                                          ^
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                            ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   drivers/power/supply/ab8500_btemp.c:509:6: note: initialize the variable 'i' to silence this warning
           u8 i;
               ^
                = '\0'
   1 warning generated.


vim +/i +527 drivers/power/supply/ab8500_btemp.c

   497	
   498	/**
   499	 * ab8500_btemp_id() - Identify the connected battery
   500	 * @di:		pointer to the ab8500_btemp structure
   501	 *
   502	 * This function will try to identify the battery by reading the ID
   503	 * resistor. Some brands use a combined ID resistor with a NTC resistor to
   504	 * both be able to identify and to read the temperature of it.
   505	 */
   506	static int ab8500_btemp_id(struct ab8500_btemp *di)
   507	{
   508		int res;
   509		u8 i;
   510	
   511		di->curr_source = BTEMP_BATCTRL_CURR_SRC_7UA;
   512	
   513		res =  ab8500_btemp_get_batctrl_res(di);
   514		if (res < 0) {
   515			dev_err(di->dev, "%s get batctrl res failed\n", __func__);
   516			return -ENXIO;
   517		}
   518	
   519		if ((res <= di->bm->bat_type->resis_high) &&
   520		    (res >= di->bm->bat_type->resis_low)) {
   521			dev_info(di->dev, "Battery detected on %s"
   522				 " low %d < res %d < high: %d"
   523				 " index: %d\n",
   524				 di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL ?
   525				 "BATCTRL" : "BATTEMP",
   526				 di->bm->bat_type->resis_low, res,
 > 527				 di->bm->bat_type->resis_high, i);
   528		} else {
   529			dev_warn(di->dev, "Battery identified as unknown"
   530				 ", resistance %d Ohm\n", res);
   531			return -ENXIO;
   532		}
   533	
   534		/*
   535		 * We only have to change current source if the
   536		 * detected type is Type 1 (LIPO) resis_high = 53407, resis_low = 12500
   537		 * if someone hacks this in.
   538		 *
   539		 * FIXME: make sure this is done automatically for the batteries
   540		 * that need it.
   541		 */
   542		if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
   543		    (di->bm->bat_type->name == POWER_SUPPLY_TECHNOLOGY_LIPO) &&
   544		    (res <= 53407) && (res >= 12500)) {
   545			dev_dbg(di->dev, "Set BATCTRL current source to 20uA\n");
   546			di->curr_source = BTEMP_BATCTRL_CURR_SRC_20UA;
   547		}
   548	
   549		return 0;
   550	}
   551	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
