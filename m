Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD54A3541
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354439AbiA3Iyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:54:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:10225 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354397AbiA3Iy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643532869; x=1675068869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DVBUvvGVuqe8bIyRb/vS+xq8iR7677KjfrHOC3cjuVs=;
  b=hac/tozt9taK5KihB8Xcrd7x6/NveHqt6vhmx+m9RD2LQNseonIj/t+q
   dX08O07ger7esRJMiv/Uo6XZenu5HNOLAMvhUaf6sfO1BtE4o7a+6AqWs
   0ezT8SqvUzFVsrrox2X663o2tgOKNyZD24UHoU692w3MGRpapEZDW+APd
   UvSUY0kg9yVO/G1BZLFTiKvK04tCkkuOTqVJk6W4RQSSZonGQUiqJ2aUd
   1YEIbizkWyTl+N0/YjBc6X+zlehamuvRcPp5xU+bapciiOdZISkm4WQHg
   8Xg7INvvBaotHLZm0zFqHCRUwM+YvtI23LJiFfRC81tzhz+7yZ/0ZYv78
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="310640863"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="310640863"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 00:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="619110856"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2022 00:54:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nE5yc-000QHY-79; Sun, 30 Jan 2022 08:54:26 +0000
Date:   Sun, 30 Jan 2022 16:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/4.14 9175/9999]
 arch/xtensa/platforms/xtfpga/include/platform/hardware.h:59:26: error:
 initializer element is not constant
Message-ID: <202201301621.BORpg7L3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.14
head:   113f0cfeac7f8d899386af2e8e47edba426d9fd3
commit: fe700bd139564d097d1ebed90da637b80bd7f5c1 [9175/9999] xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF
config: xtensa-randconfig-r005-20220130 (https://download.01.org/0day-ci/archive/20220130/202201301621.BORpg7L3-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=fe700bd139564d097d1ebed90da637b80bd7f5c1
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.14
        git checkout fe700bd139564d097d1ebed90da637b80bd7f5c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

                           ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:59:36: note: in expansion of macro 'unlikely'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                       ^~~~~~~~
   include/linux/dma-mapping.h:327:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
     ^~~~~~
   include/linux/dma-mapping.h:327:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   arch/xtensa/include/asm/page.h:185:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
     ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
            ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   include/asm-generic/bug.h:59:32: note: in expansion of macro 'if'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                   ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
    #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
                           ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:59:36: note: in expansion of macro 'unlikely'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                       ^~~~~~~~
   include/linux/dma-mapping.h:327:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
     ^~~~~~
   include/linux/dma-mapping.h:327:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   arch/xtensa/include/asm/page.h:185:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
     ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
            ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   include/asm-generic/bug.h:59:32: note: in expansion of macro 'if'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                   ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
    #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
                           ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:59:36: note: in expansion of macro 'unlikely'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                       ^~~~~~~~
   include/linux/dma-mapping.h:327:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
     ^~~~~~
   include/linux/dma-mapping.h:327:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   arch/xtensa/include/asm/page.h:185:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
     ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
            ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   include/asm-generic/bug.h:59:32: note: in expansion of macro 'if'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                   ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
    #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
                           ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:59:36: note: in expansion of macro 'unlikely'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                       ^~~~~~~~
   include/linux/dma-mapping.h:327:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
     ^~~~~~
   include/linux/dma-mapping.h:327:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   arch/xtensa/include/asm/page.h:185:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
     ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
            ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   include/asm-generic/bug.h:59:32: note: in expansion of macro 'if'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                   ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
    #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
                           ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:59:36: note: in expansion of macro 'unlikely'
    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                       ^~~~~~~~
   include/linux/dma-mapping.h:327:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
     ^~~~~~
   include/linux/dma-mapping.h:327:9: note: in expansion of macro 'pfn_valid'
     BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
            ^~~~~~~~~
   In file included from arch/xtensa/include/asm/processor.h:14:0,
                    from arch/xtensa/include/asm/bitops.h:22,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from arch/xtensa/platforms/xtfpga/setup.c:19:
   arch/xtensa/platforms/xtfpga/setup.c: At top level:
>> arch/xtensa/platforms/xtfpga/include/platform/hardware.h:59:26: error: initializer element is not constant
    #define OETH_REGS_PADDR  (XCHAL_KIO_PADDR + 0x0D030000)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:168:12: note: in expansion of macro 'OETH_REGS_PADDR'
      .start = OETH_REGS_PADDR,
               ^~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:59:26: note: (near initialization for 'ethoc_res[0].start')
    #define OETH_REGS_PADDR  (XCHAL_KIO_PADDR + 0x0D030000)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:168:12: note: in expansion of macro 'OETH_REGS_PADDR'
      .start = OETH_REGS_PADDR,
               ^~~~~~~~~~~~~~~
>> arch/xtensa/platforms/xtfpga/include/platform/hardware.h:59:26: error: initializer element is not constant
    #define OETH_REGS_PADDR  (XCHAL_KIO_PADDR + 0x0D030000)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:169:12: note: in expansion of macro 'OETH_REGS_PADDR'
      .end   = OETH_REGS_PADDR + OETH_REGS_SIZE - 1,
               ^~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:59:26: note: (near initialization for 'ethoc_res[0].end')
    #define OETH_REGS_PADDR  (XCHAL_KIO_PADDR + 0x0D030000)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:169:12: note: in expansion of macro 'OETH_REGS_PADDR'
      .end   = OETH_REGS_PADDR + OETH_REGS_SIZE - 1,
               ^~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:61:29: error: initializer element is not constant
    #define OETH_SRAMBUFF_PADDR (XCHAL_KIO_PADDR + 0x0D800000)
                                ^
   arch/xtensa/platforms/xtfpga/setup.c:173:12: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
      .start = OETH_SRAMBUFF_PADDR,
               ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:61:29: note: (near initialization for 'ethoc_res[1].start')
    #define OETH_SRAMBUFF_PADDR (XCHAL_KIO_PADDR + 0x0D800000)
                                ^
   arch/xtensa/platforms/xtfpga/setup.c:173:12: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
      .start = OETH_SRAMBUFF_PADDR,
               ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:61:29: error: initializer element is not constant
    #define OETH_SRAMBUFF_PADDR (XCHAL_KIO_PADDR + 0x0D800000)
                                ^
   arch/xtensa/platforms/xtfpga/setup.c:174:12: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
      .end   = OETH_SRAMBUFF_PADDR + OETH_SRAMBUFF_SIZE - 1,
               ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:61:29: note: (near initialization for 'ethoc_res[1].end')
    #define OETH_SRAMBUFF_PADDR (XCHAL_KIO_PADDR + 0x0D800000)
                                ^
   arch/xtensa/platforms/xtfpga/setup.c:174:12: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
      .end   = OETH_SRAMBUFF_PADDR + OETH_SRAMBUFF_SIZE - 1,
               ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:66:23: error: initializer element is not constant
    #define C67X00_PADDR  (XCHAL_KIO_PADDR + 0x0D0D0000)
                          ^
   arch/xtensa/platforms/xtfpga/setup.c:211:12: note: in expansion of macro 'C67X00_PADDR'
      .start = C67X00_PADDR,
               ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:66:23: note: (near initialization for 'c67x00_res[0].start')
    #define C67X00_PADDR  (XCHAL_KIO_PADDR + 0x0D0D0000)
                          ^
   arch/xtensa/platforms/xtfpga/setup.c:211:12: note: in expansion of macro 'C67X00_PADDR'
      .start = C67X00_PADDR,
               ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:66:23: error: initializer element is not constant
    #define C67X00_PADDR  (XCHAL_KIO_PADDR + 0x0D0D0000)
                          ^
   arch/xtensa/platforms/xtfpga/setup.c:212:12: note: in expansion of macro 'C67X00_PADDR'
      .end   = C67X00_PADDR + C67X00_SIZE - 1,
               ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:66:23: note: (near initialization for 'c67x00_res[0].end')
    #define C67X00_PADDR  (XCHAL_KIO_PADDR + 0x0D0D0000)
                          ^
   arch/xtensa/platforms/xtfpga/setup.c:212:12: note: in expansion of macro 'C67X00_PADDR'
      .end   = C67X00_PADDR + C67X00_SIZE - 1,
               ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:46:26: error: initializer element is not constant
    #define DUART16552_PADDR (XCHAL_KIO_PADDR + 0x0D050020)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:242:11: note: in expansion of macro 'DUART16552_PADDR'
     .start = DUART16552_PADDR,
              ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:46:26: note: (near initialization for 'serial_resource.start')
    #define DUART16552_PADDR (XCHAL_KIO_PADDR + 0x0D050020)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:242:11: note: in expansion of macro 'DUART16552_PADDR'
     .start = DUART16552_PADDR,
              ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:46:26: error: initializer element is not constant
    #define DUART16552_PADDR (XCHAL_KIO_PADDR + 0x0D050020)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:243:9: note: in expansion of macro 'DUART16552_PADDR'
     .end = DUART16552_PADDR + 0x1f,
            ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:46:26: note: (near initialization for 'serial_resource.end')
    #define DUART16552_PADDR (XCHAL_KIO_PADDR + 0x0D050020)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:243:9: note: in expansion of macro 'DUART16552_PADDR'
     .end = DUART16552_PADDR + 0x1f,
            ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:46:26: error: initializer element is not constant
    #define DUART16552_PADDR (XCHAL_KIO_PADDR + 0x0D050020)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:249:14: note: in expansion of macro 'DUART16552_PADDR'
      .mapbase = DUART16552_PADDR,
                 ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:46:26: note: (near initialization for 'serial_platform_data[0].mapbase')
    #define DUART16552_PADDR (XCHAL_KIO_PADDR + 0x0D050020)
                             ^
   arch/xtensa/platforms/xtfpga/setup.c:249:14: note: in expansion of macro 'DUART16552_PADDR'
      .mapbase = DUART16552_PADDR,
                 ^~~~~~~~~~~~~~~~


vim +59 arch/xtensa/platforms/xtfpga/include/platform/hardware.h

0d456bad36d42d Max Filippov 2012-11-05  56  
0d456bad36d42d Max Filippov 2012-11-05  57  /*  OpenCores Ethernet controller:  */
0d456bad36d42d Max Filippov 2012-11-05  58  				/* regs + RX/TX descriptors */
0d456bad36d42d Max Filippov 2012-11-05 @59  #define OETH_REGS_PADDR		(XCHAL_KIO_PADDR + 0x0D030000)
0d456bad36d42d Max Filippov 2012-11-05  60  #define OETH_REGS_SIZE		0x1000
0d456bad36d42d Max Filippov 2012-11-05  61  #define OETH_SRAMBUFF_PADDR	(XCHAL_KIO_PADDR + 0x0D800000)
0d456bad36d42d Max Filippov 2012-11-05  62  
0d456bad36d42d Max Filippov 2012-11-05  63  				/* 5*rx buffs + 5*tx buffs */
0d456bad36d42d Max Filippov 2012-11-05  64  #define OETH_SRAMBUFF_SIZE	(5 * 0x600 + 5 * 0x600)
0d456bad36d42d Max Filippov 2012-11-05  65  

:::::: The code at line 59 was first introduced by commit
:::::: 0d456bad36d42d16022be045c8a53ddbb59ee478 xtensa: add support for the XTFPGA boards

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Chris Zankel <chris@zankel.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
