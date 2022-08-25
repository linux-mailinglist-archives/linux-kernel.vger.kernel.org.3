Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749835A19B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbiHYTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243705AbiHYTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:40:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BC241
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661456439; x=1692992439;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EOa6ND6Ltnmgvme/ttM7yj9G9HApCZo+GVDFgJcozXA=;
  b=d7DALJoFugzj5YOTS7VYOpga5WOC6kf0UQjmpZlhLkGz955KniHP9vJJ
   DfCFAFZhCpr2tRMygPqE+0UibbyDAQ82KxmGgWiX7ooE3DrlngJF8vxPF
   S5ia7/RcjtLJDlrG2zA/VwI91Pj5nOvf/Ie9oyslgJ8Vt0bQ4ILNKJ633
   briaoU54e7VstE4WmGANIUQsWJSr8jGkWPUqSGpjABCHC2boq0ykl9I6z
   92juzR7Jk+C+uBo9r26+99QZ42mvir03OIwWFqcCjC1xjjKAHOiGpOzlh
   2dM+trBp9/gFNg/AcyHdkal2t3K3Rps3XQ/q/rz7iV0hKHqa4v8N6X8ti
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320430964"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="320430964"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 12:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="643382723"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2022 12:40:36 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRIiS-0002o3-0M;
        Thu, 25 Aug 2022 19:40:36 +0000
Date:   Fri, 26 Aug 2022 03:40:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.14.y 433/2972]
 arch/xtensa/platforms/xtfpga/include/platform/hardware.h:59:26: error:
 initializer element is not constant
Message-ID: <202208260355.edDfrXLE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
head:   e548869f356fead9fdcb3562f52d2226574f4f41
commit: fe700bd139564d097d1ebed90da637b80bd7f5c1 [433/2972] xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF
config: xtensa-randconfig-r006-20220823 (https://download.01.org/0day-ci/archive/20220826/202208260355.edDfrXLE-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=fe700bd139564d097d1ebed90da637b80bd7f5c1
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.14.y
        git checkout fe700bd139564d097d1ebed90da637b80bd7f5c1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from arch/xtensa/platforms/xtfpga/setup.c:19:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/xtensa/include/asm/page.h:185:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
     ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
            ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
