Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590134B7A35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbiBOWIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:08:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:08:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC49237FA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644962909; x=1676498909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q/XiABt3SY2LqKOMGRdBwg4v9msBDPSgWH6xCIWMP1k=;
  b=MiakwBUZW4+K8Kj06UsIN9MGzpT5LsL+CcIUeUrk+tW0Z1L3BCGX9H23
   CjVkK02dpNVqRxZST8aq8TgxoZTvvJOi4lJqtubsP8q9NH+V6DffSV4HI
   VExQccach6yJhI88GBmIPqfEOFrNUc1Nx5SnJ8+tVp1Udkc5+5/UTIXIb
   pVy/FtAa6jLE+1wsiH9izONHS1TFvnIbG9SPEcX1ClSiLIew3v89/IZZv
   excVhuW4GzyxYinpJ9XxzcyvBx8/UAKmAwt+8B688rnqCqimMEnE2obQY
   N+QaW9HHjwkodRpu/j4n2davku2x3f87VPu6DECNd3e23MxEpJa+Mn2DD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="248062156"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="248062156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 14:08:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571017559"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2022 14:08:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK5zU-000A5Z-FP; Tue, 15 Feb 2022 22:08:08 +0000
Date:   Wed, 16 Feb 2022 06:07:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     ckkim <changkon12@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.17.y 9/41]
 drivers/power/reset/odroid-reboot.c:141:17: error: 'arm_pm_restart'
 undeclared; did you mean 'alarm_restart'?
Message-ID: <202202160601.6EUNHQqV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.17.y
head:   992855288ffabfafb16c8ed7ce9a81fc64cfc89a
commit: 5129b4258d6570b94abc714f4ac79508f8b7645b [9/41] ODROID-COMMON: power:reset: Add odroid support
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220216/202202160601.6EUNHQqV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/5129b4258d6570b94abc714f4ac79508f8b7645b
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.17.y
        git checkout 5129b4258d6570b94abc714f4ac79508f8b7645b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/power/reset/odroid-reboot.c:63:6: warning: no previous prototype for 'odroid_card_reset' [-Wmissing-prototypes]
      63 | void odroid_card_reset(void)
         |      ^~~~~~~~~~~~~~~~~
   drivers/power/reset/odroid-reboot.c: In function 'odroid_restart_probe':
>> drivers/power/reset/odroid-reboot.c:141:17: error: 'arm_pm_restart' undeclared (first use in this function); did you mean 'alarm_restart'?
     141 |                 arm_pm_restart = do_odroid_restart;
         |                 ^~~~~~~~~~~~~~
         |                 alarm_restart
   drivers/power/reset/odroid-reboot.c:141:17: note: each undeclared identifier is reported only once for each function it appears in


vim +141 drivers/power/reset/odroid-reboot.c

   133	
   134	static int odroid_restart_probe(struct platform_device *pdev)
   135	{
   136		struct device_node *of_node;
   137		u32 id;
   138	
   139		if (!of_property_read_u32(pdev->dev.of_node, "sys_reset", &id)) {
   140			psci_function_id_restart = id;
 > 141			arm_pm_restart = do_odroid_restart;
   142		}
   143	
   144		if (!of_property_read_u32(pdev->dev.of_node, "sys_poweroff", &id)) {
   145			psci_function_id_poweroff = id;
   146			pm_power_off = do_odroid_poweroff;
   147		}
   148	
   149		of_node = pdev->dev.of_node;
   150	
   151		sd_vqsw = of_get_named_gpio(of_node, "sd-vqsw", 0);
   152		if (!gpio_is_valid(sd_vqsw)) sd_vqsw = 0;
   153	
   154		sd_vmmc = of_get_named_gpio(of_node, "sd-vmmc", 0);
   155		if (!gpio_is_valid(sd_vmmc)) sd_vmmc = 0;
   156	
   157		sd_vqen = of_get_named_gpio(of_node, "sd-vqen", 0);
   158		if (!gpio_is_valid(sd_vqen)) sd_vqen = 0;
   159	
   160		return 0;
   161	}
   162	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
