Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAABF596628
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiHPXuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHPXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:50:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2847CA81
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660693807; x=1692229807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tGps2aTVF9RdxlBoZb+4BkVS5YWixN7iaKDPAl1LHcs=;
  b=Y0DEGQMppdPIBo4lLtcTooXxIIjYBPdaaPJLuo8SplubRp5mjYKryCj2
   IpGaRBUI8MBygVeQU02Wp7JBJuzqUwrOqfF1KpHLeF2Dv7MY2XCeFBy8Q
   4BVfP5BejkZ+/fsznRWsSzOfltME1LfVzFwWt2EmFJ0f4gVU4MdOjKpdZ
   yceRGnke+s4QbLGhTDJjmQvQysD+LOaS6rTf9BjYOZw4CZ4btjGdcwqYa
   XxTouxiHyseP0mAe0+ag9eXIhLjDftWSKscZAtY2xtV969mraaWTDg60J
   akPdO9gvLCqk4de7I1xIMuNpIkhtUjS3T7/GH/PKpMFQC0wHFioQIhaj6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="275412519"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="275412519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 16:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="749500266"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 16:50:04 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO6Jv-0000LM-2f;
        Tue, 16 Aug 2022 23:50:03 +0000
Date:   Wed, 17 Aug 2022 07:49:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org,
        linux-kernel@vger.kernel.org
Subject: [gerg-m68knommu:armnommu 3/3]
 arch/arm/include/asm/glue-cache.h:126:2: error: Unknown cache maintenance
 model
Message-ID: <202208170737.9JNNRaxw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git armnommu
head:   561378477b321d37f9e64540bf7aae6dbc4f1766
commit: 561378477b321d37f9e64540bf7aae6dbc4f1766 [3/3] ARM: versatile: support configuring versatile machine for no-MMU
config: arm-randconfig-r035-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170737.9JNNRaxw-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6afcc4a459ead8809a0d6d9b4bf7b64bcc13582b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git/commit/?id=561378477b321d37f9e64540bf7aae6dbc4f1766
        git remote add gerg-m68knommu https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
        git fetch --no-tags gerg-m68knommu armnommu
        git checkout 561378477b321d37f9e64540bf7aae6dbc4f1766
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:25:
   In file included from include/linux/atomic.h:7:
   arch/arm/include/asm/atomic.h:28:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ >= 6
       ^
   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/arm/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:13:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm/include/asm/bug.h:7:
   In file included from arch/arm/include/asm/opcodes.h:86:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   In file included from arch/arm/include/asm/swab.h:19:
   arch/arm/include/uapi/asm/swab.h:27:29: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if !defined(__KERNEL__) || __LINUX_ARM_ARCH__ < 6
                               ^
   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/arm/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:13:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm/include/asm/bug.h:7:
   In file included from arch/arm/include/asm/opcodes.h:86:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/arm/include/asm/swab.h:21:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ >= 6
       ^
   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/arm/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:14:
   In file included from include/linux/restart_block.h:10:
   In file included from include/linux/time64.h:5:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:6:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:67:
   arch/arm/include/asm/bitops.h:218:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ < 5
       ^
   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/arm/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/arm/include/asm/thread_info.h:13:
   arch/arm/include/asm/fpstate.h:29:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ < 6
       ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:703:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   arch/arm/include/asm/uaccess.h:302:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ >= 6
       ^
   arch/arm/include/asm/uaccess.h:404:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ >= 6
       ^
   In file included from arch/arm/kernel/asm-offsets.c:13:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   arch/arm/include/asm/io.h:53:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ < 6
       ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from arch/arm/include/asm/cacheflush.h:12:
>> arch/arm/include/asm/glue-cache.h:126:2: error: Unknown cache maintenance model
   #error Unknown cache maintenance model
    ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from arch/arm/include/asm/cacheflush.h:14:
   arch/arm/include/asm/cachetype.h:29:5: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #if __LINUX_ARM_ARCH__ >= 7
       ^
   arch/arm/include/asm/cachetype.h:34:7: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #elif __LINUX_ARM_ARCH__ >= 6
         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   arch/arm/include/asm/cacheflush.h:197:7: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #elif __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
         ^
   arch/arm/include/asm/cacheflush.h:199:7: warning: '__LINUX_ARM_ARCH__' is not defined, evaluates to 0 [-Wundef]
   #elif __LINUX_ARM_ARCH__ == 6 && defined(CONFIG_ARM_ERRATA_411920)
         ^
   In file included from arch/arm/kernel/asm-offsets.c:16:
>> arch/arm/include/asm/glue-df.h:96:2: error: Unknown data abort handler type
   #error Unknown data abort handler type
    ^
   In file included from arch/arm/kernel/asm-offsets.c:17:
>> arch/arm/include/asm/glue-pf.h:51:2: error: Unknown prefetch abort handler type
   #error Unknown prefetch abort handler type
    ^
   24 warnings and 3 errors generated.
   make[2]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1207: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +126 arch/arm/include/asm/glue-cache.h

55bdd694116597d Catalin Marinas 2010-05-21  124  
753790e713d80b5 Russell King    2011-02-06  125  #if !defined(_CACHE) && !defined(MULTI_CACHE)
25985edcedea639 Lucas De Marchi 2011-03-30 @126  #error Unknown cache maintenance model
753790e713d80b5 Russell King    2011-02-06  127  #endif
753790e713d80b5 Russell King    2011-02-06  128  

:::::: The code at line 126 was first introduced by commit
:::::: 25985edcedea6396277003854657b5f3cb31a628 Fix common misspellings

:::::: TO: Lucas De Marchi <lucas.demarchi@profusion.mobi>
:::::: CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
