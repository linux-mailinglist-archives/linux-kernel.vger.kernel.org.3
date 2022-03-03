Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17414CB54E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiCCDNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiCCDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:13:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4BDDF0F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646277164; x=1677813164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uQgCDRFjI4A/tO1rCthwIitwuInhh1EfWqjhiqMZd6Y=;
  b=apHlUZcB/swUDlylbGqkZXKPrQ/XM83pdsUT48bYv8S1TnPYDOThZzzG
   PyW6QjmzNxCihFlInw/j1Rw74C6FZCkucgH1podqhYoC8ZyjHjCxnlkai
   yOTzu6V3D+SlWX2XIDVcApmziDm4ew2btlWJG0XrwumDjz0NuWqHt/jDE
   Wltq6qs9QULwWlnPg2VBlNyUFllwIiDu0MCI7RyQzdMCvQKcy2hVFnPQC
   7eNlvIaM0adJfhRwP7aPf6Vk7hx2dE2f9lEABxdK4P4VtI/QQ6vnxowA9
   mpBPMAg6KqqlkHHXiUcnJnbp6IXbr380TDstVSgP4ShgAvUXgpmNQ2wCH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251141282"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="251141282"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 19:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="686343493"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2022 19:12:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPbtS-00004Z-78; Thu, 03 Mar 2022 03:12:42 +0000
Date:   Thu, 3 Mar 2022 11:12:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     ckkim <changkon12@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.17.y 9/41]
 drivers/power/reset/odroid-reboot.c:63:6: warning: no previous prototype for
 'odroid_card_reset'
Message-ID: <202203031004.mL5plmaA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.17.y
head:   e882d3aa45fcf49791433e9606016225df72a12e
commit: ac6c922471a98860d696598875a4293c26c21a26 [9/41] ODROID-COMMON: power:reset: Add odroid support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220303/202203031004.mL5plmaA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/ac6c922471a98860d696598875a4293c26c21a26
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.17.y
        git checkout ac6c922471a98860d696598875a4293c26c21a26
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/power/reset/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/power/reset/odroid-reboot.c:63:6: warning: no previous prototype for 'odroid_card_reset' [-Wmissing-prototypes]
      63 | void odroid_card_reset(void)
         |      ^~~~~~~~~~~~~~~~~
   drivers/power/reset/odroid-reboot.c: In function 'odroid_restart_probe':
   drivers/power/reset/odroid-reboot.c:141:17: error: 'arm_pm_restart' undeclared (first use in this function); did you mean 'alarm_restart'?
     141 |                 arm_pm_restart = do_odroid_restart;
         |                 ^~~~~~~~~~~~~~
         |                 alarm_restart
   drivers/power/reset/odroid-reboot.c:141:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/odroid_card_reset +63 drivers/power/reset/odroid-reboot.c

    62	
  > 63	void odroid_card_reset(void)
    64	{
    65		int ret = 0;
    66	
    67		if ((sd_vqsw == 0) && (sd_vmmc == 0))
    68			return;
    69	
    70		if (sd_vqen == 0) {
    71			gpio_free(sd_vqsw);
    72			gpio_free(sd_vmmc);
    73			ret = gpio_request_one(sd_vqsw,
    74					GPIOF_OUT_INIT_LOW, "REBOOT");
    75			CHECK_RET(ret);
    76			mdelay(10);
    77			ret = gpio_direction_output(sd_vqsw, 1);
    78			CHECK_RET(ret);
    79			ret = gpio_request_one(sd_vmmc,
    80					GPIOF_OUT_INIT_LOW, "REBOOT");
    81			CHECK_RET(ret);
    82			mdelay(10);
    83			ret = gpio_direction_output(sd_vqsw, 0);
    84			CHECK_RET(ret);
    85			ret = gpio_direction_output(sd_vmmc, 1);
    86			CHECK_RET(ret);
    87			mdelay(5);
    88			gpio_free(sd_vqsw);
    89			gpio_free(sd_vmmc);
    90		} else {
    91			gpio_free(sd_vqsw);
    92			gpio_free(sd_vqen);
    93			gpio_free(sd_vmmc);
    94	
    95			ret = gpio_request_one(sd_vqsw,
    96					GPIOF_OUT_INIT_LOW, "REBOOT");
    97			CHECK_RET(ret);
    98			ret = gpio_request_one(sd_vqen,
    99					GPIOF_OUT_INIT_LOW, "REBOOT");
   100			CHECK_RET(ret);
   101			ret = gpio_request_one(sd_vmmc,
   102					GPIOF_OUT_INIT_LOW, "REBOOT");
   103			CHECK_RET(ret);
   104			mdelay(100);
   105			ret = gpio_direction_input(sd_vqen);
   106			CHECK_RET(ret);
   107			ret = gpio_direction_input(sd_vmmc);
   108			CHECK_RET(ret);
   109			ret = gpio_direction_input(sd_vqsw);
   110			CHECK_RET(ret);
   111			mdelay(5);
   112			gpio_free(sd_vqen);
   113			gpio_free(sd_vmmc);
   114			gpio_free(sd_vqsw);
   115		}
   116	}
   117	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
