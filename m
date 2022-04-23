Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1750C818
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiDWHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiDWHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:53:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11101A5DC9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650700253; x=1682236253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nn2kN0+rGvFVYY3kzW0Ubp2gmmm+EgV0+u/9xFNQOkQ=;
  b=dAb7UMHJ3Vrch1S41RrUywOX7589nThNhXeaqVBQZehcIsSddN4cpmUm
   51OgeT6CpwtItWv33EzoYBk1HCVcft0qcfH4bDbtwlhvpP5RfXB9qLY3P
   s9savSjAX8J0CfHThZor644RX7QuYCtt89RN2lwzzzuY79Mwh81JM4C3g
   xO+E1Q6Raoaog8ww/MhncpMNm9MjX7E+CrkY9t+nAxjV6MEz3SFLMxfxd
   bok4omN6R5z2Q95zZNKegON4UCEQsmrb3t/7zzYW2uL/aL6/CyzGNHaQn
   5P/2WRcO90KJT+i5QXDkiItRIMLoTVJujDnIhYpAuf4WJAmR5QCBiU28w
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245435655"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="245435655"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 00:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="563360220"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2022 00:50:51 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niAXa-000033-OQ;
        Sat, 23 Apr 2022 07:50:50 +0000
Date:   Sat, 23 Apr 2022 15:50:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 3/4] ARM: at91: pm: add quirks for pm
Message-ID: <202204231525.D4VKBvJr-lkp@intel.com>
References: <20220412153046.50014-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412153046.50014-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

I love your patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu-Beznea/ARM-at91-pm-add-quirks-for-ethernet/20220412-233013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-randconfig-r004-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231525.D4VKBvJr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/338e7bd157de47af9322de066375e240f453a0e3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Claudiu-Beznea/ARM-at91-pm-add-quirks-for-ethernet/20220412-233013
        git checkout 338e7bd157de47af9322de066375e240f453a0e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/arm/mach-at91/pm.c:374:4: error: call to undeclared function 'wakeup_sources_walk_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           for_each_wakeup_source(ws) {
                           ^
   include/linux/pm_wakeup.h:67:14: note: expanded from macro 'for_each_wakeup_source'
           for ((ws) = wakeup_sources_walk_start();        \
                       ^
   arch/arm/mach-at91/pm.c:374:4: note: did you mean 'wakeup_source_register'?
   include/linux/pm_wakeup.h:67:14: note: expanded from macro 'for_each_wakeup_source'
           for ((ws) = wakeup_sources_walk_start();        \
                       ^
   include/linux/pm_wakeup.h:144:37: note: 'wakeup_source_register' declared here
   static inline struct wakeup_source *wakeup_source_register(struct device *dev,
                                       ^
>> arch/arm/mach-at91/pm.c:374:4: warning: incompatible integer to pointer conversion assigning to 'struct wakeup_source *' from 'int' [-Wint-conversion]
                           for_each_wakeup_source(ws) {
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm_wakeup.h:67:12: note: expanded from macro 'for_each_wakeup_source'
           for ((ws) = wakeup_sources_walk_start();        \
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-at91/pm.c:374:4: error: call to undeclared function 'wakeup_sources_walk_next'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/pm_wakeup.h:69:14: note: expanded from macro 'for_each_wakeup_source'
                (ws) = wakeup_sources_walk_next((ws)))
                       ^
>> arch/arm/mach-at91/pm.c:374:4: warning: incompatible integer to pointer conversion assigning to 'struct wakeup_source *' from 'int' [-Wint-conversion]
                           for_each_wakeup_source(ws) {
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm_wakeup.h:69:12: note: expanded from macro 'for_each_wakeup_source'
                (ws) = wakeup_sources_walk_next((ws)))
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings and 2 errors generated.


vim +/wakeup_sources_walk_start +374 arch/arm/mach-at91/pm.c

   344	
   345	static int at91_pm_config_quirks(bool suspend)
   346	{
   347		struct wakeup_source *ws;
   348		int i, j, ret, tmp;
   349	
   350		/*
   351		 * Ethernet IPs who's device_node pointers are stored into
   352		 * soc_pm.quirks.eth[].np cannot handle WoL packets while in ULP0, ULP1
   353		 * or both due to a hardware bug. If they receive WoL packets while in
   354		 * ULP0 or ULP1 IPs could stop working or the whole system could stop
   355		 * working. We cannot handle this scenario in the ethernet driver itself
   356		 * as the driver is common to multiple vendors and also we only know
   357		 * here, in this file, if we suspend to ULP0 or ULP1 mode. Thus handle
   358		 * these scenarios here, as quirks.
   359		 */
   360		for (i = 0; i < AT91_PM_MAX_ETH; i++) {
   361			if (!at91_pm_eth_quirk_is_valid(i))
   362				continue;
   363	
   364			/*
   365			 * For modes in dns_modes mask the system blocks if quirk is not
   366			 * applied but if applied the interface doesn't act at WoL
   367			 * events. Thus take care to avoid suspending if this interface
   368			 * is the only configured wakeup source.
   369			 */
   370			if (suspend &&
   371			    soc_pm.quirks.eth[i].dns_modes & BIT(soc_pm.data.mode)) {
   372				int ws_count = 0;
   373	
 > 374				for_each_wakeup_source(ws) {
   375					ws_count++;
   376					if (ws_count > 1)
   377						break;
   378				}
   379	
   380				/*
   381				 * Checking ws == 1 is good for all SAMA5 based platforms
   382				 * even when both G_ETH and E_ETH are available as dsn_modes
   383				 * is populated only on G_ETH interface.
   384				 */
   385				if (ws_count == 1) {
   386					pr_err("AT91: PM: Ethernet cannot resume from WoL!");
   387					ret = -EPERM;
   388					goto clk_unconfigure;
   389				}
   390			}
   391	
   392			if (suspend) {
   393				clk_bulk_disable_unprepare(AT91_PM_ETH_MAX_CLK,
   394							   soc_pm.quirks.eth[i].clks);
   395			} else {
   396				ret = clk_bulk_prepare_enable(AT91_PM_ETH_MAX_CLK,
   397							      soc_pm.quirks.eth[i].clks);
   398				if (ret)
   399					goto clk_unconfigure;
   400			}
   401		}
   402	
   403		return 0;
   404	
   405	clk_unconfigure:
   406		/*
   407		 * In case of resume we reach this point if clk_prepare_enable() failed.
   408		 * we don't want to revert the previous clk_prepare_enable() for the
   409		 * other IP.
   410		 */
   411		if (suspend) {
   412			for (j = i - 1; j <= 0; j--) {
   413				if (!at91_pm_eth_quirk_is_valid(i))
   414					continue;
   415	
   416				tmp = clk_bulk_prepare_enable(AT91_PM_ETH_MAX_CLK,
   417							      soc_pm.quirks.eth[i].clks);
   418				if (tmp) {
   419					pr_err("AT91: PM: failed to enable %s clock\n",
   420						i == AT91_PM_ETH_PCLK ? "pclk" : "hclk");
   421				}
   422			}
   423		}
   424	
   425		return ret;
   426	}
   427	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
