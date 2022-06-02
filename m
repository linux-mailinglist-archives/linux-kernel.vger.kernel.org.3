Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E697553BCC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiFBQsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiFBQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:47:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B01AF3A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654188459; x=1685724459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sBlbGdcRv5SH1ew+JQxlJWB6lPhH0M9JrCILxBpTNrw=;
  b=cMkP8FgS8I2j9bFHgfdSK0xgckYDHqvoQ/PnqfsWdpEE9ysXEdwbfZTN
   0SynsWI8YA9LUOBsSK3D2T7ZHN3GD+ByJj0FrvUlk3lQ+M99XEJswAKpp
   DYrxCgVVS/8PFcvMiSVaINBOfA2LJ4jtM85d0/M5j5PRL49Csau5dou/l
   jqTizRbtAMUJJ1QsphHMiFpjb3OBobBTpEYj1g7Mk1jizqs8+r0DxqPfN
   FhPriQsrgGTn9pVAzUlFI/mKaGeOmQ3JYiPWJ5u5hhFx2lmL24iXpYpS5
   DP2SCQT2uBYAJU95u/kDEssjqVhYRuAW9kQG7DOrLeEahEeJJ+l/mSn6Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="273572941"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="273572941"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 09:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="582166286"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2022 09:47:37 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwnyy-0005Hj-GP;
        Thu, 02 Jun 2022 16:47:36 +0000
Date:   Fri, 3 Jun 2022 00:47:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 26/31]
 include/linux/rcupdate.h:784:2: error: call to undeclared function
 'preempt_disable'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202206030038.x0u6tIk4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   8e0ac1b6b44d1c62420ad92b2a1cbc106a00f3de
commit: 969a734e01b9cf090fce853d9d706455e5a9cdf1 [26/31] riscv: Make virt_to_pfn() a static inline
config: riscv-randconfig-r031-20220531 (https://download.01.org/0day-ci/archive/20220603/202206030038.x0u6tIk4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=969a734e01b9cf090fce853d9d706455e5a9cdf1
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 969a734e01b9cf090fce853d9d706455e5a9cdf1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:11:
   In file included from include/linux/rbtree.h:24:
>> include/linux/rcupdate.h:784:2: error: call to undeclared function 'preempt_disable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           preempt_disable();
           ^
>> include/linux/rcupdate.h:794:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           preempt_disable_notrace();
           ^
>> include/linux/rcupdate.h:809:2: error: call to undeclared function 'preempt_enable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           preempt_enable();
           ^
>> include/linux/rcupdate.h:816:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           preempt_enable_notrace();
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           lockdep_assert_preemption_disabled();
           ^
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:320:31: note: expanded from macro 'this_cpu_read_1'
   #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:118:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_disable_notrace();                                      \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:320:31: note: expanded from macro 'this_cpu_read_1'
   #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:120:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_enable_notrace();                                       \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:323:31: note: expanded from macro 'this_cpu_read_2'
   #define this_cpu_read_2(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:118:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_disable_notrace();                                      \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:323:31: note: expanded from macro 'this_cpu_read_2'
   #define this_cpu_read_2(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:120:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_enable_notrace();                                       \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:326:31: note: expanded from macro 'this_cpu_read_4'
   #define this_cpu_read_4(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:118:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_disable_notrace();                                      \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:326:31: note: expanded from macro 'this_cpu_read_4'
   #define this_cpu_read_4(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:120:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_enable_notrace();                                       \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:329:31: note: expanded from macro 'this_cpu_read_8'
   #define this_cpu_read_8(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:118:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_disable_notrace();                                      \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:608:8: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        __lockdep_enabled                  &&              \
                        ^
   include/linux/lockdep.h:580:44: note: expanded from macro '__lockdep_enabled'
   #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
                                                    ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:329:31: note: expanded from macro 'this_cpu_read_8'
   #define this_cpu_read_8(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:120:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_enable_notrace();                                       \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_count'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:609:9: note: expanded from macro 'lockdep_assert_preemption_disabled'
                        (preempt_count() == 0              &&              \
                         ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:610:9: note: expanded from macro 'lockdep_assert_preemption_disabled'
                         this_cpu_read(hardirqs_enabled)));                \
                         ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   include/linux/percpu-defs.h:321:23: note: expanded from macro '__pcpu_size_call_return'
           case 1: pscr_ret__ = stem##1(variable); break;                  \
                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:320:31: note: expanded from macro 'this_cpu_read_1'
   #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:118:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_disable_notrace();                                      \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:610:9: note: expanded from macro 'lockdep_assert_preemption_disabled'
                         this_cpu_read(hardirqs_enabled)));                \
                         ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   include/linux/percpu-defs.h:321:23: note: expanded from macro '__pcpu_size_call_return'
           case 1: pscr_ret__ = stem##1(variable); break;                  \
                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:320:31: note: expanded from macro 'this_cpu_read_1'
   #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:120:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_enable_notrace();                                       \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:610:9: note: expanded from macro 'lockdep_assert_preemption_disabled'
                         this_cpu_read(hardirqs_enabled)));                \
                         ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   include/linux/percpu-defs.h:322:23: note: expanded from macro '__pcpu_size_call_return'
           case 2: pscr_ret__ = stem##2(variable); break;                  \
                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:323:31: note: expanded from macro 'this_cpu_read_2'
   #define this_cpu_read_2(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:118:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_disable_notrace();                                      \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:610:9: note: expanded from macro 'lockdep_assert_preemption_disabled'
                         this_cpu_read(hardirqs_enabled)));                \
                         ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   include/linux/percpu-defs.h:322:23: note: expanded from macro '__pcpu_size_call_return'
           case 2: pscr_ret__ = stem##2(variable); break;                  \
                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:323:31: note: expanded from macro 'this_cpu_read_2'
   #define this_cpu_read_2(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:120:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_enable_notrace();                                       \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_disable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:610:9: note: expanded from macro 'lockdep_assert_preemption_disabled'
                         this_cpu_read(hardirqs_enabled)));                \
                         ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   include/linux/percpu-defs.h:323:23: note: expanded from macro '__pcpu_size_call_return'
           case 4: pscr_ret__ = stem##4(variable); break;                  \
                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:326:31: note: expanded from macro 'this_cpu_read_4'
   #define this_cpu_read_4(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:118:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_disable_notrace();                                      \
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:11:
   In file included from arch/riscv/include/asm/page.h:14:
   In file included from arch/riscv/include/asm/pgtable.h:108:
   In file included from arch/riscv/include/asm/tlbflush.h:10:
   In file included from include/linux/mm_types.h:19:
>> include/linux/seqlock.h:271:2: error: call to undeclared function 'preempt_enable_notrace'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/lockdep.h:610:9: note: expanded from macro 'lockdep_assert_preemption_disabled'
                         this_cpu_read(hardirqs_enabled)));                \
                         ^
   include/linux/percpu-defs.h:507:29: note: expanded from macro 'this_cpu_read'
   #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
                                           ^
   include/linux/percpu-defs.h:323:23: note: expanded from macro '__pcpu_size_call_return'
           case 4: pscr_ret__ = stem##4(variable); break;                  \
                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/asm-generic/percpu.h:326:31: note: expanded from macro 'this_cpu_read_4'
   #define this_cpu_read_4(pcp)            this_cpu_generic_read(pcp)
                                           ^
   include/asm-generic/percpu.h:138:11: note: expanded from macro 'this_cpu_generic_read'
                   __ret = __this_cpu_generic_read_nopreempt(pcp);         \
                           ^
   include/asm-generic/percpu.h:120:2: note: expanded from macro '__this_cpu_generic_read_nopreempt'
           preempt_enable_notrace();                                       \
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/preempt_disable +784 include/linux/rcupdate.h

^1da177e4c3f41 Linus Torvalds    2005-04-16  766  
1c50b728c3e734 Mathieu Desnoyers 2008-09-29  767  /**
ca5ecddfa8fcbd Paul E. McKenney  2010-04-28  768   * rcu_read_lock_sched() - mark the beginning of a RCU-sched critical section
1c50b728c3e734 Mathieu Desnoyers 2008-09-29  769   *
1893afd6340911 Paul E. McKenney  2021-04-29  770   * This is equivalent to rcu_read_lock(), but also disables preemption.
1893afd6340911 Paul E. McKenney  2021-04-29  771   * Read-side critical sections can also be introduced by anything else that
1893afd6340911 Paul E. McKenney  2021-04-29  772   * disables preemption, including local_irq_disable() and friends.  However,
1893afd6340911 Paul E. McKenney  2021-04-29  773   * please note that the equivalence to rcu_read_lock() applies only to
1893afd6340911 Paul E. McKenney  2021-04-29  774   * v5.0 and later.  Before v5.0, rcu_read_lock() and rcu_read_lock_sched()
1893afd6340911 Paul E. McKenney  2021-04-29  775   * were unrelated.
3842a0832a1d6e Paul E. McKenney  2011-11-28  776   *
3842a0832a1d6e Paul E. McKenney  2011-11-28  777   * Note that rcu_read_lock_sched() and the matching rcu_read_unlock_sched()
3842a0832a1d6e Paul E. McKenney  2011-11-28  778   * must occur in the same context, for example, it is illegal to invoke
3842a0832a1d6e Paul E. McKenney  2011-11-28  779   * rcu_read_unlock_sched() from process context if the matching
3842a0832a1d6e Paul E. McKenney  2011-11-28  780   * rcu_read_lock_sched() was invoked from an NMI handler.
1c50b728c3e734 Mathieu Desnoyers 2008-09-29  781   */
d6714c22b43fbc Paul E. McKenney  2009-08-22  782  static inline void rcu_read_lock_sched(void)
d6714c22b43fbc Paul E. McKenney  2009-08-22  783  {
d6714c22b43fbc Paul E. McKenney  2009-08-22 @784  	preempt_disable();
bc33f24bdca8b6 Paul E. McKenney  2009-08-22  785  	__acquire(RCU_SCHED);
d8ab29f8be918b Paul E. McKenney  2011-10-07  786  	rcu_lock_acquire(&rcu_sched_lock_map);
f78f5b90c4ffa5 Paul E. McKenney  2015-06-18  787  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
bde23c6892878e Heiko Carstens    2012-02-01  788  			 "rcu_read_lock_sched() used illegally while idle");
d6714c22b43fbc Paul E. McKenney  2009-08-22  789  }
1eba8f84380bed Paul E. McKenney  2009-09-23  790  
1eba8f84380bed Paul E. McKenney  2009-09-23  791  /* Used by lockdep and tracing: cannot be traced, cannot call lockdep. */
7c614d6461399a Paul E. McKenney  2009-08-24  792  static inline notrace void rcu_read_lock_sched_notrace(void)
d6714c22b43fbc Paul E. McKenney  2009-08-22  793  {
d6714c22b43fbc Paul E. McKenney  2009-08-22 @794  	preempt_disable_notrace();
bc33f24bdca8b6 Paul E. McKenney  2009-08-22  795  	__acquire(RCU_SCHED);
d6714c22b43fbc Paul E. McKenney  2009-08-22  796  }
1c50b728c3e734 Mathieu Desnoyers 2008-09-29  797  
000601bb62330f Tobias Klauser    2020-07-09  798  /**
000601bb62330f Tobias Klauser    2020-07-09  799   * rcu_read_unlock_sched() - marks the end of a RCU-classic critical section
1c50b728c3e734 Mathieu Desnoyers 2008-09-29  800   *
000601bb62330f Tobias Klauser    2020-07-09  801   * See rcu_read_lock_sched() for more information.
1c50b728c3e734 Mathieu Desnoyers 2008-09-29  802   */
d6714c22b43fbc Paul E. McKenney  2009-08-22  803  static inline void rcu_read_unlock_sched(void)
d6714c22b43fbc Paul E. McKenney  2009-08-22  804  {
f78f5b90c4ffa5 Paul E. McKenney  2015-06-18  805  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
bde23c6892878e Heiko Carstens    2012-02-01  806  			 "rcu_read_unlock_sched() used illegally while idle");
d8ab29f8be918b Paul E. McKenney  2011-10-07  807  	rcu_lock_release(&rcu_sched_lock_map);
bc33f24bdca8b6 Paul E. McKenney  2009-08-22  808  	__release(RCU_SCHED);
d6714c22b43fbc Paul E. McKenney  2009-08-22 @809  	preempt_enable();
d6714c22b43fbc Paul E. McKenney  2009-08-22  810  }
1eba8f84380bed Paul E. McKenney  2009-09-23  811  
1eba8f84380bed Paul E. McKenney  2009-09-23  812  /* Used by lockdep and tracing: cannot be traced, cannot call lockdep. */
7c614d6461399a Paul E. McKenney  2009-08-24  813  static inline notrace void rcu_read_unlock_sched_notrace(void)
d6714c22b43fbc Paul E. McKenney  2009-08-22  814  {
bc33f24bdca8b6 Paul E. McKenney  2009-08-22  815  	__release(RCU_SCHED);
d6714c22b43fbc Paul E. McKenney  2009-08-22 @816  	preempt_enable_notrace();
d6714c22b43fbc Paul E. McKenney  2009-08-22  817  }
1c50b728c3e734 Mathieu Desnoyers 2008-09-29  818  

:::::: The code at line 784 was first introduced by commit
:::::: d6714c22b43fbcbead7e7b706ff270e15f04a791 rcu: Renamings to increase RCU clarity

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
