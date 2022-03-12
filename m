Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5324D6ED2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiCLN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiCLN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:29:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BB275D1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647091712; x=1678627712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=25ieZFyhfauSAlIjBX80Xl0zr7uS364BXRZWXtOaO1A=;
  b=nwX7N5mhnAJbroLo1UcEHTtUdIXf6ujBZ8k+UH+hTDNKjrMvHyHK7NnT
   GMh/WcgsGshs73bv0tEWYzPMDE9FBd+1ztFJu7oPfLhAq+PcGS314eNS/
   NpGxfcPMES1qCvAjzDuOGB9EHloVpUmZ5TArDXrsOA2WBGLJtXMkR/uOB
   qvgUvGY6wIYFrqa4BucTclt1J/KBlJVbl5E8Qsjlw8t9sd/YC40Zrcl89
   Qx6PMJ28r1Bnkvo+l2hmj1rjef+sPzOKT4YPR927r9a/+gcA7GeHdgpUN
   +7ozOo6dPnjN4xCm1m+cOalzLZHyOMseTGvW2bosP1WghO8r00ezea2YR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="254623710"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="254623710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 05:28:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="645265336"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 05:28:29 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT1nI-0007u0-OU; Sat, 12 Mar 2022 13:28:28 +0000
Date:   Sat, 12 Mar 2022 21:27:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     kbuild-all@lists.01.org, Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] arch: arm: mach-hpe: Introduce the HPE GXP
 architecture
Message-ID: <202203122119.szjgiy49-lkp@intel.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on soc/for-next robh/for-next linus/master v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/nick-hawkins-hpe-com/arch-arm-mach-hpe-Introduce-the-HPE-GXP-architecture/20220311-035513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 58dedf0a4782ce42b4d31f1f62e5ad80a1b73d72
config: arm-randconfig-c002-20220312 (https://download.01.org/0day-ci/archive/20220312/202203122119.szjgiy49-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9fbfc32473a65e025764e0a1456c421b4706fe8e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review nick-hawkins-hpe-com/arch-arm-mach-hpe-Introduce-the-HPE-GXP-architecture/20220311-035513
        git checkout 9fbfc32473a65e025764e0a1456c421b4706fe8e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   drivers/memstick/host/r592.c:47:13: warning: no previous prototype for 'memstick_debug_get_tpc_name' [-Wmissing-prototypes]
      47 | const char *memstick_debug_get_tpc_name(int tpc)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
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
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   init/calibrate.c:261:37: warning: no previous prototype for 'calibrate_delay_is_known' [-Wmissing-prototypes]
     261 | unsigned long __attribute__((weak)) calibrate_delay_is_known(void)
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/ptrace.c:854:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
     854 | asmlinkage int syscall_trace_enter(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/ptrace.c:882:17: warning: no previous prototype for 'syscall_trace_exit' [-Wmissing-prototypes]
     882 | asmlinkage void syscall_trace_exit(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/reboot.c:78:6: warning: no previous prototype for 'soft_restart' [-Wmissing-prototypes]
      78 | void soft_restart(unsigned long addr)
         |      ^~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
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
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/sys_arm.c:32:17: warning: no previous prototype for 'sys_arm_fadvise64_64' [-Wmissing-prototypes]
      32 | asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
         |                 ^~~~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/time.c:88:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
      88 | void __init time_init(void)
         |             ^~~~~~~~~
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/traps.c:84:6: warning: no previous prototype for 'dump_backtrace_stm' [-Wmissing-prototypes]
      84 | void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
         |      ^~~~~~~~~~~~~~~~~~
   arch/arm/kernel/traps.c:433:17: warning: no previous prototype for 'do_undefinstr' [-Wmissing-prototypes]
     433 | asmlinkage void do_undefinstr(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~
   arch/arm/kernel/traps.c:498:39: warning: no previous prototype for 'handle_fiq_as_nmi' [-Wmissing-prototypes]
     498 | asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
         |                                       ^~~~~~~~~~~~~~~~~
   arch/arm/kernel/traps.c:517:17: warning: no previous prototype for 'bad_mode' [-Wmissing-prototypes]
     517 | asmlinkage void bad_mode(struct pt_regs *regs, int reason)
         |                 ^~~~~~~~
   arch/arm/kernel/traps.c:590:16: warning: no previous prototype for 'arm_syscall' [-Wmissing-prototypes]
     590 | asmlinkage int arm_syscall(int no, struct pt_regs *regs)
         |                ^~~~~~~~~~~
   arch/arm/kernel/traps.c:716:1: warning: no previous prototype for 'baddataabort' [-Wmissing-prototypes]
     716 | baddataabort(int code, unsigned long instr, struct pt_regs *regs)
         | ^~~~~~~~~~~~
   arch/arm/kernel/traps.c:756:17: warning: no previous prototype for '__div0' [-Wmissing-prototypes]
     756 | asmlinkage void __div0(void)
         |                 ^~~~~~
   arch/arm/kernel/traps.c:763:6: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
     763 | void abort(void)
         |      ^~~~~
--
>> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/suspend.c:75:6: warning: no previous prototype for '__cpu_suspend_save' [-Wmissing-prototypes]
      75 | void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
         |      ^~~~~~~~~~~~~~~~~~
..

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
