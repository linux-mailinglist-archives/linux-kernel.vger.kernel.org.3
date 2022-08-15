Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144559271C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiHOAl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiHOAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:41:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8685F75
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660524084; x=1692060084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nG0i8Kdv6v0yYaspB/vNr/mJCBvXZ6bkT/01hEiUMuk=;
  b=jEnYKMa8mF9IuYPx+BqF/rh9gK8zAzlvLlcLey0zfMxQh6rXFXWgP5ZH
   5468wtzxhWiQlkrCrXUDXSxZjif+9+LuGlEfrzVCVP5lkkkN/9d1M+IbN
   Hq43oII+JsvrlvEb+Uxtu7Kmw+SgdDKzG3R0pkx624EBUQkboWC+ldyxj
   YcucRVhEUYusPO9APobrRLOg3i/St0mT7RAcDsrzrMn5vKbC00brrH4ut
   FXr/PZ4oGBzWChKPGsjATTe5hTsi5bq8QjrRmThecuaQhiVVMMELtrEc/
   Oyy21BTN9kF2AWlIxBmsPJNe6k/FSuQd6fm4Py7zXjdnPrg5PwQmTWejb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="353605683"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="353605683"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 17:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="606484043"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2022 17:41:22 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNOAT-0000fG-2T;
        Mon, 15 Aug 2022 00:41:21 +0000
Date:   Mon, 15 Aug 2022 08:41:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: drivers/clocksource/timer-ti-dm.c:1039:34: warning:
 'omap_timer_match' defined but not used
Message-ID: <202208150851.T0MUBaQR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567 clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3
date:   3 weeks ago
config: x86_64-buildonly-randconfig-r004-20220815 (https://download.01.org/0day-ci/archive/20220815/202208150851.T0MUBaQR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/clocksource/ drivers/soc/mediatek/ drivers/usb/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-ti-dm.c:1039:34: warning: 'omap_timer_match' defined but not used [-Wunused-const-variable=]
    1039 | static const struct of_device_id omap_timer_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/omap_timer_match +1039 drivers/clocksource/timer-ti-dm.c

d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1038  
9725f4451a9ccd arch/arm/plat-omap/dmtimer.c Jon Hunter     2012-05-14 @1039  static const struct of_device_id omap_timer_match[] = {
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1040  	{
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1041  		.compatible = "ti,omap2420-timer",
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1042  	},
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1043  	{
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1044  		.compatible = "ti,omap3430-timer",
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1045  		.data = &omap3plus_pdata,
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1046  	},
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1047  	{
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1048  		.compatible = "ti,omap4430-timer",
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1049  		.data = &omap3plus_pdata,
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1050  	},
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1051  	{
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1052  		.compatible = "ti,omap5430-timer",
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1053  		.data = &omap3plus_pdata,
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1054  	},
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1055  	{
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1056  		.compatible = "ti,am335x-timer",
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1057  		.data = &omap3plus_pdata,
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1058  	},
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1059  	{
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1060  		.compatible = "ti,am335x-timer-1ms",
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1061  		.data = &omap3plus_pdata,
d1c6ccfe3dbdd2 arch/arm/plat-omap/dmtimer.c Jon Hunter     2013-03-19  1062  	},
8c0cabd7970c0d arch/arm/plat-omap/dmtimer.c Neil Armstrong 2015-10-22  1063  	{
8c0cabd7970c0d arch/arm/plat-omap/dmtimer.c Neil Armstrong 2015-10-22  1064  		.compatible = "ti,dm816-timer",
8c0cabd7970c0d arch/arm/plat-omap/dmtimer.c Neil Armstrong 2015-10-22  1065  		.data = &omap3plus_pdata,
8c0cabd7970c0d arch/arm/plat-omap/dmtimer.c Neil Armstrong 2015-10-22  1066  	},
9725f4451a9ccd arch/arm/plat-omap/dmtimer.c Jon Hunter     2012-05-14  1067  	{},
9725f4451a9ccd arch/arm/plat-omap/dmtimer.c Jon Hunter     2012-05-14  1068  };
9725f4451a9ccd arch/arm/plat-omap/dmtimer.c Jon Hunter     2012-05-14  1069  MODULE_DEVICE_TABLE(of, omap_timer_match);
9725f4451a9ccd arch/arm/plat-omap/dmtimer.c Jon Hunter     2012-05-14  1070  

:::::: The code at line 1039 was first introduced by commit
:::::: 9725f4451a9ccd159b1d13f63e05896cd9bce07d ARM: OMAP: Add DT support for timer driver

:::::: TO: Jon Hunter <jon-hunter@ti.com>
:::::: CC: Jon Hunter <jon-hunter@ti.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
