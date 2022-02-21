Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078974BDD53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355065AbiBUKcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:32:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354891AbiBUKcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:32:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66076C961
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645437179; x=1676973179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iu+zMLF3uEJwf1pZVGzd3cv6unyU/opZuLXB5dw8lj4=;
  b=UaqgbUCb+XmzoLaH4IeEJMt0ZRFSkevjDlM8alZgKecG2WUsf8AC5TYC
   vOuOg6Q3EpnZT/QnXdR0bjFyruZBInTUKGB99ip+Tkpy/hHGRZMBWQF47
   ZQ308cHWkXBow4lrGSSmohwOtAJiM4t8IyzCioFxE1w1wstQLoLjk9xtZ
   zXMvv2hZ9OwLHtu43qfxTVEC5+CQN9lYpGPrx7FlGYeRwlDoaP4MFQG+g
   r+zxNDE7ybVlAOpSI6ahniEQBB/50b9kbY7bAbWpWTpok5cGLSDTO2e6x
   5AJt37NjT2XsEg4hTMYjWJs0L+ll1mc90MMi2PN1XR6YHFMp8urSxNqq5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337908402"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="337908402"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 01:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="627324138"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 01:52:11 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM5MY-0001Ts-FH; Mon, 21 Feb 2022 09:52:10 +0000
Date:   Mon, 21 Feb 2022 17:51:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 522/552]
 sound/soc/apple/mca.c:776:6: warning: no previous prototype for
 'apple_mca_release_dma_chans'
Message-ID: <202202211725.BAv78HTm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: aa68cd40e7ed6c63500d8ea9b8946e4d8c974f9c [522/552] ASoC: apple-mca: Add platform driver for Apple SoCs
config: m68k-buildonly-randconfig-r005-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211725.BAv78HTm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/aa68cd40e7ed6c63500d8ea9b8946e4d8c974f9c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout aa68cd40e7ed6c63500d8ea9b8946e4d8c974f9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/dma/ sound/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/apple/mca.c: In function 'mca_configure_serdes':
   sound/soc/apple/mca.c:294:23: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     294 |         serdes_conf = FIELD_PREP(SERDES_CONF_NCHANS, max(slots, 1) - 1);
         |                       ^~~~~~~~~~
   sound/soc/apple/mca.c: At top level:
>> sound/soc/apple/mca.c:776:6: warning: no previous prototype for 'apple_mca_release_dma_chans' [-Wmissing-prototypes]
     776 | void apple_mca_release_dma_chans(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/apple/mca.c:791:6: warning: no previous prototype for 'apple_mca_put_clks' [-Wmissing-prototypes]
     791 | void apple_mca_put_clks(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/apple/mca.c:9:
   sound/soc/apple/mca.c: In function 'apple_mca_probe':
   sound/soc/apple/mca.c:917:45: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long int' [-Wformat=]
     917 |                         dev_err(&pdev->dev, "unable to obtain clock %s: %d\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/apple/mca.c:917:25: note: in expansion of macro 'dev_err'
     917 |                         dev_err(&pdev->dev, "unable to obtain clock %s: %d\n",
         |                         ^~~~~~~
   sound/soc/apple/mca.c:917:74: note: format string is defined here
     917 |                         dev_err(&pdev->dev, "unable to obtain clock %s: %d\n",
         |                                                                         ~^
         |                                                                          |
         |                                                                          int
         |                                                                         %ld
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/apple/mca.c:9:
   sound/soc/apple/mca.c:951:61: warning: format '%d' expects argument of type 'int', but argument 4 has type 'struct device_node *' [-Wformat=]
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/apple/mca.c:951:41: note: in expansion of macro 'dev_err'
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                         ^~~~~~~
   sound/soc/apple/mca.c:951:82: note: format string is defined here
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                                                                 ~^
         |                                                                                  |
         |                                                                                  int
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/apple/mca.c:9:
   sound/soc/apple/mca.c:951:61: warning: too many arguments for format [-Wformat-extra-args]
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/apple/mca.c:951:41: note: in expansion of macro 'dev_err'
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                         ^~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NFSD_V2_ACL
   Depends on NETWORK_FILESYSTEMS && NFSD
   Selected by
   - NFSD_V3_ACL && NETWORK_FILESYSTEMS


vim +/apple_mca_release_dma_chans +776 sound/soc/apple/mca.c

   775	
 > 776	void apple_mca_release_dma_chans(struct mca_data *mca)
   777	{
   778		int i;
   779		struct mca_route *route;
   780	
   781		list_for_each_entry(route, &mca->routes, list) {
   782			for_each_pcm_streams(i) {
   783				if (!route->chan[i])
   784					continue;
   785				dma_release_channel(route->chan[i]);
   786				route->chan[i] = NULL;
   787			}
   788		}
   789	}
   790	
 > 791	void apple_mca_put_clks(struct mca_data *mca)
   792	{
   793		struct mca_route *route;
   794		int i;
   795	
   796		list_for_each_entry(route, &mca->routes, list) {
   797			if (!route->clk_parent)
   798				continue;
   799			//clk_rate_exclusive_put(route->clk_parent);
   800			route->clk_parent = NULL;
   801		}
   802	
   803		for (i = 0; i < mca->nclusters; i++) {
   804			if (!mca->clk_parents[i])
   805				continue;
   806			clk_put(mca->clk_parents[i]);
   807			mca->clk_parents[i] = NULL;
   808		}
   809	}
   810	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
