Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082144688E7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhLEBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 20:47:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:3061 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhLEBrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 20:47:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="217843265"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="217843265"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 17:44:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="578878252"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2021 17:44:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtgZT-000Jfk-3k; Sun, 05 Dec 2021 01:44:07 +0000
Date:   Sun, 5 Dec 2021 09:43:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     kbuild-all@lists.01.org, linux-m68k@lists.linux-m68k.org,
        uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: [gerg-m68knommu:armnommu 4/4] cc1: error:
 arch/arm/mach-versatile/include: No such file or directory
Message-ID: <202112050940.8HUo4dw9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git armnommu
head:   6ffd7a3db739bfbe74f339ddf1ba19083ddd319e
commit: 6ffd7a3db739bfbe74f339ddf1ba19083ddd319e [4/4] ARM: versatile: support configuring versatile machine for no-MMU
config: arm-randconfig-p002-20211205 (https://download.01.org/0day-ci/archive/20211205/202112050940.8HUo4dw9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git/commit/?id=6ffd7a3db739bfbe74f339ddf1ba19083ddd319e
        git remote add gerg-m68knommu https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
        git fetch --no-tags gerg-m68knommu armnommu
        git checkout 6ffd7a3db739bfbe74f339ddf1ba19083ddd319e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
--
>> cc1: error: arch/arm/mach-versatile/include: No such file or directory [-Werror=missing-include-dirs]
   cc1: all warnings being treated as errors
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   drivers/dax/super.c:375:6: warning: no previous prototype for 'run_dax' [-Wmissing-prototypes]
     375 | void run_dax(struct dax_device *dax_dev)
         |      ^~~~~~~
--
>> arm-linux-gnueabi-gcc: error: unrecognized command-line option '-Wout-of-line-declaration'; did you mean '-Wold-style-declaration'?
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   init/main.c:768:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     768 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:780:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     780 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:782:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     782 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   init/calibrate.c:261:37: warning: no previous prototype for 'calibrate_delay_is_known' [-Wmissing-prototypes]
     261 | unsigned long __attribute__((weak)) calibrate_delay_is_known(void)
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/ptrace.c:854:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
     854 | asmlinkage int syscall_trace_enter(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/ptrace.c:882:17: warning: no previous prototype for 'syscall_trace_exit' [-Wmissing-prototypes]
     882 | asmlinkage void syscall_trace_exit(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/reboot.c:78:6: warning: no previous prototype for 'soft_restart' [-Wmissing-prototypes]
      78 | void soft_restart(unsigned long addr)
         |      ^~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/signal.c:186:16: warning: no previous prototype for 'sys_sigreturn' [-Wmissing-prototypes]
     186 | asmlinkage int sys_sigreturn(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~
   arch/arm/kernel/signal.c:216:16: warning: no previous prototype for 'sys_rt_sigreturn' [-Wmissing-prototypes]
     216 | asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~~~
   arch/arm/kernel/signal.c:601:1: warning: no previous prototype for 'do_work_pending' [-Wmissing-prototypes]
     601 | do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
         | ^~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/sys_arm.c:32:17: warning: no previous prototype for 'sys_arm_fadvise64_64' [-Wmissing-prototypes]
      32 | asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
         |                 ^~~~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-versatile/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/time.c:88:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
      88 | void __init time_init(void)
         |             ^~~~~~~~~
..

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
