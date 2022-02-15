Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32F4B6ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiBOLZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:25:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBOLZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:25:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB2108555
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644924308; x=1676460308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cqn2X0osSuXDH//2qQbOhV8xnDgXUM1QyR4CUXfzmQI=;
  b=n0GpkmT7a3pxW6UslExddXGJzWZPDtisOPZGO9v0jOvlUObmYh67fRb2
   3aIR8ho3IHIzdERRHGKTjUrM8zzK9NdtT/fEb8RIZq958lCRqg3wQ3SuK
   2ydoOJH4/j9suo+WdcTViTz25FbabUaJWvIpVtOoHqS7NkeBytTxdXZmr
   UGq+/kqkFyJaosffo0SwaAS4mStX7v+B5ouk7J5r1TsuDhAdbQ1Tuo05r
   BjcdkwvSpSYSGjaGw+xg3bKAxFmTD1Im5Zg+ILDTasaXEzZWafhCSlWWZ
   XiMbDDf/UhOCPaxE3KdXiMgg8G2oHwS6NdkFzRbIwiKpY2inT1y35nD93
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250072588"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="250072588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 03:24:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="635815621"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 03:24:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJvws-0009bg-8p; Tue, 15 Feb 2022 11:24:46 +0000
Date:   Tue, 15 Feb 2022 19:23:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     ckkim <changkon12@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.17.y 9/41]
 drivers/power/reset/odroid-reboot.c:63:6: warning: no previous prototype for
 'odroid_card_reset'
Message-ID: <202202151819.zUcA2HQK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.17.y
head:   992855288ffabfafb16c8ed7ce9a81fc64cfc89a
commit: 5129b4258d6570b94abc714f4ac79508f8b7645b [9/41] ODROID-COMMON: power:reset: Add odroid support
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220215/202202151819.zUcA2HQK-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/power/reset/

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
