Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CF589EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiHDPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiHDPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:42:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5F252BF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659627759; x=1691163759;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/sO3bK65pKVZ1iDdvnWnZimmDSlRaWOseNM6XOn2moM=;
  b=HsmRd3cb+9wqjv+csa6jV7u/5IQCxcTsgO9UaeKiThj5Lw08kthkXeJ4
   OV1NPFcJ16DWyByhbzMSJWHK1xyHHbnfPMu0tCkr/1NSIUYYd7Sxw3V8V
   p9qodtbq//f+DDN8GBO0YYmTX/+Uf43nGvPR6oCUgi83HPI00LletoM0t
   ZTsFPYANISq8WOkP+f49kOZGMFObcASvblITUJbI8eqSIW/RuBHjwnGeY
   C+cMc7ajbty9XRU7TtLJ23jjY1NavlXd/SKPYFrbqQNSwLN9lZoPmPtiv
   AuTHU5UgSGbs0AKYdyeNdawOwEc5R0fSEE1+EX6KC2QFkxT3scbT1OCea
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287529391"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287529391"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 08:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579119349"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 08:42:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJczR-000IaF-1N;
        Thu, 04 Aug 2022 15:42:25 +0000
Date:   Thu, 4 Aug 2022 23:42:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: drivers/clocksource/timer-ti-dm.c:1039:34: warning: unused variable
 'omap_timer_match'
Message-ID: <202208042325.gDk2PAQf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
commit: ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567 clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3
date:   8 days ago
config: hexagon-randconfig-r011-20220804 (https://download.01.org/0day-ci/archive/20220804/202208042325.gDk2PAQf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-ti-dm.c:1039:34: warning: unused variable 'omap_timer_match' [-Wunused-const-variable]
   static const struct of_device_id omap_timer_match[] = {
                                    ^
   1 warning generated.


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
