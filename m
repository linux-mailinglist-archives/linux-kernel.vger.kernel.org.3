Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591850494D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiDQTPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDQTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 15:15:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC313F25
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650222779; x=1681758779;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xtrEpLh6UiTV+1kZ95TE+8V5ZKjZ00SsRHrAgKeFScA=;
  b=X1qXk2Tw4MJdFPlV3Z9HGEpEhZBa4ZUg1QdwNeeMZSzb4HQ2jvzwE0BD
   efA+rnEuhnQm4YwdHcAprEG0CD+FA/vV5CuW5jiezYQvN5rI3hCBPMbKR
   HH+fqyw3SNlSBpA4SKVAr2XaiIgyegHgQueeyeiCsEgatrStLwSSj37TO
   KLi+XsvgRGDZWi+mxjtI2Jtpge3oWKYebqUqlj4B3PhpBf3Wh94IV3FAS
   rW2XQuUmiOyhPiREWPztmneLzabLqTfPzdqpSn3Ttc5yqns/iGjZe0nxH
   0Jz/h7m5qBTXiWKSYt4W0BmAUrDBDD0t2g2JGGnxVYJOKaIfYxg8hfi6Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="288491706"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="288491706"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 12:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="726399032"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2022 12:12:57 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngAKO-00046X-8y;
        Sun, 17 Apr 2022 19:12:56 +0000
Date:   Mon, 18 Apr 2022 03:12:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kees:for-next/randstruct 5/5]
 arch/x86/include/asm/cpufeature.h:194:54: error: no member named
 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
Message-ID: <202204180303.a8GY7xNF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/randstruct
head:   0f9614862c554c424c7b099d2cf84a3ecd755357
commit: 0f9614862c554c424c7b099d2cf84a3ecd755357 [5/5] randstruct: Enable Clang support
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220418/202204180303.a8GY7xNF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ef94609d6ebe981767788e6877b0b3b731d425af)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=0f9614862c554c424c7b099d2cf84a3ecd755357
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/randstruct
        git checkout 0f9614862c554c424c7b099d2cf84a3ecd755357
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
>> arch/x86/include/asm/cpufeature.h:194:54: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
                        [cap_byte] "i" (&((const char *)boot_cpu_data.x86_capability)[bit >> 3])
                                                                      ^~~~~~~~~~~~~~
                                                                      vmx_capability
   include/linux/compiler_types.h:283:42: note: expanded from macro 'asm_volatile_goto'
   #define asm_volatile_goto(x...) asm goto(x)
                                            ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
--
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:173:27: note: expanded from macro '_SIG_SET_OP'
           case 4: set->sig[3] = op(set->sig[3]);                          \
                                    ^        ~
   include/linux/signal.h:185:24: note: expanded from macro '_sig_not'
   #define _sig_not(x)     (~(x))
                              ^
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:173:10: note: expanded from macro '_SIG_SET_OP'
           case 4: set->sig[3] = op(set->sig[3]);                          \
                   ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:20: note: expanded from macro '_SIG_SET_OP'
                   set->sig[2] = op(set->sig[2]);                          \
                                    ^        ~
   include/linux/signal.h:185:24: note: expanded from macro '_sig_not'
   #define _sig_not(x)     (~(x))
                              ^
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_OP(signotset, _sig_not)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:3: note: expanded from macro '_SIG_SET_OP'
                   set->sig[2] = op(set->sig[2]);                          \
                   ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:10:
   include/linux/cred.h:254:17: error: no member named 'non_rcu' in 'struct cred'
           nonconst_cred->non_rcu = 0;
           ~~~~~~~~~~~~~  ^
   include/linux/cred.h:266:17: error: no member named 'non_rcu' in 'struct cred'
           nonconst_cred->non_rcu = 0;
           ~~~~~~~~~~~~~  ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   include/linux/fs.h:2896:17: error: no member named 'i_nlink' in 'struct inode'
           return !inode->i_nlink || inode_unhashed(inode);
                   ~~~~~  ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/x86/include/asm/pgtable.h:21:
>> arch/x86/include/asm/pkru.h:37:6: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           if (cpu_feature_enabled(X86_FEATURE_OSPKE))
               ^
   arch/x86/include/asm/cpufeature.h:139:65: note: expanded from macro 'cpu_feature_enabled'
           (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                                                          ^
   arch/x86/include/asm/cpufeature.h:204:23: note: expanded from macro 'static_cpu_has'
           __builtin_constant_p(boot_cpu_has(bit)) ?               \
                                ^
   arch/x86/include/asm/cpufeature.h:141:27: note: expanded from macro 'boot_cpu_has'
   #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
                                   ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/x86/include/asm/pgtable.h:21:
>> arch/x86/include/asm/pkru.h:37:6: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           if (cpu_feature_enabled(X86_FEATURE_OSPKE))
               ^
   arch/x86/include/asm/cpufeature.h:139:65: note: expanded from macro 'cpu_feature_enabled'
           (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                                                          ^
   arch/x86/include/asm/cpufeature.h:205:3: note: expanded from macro 'static_cpu_has'
                   boot_cpu_has(bit) :                             \
                   ^
   arch/x86/include/asm/cpufeature.h:141:27: note: expanded from macro 'boot_cpu_has'
   #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
                                   ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/x86/include/asm/pgtable.h:21:
   arch/x86/include/asm/pkru.h:44:7: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
                ^
   arch/x86/include/asm/cpufeature.h:139:65: note: expanded from macro 'cpu_feature_enabled'
           (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                                                          ^
   arch/x86/include/asm/cpufeature.h:204:23: note: expanded from macro 'static_cpu_has'
           __builtin_constant_p(boot_cpu_has(bit)) ?               \
                                ^
   arch/x86/include/asm/cpufeature.h:141:27: note: expanded from macro 'boot_cpu_has'
   #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
                                   ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/x86/include/asm/pgtable.h:21:
   arch/x86/include/asm/pkru.h:44:7: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
                ^
   arch/x86/include/asm/cpufeature.h:139:65: note: expanded from macro 'cpu_feature_enabled'
           (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                                                          ^
   arch/x86/include/asm/cpufeature.h:205:3: note: expanded from macro 'static_cpu_has'
                   boot_cpu_has(bit) :                             \
                   ^
   arch/x86/include/asm/cpufeature.h:141:27: note: expanded from macro 'boot_cpu_has'
   #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
                                   ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/x86/include/asm/pgtable.h:21:
   arch/x86/include/asm/pkru.h:56:7: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
                ^
   arch/x86/include/asm/cpufeature.h:139:65: note: expanded from macro 'cpu_feature_enabled'
           (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                                                          ^
   arch/x86/include/asm/cpufeature.h:204:23: note: expanded from macro 'static_cpu_has'
           __builtin_constant_p(boot_cpu_has(bit)) ?               \
                                ^
   arch/x86/include/asm/cpufeature.h:141:27: note: expanded from macro 'boot_cpu_has'
   #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
                                   ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/x86/include/asm/pgtable.h:21:
   arch/x86/include/asm/pkru.h:56:7: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
                ^
   arch/x86/include/asm/cpufeature.h:139:65: note: expanded from macro 'cpu_feature_enabled'
           (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                                                          ^
   arch/x86/include/asm/cpufeature.h:205:3: note: expanded from macro 'static_cpu_has'
                   boot_cpu_has(bit) :                             \
                   ^
   arch/x86/include/asm/cpufeature.h:141:27: note: expanded from macro 'boot_cpu_has'
   #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
                                   ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
>> arch/x86/include/asm/pgtable.h:249:9: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           return boot_cpu_has(X86_FEATURE_PSE);
                  ^
   arch/x86/include/asm/cpufeature.h:141:27: note: expanded from macro 'boot_cpu_has'
   #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
                                   ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   arch/x86/include/asm/pgtable.h:1424:9: error: no member named 'x86_capability' in 'struct cpuinfo_x86'; did you mean 'vmx_capability'?
           return boot_cpu_has_bug(X86_BUG_L1TF);
                  ^
   arch/x86/include/asm/cpufeature.h:215:32: note: expanded from macro 'boot_cpu_has_bug'
   #define boot_cpu_has_bug(bit)           cpu_has_bug(&boot_cpu_data, (bit))
                                           ^
   arch/x86/include/asm/cpufeature.h:210:30: note: expanded from macro 'cpu_has_bug'
   #define cpu_has_bug(c, bit)             cpu_has(c, (bit))
                                           ^
   arch/x86/include/asm/cpufeature.h:123:3: note: expanded from macro 'cpu_has'
            test_cpu_cap(c, bit))
            ^
   arch/x86/include/asm/cpufeature.h:54:40: note: expanded from macro 'test_cpu_cap'
            test_bit(bit, (unsigned long *)((c)->x86_capability))
                                                 ^
   arch/x86/include/asm/processor.h:91:10: note: 'vmx_capability' declared here
           __u32                   vmx_capability[NVMXINTS];
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:27:
>> arch/x86/kernel/asm-offsets_32.c:20:2: error: no member named 'x86_capability' in 'cpuinfo_x86'
           OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
           ^                                           ~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: expanded from macro 'OFFSET'
           DEFINE(sym, offsetof(struct str, mem))
                       ^                    ~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
   #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
                                   ^                        ~~~~~~
   include/linux/kbuild.h:6:62: note: expanded from macro 'DEFINE'
           asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
                                                                       ^~~
   28 warnings and 13 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1195: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +194 arch/x86/include/asm/cpufeature.h

b1ae32dbab50ed Alexei Starovoitov 2018-05-13  168  
a3c8acd04376d6 H. Peter Anvin     2010-05-11  169  /*
bfdd5a67c8cb02 Borislav Petkov    2019-03-29  170   * Static testing of CPU features. Used the same as boot_cpu_has(). It
bfdd5a67c8cb02 Borislav Petkov    2019-03-29  171   * statically patches the target code for additional performance. Use
bfdd5a67c8cb02 Borislav Petkov    2019-03-29  172   * static_cpu_has() only in fast paths, where every cycle counts. Which
bfdd5a67c8cb02 Borislav Petkov    2019-03-29  173   * means that the boot_cpu_has() variant is already fast enough for the
bfdd5a67c8cb02 Borislav Petkov    2019-03-29  174   * majority of cases and you should stick to using it as it is generally
bfdd5a67c8cb02 Borislav Petkov    2019-03-29  175   * only two instructions: a RIP-relative MOV and a TEST.
0507503671f9b1 H. Peter Anvin     2021-09-10  176   *
0507503671f9b1 H. Peter Anvin     2021-09-10  177   * Do not use an "m" constraint for [cap_byte] here: gcc doesn't know
0507503671f9b1 H. Peter Anvin     2021-09-10  178   * that this is only used on a fallback path and will sometimes cause
0507503671f9b1 H. Peter Anvin     2021-09-10  179   * it to manifest the address of boot_cpu_data in a register, fouling
0507503671f9b1 H. Peter Anvin     2021-09-10  180   * the mainline (post-initialization) code.
a3c8acd04376d6 H. Peter Anvin     2010-05-11  181   */
ae37a8cd9b0ad3 Borislav Petkov    2019-03-07  182  static __always_inline bool _static_cpu_has(u16 bit)
4a90a99c4f8002 Borislav Petkov    2013-06-09  183  {
2fe2a2c7a97c9b Juergen Gross      2021-03-11  184  	asm_volatile_goto(
2fe2a2c7a97c9b Juergen Gross      2021-03-11  185  		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
0507503671f9b1 H. Peter Anvin     2021-09-10  186  		".pushsection .altinstr_aux,\"ax\"\n"
c3462ba9868372 Ingo Molnar        2018-12-19  187  		"6:\n"
0507503671f9b1 H. Peter Anvin     2021-09-10  188  		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
c3462ba9868372 Ingo Molnar        2018-12-19  189  		" jnz %l[t_yes]\n"
c3462ba9868372 Ingo Molnar        2018-12-19  190  		" jmp %l[t_no]\n"
0507503671f9b1 H. Peter Anvin     2021-09-10  191  		".popsection\n"
3197b04bb39b59 Peter Zijlstra     2018-01-16  192  		 : : [feature]  "i" (bit),
2476f2fa20568b Brian Gerst        2016-01-27  193  		     [bitnum]   "i" (1 << (bit & 7)),
0507503671f9b1 H. Peter Anvin     2021-09-10 @194  		     [cap_byte] "i" (&((const char *)boot_cpu_data.x86_capability)[bit >> 3])
2476f2fa20568b Brian Gerst        2016-01-27  195  		 : : t_yes, t_no);
2476f2fa20568b Brian Gerst        2016-01-27  196  t_yes:
4a90a99c4f8002 Borislav Petkov    2013-06-09  197  	return true;
4a90a99c4f8002 Borislav Petkov    2013-06-09  198  t_no:
4a90a99c4f8002 Borislav Petkov    2013-06-09  199  	return false;
4a90a99c4f8002 Borislav Petkov    2013-06-09  200  }
4a90a99c4f8002 Borislav Petkov    2013-06-09  201  

:::::: The code at line 194 was first introduced by commit
:::::: 0507503671f9b1c867e889cbec0f43abf904f23c x86/asm: Avoid adding register pressure for the init case in static_cpu_has()

:::::: TO: H. Peter Anvin <hpa@zytor.com>
:::::: CC: Borislav Petkov <bp@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
