Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF046520510
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiEITQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiEITQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:16:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6344C781
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652123580; x=1683659580;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wY/3eKaGs+7mZ+hRBExVmSgBjRISz6hZzU/ALUSB9Rk=;
  b=RPme/d6XKYm4UYgq0sKk1Kqg7AxKLQ+PIahN7DOJ8LA+4SbgAQ86U9m+
   +KxhNukE5UEGfo0ZLivRxgMd8JWsKy8IEt6CtOwSFh3H4+9RiCi5AlBsP
   /F403NY6C+VWTAoWIExvAG0CsUcCQFLK56k7DT72CUFK157Z1ZsaP4qHS
   kMdiLTvmmku+VHWZb+16h2++41qmZCCzQ9L3G82e6tOwb85NZUJk+y4A7
   n1u+lefSFlOql6VFcBCw4y4EXMkWuVLUPX4PQu4rg8DO2vklYdvK6pFql
   gpAs+Aoa4X0pTkK+1QByWPxwlyLtJlBLVLSdgy6aTazAqTT1SRc5ZoeEb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251193508"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="251193508"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 12:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="669491962"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2022 12:12:54 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no8oP-000Go8-GT;
        Mon, 09 May 2022 19:12:53 +0000
Date:   Tue, 10 May 2022 03:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: arch/m68k/include/asm/amigaints.h:40:33: error: 'IRQ_AUTO_2'
 undeclared
Message-ID: <202205100302.SfvKkCPB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: 9ab27d1d35fda0c5fce624083e92546a8545e7e5 ata: add Amiga Gayle PATA controller driver
date:   4 years, 2 months ago
config: m68k-randconfig-r002-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100302.SfvKkCPB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ab27d1d35fda0c5fce624083e92546a8545e7e5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9ab27d1d35fda0c5fce624083e92546a8545e7e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/io_mm.h:27,
                    from arch/m68k/include/asm/io.h:5,
                    from include/linux/bio.h:28,
                    from include/linux/blkdev.h:21,
                    from drivers/ata/pata_gayle.c:15:
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsb':
   arch/m68k/include/asm/raw_io.h:97:14: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      97 |         ({u8 __w, __v = (b);  u32 _addr = ((u32) (addr)); \
         |              ^~~
   arch/m68k/include/asm/raw_io.h:413:17: note: in expansion of macro 'rom_out_8'
     413 |                 rom_out_8(port, *buf++);
         |                 ^~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw':
   arch/m68k/include/asm/raw_io.h:100:15: warning: variable '__w' set but not used [-Wunused-but-set-variable]
     100 |         ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |               ^~~
   arch/m68k/include/asm/raw_io.h:431:17: note: in expansion of macro 'rom_out_be16'
     431 |                 rom_out_be16(port, *buf++);
         |                 ^~~~~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw_swapw':
   arch/m68k/include/asm/raw_io.h:104:15: warning: variable '__w' set but not used [-Wunused-but-set-variable]
     104 |         ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |               ^~~
   arch/m68k/include/asm/raw_io.h:449:17: note: in expansion of macro 'rom_out_le16'
     449 |                 rom_out_le16(port, *buf++);
         |                 ^~~~~~~~~~~~
   In file included from include/linux/kernel.h:10,
                    from include/linux/ata.h:32,
                    from drivers/ata/pata_gayle.c:14:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:147:9: note: in expansion of macro 'BUG_ON'
     147 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:147:17: note: in expansion of macro 'virt_addr_valid'
     147 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dma-mapping.h:329:9: note: in expansion of macro 'BUG_ON'
     329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
         |         ^~~~~~
   arch/m68k/include/asm/page_mm.h:170:33: note: in expansion of macro 'virt_addr_valid'
     170 | #define pfn_valid(pfn)          virt_addr_valid(pfn_to_virt(pfn))
         |                                 ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:329:16: note: in expansion of macro 'pfn_valid'
     329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
         |                ^~~~~~~~~
   In file included from drivers/ata/pata_gayle.c:28:
   drivers/ata/pata_gayle.c: In function 'pata_gayle_init_one':
>> arch/m68k/include/asm/amigaints.h:40:33: error: 'IRQ_AUTO_2' undeclared (first use in this function)
      40 | #define IRQ_AMIGA_PORTS         IRQ_AUTO_2
         |                                 ^~~~~~~~~~
   drivers/ata/pata_gayle.c:187:39: note: in expansion of macro 'IRQ_AMIGA_PORTS'
     187 |         ret = ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
         |                                       ^~~~~~~~~~~~~~~
   arch/m68k/include/asm/amigaints.h:40:33: note: each undeclared identifier is reported only once for each function it appears in
      40 | #define IRQ_AMIGA_PORTS         IRQ_AUTO_2
         |                                 ^~~~~~~~~~
   drivers/ata/pata_gayle.c:187:39: note: in expansion of macro 'IRQ_AMIGA_PORTS'
     187 |         ret = ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
         |                                       ^~~~~~~~~~~~~~~
   In file included from drivers/ata/pata_gayle.c:21:
   drivers/ata/pata_gayle.c: At top level:
   include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'pata_gayle_driver_init': 'cold' [-Wmissing-attributes]
     132 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/platform_device.h:251:1: note: in expansion of macro 'module_init'
     251 | module_init(__platform_driver##_init); \
         | ^~~~~~~~~~~
   drivers/ata/pata_gayle.c:213:1: note: in expansion of macro 'module_platform_driver_probe'
     213 | module_platform_driver_probe(pata_gayle_driver, pata_gayle_init_one);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/ata/pata_gayle.c:22:
   drivers/ata/pata_gayle.c:213:30: note: 'init_module' target declared here
     213 | module_platform_driver_probe(pata_gayle_driver, pata_gayle_init_one);
         |                              ^~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:246:19: note: in definition of macro 'module_platform_driver_probe'
     246 | static int __init __platform_driver##_init(void) \
         |                   ^~~~~~~~~~~~~~~~~
   In file included from drivers/ata/pata_gayle.c:21:
   include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'pata_gayle_driver_exit': 'cold' [-Wmissing-attributes]
     138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/platform_device.h:256:1: note: in expansion of macro 'module_exit'
     256 | module_exit(__platform_driver##_exit);
         | ^~~~~~~~~~~
   drivers/ata/pata_gayle.c:213:1: note: in expansion of macro 'module_platform_driver_probe'
     213 | module_platform_driver_probe(pata_gayle_driver, pata_gayle_init_one);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/ata/pata_gayle.c:22:
   drivers/ata/pata_gayle.c:213:30: note: 'cleanup_module' target declared here
     213 | module_platform_driver_probe(pata_gayle_driver, pata_gayle_init_one);
         |                              ^~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:252:20: note: in definition of macro 'module_platform_driver_probe'
     252 | static void __exit __platform_driver##_exit(void) \
         |                    ^~~~~~~~~~~~~~~~~


vim +/IRQ_AUTO_2 +40 arch/m68k/include/asm/amigaints.h

^1da177e4c3f415 include/asm-m68k/amigaints.h Linus Torvalds 2005-04-16  38  
1d174cfb0f2a896 include/asm-m68k/amigaints.h Roman Zippel   2006-06-25  39  /* interrupts from external hardware */
74be8d0835f91f0 include/asm-m68k/amigaints.h Roman Zippel   2006-06-25 @40  #define IRQ_AMIGA_PORTS		IRQ_AUTO_2
74be8d0835f91f0 include/asm-m68k/amigaints.h Roman Zippel   2006-06-25  41  #define IRQ_AMIGA_EXTER		IRQ_AUTO_6
^1da177e4c3f415 include/asm-m68k/amigaints.h Linus Torvalds 2005-04-16  42  

:::::: The code at line 40 was first introduced by commit
:::::: 74be8d0835f91f0f77a2f1554dfa7242f1f7b652 [PATCH] m68k: convert amiga irq code

:::::: TO: Roman Zippel <zippel@linux-m68k.org>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
