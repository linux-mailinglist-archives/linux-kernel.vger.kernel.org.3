Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65C591A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiHMN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbiHMN2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:28:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C75C9E1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660397300; x=1691933300;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XtMFkYHY/cD350rDxfXGg6FL4eS2ZlT/y400Kyk5TwM=;
  b=OK0AeB/FOz1HSkh8UwAKNV/1gwajCEHiSvDXbl0XExwn7CceNPgR8PBL
   t90JOcEwXVXObQfm0t4/IMhR60HgbEtP1u+KgPoX+RwFOtHur4m11KmaR
   WXmP6K4gcddNOm40f2cAMoKa1TiqbLReERwadS+dknnMS2keB+S7b/GOq
   unUlhszMlZ0H5cghnFtRmFPpck8h95dgMUCJ26n+Q2bk6ZWK2qaNkc6qj
   XQkvdneUajrs8My7evSd1eZl5xEgc2fy5A8TGWA7SOF0pjSYQq/stpoB8
   H6DFw9OLYjfbS4CztoaFSbKLIDfSdUB5L3Qz9lsa8/3tA2lqvEDDB6lui
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317729641"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="317729641"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="851834770"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 06:28:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMrBa-0001hd-1g;
        Sat, 13 Aug 2022 13:28:18 +0000
Date:   Sat, 13 Aug 2022 21:27:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:io_uring/dma-register-v3 3/8] include/linux/fs.h:3610:60:
 warning: 'struct bio_vec' declared inside parameter list will not be visible
 outside of this definition or declaration
Message-ID: <202208132106.JaGpr7MH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git io_uring/dma-register-v3
head:   e1c6d38d05e532b3aaf12a5ab8707929bcdc1180
commit: 59f51e67d3aa45e21c693f274e516a8e307ac829 [3/8] file: add ops to dma map bvec
config: m68k-buildonly-randconfig-r001-20220804 (https://download.01.org/0day-ci/archive/20220813/202208132106.JaGpr7MH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=59f51e67d3aa45e21c693f274e516a8e307ac829
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch io_uring/dma-register-v3
        git checkout 59f51e67d3aa45e21c693f274e516a8e307ac829
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/kernel/ io_uring/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/seq_file.h:12,
                    from arch/m68k/kernel/irq.c:17:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/m68k/kernel/process.c:21:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   arch/m68k/kernel/process.c:114:16: warning: no previous prototype for 'm68k_clone' [-Wmissing-prototypes]
     114 | asmlinkage int m68k_clone(struct pt_regs *regs)
         |                ^~~~~~~~~~
   arch/m68k/kernel/process.c:135:16: warning: no previous prototype for 'm68k_clone3' [-Wmissing-prototypes]
     135 | asmlinkage int m68k_clone3(struct pt_regs *regs)
         |                ^~~~~~~~~~~
   arch/m68k/kernel/process.c:216:5: warning: no previous prototype for 'dump_fpu' [-Wmissing-prototypes]
     216 | int dump_fpu (struct pt_regs *regs, struct user_m68kfp_struct *fpu)
         |     ^~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/m68k/kernel/ptrace.c:16:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   arch/m68k/kernel/ptrace.c:275:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
     275 | asmlinkage int syscall_trace_enter(void)
         |                ^~~~~~~~~~~~~~~~~~~
   arch/m68k/kernel/ptrace.c:284:17: warning: no previous prototype for 'syscall_trace_leave' [-Wmissing-prototypes]
     284 | asmlinkage void syscall_trace_leave(void)
         |                 ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/m68k/kernel/signal.c:32:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   arch/m68k/kernel/signal.c:756:18: warning: no previous prototype for 'do_sigreturn' [-Wmissing-prototypes]
     756 | asmlinkage void *do_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
         |                  ^~~~~~~~~~~~
   arch/m68k/kernel/signal.c:783:18: warning: no previous prototype for 'do_rt_sigreturn' [-Wmissing-prototypes]
     783 | asmlinkage void *do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
         |                  ^~~~~~~~~~~~~~~
   arch/m68k/kernel/signal.c:1106:6: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
    1106 | void do_notify_resume(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/m68k/kernel/sys_m68k.c:13:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   arch/m68k/kernel/sys_m68k.c:535:1: warning: no previous prototype for 'sys_cacheflush' [-Wmissing-prototypes]
     535 | sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
         | ^~~~~~~~~~~~~~
   arch/m68k/kernel/sys_m68k.c:544:1: warning: no previous prototype for 'sys_atomic_cmpxchg_32' [-Wmissing-prototypes]
     544 | sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/m68k/kernel/sys_m68k.c:562:16: warning: no previous prototype for 'sys_getpagesize' [-Wmissing-prototypes]
     562 | asmlinkage int sys_getpagesize(void)
         |                ^~~~~~~~~~~~~~~
   arch/m68k/kernel/sys_m68k.c:567:26: warning: no previous prototype for 'sys_get_thread_area' [-Wmissing-prototypes]
     567 | asmlinkage unsigned long sys_get_thread_area(void)
         |                          ^~~~~~~~~~~~~~~~~~~
   arch/m68k/kernel/sys_m68k.c:572:16: warning: no previous prototype for 'sys_set_thread_area' [-Wmissing-prototypes]
     572 | asmlinkage int sys_set_thread_area(unsigned long tp)
         |                ^~~~~~~~~~~~~~~~~~~
   arch/m68k/kernel/sys_m68k.c:578:16: warning: no previous prototype for 'sys_atomic_barrier' [-Wmissing-prototypes]
     578 | asmlinkage int sys_atomic_barrier(void)
         |                ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/m68k/kernel/time.c:22:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   arch/m68k/kernel/time.c:154:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
     154 | void __init time_init(void)
         |             ^~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from arch/m68k/kernel/traps.c:25:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   arch/m68k/kernel/traps.c:752:17: warning: no previous prototype for 'buserr_c' [-Wmissing-prototypes]
     752 | asmlinkage void buserr_c(struct frame *fp)
         |                 ^~~~~~~~
   arch/m68k/kernel/traps.c:966:6: warning: no previous prototype for 'bad_super_trap' [-Wmissing-prototypes]
     966 | void bad_super_trap (struct frame *fp)
         |      ^~~~~~~~~~~~~~
   arch/m68k/kernel/traps.c:1138:17: warning: no previous prototype for 'set_esp0' [-Wmissing-prototypes]
    1138 | asmlinkage void set_esp0(unsigned long ssp)
         |                 ^~~~~~~~
   arch/m68k/kernel/traps.c:1147:17: warning: no previous prototype for 'fpsp040_die' [-Wmissing-prototypes]
    1147 | asmlinkage void fpsp040_die(void)
         |                 ^~~~~~~~~~~
--
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from include/linux/elfcore.h:11,
                    from include/linux/crash_core.h:6,
                    from include/linux/kexec.h:18,
                    from arch/m68k/kernel/machine_kexec.c:6:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   arch/m68k/kernel/machine_kexec.c:26:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
      26 | void machine_shutdown(void)
         |      ^~~~~~~~~~~~~~~~
   arch/m68k/kernel/machine_kexec.c:30:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
      30 | void machine_crash_shutdown(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from io_uring/io_uring.c:45:
>> include/linux/fs.h:3610:60: warning: 'struct bio_vec' declared inside parameter list will not be visible outside of this definition or declaration
    3610 | static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
         |                                                            ^~~~~~~
   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:1183:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    1183 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~


vim +3610 include/linux/fs.h

  3599	
  3600	/* mm/fadvise.c */
  3601	extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
  3602			       int advice);
  3603	extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
  3604				   int advice);
  3605	
  3606	#ifdef CONFIG_HAS_DMA
  3607	void *file_dma_map(struct file *file, struct bio_vec *bvec, int nr_vecs);
  3608	void file_dma_unmap(struct file *file, void *dma_tag);
  3609	#else
> 3610	static inline void *file_dma_map(struct file *file, struct bio_vec *bvec,
  3611					 int nr_vecs)
  3612	{
  3613		return ERR_PTR(-ENOTSUPP);
  3614	}
  3615	static inline void file_dma_unmap(struct file *file, void *dma_tag) {}
  3616	#endif
  3617	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
