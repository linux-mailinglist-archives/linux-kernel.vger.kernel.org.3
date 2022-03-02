Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4E4C9BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiCBDEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCBDEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:04:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C659A40
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646190219; x=1677726219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HYzWqTuLWrWMQnH+IdzhCoZymsrGOHLI82BZ5hT+Gvo=;
  b=lKr2w5RnMqMXqJhs/YoThNsx94bPt+vp9AW0qjBw2Eku2/Om0xelEsm8
   /9IbDfzD8p6sc2YckNeUKdSpl2yoLkyNsdkvS5N3ZmojqEg9hbkF/JBF0
   QOmz0Mw1/1mprU4UDx9HIhF40+4tAmVOgILdofmcnv/haPLfuxvt5/izz
   8z2l1QYMNWBIPSv+Wg1QktkA4rdC6qc4bBL2WIJuZ4Gy8GZyTz5qXFDUF
   iwhRRY/QJaX/IEEcqCfWYsXu1DiQQ5ZOl0RpSi9fsV2qeFgARVJkuIjYq
   XsnXqM2ThuYJVfunVsgzRg9sP3GjPJdD+JdiZmQ80E9Bg9UZ4lPz/nqNe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252128263"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252128263"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 19:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="510830190"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Mar 2022 19:03:35 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPFH4-0000z0-KT; Wed, 02 Mar 2022 03:03:34 +0000
Date:   Wed, 2 Mar 2022 11:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-03-01 258/355]
 drivers/dma/apple-admac.c:240:22: error: implicit declaration of function
 'FIELD_GET'; did you mean 'FOLL_GET'?
Message-ID: <202203021008.QEdlvQvz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-03-01
head:   d7cc9472c1c5430d7caa806e8180d2359ea46266
commit: ca01702f8859c2acd332ad63d3418e14f2f0cae8 [258/355] dmaengine: apple-admac: Add Apple ADMAC driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220302/202203021008.QEdlvQvz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ca01702f8859c2acd332ad63d3418e14f2f0cae8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-03-01
        git checkout ca01702f8859c2acd332ad63d3418e14f2f0cae8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/ drivers/platform/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dma/apple-admac.c:132:14: warning: no previous prototype for 'admac_tx_submit' [-Wmissing-prototypes]
     132 | dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
         |              ^~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:154:33: warning: no previous prototype for 'admac_prep_dma_cyclic' [-Wmissing-prototypes]
     154 | struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:156,
                    from include/linux/bug.h:5,
                    from arch/powerpc/include/asm/cmpxchg.h:8,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
   drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
   drivers/dma/apple-admac.c:200:26: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
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
   drivers/dma/apple-admac.c:200:9: note: in expansion of macro 'dev_dbg'
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |         ^~~~~~~
   drivers/dma/apple-admac.c:200:54: note: format string is defined here
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                                                   ~~~^
         |                                                      |
         |                                                      long long unsigned int
         |                                                   %x
   drivers/dma/apple-admac.c:204:53: warning: right shift count >= width of type [-Wshift-count-overflow]
     204 |         admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
         |                                                     ^~
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:228:5: warning: no previous prototype for 'admac_alloc_chan_resources' [-Wmissing-prototypes]
     228 | int admac_alloc_chan_resources(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:233:6: warning: no previous prototype for 'admac_free_chan_resources' [-Wmissing-prototypes]
     233 | void admac_free_chan_resources(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:238:5: warning: no previous prototype for 'admac_ring_noccupied_slots' [-Wmissing-prototypes]
     238 | int admac_ring_noccupied_slots(int ringval)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c: In function 'admac_ring_noccupied_slots':
>> drivers/dma/apple-admac.c:240:22: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     240 |         int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
         |                      ^~~~~~~~~
         |                      FOLL_GET
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:258:5: warning: no previous prototype for 'admac_cyclic_read_residue' [-Wmissing-prototypes]
     258 | u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:284:17: warning: no previous prototype for 'admac_tx_status' [-Wmissing-prototypes]
     284 | enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
         |                 ^~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:353:6: warning: no previous prototype for 'admac_start_current_tx' [-Wmissing-prototypes]
     353 | void admac_start_current_tx(struct admac_chan *adchan)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:367:6: warning: no previous prototype for 'admac_issue_pending' [-Wmissing-prototypes]
     367 | void admac_issue_pending(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:386:5: warning: no previous prototype for 'admac_pause' [-Wmissing-prototypes]
     386 | int admac_pause(struct dma_chan *chan)
         |     ^~~~~~~~~~~
   drivers/dma/apple-admac.c:395:5: warning: no previous prototype for 'admac_resume' [-Wmissing-prototypes]
     395 | int admac_resume(struct dma_chan *chan)
         |     ^~~~~~~~~~~~
   drivers/dma/apple-admac.c:404:5: warning: no previous prototype for 'admac_terminate_all' [-Wmissing-prototypes]
     404 | int admac_terminate_all(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +240 drivers/dma/apple-admac.c

   237	
   238	int admac_ring_noccupied_slots(int ringval)
   239	{
 > 240		int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
   241		int rdslot = FIELD_GET(RING_READ_SLOT, ringval);
   242	
   243		if (wrslot != rdslot) {
   244			return (wrslot + 4 - rdslot) % 4;
   245		} else {
   246			WARN_ON((ringval & (RING_FULL | RING_EMPTY)) == 0);
   247	
   248			if (ringval & RING_FULL)
   249				return 4;
   250			else
   251				return 0;
   252		}
   253	}
   254	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
