Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF25471B6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 06:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiFKECJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 00:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiFKECE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 00:02:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09FFDB9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654920122; x=1686456122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/0Fy8SZZQb47IpDRTn4cq8/66axdUZmVqC6eUST9HN4=;
  b=PxxtP4lVqzFT59G5rhItwIWqoLLn4iOMBfC4wpxb+wZLycvQqJiN/Idc
   WqCSFiMJQq/rZYtFS7UWLqXxBArQ9pQEOLLotNiL2gUmvuD6qBRWk/C5d
   KH8JYUAmVs2wsvb7mIdCF/X1bY4gIMpUCcq4GXsjkcCNG8ix2oP2XWDQH
   WK3tVOlCXZZotWH/piD7by6NvP5u62CevJZjXj6DNrzJ/2ZtH2sdgp4AI
   8JhkWcaO7crEk//+Ul14A/FUhxLwHmAj9iNHSdL0IQIF3H0HB8xFu1mWj
   325g9tKHqv/SB7j2+MrYBRvRkeqwBp1G+hOw3ct24CgSVa6fvK1gPpNFI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275350952"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="275350952"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 21:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="828592451"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2022 21:02:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzsK0-000IWb-O4;
        Sat, 11 Jun 2022 04:02:00 +0000
Date:   Sat, 11 Jun 2022 12:01:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [vkoul-dmaengine:next 6/11] drivers/dma/apple-admac.c:209:26:
 warning: format '%x' expects argument of type 'unsigned int', but argument 7
 has type 'long unsigned int'
Message-ID: <202206111149.QgVBL86Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
head:   c9357195c5770029f0c65a5b76756dea5b767ff0
commit: b127315d9a78c011c011b88b92f650510edcfbd2 [6/11] dmaengine: apple-admac: Add Apple ADMAC driver
config: parisc64-allyesconfig (https://download.01.org/0day-ci/archive/20220611/202206111149.QgVBL86Y-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=b127315d9a78c011c011b88b92f650510edcfbd2
        git remote add vkoul-dmaengine https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
        git fetch --no-tags vkoul-dmaengine next
        git checkout b127315d9a78c011c011b88b92f650510edcfbd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/mgag200/ drivers/iio/adc/ drivers/regulator/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:584,
                    from include/linux/kernel.h:29,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:10:
   drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
>> drivers/dma/apple-admac.c:209:26: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'long unsigned int' [-Wformat=]
     209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/apple-admac.c:209:9: note: in expansion of macro 'dev_dbg'
     209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
         |         ^~~~~~~
   drivers/dma/apple-admac.c:209:75: note: format string is defined here
     209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
         |                                                                          ~^
         |                                                                           |
         |                                                                           unsigned int
         |                                                                          %lx
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dmaengine.h:12,
                    from include/linux/of_dma.h:14,
                    from drivers/dma/apple-admac.c:14:
>> drivers/dma/apple-admac.c:213:29: warning: right shift count >= width of type [-Wshift-count-overflow]
     213 |         writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
         |                             ^~
   arch/parisc/include/asm/io.h:219:40: note: in definition of macro 'writel_relaxed'
     219 | #define writel_relaxed(l, addr) writel(l, addr)
         |                                        ^


vim +209 drivers/dma/apple-admac.c

   195	
   196	/*
   197	 * Write one hardware descriptor for a dmaengine cyclic transaction.
   198	 */
   199	static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
   200						struct admac_tx *tx)
   201	{
   202		dma_addr_t addr;
   203	
   204		addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
   205	
   206		/* If happens means we have buggy code */
   207		WARN_ON_ONCE(addr + tx->period_len > tx->buf_end);
   208	
 > 209		dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
   210			channo, &addr, tx->period_len, FLAG_DESC_NOTIFY);
   211	
   212		writel_relaxed(addr,             ad->base + REG_DESC_WRITE(channo));
 > 213		writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
   214		writel_relaxed(tx->period_len,   ad->base + REG_DESC_WRITE(channo));
   215		writel_relaxed(FLAG_DESC_NOTIFY, ad->base + REG_DESC_WRITE(channo));
   216	
   217		tx->submitted_pos += tx->period_len;
   218		tx->submitted_pos %= 2 * tx->buf_len;
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
