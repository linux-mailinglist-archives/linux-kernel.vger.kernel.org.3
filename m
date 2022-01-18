Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0663493164
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350257AbiARX1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:27:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:56642 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234491AbiARX1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642548439; x=1674084439;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FcuDy7Mjh0G8Fmr//5jE81ABQXB00sIEf3nMipzNJzY=;
  b=mplHZ5EqVin04WGTfVGpS7QKzl8KjyTteWPvF6i8NpC+DvhLfffTHV3Y
   dc0yHqankX/7d7a4eJ+jmznyifupftgn9Gnc5WLJH0lBWTlhDm2uXE+mi
   4IzeBjrT0m+v5Y2bBCEk50LZGJuyX7Z134SSOZxJqBXNuSZa0MkkJeOHv
   yp6fH7DimiEUleRgvlYT6EL/WwokQ197Ja1Y/du90jLbQ2udLMR7mKB8+
   nG5/SeN5Yvq1r6QaJEHE0mr8G6eL2xemmSObK9R3W0Ba+lgEBBVE5lWPQ
   zS4cPfuYboJOahggaysZJKObaZAvvkXxEyZpL+e/mg3yjOOLmXF1S5hH0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305669906"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="305669906"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 15:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625671254"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 15:27:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9xsc-000D26-L5; Tue, 18 Jan 2022 23:27:10 +0000
Date:   Wed, 19 Jan 2022 07:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 4/10] drivers/dma/apple-admac.c:137:22:
 error: implicit declaration of function 'FIELD_GET'; did you mean
 'FOLL_GET'?
Message-ID: <202201190747.aM6P94bs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   63a99f1a44208593f5a423b5378824abc2246988
commit: 87fbc71e4e06939d5036c063908f76f03e88abae [4/10] dmaengine: apple-admac: Add Apple ADMAC driver
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201190747.aM6P94bs-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/87fbc71e4e06939d5036c063908f76f03e88abae
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 87fbc71e4e06939d5036c063908f76f03e88abae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dma/apple-admac.c:125:5: warning: no previous prototype for 'admac_alloc_chan_resources' [-Wmissing-prototypes]
     125 | int admac_alloc_chan_resources(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:130:6: warning: no previous prototype for 'admac_free_chan_resources' [-Wmissing-prototypes]
     130 | void admac_free_chan_resources(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:135:5: warning: no previous prototype for 'admac_ring_noccupied_slots' [-Wmissing-prototypes]
     135 | int admac_ring_noccupied_slots(int ringval)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c: In function 'admac_ring_noccupied_slots':
>> drivers/dma/apple-admac.c:137:22: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     137 |         int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
         |                      ^~~~~~~~~
         |                      FOLL_GET
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:155:5: warning: no previous prototype for 'admac_cyclic_read_residue' [-Wmissing-prototypes]
     155 | u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:181:17: warning: no previous prototype for 'admac_tx_status' [-Wmissing-prototypes]
     181 | enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/csky/include/asm/bug.h:18,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
   drivers/dma/apple-admac.c: In function 'admac_tx_status':
   drivers/dma/apple-admac.c:221:34: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/apple-admac.c:221:17: note: in expansion of macro 'dev_dbg'
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                 ^~~~~~~
   drivers/dma/apple-admac.c:221:51: note: format string is defined here
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                                 ~~^
         |                                                   |
         |                                                   long unsigned int
         |                                                 %x
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/csky/include/asm/bug.h:18,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
   drivers/dma/apple-admac.c:221:34: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/apple-admac.c:221:17: note: in expansion of macro 'dev_dbg'
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                 ^~~~~~~
   drivers/dma/apple-admac.c:221:57: note: format string is defined here
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                                       ~~^
         |                                                         |
         |                                                         long int
         |                                                       %d
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:228:6: warning: no previous prototype for 'admac_start' [-Wmissing-prototypes]
     228 | void admac_start(struct admac_chan *adchan)
         |      ^~~~~~~~~~~
   drivers/dma/apple-admac.c:244:6: warning: no previous prototype for 'admac_issue_pending' [-Wmissing-prototypes]
     244 | void admac_issue_pending(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:263:5: warning: no previous prototype for 'admac_pause' [-Wmissing-prototypes]
     263 | int admac_pause(struct dma_chan *chan)
         |     ^~~~~~~~~~~
   drivers/dma/apple-admac.c:272:5: warning: no previous prototype for 'admac_resume' [-Wmissing-prototypes]
     272 | int admac_resume(struct dma_chan *chan)
         |     ^~~~~~~~~~~~
   drivers/dma/apple-admac.c:281:5: warning: no previous prototype for 'admac_terminate_all' [-Wmissing-prototypes]
     281 | int admac_terminate_all(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:303:14: warning: no previous prototype for 'admac_tx_submit' [-Wmissing-prototypes]


vim +137 drivers/dma/apple-admac.c

   134	
   135	int admac_ring_noccupied_slots(int ringval)
   136	{
 > 137		int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
   138		int rdslot = FIELD_GET(RING_READ_SLOT, ringval);
   139	
   140		if (wrslot != rdslot) {
   141			return (wrslot + 4 - rdslot) % 4;
   142		} else {
   143			WARN_ON((ringval & (RING_FULL | RING_EMPTY)) == 0);
   144	
   145			if (ringval & RING_FULL)
   146				return 4;
   147			else
   148				return 0;
   149		}
   150	}
   151	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
