Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57DE4DE5F2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiCSEcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiCSEcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:32:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B92D1CE2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647664262; x=1679200262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4TXtpZTFhKTJaQUWw6yi2Wr6LG+46KjXcInPX4RItVg=;
  b=mW7uGW8jAe7bev8oqEqJUxgZsGG+6KFyQiDESzrfD14JRLRZL6VKVuZx
   0rVz8xnUxy+FiaT37QTD5/cye2GpbPRg5LDrqzMSNIv4zCVkjBeqZmgi4
   P3Xbsju6j95rXsaDgEPCRZbq7KhzE9QYUR/jUMn53u0yGkM9txgWp6yDO
   SRSwIsowQHs+VYJsm04bwauR1y3zQA3lXrI5raIJraAXbU15Z79OUi0eP
   hUSyZoCrAfCdvMmqeJmBboAQnHGvgdn0FsVsL/FMdoo2oLKlnrAbnQA9l
   CGn3QrgpLE4Pvu8pvJPAU2u9lxHV3MJQtSJ5heKJq/kscyrCiD73H5P3c
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257468108"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257468108"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 21:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647768257"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2022 21:31:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVQjz-000FaO-UN; Sat, 19 Mar 2022 04:30:59 +0000
Date:   Sat, 19 Mar 2022 12:30:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:locking/core 17/19] arch/x86/kvm/x86.h:29:2: error:
 too many arguments to function 'lockdep_hardirqs_on_prepare'
Message-ID: <202203191233.qMjpfK62-lkp@intel.com>
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
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220319/202203191233.qMjpfK62-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=5c9f3806a4400c2957abeea9419547f856457a20
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue locking/core
        git checkout 5c9f3806a4400c2957abeea9419547f856457a20
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/cpuid.h:5,
                    from arch/x86/kvm/mmu.h:7,
                    from arch/x86/kvm/x86.c:22:
   arch/x86/kvm/x86.h: In function 'kvm_guest_enter_irqoff':
>> arch/x86/kvm/x86.h:29:2: error: too many arguments to function 'lockdep_hardirqs_on_prepare'
      29 |  lockdep_hardirqs_on_prepare(CALLER_ADDR0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/special_insns.h:10,
                    from arch/x86/include/asm/processor.h:25,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/x86/kvm/x86.c:19:
   include/linux/irqflags.h:23:15: note: declared here
      23 |   extern void lockdep_hardirqs_on_prepare(void);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/x86/kvm/vmx/../cpuid.h:5,
                    from arch/x86/kvm/vmx/evmcs.c:7:
   arch/x86/kvm/vmx/../x86.h: In function 'kvm_guest_enter_irqoff':
>> arch/x86/kvm/vmx/../x86.h:29:2: error: too many arguments to function 'lockdep_hardirqs_on_prepare'
      29 |  lockdep_hardirqs_on_prepare(CALLER_ADDR0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/special_insns.h:10,
                    from arch/x86/include/asm/processor.h:25,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from arch/x86/kvm/vmx/evmcs.c:4:
   include/linux/irqflags.h:23:15: note: declared here
      23 |   extern void lockdep_hardirqs_on_prepare(void);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/lockdep_hardirqs_on_prepare +29 arch/x86/kvm/x86.h

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
