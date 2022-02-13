Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED084B392A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 04:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiBMDCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 22:02:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiBMDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 22:02:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0335F381
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 19:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644721364; x=1676257364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sabLo+W5QfhOuINKXOF5o2N6LTlynbU6SjwZ3nYhAcc=;
  b=IqOQStPLoaMATh7DYYACbbPDppMs/rK6TypMHtrLIn3aTVMg4bHe/S89
   yq4kW+KOqxFEF6PjcC1gfhgeRKS/bpSPsw2y9HWzn/f/7SUjTYBdMIPz/
   3eE7GcByzy9kZ7E7IHCJuIjpTXuLnSpL4uMdoU1iQn+DZwIKG7tzLIyuF
   zowJ9L7xxpkK84XeT5eRCYmIhScXgmkvey+dgOSix8nvLuqOQ8PfPZ64i
   G0mSVj+3tJYiEjJhDmFXrdPnm3blrEa+djWX/w0nNRbVyhqV6kf+Rbxoh
   uQPMIbHdDge3HvwtWTmVpSH1pycYdPj+kUFnwGOv8I/1ZyjI4N6ZPeGrR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="274481584"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="274481584"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 19:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="527402592"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Feb 2022 19:02:43 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ59u-0006wE-ET; Sun, 13 Feb 2022 03:02:42 +0000
Date:   Sun, 13 Feb 2022 11:02:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:set_fs 6/11] arch/nios2/kernel/signal.c:109:14:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202202131038.l60bQPlc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs
head:   0a081326831928b0d739bce68b8c0f9138b9c8ba
commit: a954036380ae20dbfa0c203bf6cafb21d1f3cedd [6/11] uaccess: generalize access_ok()
config: nios2-randconfig-s031-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131038.l60bQPlc-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs
        git checkout a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/nios2/kernel/signal.c:109:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got struct rt_sigframe *frame @@
   arch/nios2/kernel/signal.c:109:14: sparse:     expected void const [noderef] __user *ptr
   arch/nios2/kernel/signal.c:109:14: sparse:     got struct rt_sigframe *frame
   arch/nios2/kernel/signal.c:112:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct sigset_t * @@
   arch/nios2/kernel/signal.c:112:37: sparse:     expected void const [noderef] __user *from
   arch/nios2/kernel/signal.c:112:37: sparse:     got struct sigset_t *
   arch/nios2/kernel/signal.c:189:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct siginfo [noderef] [usertype] __user *to @@     got struct siginfo * @@
   arch/nios2/kernel/signal.c:189:46: sparse:     expected struct siginfo [noderef] [usertype] __user *to
   arch/nios2/kernel/signal.c:189:46: sparse:     got struct siginfo *
   arch/nios2/kernel/signal.c:192:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__pu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:192:16: sparse:     expected unsigned long [noderef] __user *__pu_ptr
   arch/nios2/kernel/signal.c:192:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:193:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucontext *[noderef] __user *__pu_ptr @@     got struct ucontext ** @@
   arch/nios2/kernel/signal.c:193:16: sparse:     expected struct ucontext *[noderef] __user *__pu_ptr
   arch/nios2/kernel/signal.c:193:16: sparse:     got struct ucontext **
   arch/nios2/kernel/signal.c:194:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigaltstack [noderef] [usertype] __user * @@     got struct sigaltstack * @@
   arch/nios2/kernel/signal.c:194:33: sparse:     expected struct sigaltstack [noderef] [usertype] __user *
   arch/nios2/kernel/signal.c:194:33: sparse:     got struct sigaltstack *
   arch/nios2/kernel/signal.c:196:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct sigset_t * @@
   arch/nios2/kernel/signal.c:196:30: sparse:     expected void [noderef] __user *to
   arch/nios2/kernel/signal.c:196:30: sparse:     got struct sigset_t *
   arch/nios2/kernel/signal.c:48:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__gu_ptr @@     got int * @@
   arch/nios2/kernel/signal.c:48:15: sparse:     expected int const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:48:15: sparse:     got int *
   arch/nios2/kernel/signal.c:52:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:52:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:52:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:53:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:53:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:53:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:54:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:54:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:55:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:55:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:55:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:56:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:56:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:56:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:57:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:57:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:57:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:58:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:58:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:58:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:59:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:59:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:59:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:60:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:60:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:60:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:61:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:61:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:61:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:62:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:62:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:62:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:63:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:63:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:63:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:64:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:64:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:64:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:65:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:65:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:65:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:66:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:66:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:66:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:67:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:67:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:67:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:68:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:68:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:68:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:69:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:69:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:69:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:70:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:70:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:70:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:71:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:71:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:71:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:72:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:72:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:72:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:73:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:73:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:73:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:74:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:74:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:74:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:76:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:76:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:76:16: sparse:     got unsigned long *
   arch/nios2/kernel/signal.c:78:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__gu_ptr @@     got unsigned long * @@
   arch/nios2/kernel/signal.c:78:16: sparse:     expected unsigned long const [noderef] __user *__gu_ptr
   arch/nios2/kernel/signal.c:78:16: sparse:     got unsigned long *

vim +109 arch/nios2/kernel/signal.c

b53e906d255d7b Ley Foon Tan      2014-11-06  100  
b53e906d255d7b Ley Foon Tan      2014-11-06  101  asmlinkage int do_rt_sigreturn(struct switch_stack *sw)
b53e906d255d7b Ley Foon Tan      2014-11-06  102  {
b53e906d255d7b Ley Foon Tan      2014-11-06  103  	struct pt_regs *regs = (struct pt_regs *)(sw + 1);
b53e906d255d7b Ley Foon Tan      2014-11-06  104  	/* Verify, can we follow the stack back */
b53e906d255d7b Ley Foon Tan      2014-11-06  105  	struct rt_sigframe *frame = (struct rt_sigframe *) regs->sp;
b53e906d255d7b Ley Foon Tan      2014-11-06  106  	sigset_t set;
b53e906d255d7b Ley Foon Tan      2014-11-06  107  	int rval;
b53e906d255d7b Ley Foon Tan      2014-11-06  108  
96d4f267e40f95 Linus Torvalds    2019-01-03 @109  	if (!access_ok(frame, sizeof(*frame)))
b53e906d255d7b Ley Foon Tan      2014-11-06  110  		goto badframe;
b53e906d255d7b Ley Foon Tan      2014-11-06  111  
b53e906d255d7b Ley Foon Tan      2014-11-06  112  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
b53e906d255d7b Ley Foon Tan      2014-11-06  113  		goto badframe;
b53e906d255d7b Ley Foon Tan      2014-11-06  114  
b53e906d255d7b Ley Foon Tan      2014-11-06  115  	set_current_blocked(&set);
b53e906d255d7b Ley Foon Tan      2014-11-06  116  
b53e906d255d7b Ley Foon Tan      2014-11-06  117  	if (rt_restore_ucontext(regs, sw, &frame->uc, &rval))
b53e906d255d7b Ley Foon Tan      2014-11-06  118  		goto badframe;
b53e906d255d7b Ley Foon Tan      2014-11-06  119  
b53e906d255d7b Ley Foon Tan      2014-11-06  120  	return rval;
b53e906d255d7b Ley Foon Tan      2014-11-06  121  
b53e906d255d7b Ley Foon Tan      2014-11-06  122  badframe:
3cf5d076fb4d48 Eric W. Biederman 2019-05-23  123  	force_sig(SIGSEGV);
b53e906d255d7b Ley Foon Tan      2014-11-06  124  	return 0;
b53e906d255d7b Ley Foon Tan      2014-11-06  125  }
b53e906d255d7b Ley Foon Tan      2014-11-06  126  

:::::: The code at line 109 was first introduced by commit
:::::: 96d4f267e40f9509e8a66e2b39e8b95655617693 Remove 'type' argument from access_ok() function

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
