Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451C34B5372
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355216AbiBNOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:37:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiBNOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:37:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F2488AB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644849430; x=1676385430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6LOK4VVNnkh4NqshkBZRVXh25R9/25K4xECHUcNdZ8I=;
  b=GXWgL/5oBFQuE+pFaqGNLzJXdfbTyyTu6tGqwFHxY20edRsNlwo0Fmkz
   AxmST5BTp13rX6a/9XvIgvd8NU96WMHP9rwyYBH3nHTF58T0zixcIaZ8H
   XWMujNUMJkfnYJt3N7W09fXQew6uiO60TYXoUBtfcToYTsPIvK9HJiToA
   /OQG2uyzmk5bZzb6pAT9cJ1vcUQs/bOGyUfOpmqBketYnEX6IDwYn0wqb
   Lv88IWDi7ZM74ROJecSbRGj5U4eW67045XqdJ3aUnq4Y5WFE3gWpEq3zb
   S5fX2aHcTkn5CT+Z8GFWaNj7czCurE8s6cdKyirsADfUkJyektjheOr1l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313377943"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="313377943"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:37:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="495683768"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2022 06:37:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJcTU-0008ed-CQ; Mon, 14 Feb 2022 14:37:08 +0000
Date:   Mon, 14 Feb 2022 22:36:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: kernel/time/hrtimer.c:650:19: warning: unused function
 'hrtimer_hres_active'
Message-ID: <202202142217.xTcn7mgj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: 9482fd71dbb8f0d1a61821a83e467dc0a9d7b429 hrtimer: Use raw_cpu_ptr() in clock_was_set()
date:   6 months ago
config: mips-randconfig-r033-20220213 (https://download.01.org/0day-ci/archive/20220214/202202142217.xTcn7mgj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/ kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/hrtimer.c:120:21: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_REALTIME,
   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:22: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_MONOTONIC,
   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:21: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_BOOTTIME,
   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:17: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_TAI,
   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:1648:7: warning: variable 'expires_in_hardirq' set but not used
   bool expires_in_hardirq;
   ^
   kernel/time/hrtimer.c:276:20: warning: unused function 'is_migration_base'
   static inline bool is_migration_base(struct hrtimer_clock_base
   ^
>> kernel/time/hrtimer.c:650:19: warning: unused function 'hrtimer_hres_active'
   static inline int hrtimer_hres_active(void)
   ^
   kernel/time/hrtimer.c:1887:20: warning: unused function '__hrtimer_peek_ahead_timers'
   static inline void __hrtimer_peek_ahead_timers(void) { }
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 105, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-ea071884b0/bin
   clang-15: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm scripts security sound source usr virt


vim +/hrtimer_hres_active +650 kernel/time/hrtimer.c

28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  649  
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21 @650  static inline int hrtimer_hres_active(void)
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  651  {
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  652  	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  653  }
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  654  

:::::: The code at line 650 was first introduced by commit
:::::: 28bfd18bf3daa5db8bb3422ea7138c8b7d2444ac hrtimer: Make the hrtimer_cpu_base::hres_active field unconditional, to simplify the code

:::::: TO: Anna-Maria Gleixner <anna-maria@linutronix.de>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
