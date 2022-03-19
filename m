Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216B24DE5E3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiCSELZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiCSELX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:11:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A21BE13A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647663002; x=1679199002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dGLMu86/na7XNy8AfG00unkjirXLfkOk8XkuuhsLmjk=;
  b=DduIZKo+m9WFHIv4JTEIJx9fKJ0zuK6ZBcBCWV/kaCC9pYN5u23BxEkh
   4AxISO3BZdABHyL5fwWSeDiG/Dx8XInIV/1/SQR6WiBBTvfg7g5o9F1H3
   1gL7dZX7kYyGyMuZF+XkBp4GG/oV7z5jGclOu9L8W1Eo9Y1tftY9RjbvW
   EygytCNwKByExlnp+JRdr9N7q3KfRwIwVmIhoHH43ZMsHdu4UjPpYvqIj
   Bl/fm6ikO/T+VDuRip792SAMDPG5XhsbwC5+GahjVq/7CF4YpqUqdxOi8
   14Th74qCeNNql0zkkff35yJufv9XLfmK/MQUGEnA9hHHAAryuHAb/t4nD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257467306"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257467306"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 21:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="499476933"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2022 21:09:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVQPf-000FZ4-8c; Sat, 19 Mar 2022 04:09:59 +0000
Date:   Sat, 19 Mar 2022 12:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:locking/core 17/19] arch/x86/kvm/x86.h:29:30: error:
 too many arguments to function call, expected 0, have 1
Message-ID: <202203191213.tC0sjaY7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
head:   200a79c670d24d4d9a75a6a9cbfd14af2f5d0ad9
commit: 5c9f3806a4400c2957abeea9419547f856457a20 [17/19] lockdep: Fix -Wunused-parameter for _THIS_IP_
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220319/202203191213.tC0sjaY7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=5c9f3806a4400c2957abeea9419547f856457a20
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue locking/core
        git checkout 5c9f3806a4400c2957abeea9419547f856457a20
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/x86.c:22:
   In file included from arch/x86/kvm/mmu.h:7:
   In file included from arch/x86/kvm/cpuid.h:5:
>> arch/x86/kvm/x86.h:29:30: error: too many arguments to function call, expected 0, have 1
           lockdep_hardirqs_on_prepare(CALLER_ADDR0);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~
   include/linux/ftrace.h:879:22: note: expanded from macro 'CALLER_ADDR0'
   #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:23:15: note: 'lockdep_hardirqs_on_prepare' declared here
     extern void lockdep_hardirqs_on_prepare(void);
                 ^
   In file included from arch/x86/kvm/x86.c:41:
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from arch/x86/kvm/emulate.c:28:
>> arch/x86/kvm/x86.h:29:30: error: too many arguments to function call, expected 0, have 1
           lockdep_hardirqs_on_prepare(CALLER_ADDR0);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~
   include/linux/ftrace.h:879:22: note: expanded from macro 'CALLER_ADDR0'
   #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:23:15: note: 'lockdep_hardirqs_on_prepare' declared here
     extern void lockdep_hardirqs_on_prepare(void);
                 ^
   1 error generated.


vim +29 arch/x86/kvm/x86.h

65297341d8e15b Uros Bizjak         2021-08-09  12  
bc908e091b3264 Sean Christopherson 2021-05-04  13  static __always_inline void kvm_guest_enter_irqoff(void)
bc908e091b3264 Sean Christopherson 2021-05-04  14  {
bc908e091b3264 Sean Christopherson 2021-05-04  15  	/*
bc908e091b3264 Sean Christopherson 2021-05-04  16  	 * VMENTER enables interrupts (host state), but the kernel state is
bc908e091b3264 Sean Christopherson 2021-05-04  17  	 * interrupts disabled when this is invoked. Also tell RCU about
bc908e091b3264 Sean Christopherson 2021-05-04  18  	 * it. This is the same logic as for exit_to_user_mode().
bc908e091b3264 Sean Christopherson 2021-05-04  19  	 *
bc908e091b3264 Sean Christopherson 2021-05-04  20  	 * This ensures that e.g. latency analysis on the host observes
bc908e091b3264 Sean Christopherson 2021-05-04  21  	 * guest mode as interrupt enabled.
bc908e091b3264 Sean Christopherson 2021-05-04  22  	 *
bc908e091b3264 Sean Christopherson 2021-05-04  23  	 * guest_enter_irqoff() informs context tracking about the
bc908e091b3264 Sean Christopherson 2021-05-04  24  	 * transition to guest mode and if enabled adjusts RCU state
bc908e091b3264 Sean Christopherson 2021-05-04  25  	 * accordingly.
bc908e091b3264 Sean Christopherson 2021-05-04  26  	 */
bc908e091b3264 Sean Christopherson 2021-05-04  27  	instrumentation_begin();
bc908e091b3264 Sean Christopherson 2021-05-04  28  	trace_hardirqs_on_prepare();
bc908e091b3264 Sean Christopherson 2021-05-04 @29  	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
bc908e091b3264 Sean Christopherson 2021-05-04  30  	instrumentation_end();
bc908e091b3264 Sean Christopherson 2021-05-04  31  
bc908e091b3264 Sean Christopherson 2021-05-04  32  	guest_enter_irqoff();
bc908e091b3264 Sean Christopherson 2021-05-04  33  	lockdep_hardirqs_on(CALLER_ADDR0);
bc908e091b3264 Sean Christopherson 2021-05-04  34  }
bc908e091b3264 Sean Christopherson 2021-05-04  35  

:::::: The code at line 29 was first introduced by commit
:::::: bc908e091b3264672889162733020048901021fb KVM: x86: Consolidate guest enter/exit logic to common helpers

:::::: TO: Sean Christopherson <seanjc@google.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
