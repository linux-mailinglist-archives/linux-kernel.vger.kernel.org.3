Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7192253BD66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiFBRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiFBRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:39:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC90A7E3A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654191542; x=1685727542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TDwDIeoLuIKiJ35zXXcvzj5Wsi6WGDKsIjrvXwvdLCU=;
  b=bX7eBUdxlY0i5TNJ4P+98Md7DKzdIon5ONbejiqBW5se0WrXe7qACbyH
   Iy7k3UD1uMAuj8o+KqtpKre77+Se94jKm66NdHKMp2RFQKnrxCqhUGi40
   p+FWuOGzF5LUAjcy4aDBKvg7yn7tJ9cWGx7oHo/8EEr20Q9BUqAPqEkT8
   wE4riD3wTHr5D5nLXlj2cErFQs8gBxArW3RuWGTlAlUrU6O4bHN/x4mvV
   3T0YWiTr7mefXcBrHHZgQvN0qJ7FNoUlSl+VHSCy81qzswYWmLCD5b4EE
   7JI4hviUjb4OaUrjvCehy5SL7TmUTKHG7aTBlNfu2wRlXWUWhDws0v5JU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="256502677"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="256502677"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 10:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="634155361"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2022 10:38:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwomL-0005Je-PH;
        Thu, 02 Jun 2022 17:38:37 +0000
Date:   Fri, 3 Jun 2022 01:37:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 26/31]
 arch/riscv/include/asm/pgtable-64.h:111:25: error: implicit declaration of
 function 'pfn_to_virt'
Message-ID: <202206030130.THircVJ2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   8e0ac1b6b44d1c62420ad92b2a1cbc106a00f3de
commit: 969a734e01b9cf090fce853d9d706455e5a9cdf1 [26/31] riscv: Make virt_to_pfn() a static inline
config: riscv-randconfig-r042-20220531 (https://download.01.org/0day-ci/archive/20220603/202206030130.THircVJ2-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=969a734e01b9cf090fce853d9d706455e5a9cdf1
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 969a734e01b9cf090fce853d9d706455e5a9cdf1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM
   In file included from include/linux/rbtree.h:24,
   from include/linux/mm_types.h:11,
   from arch/riscv/include/asm/tlbflush.h:10,
   from arch/riscv/include/asm/pgtable.h:108,
   from arch/riscv/include/asm/page.h:14,
   from arch/riscv/include/asm/thread_info.h:11,
   from include/linux/thread_info.h:60,
   from include/asm-generic/preempt.h:5,
   from ./arch/riscv/include/generated/asm/preempt.h:1,
   from include/linux/preempt.h:78,
   from include/linux/spinlock.h:55,
   from include/linux/mmzone.h:8,
   from include/linux/gfp.h:6,
   from include/linux/mm.h:7,
   from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/rcupdate.h: In function '__rcu_read_lock':
>> include/linux/rcupdate.h:68:9: error: implicit declaration of function 'preempt_disable'
   68 | preempt_disable();
   | ^~~~~~~~~~~~~~~
   include/linux/rcupdate.h: In function '__rcu_read_unlock':
>> include/linux/rcupdate.h:73:9: error: implicit declaration of function 'preempt_enable'
   73 | preempt_enable();
   | ^~~~~~~~~~~~~~
   In file included from include/linux/rbtree.h:24,
   from include/linux/mm_types.h:11,
   from arch/riscv/include/asm/tlbflush.h:10,
   from arch/riscv/include/asm/pgtable.h:108,
   from arch/riscv/include/asm/page.h:14,
   from arch/riscv/include/asm/thread_info.h:11,
   from include/linux/thread_info.h:60,
   from include/asm-generic/preempt.h:5,
   from ./arch/riscv/include/generated/asm/preempt.h:1,
   from include/linux/preempt.h:78,
   from include/linux/spinlock.h:55,
   from include/linux/mmzone.h:8,
   from include/linux/gfp.h:6,
   from include/linux/mm.h:7,
   from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/rcupdate.h: In function 'rcu_read_lock_sched_notrace':
>> include/linux/rcupdate.h:794:9: error: implicit declaration of function 'preempt_disable_notrace'
   794 | preempt_disable_notrace();
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h: In function 'rcu_read_unlock_sched_notrace':
>> include/linux/rcupdate.h:816:9: error: implicit declaration of function 'preempt_enable_notrace'
   816 | preempt_enable_notrace();
   | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:93,
   from <command-line>:
   include/asm-generic/mmiowb.h: In function 'mmiowb_set_pending':
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
   35 | (typeof(ptr)) (__ptr + (off)); | ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:33: note: in expansion of macro 'raw_cpu_ptr'
   30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
   | ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:37:35: note: in expansion of macro '__mmiowb_state'
   37 | struct mmiowb_state = __mmiowb_state();
   | ^~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h: In function 'mmiowb_spin_lock':
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
   35 | (typeof(ptr)) (__ptr + (off)); | ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:33: note: in expansion of macro 'raw_cpu_ptr'
   30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
   | ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:45:35: note: in expansion of macro '__mmiowb_state'
   45 | struct mmiowb_state = __mmiowb_state();
   | ^~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h: In function 'mmiowb_spin_unlock':
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
   35 | (typeof(ptr)) (__ptr + (off)); | ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:33: note: in expansion of macro 'raw_cpu_ptr'
   30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
   | ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:51:35: note: in expansion of macro '__mmiowb_state'
   51 | struct mmiowb_state = __mmiowb_state();
   | ^~~~~~~~~~~~~~
   In file included from arch/riscv/include/asm/bug.h:83,
   from include/linux/bug.h:5,
   from include/linux/mmdebug.h:5,
   from include/linux/mm.h:6,
   from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h: In function '__seqprop_assert':
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/asm-generic/rwonce.h:44:43: note: in expansion of macro '__unqual_scalar_typeof'
   44 | #define __READ_ONCE(x) volatile __unqual_scalar_typeof(x)
   | ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
   50 | __READ_ONCE(x); | ^~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
   50 | __READ_ONCE(x); | ^~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
   67 | | ^~~~~~~~~~~
   include/asm-generic/percpu.h:129:18: note: in expansion of macro 'raw_cpu_generic_read'
   129 | ___ret = raw_cpu_generic_read(pcp); | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:140:25: note: in expansion of macro '__this_cpu_generic_read_noirq'
   140 | __ret = __this_cpu_generic_read_noirq(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:320:41: note: in expansion of macro 'this_cpu_generic_read'
   320 | #define this_cpu_read_1(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 | case 1: pscr_ret__ = stem##1(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:323:41: note: in expansion of macro 'this_cpu_generic_read'
   323 | #define this_cpu_read_2(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'this_cpu_read_2'
   322 | case 2: pscr_ret__ = stem##2(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:323:41: note: in expansion of macro 'this_cpu_generic_read'
   323 | #define this_cpu_read_2(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'this_cpu_read_2'
   322 | case 2: pscr_ret__ = stem##2(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:323:41: note: in expansion of macro 'this_cpu_generic_read'
   323 | #define this_cpu_read_2(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'this_cpu_read_2'
   322 | case 2: pscr_ret__ = stem##2(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:323:41: note: in expansion of macro 'this_cpu_generic_read'
   323 | #define this_cpu_read_2(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'this_cpu_read_2'
   322 | case 2: pscr_ret__ = stem##2(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/linux/compiler_types.h:340:9: note: in expansion of macro '__compiletime_assert'
   340 | __compiletime_assert(condition, msg, prefix, suffix)
   | ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
   352 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   | ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 | compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), | ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 | compiletime_assert_rwonce_type(x); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:323:41: note: in expansion of macro 'this_cpu_generic_read'
   323 | #define this_cpu_read_2(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'this_cpu_read_2'
   322 | case 2: pscr_ret__ = stem##2(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'
   271 | lockdep_assert_preemption_disabled();
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/smp.h:60:54: error: invalid use of undefined type 'struct thread_info'
   60 | #define raw_smp_processor_id() (current_thread_info()->cpu)
   | ^~
   include/asm-generic/bug.h:104:32: note: in definition of macro 'WARN_ON_ONCE'
   104 | int __ret_warn_on = | ^~~~~~~~~
   include/asm-generic/rwonce.h:44:43: note: in expansion of macro '__unqual_scalar_typeof'
   44 | #define __READ_ONCE(x) volatile __unqual_scalar_typeof(x)
   | ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
   50 | __READ_ONCE(x); | ^~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
   119 | ___ret = | ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 | __kernel __force (__offset))
   | ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   | ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   | ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 | arch_raw_cpu_ptr(ptr); | ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:29: note: in expansion of macro 'raw_cpu_ptr'
   119 | ___ret = | ^~~~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   138 | __ret = __this_cpu_generic_read_nopreempt(pcp); | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:323:41: note: in expansion of macro 'this_cpu_generic_read'
   323 | #define this_cpu_read_2(pcp) this_cpu_generic_read(pcp)
   | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'this_cpu_read_2'
   322 | case 2: pscr_ret__ = stem##2(variable); break; | ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
   507 | #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
   | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:580:50: note: in expansion of macro 'this_cpu_read'
   580 | #define __lockdep_enabled (debug_locks && !this_cpu_read(lockdep_recursion))
   | ^~~~~~~~~~~~~
   include/linux/lockdep.h:608:22: note: in expansion of macro '__lockdep_enabled'
   608 | __lockdep_enabled && | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:271:9: note: in expansion of macro 'lockdep_assert_preemption_disabled'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +/pfn_to_virt +111 arch/riscv/include/asm/pgtable-64.h

e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   53  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   54  #define pud_val(x)      ((x).pud)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   55  #define __pud(x)        ((pud_t) { (x) })
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  @56  #define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   57  
07037db5d479f9 Palmer Dabbelt   2017-07-10   58  /* Page Middle Directory entry */
07037db5d479f9 Palmer Dabbelt   2017-07-10   59  typedef struct {
07037db5d479f9 Palmer Dabbelt   2017-07-10   60  	unsigned long pmd;
07037db5d479f9 Palmer Dabbelt   2017-07-10   61  } pmd_t;
07037db5d479f9 Palmer Dabbelt   2017-07-10   62  
07037db5d479f9 Palmer Dabbelt   2017-07-10   63  #define pmd_val(x)      ((x).pmd)
07037db5d479f9 Palmer Dabbelt   2017-07-10   64  #define __pmd(x)        ((pmd_t) { (x) })
07037db5d479f9 Palmer Dabbelt   2017-07-10   65  
07037db5d479f9 Palmer Dabbelt   2017-07-10   66  #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
07037db5d479f9 Palmer Dabbelt   2017-07-10   67  
07037db5d479f9 Palmer Dabbelt   2017-07-10   68  static inline int pud_present(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   69  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   70  	return (pud_val(pud) & _PAGE_PRESENT);
07037db5d479f9 Palmer Dabbelt   2017-07-10   71  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   72  
07037db5d479f9 Palmer Dabbelt   2017-07-10   73  static inline int pud_none(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   74  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   75  	return (pud_val(pud) == 0);
07037db5d479f9 Palmer Dabbelt   2017-07-10   76  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   77  
07037db5d479f9 Palmer Dabbelt   2017-07-10   78  static inline int pud_bad(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   79  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   80  	return !pud_present(pud);
07037db5d479f9 Palmer Dabbelt   2017-07-10   81  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   82  
af6513ead0462c Steven Price     2020-02-03   83  #define pud_leaf	pud_leaf
af6513ead0462c Steven Price     2020-02-03   84  static inline int pud_leaf(pud_t pud)
af6513ead0462c Steven Price     2020-02-03   85  {
f5397c3ee0a3e2 Nanyong Sun      2021-04-30   86  	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
af6513ead0462c Steven Price     2020-02-03   87  }
af6513ead0462c Steven Price     2020-02-03   88  
07037db5d479f9 Palmer Dabbelt   2017-07-10   89  static inline void set_pud(pud_t *pudp, pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   90  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   91  	*pudp = pud;
07037db5d479f9 Palmer Dabbelt   2017-07-10   92  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   93  
07037db5d479f9 Palmer Dabbelt   2017-07-10   94  static inline void pud_clear(pud_t *pudp)
07037db5d479f9 Palmer Dabbelt   2017-07-10   95  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   96  	set_pud(pudp, __pud(0));
07037db5d479f9 Palmer Dabbelt   2017-07-10   97  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   98  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  @99  static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  100  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  101  	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  102  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  103  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  104  static inline unsigned long _pud_pfn(pud_t pud)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  105  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  106  	return pud_val(pud) >> _PAGE_PFN_SHIFT;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  107  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  108  
9cf6fa24584431 Aneesh Kumar K.V 2021-07-07  109  static inline pmd_t *pud_pgtable(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10  110  {
9cf6fa24584431 Aneesh Kumar K.V 2021-07-07 @111  	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
07037db5d479f9 Palmer Dabbelt   2017-07-10  112  }
07037db5d479f9 Palmer Dabbelt   2017-07-10  113  
8ad8b72721d0f0 Nick Hu          2020-01-06  114  static inline struct page *pud_page(pud_t pud)
8ad8b72721d0f0 Nick Hu          2020-01-06  115  {
8ad8b72721d0f0 Nick Hu          2020-01-06 @116  	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
8ad8b72721d0f0 Nick Hu          2020-01-06  117  }
8ad8b72721d0f0 Nick Hu          2020-01-06  118  
d10efa21a93748 Qinglin Pan      2022-01-27  119  #define mm_p4d_folded  mm_p4d_folded
d10efa21a93748 Qinglin Pan      2022-01-27  120  static inline bool mm_p4d_folded(struct mm_struct *mm)
d10efa21a93748 Qinglin Pan      2022-01-27  121  {
d10efa21a93748 Qinglin Pan      2022-01-27  122  	if (pgtable_l5_enabled)
d10efa21a93748 Qinglin Pan      2022-01-27  123  		return false;
d10efa21a93748 Qinglin Pan      2022-01-27  124  
d10efa21a93748 Qinglin Pan      2022-01-27  125  	return true;
d10efa21a93748 Qinglin Pan      2022-01-27  126  }
d10efa21a93748 Qinglin Pan      2022-01-27  127  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  128  #define mm_pud_folded  mm_pud_folded
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  129  static inline bool mm_pud_folded(struct mm_struct *mm)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  130  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  131  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  132  		return false;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  133  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  134  	return true;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  135  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  136  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  137  #define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  138  
07037db5d479f9 Palmer Dabbelt   2017-07-10  139  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
07037db5d479f9 Palmer Dabbelt   2017-07-10  140  {
07037db5d479f9 Palmer Dabbelt   2017-07-10  141  	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
07037db5d479f9 Palmer Dabbelt   2017-07-10  142  }
07037db5d479f9 Palmer Dabbelt   2017-07-10  143  
671f9a3e2e24cd Anup Patel       2019-06-28  144  static inline unsigned long _pmd_pfn(pmd_t pmd)
671f9a3e2e24cd Anup Patel       2019-06-28  145  {
671f9a3e2e24cd Anup Patel       2019-06-28  146  	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
671f9a3e2e24cd Anup Patel       2019-06-28  147  }
671f9a3e2e24cd Anup Patel       2019-06-28  148  
9eb4fcff220790 Nanyong Sun      2021-06-17  149  #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
9eb4fcff220790 Nanyong Sun      2021-06-17  150  
07037db5d479f9 Palmer Dabbelt   2017-07-10  151  #define pmd_ERROR(e) \
07037db5d479f9 Palmer Dabbelt   2017-07-10  152  	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
07037db5d479f9 Palmer Dabbelt   2017-07-10  153  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  154  #define pud_ERROR(e)   \
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  155  	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  156  
d10efa21a93748 Qinglin Pan      2022-01-27  157  #define p4d_ERROR(e)   \
d10efa21a93748 Qinglin Pan      2022-01-27  158  	pr_err("%s:%d: bad p4d %016lx.\n", __FILE__, __LINE__, p4d_val(e))
d10efa21a93748 Qinglin Pan      2022-01-27  159  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  160  static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  161  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  162  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  163  		*p4dp = p4d;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  164  	else
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  165  		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  166  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  167  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  168  static inline int p4d_none(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  169  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  170  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  171  		return (p4d_val(p4d) == 0);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  172  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  173  	return 0;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  174  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  175  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  176  static inline int p4d_present(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  177  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  178  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  179  		return (p4d_val(p4d) & _PAGE_PRESENT);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  180  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  181  	return 1;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  182  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  183  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  184  static inline int p4d_bad(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  185  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  186  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  187  		return !p4d_present(p4d);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  188  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  189  	return 0;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  190  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  191  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  192  static inline void p4d_clear(p4d_t *p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  193  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  194  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  195  		set_p4d(p4d, __p4d(0));
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  196  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  197  
d10efa21a93748 Qinglin Pan      2022-01-27  198  static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
d10efa21a93748 Qinglin Pan      2022-01-27  199  {
d10efa21a93748 Qinglin Pan      2022-01-27  200  	return __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
d10efa21a93748 Qinglin Pan      2022-01-27  201  }
d10efa21a93748 Qinglin Pan      2022-01-27  202  
d10efa21a93748 Qinglin Pan      2022-01-27  203  static inline unsigned long _p4d_pfn(p4d_t p4d)
d10efa21a93748 Qinglin Pan      2022-01-27  204  {
d10efa21a93748 Qinglin Pan      2022-01-27  205  	return p4d_val(p4d) >> _PAGE_PFN_SHIFT;
d10efa21a93748 Qinglin Pan      2022-01-27  206  }
d10efa21a93748 Qinglin Pan      2022-01-27  207  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  208  static inline pud_t *p4d_pgtable(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  209  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  210  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  211  		return (pud_t *)pfn_to_virt(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  212  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  213  	return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  214  }
d10efa21a93748 Qinglin Pan      2022-01-27  215  #define p4d_page_vaddr(p4d)	((unsigned long)p4d_pgtable(p4d))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  216  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  217  static inline struct page *p4d_page(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  218  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  219  	return pfn_to_page(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  220  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  221  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  222  #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  223  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  224  #define pud_offset pud_offset
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  225  static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  226  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  227  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  228  		return p4d_pgtable(*p4d) + pud_index(address);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  229  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  230  	return (pud_t *)p4d;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  231  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  232  
d10efa21a93748 Qinglin Pan      2022-01-27 @233  static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
d10efa21a93748 Qinglin Pan      2022-01-27  234  {
d10efa21a93748 Qinglin Pan      2022-01-27  235  	if (pgtable_l5_enabled)
d10efa21a93748 Qinglin Pan      2022-01-27  236  		*pgdp = pgd;
d10efa21a93748 Qinglin Pan      2022-01-27  237  	else
d10efa21a93748 Qinglin Pan      2022-01-27  238  		set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
d10efa21a93748 Qinglin Pan      2022-01-27  239  }
d10efa21a93748 Qinglin Pan      2022-01-27  240  

:::::: The code at line 111 was first introduced by commit
:::::: 9cf6fa2458443118b84090aa1bf7a3630b5940e8 mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
