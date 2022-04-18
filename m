Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524C3505F77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiDRVkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiDRVkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:40:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225582ED66
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650317880; x=1681853880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4/f0iZ7b4EnW1SyqylgKzUT4AANefuPo65Vx/Y0Sass=;
  b=Y0qw0Qcf5ntc0iDg6+qc47qSw/U0Cf1Uc/7+GMx4//EA54Fg90gpQ2Kq
   pg9N7rjvF6OJnbL9M4NAzi0XchQ56oszFxg1+Hmqo0C+L0VIEqk0KNhlQ
   19NQlZ/63pklEsVaja6CNphzZ3XUBO5jQucf01NhUtmU+dra61k2x5BZy
   DZL+KuisEvMaEoKA2dFyDe0mTvo0vGvNR8Hy7XYY2nlXXZ8AwANiYKNZR
   ijPNn+PefMPbobzdLlZB0NR87XOAmUuyW9aAaCIHBqtimqLfXo8cKM3Ha
   I8IcFkLflqkJFmg02PPx8Cm9D5h+1kQEp3HKGPrwIw1YFSYXoBUGgOIf0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="243547498"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="243547498"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="860340400"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Apr 2022 14:37:58 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngZ4H-00050w-TP;
        Mon, 18 Apr 2022 21:37:57 +0000
Date:   Tue, 19 Apr 2022 05:37:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2222/2356]
 arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared;
 did you mean 'BITS_PER_LONG'?
Message-ID: <202204190552.wqcl0paa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 1ac8ecdc4e754e164da21a64b262f7b0f097010f [2222/2356] headers/deps: bvec: Reduce <linux/bvec.h> dependencies, remove <linux/bvec_api.h> inclusion
config: powerpc-randconfig-m031-20220417 (https://download.01.org/0day-ci/archive/20220419/202204190552.wqcl0paa-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=1ac8ecdc4e754e164da21a64b262f7b0f097010f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 1ac8ecdc4e754e164da21a64b262f7b0f097010f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic_api.h:8,
                    from include/linux/jump_label.h:257,
                    from include/linux/page-flags.h:9,
                    from kernel/bounds.c:12:
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u8_local':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:22:18: note: in expansion of macro 'BITOFF_CAL'
      22 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:80:1: note: in expansion of macro 'XCHG_GEN'
      80 | XCHG_GEN(u8, _local, "memory");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:11:63: note: each undeclared identifier is reported only once for each function it appears in
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:22:18: note: in expansion of macro 'BITOFF_CAL'
      22 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:80:1: note: in expansion of macro 'XCHG_GEN'
      80 | XCHG_GEN(u8, _local, "memory");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u8_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:22:18: note: in expansion of macro 'BITOFF_CAL'
      22 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:81:1: note: in expansion of macro 'XCHG_GEN'
      81 | XCHG_GEN(u8, _relaxed, "cc");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u16_local':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:22:18: note: in expansion of macro 'BITOFF_CAL'
      22 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:82:1: note: in expansion of macro 'XCHG_GEN'
      82 | XCHG_GEN(u16, _local, "memory");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u16_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:22:18: note: in expansion of macro 'BITOFF_CAL'
      22 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:83:1: note: in expansion of macro 'XCHG_GEN'
      83 | XCHG_GEN(u16, _relaxed, "cc");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:206:1: note: in expansion of macro 'CMPXCHG_GEN'
     206 | CMPXCHG_GEN(u8, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8_local':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:207:1: note: in expansion of macro 'CMPXCHG_GEN'
     207 | CMPXCHG_GEN(u8, _local, , , "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8_acquire':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:208:1: note: in expansion of macro 'CMPXCHG_GEN'
     208 | CMPXCHG_GEN(u8, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:209:1: note: in expansion of macro 'CMPXCHG_GEN'
     209 | CMPXCHG_GEN(u8, _relaxed, , , "cc");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:210:1: note: in expansion of macro 'CMPXCHG_GEN'
     210 | CMPXCHG_GEN(u16, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16_local':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:211:1: note: in expansion of macro 'CMPXCHG_GEN'
     211 | CMPXCHG_GEN(u16, _local, , , "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16_acquire':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:212:1: note: in expansion of macro 'CMPXCHG_GEN'
     212 | CMPXCHG_GEN(u16, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:11:63: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      11 | #define BITOFF_CAL(size, off)   ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                               ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:47:18: note: in expansion of macro 'BITOFF_CAL'
      47 |         bitoff = BITOFF_CAL(sizeof(type), off);                 \
         |                  ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:213:1: note: in expansion of macro 'CMPXCHG_GEN'
     213 | CMPXCHG_GEN(u16, _relaxed, , , "cc");
         | ^~~~~~~~~~~
   In file included from include/linux/mm_types.h:7,
                    from include/linux/mm_page_address.h:14,
                    from include/asm-generic/memory_model.h:14,
                    from arch/powerpc/include/asm/page.h:334,
                    from arch/powerpc/include/asm/thread_info.h:13,
                    from include/linux/thread_info.h:63,
                    from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic_api.h:8,
                    from include/linux/jump_label.h:257,
                    from include/linux/page-flags.h:9,
                    from kernel/bounds.c:12:
   include/linux/mm_types_task.h: At top level:
   include/linux/mm_types_task.h:11:10: fatal error: generated/bounds.h: No such file or directory
      11 | #include <generated/bounds.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:120: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +11 arch/powerpc/include/asm/cmpxchg.h

ae3a197e3d0bfe David Howells 2012-03-28   9  
d0563a1297e234 Pan Xinhui    2016-04-27  10  #ifdef __BIG_ENDIAN
d0563a1297e234 Pan Xinhui    2016-04-27 @11  #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
d0563a1297e234 Pan Xinhui    2016-04-27  12  #else
d0563a1297e234 Pan Xinhui    2016-04-27  13  #define BITOFF_CAL(size, off)	(off * BITS_PER_BYTE)
d0563a1297e234 Pan Xinhui    2016-04-27  14  #endif
d0563a1297e234 Pan Xinhui    2016-04-27  15  

:::::: The code at line 11 was first introduced by commit
:::::: d0563a1297e234ed37f6b51c2e9321accebd1839 powerpc: Implement {cmp}xchg for u8 and u16

:::::: TO: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
