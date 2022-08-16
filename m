Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54AB5955B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiHPI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiHPIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:55:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A81272F9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660633432; x=1692169432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Jlr1lkYL2+ZgIusPy2E77CCmwFY6pfAfEw+Lw4fddQ=;
  b=DYlydjPQrqyv+X3cutnVR8sHzGyBXarSqjSJrHI2OnXk+OTo/1daTYjb
   MGryLtnTBR617R6NqHTD7VUfPW4frO+EgI1VqMEM5eCnyHmlZFIyKm38m
   dUYaFuhJ/WsWrpnY53RVlWAmOH8qJX2mgKvlmve1hnQFq/4Gix2QbGKuk
   rPe2m18a+S3DSKXUq1YyxSJSaAY7J/sEqHZ/jP3joGsWGNCQGHd5KYzWK
   4Nqvk1Uy860Yo3QYLpGLyu882/bcu9oLAgt1NpcktEkrgzKP/VHG+r0hW
   SexCfHuf4zp9/6oaaiMEvfNOns/F5LWkHRfevZKf8tFYgh4kbfJHsbIKG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290897136"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="290897136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 00:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="675105313"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 00:03:49 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNqc8-0001aa-2J;
        Tue, 16 Aug 2022 07:03:48 +0000
Date:   Tue, 16 Aug 2022 15:03:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     kbuild-all@lists.01.org, linux-m68k@lists.linux-m68k.org,
        uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: [gerg-m68knommu:armnommu 3/3]
 arch/arm/include/asm/glue-cache.h:126:2: error: #error Unknown cache
 maintenance model
Message-ID: <202208161505.XIfrS8UL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git armnommu
head:   561378477b321d37f9e64540bf7aae6dbc4f1766
commit: 561378477b321d37f9e64540bf7aae6dbc4f1766 [3/3] ARM: versatile: support configuring versatile machine for no-MMU
config: arm-randconfig-s052-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161505.XIfrS8UL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git/commit/?id=561378477b321d37f9e64540bf7aae6dbc4f1766
        git remote add gerg-m68knommu https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
        git fetch --no-tags gerg-m68knommu armnommu
        git checkout 561378477b321d37f9e64540bf7aae6dbc4f1766
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |       ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:11,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14:
   arch/arm/include/asm/barrier.h: At top level:
   arch/arm/include/asm/barrier.h:9:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
       9 | #if __LINUX_ARM_ARCH__ >= 7 ||          \
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/barrier.h:10:10: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      10 |         (__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
         |          ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/barrier.h:18:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      18 | #if __LINUX_ARM_ARCH__ >= 7
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/barrier.h:28:35: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      28 | #elif defined(CONFIG_CPU_XSC3) || __LINUX_ARM_ARCH__ == 6
         |                                   ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/processor.h:17,
                    from include/linux/prefetch.h:15,
                    from arch/arm/include/asm/atomic.h:12,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11:
   arch/arm/include/asm/vdso/processor.h:10:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      10 | #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/processor.h:110:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     110 | #if __LINUX_ARM_ARCH__ >= 5
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16,
                    from arch/arm/include/asm/atomic.h:14:
   arch/arm/include/asm/irqflags.h:22:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      22 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/atomic.h:16:
   arch/arm/include/asm/cmpxchg.h: In function '__xchg':
   arch/arm/include/asm/cmpxchg.h:35:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      35 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cmpxchg.h:42:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      42 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cmpxchg.h: At top level:
   arch/arm/include/asm/cmpxchg.h:124:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     124 | #if __LINUX_ARM_ARCH__ < 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/atomic.h:28:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      28 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/swab.h:19,
                    from include/uapi/linux/swab.h:8,
                    from include/linux/swab.h:5,
                    from arch/arm/include/asm/opcodes.h:86,
                    from arch/arm/include/asm/bug.h:7,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27:
   arch/arm/include/uapi/asm/swab.h:27:29: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      27 | #if !defined(__KERNEL__) || __LINUX_ARM_ARCH__ < 6
         |                             ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/swab.h:21:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      21 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitops.h:67,
                    from include/linux/thread_info.h:27:
   arch/arm/include/asm/bitops.h:218:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     218 | #if __LINUX_ARM_ARCH__ < 5
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/thread_info.h:13,
                    from include/linux/thread_info.h:60:
   arch/arm/include/asm/fpstate.h:29:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      29 | #if __LINUX_ARM_ARCH__ < 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:703,
                    from arch/arm/kernel/asm-offsets.c:12:
   arch/arm/include/asm/uaccess.h:302:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     302 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:404:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     404 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from arch/arm/kernel/asm-offsets.c:13:
   arch/arm/include/asm/io.h:53:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      53 | #if __LINUX_ARM_ARCH__ < 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/cacheflush.h:12,
                    from arch/arm/kernel/asm-offsets.c:14:
>> arch/arm/include/asm/glue-cache.h:126:2: error: #error Unknown cache maintenance model
     126 | #error Unknown cache maintenance model
         |  ^~~~~
   In file included from arch/arm/include/asm/cacheflush.h:14:
   arch/arm/include/asm/cachetype.h:29:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      29 | #if __LINUX_ARM_ARCH__ >= 7
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cachetype.h:34:7: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      34 | #elif __LINUX_ARM_ARCH__ >= 6
         |       ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cacheflush.h:197:7: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     197 | #elif __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
         |       ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cacheflush.h:199:7: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     199 | #elif __LINUX_ARM_ARCH__ == 6 && defined(CONFIG_ARM_ERRATA_411920)
         |       ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/asm-offsets.c:16:
>> arch/arm/include/asm/glue-df.h:96:2: error: #error Unknown data abort handler type
      96 | #error Unknown data abort handler type
         |  ^~~~~
   In file included from arch/arm/kernel/asm-offsets.c:17:
>> arch/arm/include/asm/glue-pf.h:51:2: error: #error Unknown prefetch abort handler type
      51 | #error Unknown prefetch abort handler type
         |  ^~~~~
   make[2]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1207: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +126 arch/arm/include/asm/glue-cache.h

55bdd694116597 Catalin Marinas 2010-05-21  124  
753790e713d80b Russell King    2011-02-06  125  #if !defined(_CACHE) && !defined(MULTI_CACHE)
25985edcedea63 Lucas De Marchi 2011-03-30 @126  #error Unknown cache maintenance model
753790e713d80b Russell King    2011-02-06  127  #endif
753790e713d80b Russell King    2011-02-06  128  

:::::: The code at line 126 was first introduced by commit
:::::: 25985edcedea6396277003854657b5f3cb31a628 Fix common misspellings

:::::: TO: Lucas De Marchi <lucas.demarchi@profusion.mobi>
:::::: CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
