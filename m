Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC36159CC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiHVXzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHVXzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:55:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654751A15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661212517; x=1692748517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tFQDVwZvMv+nglgF99mz+DZ0QvluGZ60Ria0uLA8E9A=;
  b=NKYlXRJ49yphHnt85KFQ7U23wMbxKyeqabEsocsMK8gWgyuaUAqcSACF
   4NHCynrWav2Wey8WsJVnWyvyiSTo8qzSt9FDxBi7ArDBux4P+RqO7Edxw
   dQR59NwiD4qEtak/f9VzzjKvvoa0tClgu8dgAXqZaemHGmA9FGnMqSV53
   UNvzaXFfpNAh3uimLNnkrLMPX3CVwEL1feGhSaCxRP9y0qcUpSHKuCyzO
   jXrGn5H0nDCFdt6gwizAcwhMp6VbPQPWl9BVEP/PI3HZCSzd6Wblterdn
   RkKNW/O3L0+DGz7RFd3OvH656L2ZUvAjbtvSmhKQZY3Wm99qRSLSGbXuS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="276576392"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="276576392"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="642228127"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2022 16:55:15 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQHGE-0000sB-24;
        Mon, 22 Aug 2022 23:55:14 +0000
Date:   Tue, 23 Aug 2022 07:54:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] kernel/signal.c:1267:29: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202208230736.BKSkIiNH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20220823/202208230736.BKSkIiNH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2600a472582e2968633831d430c2a1366ad3e8b1
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2600a472582e2968633831d430c2a1366ad3e8b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
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
   kernel/signal.c:765:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:765:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:765:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:890:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:890:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:890:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:1086:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:1086:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:1086:9: sparse:     got struct lockdep_map [noderef] __rcu *
>> kernel/signal.c:1267:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   kernel/signal.c:1267:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   kernel/signal.c:1267:29: sparse:     got unsigned char *
   kernel/signal.c:1328:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1328:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1328:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1329:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:1329:16: sparse:     expected struct k_sigaction *action
   kernel/signal.c:1329:16: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:1349:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1349:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1349:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1938:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1938:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1938:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2048:44: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2067:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2067:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2067:65: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2068:40: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2086:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2086:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2086:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2115:53: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2115:53: sparse:     expected struct task_struct *t
   kernel/signal.c:2115:53: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2116:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2116:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2116:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2145:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2145:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2145:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2148:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2148:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2148:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2181:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2181:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2181:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2221:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2221:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2221:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2223:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2223:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2223:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2280:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2280:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2280:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2315:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2315:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2315:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2355:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2355:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2355:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2357:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2357:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2357:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2457:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2457:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2457:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2541:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2541:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2541:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2553:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2553:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2553:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2588:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2588:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2588:52: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2590:49: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2628:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2628:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2628:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2957:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2957:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2957:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2977:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2977:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2977:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3044:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3044:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3044:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3046:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3046:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3046:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3197:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3197:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3197:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3200:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3200:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3200:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3589:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3589:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3589:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3601:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3601:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3601:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3606:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3606:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3606:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3611:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3611:29: sparse:     expected struct spinlock [usertype] *lock

vim +1267 kernel/signal.c

7978b567d31555f Sukadev Bhattiprolu 2009-04-02  1254  
4aaefee589f97bb Al Viro             2012-11-05  1255  static void print_fatal_signal(int signr)
45807a1df9f51d2 Ingo Molnar         2007-07-15  1256  {
4aaefee589f97bb Al Viro             2012-11-05  1257  	struct pt_regs *regs = signal_pt_regs();
747800efbe8b984 Wang Xiaoqiang      2016-05-23  1258  	pr_info("potentially unexpected fatal signal %d.\n", signr);
45807a1df9f51d2 Ingo Molnar         2007-07-15  1259  
ca5cd877ae699e7 Al Viro             2007-10-29  1260  #if defined(__i386__) && !defined(__arch_um__)
747800efbe8b984 Wang Xiaoqiang      2016-05-23  1261  	pr_info("code at %08lx: ", regs->ip);
45807a1df9f51d2 Ingo Molnar         2007-07-15  1262  	{
45807a1df9f51d2 Ingo Molnar         2007-07-15  1263  		int i;
45807a1df9f51d2 Ingo Molnar         2007-07-15  1264  		for (i = 0; i < 16; i++) {
45807a1df9f51d2 Ingo Molnar         2007-07-15  1265  			unsigned char insn;
45807a1df9f51d2 Ingo Molnar         2007-07-15  1266  
b45c6e76bc2c72f Andi Kleen          2010-01-08 @1267  			if (get_user(insn, (unsigned char *)(regs->ip + i)))
b45c6e76bc2c72f Andi Kleen          2010-01-08  1268  				break;
747800efbe8b984 Wang Xiaoqiang      2016-05-23  1269  			pr_cont("%02x ", insn);
45807a1df9f51d2 Ingo Molnar         2007-07-15  1270  		}
45807a1df9f51d2 Ingo Molnar         2007-07-15  1271  	}
747800efbe8b984 Wang Xiaoqiang      2016-05-23  1272  	pr_cont("\n");
45807a1df9f51d2 Ingo Molnar         2007-07-15  1273  #endif
3a9f84d354ce1e1 Ed Swierk           2009-01-26  1274  	preempt_disable();
45807a1df9f51d2 Ingo Molnar         2007-07-15  1275  	show_regs(regs);
3a9f84d354ce1e1 Ed Swierk           2009-01-26  1276  	preempt_enable();
45807a1df9f51d2 Ingo Molnar         2007-07-15  1277  }
45807a1df9f51d2 Ingo Molnar         2007-07-15  1278  

:::::: The code at line 1267 was first introduced by commit
:::::: b45c6e76bc2c72f6426c14bed64fdcbc9bf37cb0 kernel/signal.c: fix kernel information leak with print-fatal-signals=1

:::::: TO: Andi Kleen <andi@firstfloor.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
