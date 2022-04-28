Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737FF513BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351266AbiD1SxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351258AbiD1SxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:53:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C884A1D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651171796; x=1682707796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kTDQ8asjKztnqJvS5fU49Lf4c2PzMV7FMKINerYTb7c=;
  b=f1DA8wii3kKndZNM5GhbUxRSvgVqGBQQWJ7kGmMGwirfo49xQhfVTcTB
   F0o9Yd6NdyOL6YDQxZV7Nd0z0UoWCXwVrvvp0Ck1BoNbGrGIoPf74bDL2
   CatSvb3cUP8I39YjV2g2pN4ca0ptzAV4gVMShKbgSuoyv8V3Uq5LxqFsm
   5O2LCSG9326bhVPWqutQdEJeygpFngIEtc0FW9mnBrMH1YRcvgGsGV7Ks
   Jv9TaBf2hvB3jZlmu+oaLR6vPvEXzrBQABhy0UE3yvMQr5PjHYR7xRbsu
   tHlyAggJFBWKNUuuMhZIRQdaYeaIUs1Evce2uzBAvbV7B6ii2PGbRoljt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265913563"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="265913563"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="514431436"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2022 11:49:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk9C9-0005cV-Rk;
        Thu, 28 Apr 2022 18:48:53 +0000
Date:   Fri, 29 Apr 2022 02:48:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] arch/x86/mm/fault.c:152:29: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202204290236.XX6P9C4v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   956305b67dd062e5a58c68c871dee2ee1d579feb
commit: 2d7493c0421d267a906653b33aca69bf87f0595f [6/10] x86/uaccess: Remove tags from the address before checking
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220429/202204290236.XX6P9C4v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2d7493c0421d267a906653b33aca69bf87f0595f
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2d7493c0421d267a906653b33aca69bf87f0595f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/mm/ kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/mm/fault.c:152:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char *[assigned] instr @@
   arch/x86/mm/fault.c:152:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   arch/x86/mm/fault.c:152:29: sparse:     got unsigned char *[assigned] instr
--
   kernel/signal.c: note: in included file (through arch/x86/include/uapi/asm/signal.h, arch/x86/include/asm/signal.h, include/uapi/linux/signal.h, ...):
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:195:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:195:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:198:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:198:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:198:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:480:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:480:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:480:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:484:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:484:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:484:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:517:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:517:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:517:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:520:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:520:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:520:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:542:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:542:53: sparse:     expected struct k_sigaction *ka
   kernel/signal.c:542:53: sparse:     got struct k_sigaction [noderef] __rcu *
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:698:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:698:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:698:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:700:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:700:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:700:31: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:1263:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   kernel/signal.c:1263:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   kernel/signal.c:1263:29: sparse:     got unsigned char *
   kernel/signal.c:1330:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1330:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1330:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1331:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:1331:16: sparse:     expected struct k_sigaction *action
   kernel/signal.c:1331:16: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:1351:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1351:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1351:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1929:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1929:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1929:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2039:44: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2058:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2058:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2058:65: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2059:40: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2077:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2077:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2077:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2106:46: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2106:46: sparse:     expected struct task_struct *t
   kernel/signal.c:2106:46: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2107:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2107:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2107:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2136:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2136:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2136:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2139:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2139:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2139:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2172:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2172:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2172:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2213:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2213:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2213:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2215:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2215:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2215:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2266:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2266:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2266:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2322:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2322:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2322:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2363:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2363:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2363:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2365:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2365:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2365:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2464:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2464:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2464:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2548:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2548:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2548:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2560:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2560:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2560:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2595:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2595:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2595:52: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2597:49: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2635:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2635:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2635:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2964:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2964:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2964:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2984:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2984:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2984:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3051:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3051:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3051:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3053:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3053:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3053:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3204:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3204:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3204:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3207:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3207:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3207:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3594:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3594:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3594:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3606:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3606:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3606:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3611:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3611:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3611:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3616:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3616:29: sparse:     expected struct spinlock [usertype] *lock

vim +152 arch/x86/mm/fault.c

d24df8ecf9b6f8 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  119  
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  120  static int
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  121  is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  122  {
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  123  	unsigned char *max_instr;
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  124  	unsigned char *instr;
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  125  	int prefetch = 0;
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  126  
d24df8ecf9b6f8 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  127  	/* Erratum #91 affects AMD K8, pre-NPT CPUs */
d24df8ecf9b6f8 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  128  	if (!is_amd_k8_pre_npt())
d24df8ecf9b6f8 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  129  		return 0;
d24df8ecf9b6f8 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  130  
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  131  	/*
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  132  	 * If it was a exec (instruction fetch) fault on NX page, then
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  133  	 * do not ignore the fault:
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  134  	 */
1067f030994c69 arch/x86/mm/fault.c    Ricardo Neri      2017-10-27  135  	if (error_code & X86_PF_INSTR)
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  136  		return 0;
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  137  
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  138  	instr = (void *)convert_ip_to_linear(current, regs);
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  139  	max_instr = instr + 15;
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  140  
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  141  	/*
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  142  	 * This code has historically always bailed out if IP points to a
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  143  	 * not-present page (e.g. due to a race).  No one has ever
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  144  	 * complained about this.
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  145  	 */
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  146  	pagefault_disable();
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  147  
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  148  	while (instr < max_instr) {
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  149  		unsigned char opcode;
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  150  
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  151  		if (user_mode(regs)) {
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09 @152  			if (get_user(opcode, instr))
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  153  				break;
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  154  		} else {
25f12ae45fc193 arch/x86/mm/fault.c    Christoph Hellwig 2020-06-17  155  			if (get_kernel_nofault(opcode, instr))
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  156  				break;
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  157  		}
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  158  
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  159  		instr++;
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  160  
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  161  		if (!check_prefetch_opcode(regs, instr, opcode, &prefetch))
107a03678cac0d arch/x86/mm/fault.c    Ingo Molnar       2009-02-20  162  			break;
^1da177e4c3f41 arch/x86_64/mm/fault.c Linus Torvalds    2005-04-16  163  	}
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  164  
35f1c89b0cce24 arch/x86/mm/fault.c    Andy Lutomirski   2021-02-09  165  	pagefault_enable();
^1da177e4c3f41 arch/x86_64/mm/fault.c Linus Torvalds    2005-04-16  166  	return prefetch;
^1da177e4c3f41 arch/x86_64/mm/fault.c Linus Torvalds    2005-04-16  167  }
^1da177e4c3f41 arch/x86_64/mm/fault.c Linus Torvalds    2005-04-16  168  

:::::: The code at line 152 was first introduced by commit
:::::: 35f1c89b0cce247bf0213df243ed902989b1dcda x86/fault: Fix AMD erratum #91 errata fixup for user code

:::::: TO: Andy Lutomirski <luto@kernel.org>
:::::: CC: Borislav Petkov <bp@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
