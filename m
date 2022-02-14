Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC364B4DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350770AbiBNLSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:18:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350415AbiBNLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:18:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B665657AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644835856; x=1676371856;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/kLJyU48R70GHyVr31Y/V7xMHTXJq7WJn+RQtezx4m8=;
  b=N6RvS1d39U0XEMfNXcpSdQ+tZQl8mf3X0YodzS17U0Kczw4H82ClRXUT
   BBGBIQB3G8T8TCo0k3walfTTvQHegRHkmNojaXw1oHnngUfUe/mPPiYsU
   fJPtWRD0DZp5B+9mmZgM7zjHXAoglRJtaoODKor79JMbk4Te+HkTXfzhl
   bVK5SZLhaLeV4QxIxnRwKBClVQNiOW5pfQnSZR1BpWLW+YuujMuxAxV/0
   9UodE6DQ+doXoy5HsN3inYSHoALsUlKiEdhTWO+jPobes6KeKthxydx0C
   HuKAtoHYciiidaWSLSpqNFBep6iw/lk6LAVKQEwhDJbRLQLkbqFQ17Scj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249812835"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="249812835"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="703019134"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2022 02:50:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJYwX-0008QR-2Z; Mon, 14 Feb 2022 10:50:53 +0000
Date:   Mon, 14 Feb 2022 18:50:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/time/hrtimer.c:276:20: warning: unused function
 'is_migration_base'
Message-ID: <202202141804.APyBFuLN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: 81d741d3460ca422843ce0ec8351083f259c6166 hrtimer: Avoid unnecessary SMP function calls in clock_was_set()
date:   6 months ago
config: mips-randconfig-r033-20220213 (https://download.01.org/0day-ci/archive/20220214/202202141804.APyBFuLN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81d741d3460ca422843ce0ec8351083f259c6166
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 81d741d3460ca422843ce0ec8351083f259c6166
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
   kernel/time/hrtimer.c:1591:7: warning: variable 'expires_in_hardirq' set but not used
   bool expires_in_hardirq;
   ^
>> kernel/time/hrtimer.c:276:20: warning: unused function 'is_migration_base'
   static inline bool is_migration_base(struct hrtimer_clock_base
   ^
>> kernel/time/hrtimer.c:1830:20: warning: unused function '__hrtimer_peek_ahead_timers'
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


vim +/is_migration_base +276 kernel/time/hrtimer.c

c0a3132963db68 kernel/hrtimer.c      Thomas Gleixner           2006-01-09  275  
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04 @276  static inline bool is_migration_base(struct hrtimer_clock_base *base)
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  277  {
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  278  	return false;
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  279  }
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  280  

:::::: The code at line 276 was first introduced by commit
:::::: 5d2295f3a93b04986d069ebeaf5b07725f9096c1 hrtimer: Add a missing bracket and hide `migration_base' on !SMP

:::::: TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
