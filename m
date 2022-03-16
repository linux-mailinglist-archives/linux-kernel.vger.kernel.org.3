Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADED74DAA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353676AbiCPFtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiCPFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:49:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44720E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647409666; x=1678945666;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tOB59a+wtlGrYXv96rvzF3ToAPe+XHNOqF1O3L7x/Bw=;
  b=YIoUqBozrUfBcnHp09lmk8vM15hwi682gC7kBhCtpbs+xBpsHlBeiYR7
   2ZQHxJFN+3pwT8zgAMeC0Se+0CsUrehepUIwuvOesuyrWUthbAZ+Pdfo4
   gTvL52CwgKXIaHjHMJI2H7sPKvuwyeDJ4Fng0z9QsxVYwf6eb1aeCwzaL
   oAxO6gpNmcXDyKdND1pxwYn2TtHnArndFioy0qx0iFtwNSD6bDCnWLd2m
   Npt6ZBB4XKZll/glaReXE8MQX3pGwSSe80P0DfX7ld6XdoDYasKyQWDt1
   nw/oYWPpFqKBId11OnIukn/zvNcRITrwcCNlkYxPuyim8mvh07QwHkc53
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="237106844"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="237106844"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 22:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="714463620"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 22:47:42 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUMVZ-000C2g-OB; Wed, 16 Mar 2022 05:47:41 +0000
Date:   Wed, 16 Mar 2022 13:47:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Swathi Sridhar <swatsrid@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Prakash Gupta <guptap@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 464/9999] drivers/iommu/io-pgtable-arm.c:241:48: error: expected ')' before
 'table_pte'
Message-ID: <202203161322.YnbEPtC7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   5b194414a86d3b098004ed42b64152b41940baf7
commit: 27de1978c331d4e7571a5d0187ef1802d65dbf65 [464/9999] ANDROID: GKI: iommu/io-pgtable-arm: LPAE related updates by vendor
config: sparc-buildonly-randconfig-r001-20220314 (https://download.01.org/0day-ci/archive/20220316/202203161322.YnbEPtC7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/27de1978c331d4e7571a5d0187ef1802d65dbf65
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 27de1978c331d4e7571a5d0187ef1802d65dbf65
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/linux/dma-mapping.h:628:17: note: in expansion of macro 'WARN_ONCE'
     628 |                 WARN_ONCE(1, "Remap function not implemented for %pS\n",
         |                 ^~~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:134:9: note: in expansion of macro 'if'
     134 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/asm-generic/bug.h:166:17: note: in expansion of macro 'WARN'
     166 |                 WARN(1, format);                                \
         |                 ^~~~
   include/linux/dma-mapping.h:628:17: note: in expansion of macro 'WARN_ONCE'
     628 |                 WARN_ONCE(1, "Remap function not implemented for %pS\n",
         |                 ^~~~~~~~~
   include/linux/dma-mapping.h: In function 'dma_unremap':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/asm-generic/bug.h:164:9: note: in expansion of macro 'if'
     164 |         if (unlikely(__ret_warn_once && !__warned)) {           \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:164:13: note: in expansion of macro 'unlikely'
     164 |         if (unlikely(__ret_warn_once && !__warned)) {           \
         |             ^~~~~~~~
   include/linux/dma-mapping.h:643:17: note: in expansion of macro 'WARN_ONCE'
     643 |                 WARN_ONCE(1, "unremap function not implemented for %pS\n",
         |                 ^~~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:164:9: note: in expansion of macro 'if'
     164 |         if (unlikely(__ret_warn_once && !__warned)) {           \
         |         ^~
   include/linux/dma-mapping.h:643:17: note: in expansion of macro 'WARN_ONCE'
     643 |                 WARN_ONCE(1, "unremap function not implemented for %pS\n",
         |                 ^~~~~~~~~
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/asm-generic/bug.h:134:9: note: in expansion of macro 'if'
     134 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:134:13: note: in expansion of macro 'unlikely'
     134 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   include/asm-generic/bug.h:166:17: note: in expansion of macro 'WARN'
     166 |                 WARN(1, format);                                \
         |                 ^~~~
   include/linux/dma-mapping.h:643:17: note: in expansion of macro 'WARN_ONCE'
     643 |                 WARN_ONCE(1, "unremap function not implemented for %pS\n",
         |                 ^~~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:134:9: note: in expansion of macro 'if'
     134 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/asm-generic/bug.h:166:17: note: in expansion of macro 'WARN'
     166 |                 WARN(1, format);                                \
         |                 ^~~~
   include/linux/dma-mapping.h:643:17: note: in expansion of macro 'WARN_ONCE'
     643 |                 WARN_ONCE(1, "unremap function not implemented for %pS\n",
         |                 ^~~~~~~~~
   In file included from arch/sparc/include/asm/page.h:8,
                    from arch/sparc/include/asm/thread_info_64.h:27,
                    from arch/sparc/include/asm/thread_info.h:5,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/scatterlist.h:8,
                    from include/linux/iommu.h:22,
                    from drivers/iommu/io-pgtable-arm.c:25:
   drivers/iommu/io-pgtable-arm.c: At top level:
>> drivers/iommu/io-pgtable-arm.c:241:48: error: expected ')' before 'table_pte'
     241 | static arm_lpae_iopte iopte_val(arm_lpae_iopte table_pte)
         |                                                ^~~~~~~~~
   arch/sparc/include/asm/page_64.h:77:27: note: in definition of macro 'iopte_val'
      77 | #define iopte_val(x)    ((x).iopte)
         |                           ^
>> arch/sparc/include/asm/page_64.h:77:29: error: expected ')' before '.' token
      77 | #define iopte_val(x)    ((x).iopte)
         |                             ^
   drivers/iommu/io-pgtable-arm.c:241:23: note: in expansion of macro 'iopte_val'
     241 | static arm_lpae_iopte iopte_val(arm_lpae_iopte table_pte)
         |                       ^~~~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function 'iopte_tblcnt_set':
>> arch/sparc/include/asm/page_64.h:77:29: error: request for member 'iopte' in something not a structure or union
      77 | #define iopte_val(x)    ((x).iopte)
         |                             ^
   drivers/iommu/io-pgtable-arm.c:266:30: note: in expansion of macro 'iopte_val'
     266 |         arm_lpae_iopte pte = iopte_val(*table_pte);
         |                              ^~~~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function '__arm_lpae_alloc_pages':
   drivers/iommu/io-pgtable-arm.c:312:23: error: implicit declaration of function 'io_pgtable_alloc_pages_exact' [-Werror=implicit-function-declaration]
     312 |         void *pages = io_pgtable_alloc_pages_exact(cfg, cookie, size,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:312:23: warning: initialization of 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/iommu/io-pgtable-arm.c:337:9: error: implicit declaration of function 'io_pgtable_free_pages_exact' [-Werror=implicit-function-declaration]
     337 |         io_pgtable_free_pages_exact(cfg, cookie, pages, size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/barrier.h:20,
                    from arch/sparc/include/asm/barrier_64.h:59,
                    from arch/sparc/include/asm/barrier.h:5,
                    from arch/sparc/include/asm/atomic_64.h:13,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from drivers/iommu/io-pgtable-arm.c:23:
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_init_pte':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/asm-generic/bug.h:134:9: note: in expansion of macro 'if'
     134 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:134:13: note: in expansion of macro 'unlikely'
     134 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   include/linux/ratelimit.h:107:19: note: in expansion of macro 'WARN'
     107 |         int rtn = WARN(condition, format, ##__VA_ARGS__);       \
         |                   ^~~~
   drivers/iommu/io-pgtable-arm.c:405:17: note: in expansion of macro 'WARN_RATELIMIT'
     405 |                 WARN_RATELIMIT(1, "map without unmap\n");
         |                 ^~~~~~~~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:134:9: note: in expansion of macro 'if'
     134 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/ratelimit.h:107:19: note: in expansion of macro 'WARN'
     107 |         int rtn = WARN(condition, format, ##__VA_ARGS__);       \
         |                   ^~~~
   drivers/iommu/io-pgtable-arm.c:405:17: note: in expansion of macro 'WARN_RATELIMIT'
     405 |                 WARN_RATELIMIT(1, "map without unmap\n");
         |                 ^~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function '__arm_lpae_map':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:37: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                     ^~~~
   drivers/iommu/io-pgtable-arm.c:515:9: note: in expansion of macro 'if'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |         ^~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:125:9: note: in expansion of macro 'if'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:125:13: note: in expansion of macro 'unlikely'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:515:13: note: in expansion of macro 'WARN_ON'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |             ^~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:58:37: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                     ^~~~
   drivers/iommu/io-pgtable-arm.c:515:9: note: in expansion of macro 'if'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |         ^~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:125:9: note: in expansion of macro 'if'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   drivers/iommu/io-pgtable-arm.c:515:13: note: in expansion of macro 'WARN_ON'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |             ^~~~~~~
--
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:125:13: note: in expansion of macro 'unlikely'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:515:13: note: in expansion of macro 'WARN_ON'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |             ^~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:515:9: note: in expansion of macro 'if'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |         ^~
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   drivers/iommu/io-pgtable-arm.c:515:9: note: in expansion of macro 'if'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |         ^~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:125:9: note: in expansion of macro 'if'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:125:13: note: in expansion of macro 'unlikely'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:515:13: note: in expansion of macro 'WARN_ON'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |             ^~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   drivers/iommu/io-pgtable-arm.c:515:9: note: in expansion of macro 'if'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |         ^~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:125:9: note: in expansion of macro 'if'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   drivers/iommu/io-pgtable-arm.c:515:13: note: in expansion of macro 'WARN_ON'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |             ^~~~~~~
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   drivers/iommu/io-pgtable-arm.c:515:9: note: in expansion of macro 'if'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:127:9: note: in expansion of macro 'unlikely'
     127 |         unlikely(__ret_warn_on);                                        \
         |         ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:515:13: note: in expansion of macro 'WARN_ON'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |             ^~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:515:9: note: in expansion of macro 'if'
     515 |         if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
         |         ^~
   In file included from arch/sparc/include/asm/page.h:8,
                    from arch/sparc/include/asm/thread_info_64.h:27,
                    from arch/sparc/include/asm/thread_info.h:5,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/scatterlist.h:8,
                    from include/linux/iommu.h:22,
                    from drivers/iommu/io-pgtable-arm.c:25:
>> arch/sparc/include/asm/page_64.h:77:29: error: request for member 'iopte' in something not a structure or union
      77 | #define iopte_val(x)    ((x).iopte)
         |                             ^
   arch/sparc/include/asm/page_64.h:148:60: note: in definition of macro '__va'
     148 | #define __va(x)                 ((void *)((unsigned long) (x) + PAGE_OFFSET))
         |                                                            ^
   drivers/iommu/io-pgtable-arm.c:186:15: note: in expansion of macro 'iopte_val'
     186 |         (__va(iopte_val(pte) & ((1ULL << ARM_LPAE_MAX_ADDR_BITS) - 1)   \
         |               ^~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:535:25: note: in expansion of macro 'iopte_deref'
     535 |                 cptep = iopte_deref(pte, data);
         |                         ^~~~~~~~~~~
   In file included from include/asm-generic/barrier.h:20,
                    from arch/sparc/include/asm/barrier_64.h:59,
                    from arch/sparc/include/asm/barrier.h:5,
                    from arch/sparc/include/asm/atomic_64.h:13,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from drivers/iommu/io-pgtable-arm.c:23:
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/asm-generic/bug.h:125:9: note: in expansion of macro 'if'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:125:13: note: in expansion of macro 'unlikely'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:538:17: note: in expansion of macro 'WARN_ON'
     538 |                 WARN_ON(!selftest_running);
         |                 ^~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:125:9: note: in expansion of macro 'if'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   drivers/iommu/io-pgtable-arm.c:538:17: note: in expansion of macro 'WARN_ON'
     538 |                 WARN_ON(!selftest_running);
         |                 ^~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_prot_to_pte':
   drivers/iommu/io-pgtable-arm.c:572:33: error: 'IOMMU_USE_UPSTREAM_HINT' undeclared (first use in this function)
     572 |                 else if (prot & IOMMU_USE_UPSTREAM_HINT)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:37: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                     ^~~~
   drivers/iommu/io-pgtable-arm.c:572:22: note: in expansion of macro 'if'
     572 |                 else if (prot & IOMMU_USE_UPSTREAM_HINT)
         |                      ^~
   drivers/iommu/io-pgtable-arm.c:572:33: note: each undeclared identifier is reported only once for each function it appears in
     572 |                 else if (prot & IOMMU_USE_UPSTREAM_HINT)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:37: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                     ^~~~
   drivers/iommu/io-pgtable-arm.c:572:22: note: in expansion of macro 'if'
     572 |                 else if (prot & IOMMU_USE_UPSTREAM_HINT)
         |                      ^~
   drivers/iommu/io-pgtable-arm.c:575:33: error: 'IOMMU_USE_LLC_NWA' undeclared (first use in this function)
     575 |                 else if (prot & IOMMU_USE_LLC_NWA)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:37: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                     ^~~~
   drivers/iommu/io-pgtable-arm.c:575:22: note: in expansion of macro 'if'
     575 |                 else if (prot & IOMMU_USE_LLC_NWA)
         |                      ^~
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_map':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:37: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                     ^~~~
   drivers/iommu/io-pgtable-arm.c:610:9: note: in expansion of macro 'if'
     610 |         if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
         |         ^~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:125:9: note: in expansion of macro 'if'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:125:13: note: in expansion of macro 'unlikely'
     125 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:610:13: note: in expansion of macro 'WARN_ON'
     610 |         if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
..

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS || MCOUNT
   Selected by
   - LOCKDEP && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86


vim +241 drivers/iommu/io-pgtable-arm.c

   219	
   220	/*
   221	 * We'll use some ignored bits in table entries to keep track of the number
   222	 * of page mappings beneath the table.  The maximum number of entries
   223	 * beneath any table mapping in armv8 is 8192 (which is possible at the
   224	 * 2nd- and 3rd-level when using a 64K granule size).  The bits at our
   225	 * disposal are:
   226	 *
   227	 *     4k granule: [54..52], [11..2]
   228	 *    64k granule: [54..52], [15..2]
   229	 *
   230	 * [54..52], [11..2] is enough bits for tracking table mappings at any
   231	 * level for any granule, so we'll use those.
   232	 */
   233	#define BOTTOM_IGNORED_MASK 0x3ff
   234	#define BOTTOM_IGNORED_SHIFT 2
   235	#define BOTTOM_IGNORED_NUM_BITS 10
   236	#define TOP_IGNORED_MASK 0x7ULL
   237	#define TOP_IGNORED_SHIFT 52
   238	#define IOPTE_RESERVED_MASK ((BOTTOM_IGNORED_MASK << BOTTOM_IGNORED_SHIFT) | \
   239				     (TOP_IGNORED_MASK << TOP_IGNORED_SHIFT))
   240	
 > 241	static arm_lpae_iopte iopte_val(arm_lpae_iopte table_pte)
   242	{
   243		return table_pte & ~IOPTE_RESERVED_MASK;
   244	}
   245	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
