Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E184EB939
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbiC3EKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbiC3EK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:10:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560BA20F4D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648613324; x=1680149324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GXMtXoRhyhPbV4s+mUDid7WXBQliaTM5lEr+uqSFXdA=;
  b=ODe7FuQZE1JwZ3TrTbfo5ptjOpJV8C0lF3HXkt4hB6tT5WUqxrTHq+G4
   qEnN3H3wt4D555xCcuzGRBJPoXfHS0G9S6th+MW43x8s3yxJ2jBtYLLB+
   nj7MAnmfWaasYPu8dGsVNcuSthVqOlWnVs8qEZZBh4qwZ/5YQpwnqnC9O
   4oAgcv4tTKm69C91Pk5GtmlrxiCT8eP5fHIWLA4G0BYi9m2/wElCQMW2a
   QNuWou0mvzU8nxACSSJJCsQPnaOI6uyD0CDxaqieP+uewFz+vPvghIkNb
   eFj1fsdLmcLf/fCS0t+ER2uVWzcwJCHlZWrCOaISHNfVVllmXRqVNf8yy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="246939561"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="246939561"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719816605"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2022 21:08:40 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZPdP-0000yW-Ex; Wed, 30 Mar 2022 04:08:39 +0000
Date:   Wed, 30 Mar 2022 12:08:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/kspp-stringop-overflow 7/7]
 arch/m68k/amiga/config.c:453:56: warning: writing 1 byte into a region of
 size 0
Message-ID: <202203301238.Yblbl2iM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/kspp-stringop-overflow
head:   3801f720ebf09ec3589982fba4138e83b4177fe1
commit: 3801f720ebf09ec3589982fba4138e83b4177fe1 [7/7] Makefile: Enable -Wstringop-overflow globally
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220330/202203301238.Yblbl2iM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=3801f720ebf09ec3589982fba4138e83b4177fe1
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/kspp-stringop-overflow
        git checkout 3801f720ebf09ec3589982fba4138e83b4177fe1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/amiga/ arch/m68k/q40/ drivers/staging/r8188eu/ sound/oss/dmasound/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/m68k/amiga/config.c: In function 'config_amiga':
>> arch/m68k/amiga/config.c:453:56: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     453 |                 *(unsigned char *)ZTWO_VADDR(0xde0002) |= 0x80;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
--
   arch/m68k/q40/q40ints.c:84:13: warning: no previous prototype for 'q40_init_IRQ' [-Wmissing-prototypes]
      84 | void __init q40_init_IRQ(void)
         |             ^~~~~~~~~~~~
   arch/m68k/q40/q40ints.c:112:6: warning: no previous prototype for 'q40_mksound' [-Wmissing-prototypes]
     112 | void q40_mksound(unsigned int hz, unsigned int ticks)
         |      ^~~~~~~~~~~
   arch/m68k/q40/q40ints.c:152:6: warning: no previous prototype for 'q40_sched_init' [-Wmissing-prototypes]
     152 | void q40_sched_init (void)
         |      ^~~~~~~~~~~~~~
   arch/m68k/q40/q40ints.c: In function 'q40_timer_int':
>> arch/m68k/q40/q40ints.c:137:26: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     137 |                 *DAC_LEFT=sval;
         |                 ~~~~~~~~~^~~~~
   arch/m68k/q40/q40ints.c:138:27: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     138 |                 *DAC_RIGHT=sval;
         |                 ~~~~~~~~~~^~~~~
   arch/m68k/q40/q40ints.c: In function 'q40_mksound':
   arch/m68k/q40/q40ints.c:120:27: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     120 |                 *DAC_LEFT = 128;
         |                 ~~~~~~~~~~^~~~~
   arch/m68k/q40/q40ints.c:121:28: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     121 |                 *DAC_RIGHT = 128;
         |                 ~~~~~~~~~~~^~~~~
--
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from drivers/staging/r8188eu/core/../include/osdep_service.h:7,
                    from drivers/staging/r8188eu/core/rtw_recv.c:6:
   drivers/staging/r8188eu/core/rtw_recv.c: In function 'wlanhdr_to_ethhdr':
>> arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
      72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/r8188eu/core/rtw_recv.c:1233:9: note: in expansion of macro 'memcpy'
    1233 |         memcpy(ptr + ETH_ALEN, pattrib->src, ETH_ALEN);
         |         ^~~~~~
>> arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
      72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/r8188eu/core/rtw_recv.c:1233:9: note: in expansion of macro 'memcpy'
    1233 |         memcpy(ptr + ETH_ALEN, pattrib->src, ETH_ALEN);
         |         ^~~~~~
--
   sound/oss/dmasound/dmasound_q40.c: In function 'Q40Silence':
>> sound/oss/dmasound/dmasound_q40.c:395:29: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     395 |         *DAC_LEFT=*DAC_RIGHT=127;
         |                   ~~~~~~~~~~^~~~
   sound/oss/dmasound/dmasound_q40.c:395:18: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     395 |         *DAC_LEFT=*DAC_RIGHT=127;
         |         ~~~~~~~~~^~~~~~~~~~~~~~~
   In function 'Q40Silence',
       inlined from 'Q40Init' at sound/oss/dmasound/dmasound_q40.c:530:2:
>> sound/oss/dmasound/dmasound_q40.c:395:29: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     395 |         *DAC_LEFT=*DAC_RIGHT=127;
         |                   ~~~~~~~~~~^~~~
   sound/oss/dmasound/dmasound_q40.c:395:18: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     395 |         *DAC_LEFT=*DAC_RIGHT=127;
         |         ~~~~~~~~~^~~~~~~~~~~~~~~
   sound/oss/dmasound/dmasound_q40.c: In function 'Q40Interrupt':
   sound/oss/dmasound/dmasound_q40.c:499:37: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     499 |                 *DAC_LEFT=*DAC_RIGHT=127;
         |                           ~~~~~~~~~~^~~~
   sound/oss/dmasound/dmasound_q40.c:499:26: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     499 |                 *DAC_LEFT=*DAC_RIGHT=127;
         |                 ~~~~~~~~~^~~~~~~~~~~~~~~


vim +453 arch/m68k/amiga/config.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  395  
50190edb2a56bb Geert Uytterhoeven 2013-10-18  396  	mach_random_get_entropy = amiga_random_get_entropy;
50190edb2a56bb Geert Uytterhoeven 2013-10-18  397  
0795dbcc4c4c93 Adrian Bunk        2008-07-17  398  	/* Fill in the clock value (based on the 700 kHz E-Clock) */
^1da177e4c3f41 Linus Torvalds     2005-04-16  399  	amiga_colorclock = 5*amiga_eclock;	/* 3.5 MHz */
^1da177e4c3f41 Linus Torvalds     2005-04-16  400  
^1da177e4c3f41 Linus Torvalds     2005-04-16  401  	/* clear all DMA bits */
b4290a23cfa904 Al Viro            2006-01-12  402  	amiga_custom.dmacon = DMAF_ALL;
^1da177e4c3f41 Linus Torvalds     2005-04-16  403  	/* ensure that the DMA master bit is set */
b4290a23cfa904 Al Viro            2006-01-12  404  	amiga_custom.dmacon = DMAF_SETCLR | DMAF_MASTER;
^1da177e4c3f41 Linus Torvalds     2005-04-16  405  
^1da177e4c3f41 Linus Torvalds     2005-04-16  406  	/* don't use Z2 RAM as system memory on Z3 capable machines */
^1da177e4c3f41 Linus Torvalds     2005-04-16  407  	if (AMIGAHW_PRESENT(ZORRO3)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  408  		int i, j;
^1da177e4c3f41 Linus Torvalds     2005-04-16  409  		u32 disabled_z2mem = 0;
6ff5801acbb643 Roman Zippel       2007-05-01  410  
6ff5801acbb643 Roman Zippel       2007-05-01  411  		for (i = 0; i < m68k_num_memory; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  412  			if (m68k_memory[i].addr < 16*1024*1024) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  413  				if (i == 0) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  414  					/* don't cut off the branch we're sitting on */
f296401b04a6eb Fabian Frederick   2014-05-10  415  					pr_warn("Warning: kernel runs in Zorro II memory\n");
^1da177e4c3f41 Linus Torvalds     2005-04-16  416  					continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  417  				}
^1da177e4c3f41 Linus Torvalds     2005-04-16  418  				disabled_z2mem += m68k_memory[i].size;
^1da177e4c3f41 Linus Torvalds     2005-04-16  419  				m68k_num_memory--;
^1da177e4c3f41 Linus Torvalds     2005-04-16  420  				for (j = i; j < m68k_num_memory; j++)
^1da177e4c3f41 Linus Torvalds     2005-04-16  421  					m68k_memory[j] = m68k_memory[j+1];
^1da177e4c3f41 Linus Torvalds     2005-04-16  422  				i--;
^1da177e4c3f41 Linus Torvalds     2005-04-16  423  			}
6ff5801acbb643 Roman Zippel       2007-05-01  424  		}
^1da177e4c3f41 Linus Torvalds     2005-04-16  425  		if (disabled_z2mem)
f296401b04a6eb Fabian Frederick   2014-05-10  426  			pr_info("%dK of Zorro II memory will not be used as system memory\n",
^1da177e4c3f41 Linus Torvalds     2005-04-16  427  				disabled_z2mem>>10);
^1da177e4c3f41 Linus Torvalds     2005-04-16  428  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  429  
^1da177e4c3f41 Linus Torvalds     2005-04-16  430  	/* request all RAM */
^1da177e4c3f41 Linus Torvalds     2005-04-16  431  	for (i = 0; i < m68k_num_memory; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  432  		ram_resource[i].name =
^1da177e4c3f41 Linus Torvalds     2005-04-16  433  			(m68k_memory[i].addr >= 0x01000000) ? "32-bit Fast RAM" :
^1da177e4c3f41 Linus Torvalds     2005-04-16  434  			(m68k_memory[i].addr < 0x00c00000) ? "16-bit Fast RAM" :
^1da177e4c3f41 Linus Torvalds     2005-04-16  435  			"16-bit Slow RAM";
^1da177e4c3f41 Linus Torvalds     2005-04-16  436  		ram_resource[i].start = m68k_memory[i].addr;
^1da177e4c3f41 Linus Torvalds     2005-04-16  437  		ram_resource[i].end = m68k_memory[i].addr+m68k_memory[i].size-1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  438  		request_resource(&iomem_resource, &ram_resource[i]);
^1da177e4c3f41 Linus Torvalds     2005-04-16  439  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  440  
^1da177e4c3f41 Linus Torvalds     2005-04-16  441  	/* initialize chipram allocator */
^1da177e4c3f41 Linus Torvalds     2005-04-16  442  	amiga_chip_init();
^1da177e4c3f41 Linus Torvalds     2005-04-16  443  
^1da177e4c3f41 Linus Torvalds     2005-04-16  444  	/* our beloved beeper */
^1da177e4c3f41 Linus Torvalds     2005-04-16  445  	if (AMIGAHW_PRESENT(AMI_AUDIO))
^1da177e4c3f41 Linus Torvalds     2005-04-16  446  		amiga_init_sound();
^1da177e4c3f41 Linus Torvalds     2005-04-16  447  
^1da177e4c3f41 Linus Torvalds     2005-04-16  448  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  449  	 * if it is an A3000, set the magic bit that forces
^1da177e4c3f41 Linus Torvalds     2005-04-16  450  	 * a hard rekick
^1da177e4c3f41 Linus Torvalds     2005-04-16  451  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  452  	if (AMIGAHW_PRESENT(MAGIC_REKICK))
^1da177e4c3f41 Linus Torvalds     2005-04-16 @453  		*(unsigned char *)ZTWO_VADDR(0xde0002) |= 0x80;
^1da177e4c3f41 Linus Torvalds     2005-04-16  454  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  455  

:::::: The code at line 453 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
