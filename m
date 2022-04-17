Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD0504748
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiDQI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiDQI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:58:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161112A86
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650185745; x=1681721745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QWVnNNHAXypuLupBwBfNHFlyMGqpOdlkWIqhCvdiCUE=;
  b=B72WNjkALLHtr49Uq9Gbcsg786uxU1CXkRssGAMDj6LMPyMilMq5uSVL
   lWjfmqB6KeTwe7hvnTvjK/sVyHxk7C903KSI/RTq1K9/GAQSKqW2VsdLr
   9C+kSRK3+ObFoVx0X2AC7i77sloQ5hp4DcJVkvQR8XPROA5ye597XxMKL
   R/CH5eHcEEtJRMLBxa+emVHOjhiHn20yWfzZ6NWReDhlpJuyuTApfogxx
   5GkYJRIvau8du499gY9XCiwZl43cIZ7aV4HxXuwcLaUU/fTD9vDtaSvOS
   hjZ8HwZYsOgqjrHN3rkExotBS8GoAJKbB5ds+2YSHywaTwwbiFKjG3hV6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349822217"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="349822217"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 01:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="509428228"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Apr 2022 01:55:43 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ng0h4-0003oP-Le;
        Sun, 17 Apr 2022 08:55:42 +0000
Date:   Sun, 17 Apr 2022 16:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: kernel/time/hrtimer.c:650:19: warning: unused function
 'hrtimer_hres_active'
Message-ID: <202204171614.pxPdcp17-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   a2c29ccd9477861b16ddc02c411a6c9665250558
commit: 9482fd71dbb8f0d1a61821a83e467dc0a9d7b429 hrtimer: Use raw_cpu_ptr() in clock_was_set()
date:   8 months ago
config: mips-randconfig-r013-20220417 (https://download.01.org/0day-ci/archive/20220417/202204171614.pxPdcp17-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6fdb1de47bd5f26868838c37fa9e8cc1ac484bf)
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
   clang version 15.0.0 (git://gitmirror/llvm_project c6fdb1de47bd5f26868838c37fa9e8cc1ac484bf)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-c6fdb1de47/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel mm net nr_bisected scripts source usr


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
