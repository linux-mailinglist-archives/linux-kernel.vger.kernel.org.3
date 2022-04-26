Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2EE50F197
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbiDZHCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiDZHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:01:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B0B6004A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650956330; x=1682492330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S7V3v/7UWkopynZgkR2PGjmZ12APeM3bchRJABsI+ic=;
  b=CMKiXVaM1mKaha0MXpEn3k5Ddypn2XFprNmkvgVtwyTASl3tEAGP87V3
   HNl+kr33cFpFXTIRKgrBGxRUMZfHK8hx1zGDxu73WFEso3TUQE2VE2NbG
   Dpe4fErF+AdIPjmJJufK7ZTT/pajWdr4kDsIUkEyZzdbCvJmMwHFfpk2S
   9F389Z2FieGtqOOG871UGGpiumFJrr7VwStf+JYlPgy7v4wFdQkl1mruL
   P5dBQLBBkPCd8atAYe81Aua8IyBdNjGePAHcrTOYULk5PRhFoWYVA5moV
   /UqlzQYeBwnQJxYtGE5o9STDpN0/bNmAnqomy6ey/4vC39EYHEQSf0W4i
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252851382"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="252851382"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="650057648"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2022 23:58:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njF9r-0003J7-PH;
        Tue, 26 Apr 2022 06:58:47 +0000
Date:   Tue, 26 Apr 2022 14:58:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 6418/9999] cc1: warning:
 arch/arm/plat-iop/include: No such file or directory
Message-ID: <202204261409.CTcsyD1M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 4fae0a1dc645742f2ecd6238813b2d30d4fb31cd [6418/9999] UPSTREAM: kbuild: add some extra warning flags unconditionally
config: arm-iop32x_defconfig (https://download.01.org/0day-ci/archive/20220426/202204261409.CTcsyD1M-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/4fae0a1dc645742f2ecd6238813b2d30d4fb31cd
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 4fae0a1dc645742f2ecd6238813b2d30d4fb31cd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   init/main.c:485:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     485 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:497:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     497 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   init/do_mounts.c: In function 'change_floppy':
   init/do_mounts.c:480:9: warning: function 'change_floppy' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     480 |         vsprintf(buf, fmt, args);
         |         ^~~~~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   init/calibrate.c:261:37: warning: no previous prototype for 'calibrate_delay_is_known' [-Wmissing-prototypes]
     261 | unsigned long __attribute__((weak)) calibrate_delay_is_known(void)
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   init/calibrate.c:271:28: warning: no previous prototype for 'calibration_delay_done' [-Wmissing-prototypes]
     271 | void __attribute__((weak)) calibration_delay_done(void)
         |                            ^~~~~~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/nwfpe/softfloat.c: In function 'float32_rem':
   arch/arm/nwfpe/softfloat.c:1349:17: warning: variable 'bSign' set but not used [-Wunused-but-set-variable]
    1349 |     flag aSign, bSign, zSign;
         |                 ^~~~~
   arch/arm/nwfpe/softfloat.c: In function 'float64_rem':
   arch/arm/nwfpe/softfloat.c:2247:17: warning: variable 'bSign' set but not used [-Wunused-but-set-variable]
    2247 |     flag aSign, bSign, zSign;
         |                 ^~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/process.c:321:15: warning: no previous prototype for 'arch_randomize_brk' [-Wmissing-prototypes]
     321 | unsigned long arch_randomize_brk(struct mm_struct *mm)
         |               ^~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/ptrace.c:927:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
     927 | asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
         |                ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/ptrace.c:955:17: warning: no previous prototype for 'syscall_trace_exit' [-Wmissing-prototypes]
     955 | asmlinkage void syscall_trace_exit(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/reboot.c:82:6: warning: no previous prototype for 'soft_restart' [-Wmissing-prototypes]
      82 | void soft_restart(unsigned long addr)
         |      ^~~~~~~~~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/setup.c: In function 'early_print':
   arch/arm/kernel/setup.c:374:9: warning: function 'early_print' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     374 |         vsnprintf(buf, sizeof(buf), str, ap);
         |         ^~~~~~~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/signal.c: In function 'restore_sigframe':
   arch/arm/kernel/signal.c:179:22: warning: variable 'aux' set but not used [-Wunused-but-set-variable]
     179 |         char __user *aux;
         |                      ^~~
   arch/arm/kernel/signal.c: At top level:
   arch/arm/kernel/signal.c:227:16: warning: no previous prototype for 'sys_sigreturn' [-Wmissing-prototypes]
     227 | asmlinkage int sys_sigreturn(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~
   arch/arm/kernel/signal.c:257:16: warning: no previous prototype for 'sys_rt_sigreturn' [-Wmissing-prototypes]
     257 | asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~~~
   arch/arm/kernel/signal.c:646:1: warning: no previous prototype for 'do_work_pending' [-Wmissing-prototypes]
     646 | do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
         | ^~~~~~~~~~~~~~~
   arch/arm/kernel/signal.c:686:14: warning: no previous prototype for 'get_signal_page' [-Wmissing-prototypes]
     686 | struct page *get_signal_page(void)
         |              ^~~~~~~~~~~~~~~
   arch/arm/kernel/signal.c:717:17: warning: no previous prototype for 'addr_limit_check_failed' [-Wmissing-prototypes]
     717 | asmlinkage void addr_limit_check_failed(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/signal.c: In function 'do_signal':
   arch/arm/kernel/signal.c:602:33: warning: this statement may fall through [-Wimplicit-fallthrough=]
     602 |                         restart -= 2;
         |                         ~~~~~~~~^~~~
   arch/arm/kernel/signal.c:603:17: note: here
     603 |                 case -ERESTARTNOHAND:
         |                 ^~~~
--
>> cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
   arch/arm/kernel/sys_arm.c:35:17: warning: no previous prototype for 'sys_arm_fadvise64_64' [-Wmissing-prototypes]
      35 | asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
         |                 ^~~~~~~~~~~~~~~~~~~~
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
