Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9074BCE77
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbiBTMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:30:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbiBTMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:30:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7053B77
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645360180; x=1676896180;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iGPn762U0UupRgxOizPp5e4W0h3yr6PfLmAdVPv1uVw=;
  b=mWgHqLGC7+WtZ1rldidzfPgFcot5qQMJICIOcoCjrpwxIyuEIo5tQGPu
   1EixFvpYNQ0NOofIfRhRpN6MP55lV82hqZwqOAlkH00oWLGFWgP9wU+1Q
   ptN27j+GxYA9J3p6s9NJSymR5icRk5rqwwi0B9uqtxAQfCWg+1hsy/Yor
   XYKaJxgui6UnVBQdtzIJnkbu2+J0n/0OP8I8xSaJOylu490LD7ANqXC//
   Nldhtu4quLhGubp2097suzoW1KV7omsWpt75IeLlf3kmOtgAgXz4Dvty8
   tHVJPZ6MQlE5WpNIK9pT6XGIKr5Ik5pupidLGWqpOhymGE9fgn3znHJu1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="248950162"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="248950162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 04:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="682938788"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 04:29:38 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLlLO-0000Km-27; Sun, 20 Feb 2022 12:29:38 +0000
Date:   Sun, 20 Feb 2022 20:29:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 522/552]
 sound/soc/apple/mca.c:223:41: warning: array subscript 1 is above array
 bounds of 'bool[1]' {aka '_Bool[1]'}
Message-ID: <202202202036.km0KGsP8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: aa68cd40e7ed6c63500d8ea9b8946e4d8c974f9c [522/552] ASoC: apple-mca: Add platform driver for Apple SoCs
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220220/202202202036.km0KGsP8-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/aa68cd40e7ed6c63500d8ea9b8946e4d8c974f9c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout aa68cd40e7ed6c63500d8ea9b8946e4d8c974f9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash sound/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/apple/mca.c: In function 'mca_configure_serdes':
   sound/soc/apple/mca.c:294:23: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     294 |         serdes_conf = FIELD_PREP(SERDES_CONF_NCHANS, max(slots, 1) - 1);
         |                       ^~~~~~~~~~
   sound/soc/apple/mca.c: At top level:
   sound/soc/apple/mca.c:776:6: warning: no previous prototype for 'apple_mca_release_dma_chans' [-Wmissing-prototypes]
     776 | void apple_mca_release_dma_chans(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/apple/mca.c:791:6: warning: no previous prototype for 'apple_mca_put_clks' [-Wmissing-prototypes]
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
   sound/soc/apple/mca.c: In function 'mca_dai_set_sysclk':
>> sound/soc/apple/mca.c:223:41: warning: array subscript 1 is above array bounds of 'bool[1]' {aka '_Bool[1]'} [-Warray-bounds]
     223 |                 if (route->clocks_in_use[stream])
         |                     ~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   sound/soc/apple/mca.c:123:14: note: while referencing 'clocks_in_use'
     123 |         bool clocks_in_use[SNDRV_PCM_STREAM_LAST];
         |              ^~~~~~~~~~~~~
   sound/soc/apple/mca.c: In function 'mca_dai_hw_free':
>> sound/soc/apple/mca.c:223:41: warning: array subscript 1 is above array bounds of 'bool[1]' {aka '_Bool[1]'} [-Warray-bounds]
     223 |                 if (route->clocks_in_use[stream])
         |                     ~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   sound/soc/apple/mca.c:123:14: note: while referencing 'clocks_in_use'
     123 |         bool clocks_in_use[SNDRV_PCM_STREAM_LAST];
         |              ^~~~~~~~~~~~~
   sound/soc/apple/mca.c: In function 'mca_dai_prepare':
>> sound/soc/apple/mca.c:223:41: warning: array subscript 1 is above array bounds of 'bool[1]' {aka '_Bool[1]'} [-Warray-bounds]
     223 |                 if (route->clocks_in_use[stream])
         |                     ~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   sound/soc/apple/mca.c:123:14: note: while referencing 'clocks_in_use'
     123 |         bool clocks_in_use[SNDRV_PCM_STREAM_LAST];
         |              ^~~~~~~~~~~~~
   sound/soc/apple/mca.c: In function 'mca_dai_hw_params':
>> sound/soc/apple/mca.c:223:41: warning: array subscript 1 is above array bounds of 'bool[1]' {aka '_Bool[1]'} [-Warray-bounds]
     223 |                 if (route->clocks_in_use[stream])
         |                     ~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   sound/soc/apple/mca.c:123:14: note: while referencing 'clocks_in_use'
     123 |         bool clocks_in_use[SNDRV_PCM_STREAM_LAST];
         |              ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +223 sound/soc/apple/mca.c

   216	
   217	
   218	static bool mca_clocks_in_use(struct mca_route *route)
   219	{
   220		int stream;
   221	
   222		for_each_pcm_streams(stream)
 > 223			if (route->clocks_in_use[stream])
   224				return true;
   225		return false;
   226	}
   227	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
