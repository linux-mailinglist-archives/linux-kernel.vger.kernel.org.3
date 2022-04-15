Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22497502FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351474AbiDOUcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350982AbiDOUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:32:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE43D9FDF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650054574; x=1681590574;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jKcfF/qLwtzaOpWHPJJFjp6xmmakOOiGrFBqVhfDi9I=;
  b=aKgRy3EWf8+IUevaQ/1CITI0pKfnLviIlIRuUkUDtT6oNWtlMUZDJm1Q
   /QDCrOvsqw7mMNJCJZ2UjKH8sY1LMM4doitft+cmW8OXLFz5qk2uN6dwo
   Ex8AEJxo3iYNYavBWPNw1x0vJGP5QH/xqDoWlDiEAoCBz8ZIFhbgg9vbw
   cq6MWgmNYk149McjT5z563lhxzQ9JHI1f6VqE2CaBlqr6XqiAkX801MxK
   cNRc5dqNpt5tYr5qIgpXbxhcU5mY6/WlIFlgnLpZLLjaKewfVimIWtaw8
   7oxJl170LACwATSXbX+dGUn43QaQ69KEZ0mlzRrcGVuk8dg316s/PzvMG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262980387"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262980387"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="527579284"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2022 13:29:32 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfSZQ-0002Nh-1L;
        Fri, 15 Apr 2022 20:29:32 +0000
Date:   Sat, 16 Apr 2022 04:29:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 23/27]
 include/linux/sched/signal.h:452:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202204160418.mfpTkqQ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   64978a9d068187798f29fccb0755af70776cf047
commit: 7dc1bdf5f1f10cabafc5d8792ac0867d584affe7 [23/27] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220416/202204160418.mfpTkqQ6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=7dc1bdf5f1f10cabafc5d8792ac0867d584affe7
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 7dc1bdf5f1f10cabafc5d8792ac0867d584affe7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/ptrace.c:54:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:54:22: sparse:    struct task_struct *
   kernel/ptrace.c:54:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:73:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:73:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:73:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:74:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:74:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:74:29: sparse:     got struct cred const *
   kernel/ptrace.c:128:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:128:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:128:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:132:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:132:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:132:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:170:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:170:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:170:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:202:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:202:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:202:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:209:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:209:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:209:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:219:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:219:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:219:9: sparse:    struct task_struct *
   kernel/ptrace.c:266:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:266:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:266:44: sparse:    struct task_struct *
   kernel/ptrace.c:466:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:466:24: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:466:24: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:491:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:491:26: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:491:26: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:527:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:527:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:527:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:535:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:535:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:535:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:583:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:583:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:583:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:585:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:585:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:585:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:776:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:776:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:776:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:784:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:784:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:784:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:907:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:907:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:907:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:911:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:911:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:911:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1141:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1141:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1141:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1143:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1143:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1143:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
>> include/linux/sched/signal.h:452:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:452:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:452:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/ptrace.c:533:38: sparse: sparse: dereference of noderef expression
   include/linux/sched/signal.h:744:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:744:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:744:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:723:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:744:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:744:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:744:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:739:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:913:9: sparse: sparse: context imbalance in 'ptrace_resume' - different lock contexts for basic block
>> include/linux/sched/signal.h:452:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:452:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:452:9: sparse:     got struct lockdep_map [noderef] __rcu *
   include/linux/sched/signal.h:744:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:744:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:744:37: sparse:     got struct spinlock [noderef] __rcu *
>> include/linux/sched/signal.h:452:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:452:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:452:9: sparse:     got struct lockdep_map [noderef] __rcu *
   include/linux/sched/signal.h:744:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:744:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:744:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1295:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
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
>> kernel/signal.c:887:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:887:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:887:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:1083:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/signal.c:1083:9: sparse:     expected struct qspinlock *lock
   kernel/signal.c:1083:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/signal.c:1331:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1331:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1331:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1332:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:1332:16: sparse:     expected struct k_sigaction *action
   kernel/signal.c:1332:16: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:1352:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1352:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1352:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1930:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1930:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1930:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2040:44: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2059:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2059:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2059:65: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2060:40: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2078:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2078:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2078:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2107:46: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2107:46: sparse:     expected struct task_struct *t
   kernel/signal.c:2107:46: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2108:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2108:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2108:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2137:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2137:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2137:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2140:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2140:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2140:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2173:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2173:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2173:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2214:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2214:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2214:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2216:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2216:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2216:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2268:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2268:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2268:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2324:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2324:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2324:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2365:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2365:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2365:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2367:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2367:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2367:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2467:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2467:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2467:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2551:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2551:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2551:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2563:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2563:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2563:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2598:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2598:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2598:52: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2600:49: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2638:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2638:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2638:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2967:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2967:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2967:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2987:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2987:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2987:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3054:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3054:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3054:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3056:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3056:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3056:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3207:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3207:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3207:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3210:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3210:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3210:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3597:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3597:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3597:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3609:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3609:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3609:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3614:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3614:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3614:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3619:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3619:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3619:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4073:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4073:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4073:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4085:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4085:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4085:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4103:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *k @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:4103:11: sparse:     expected struct k_sigaction *k
   kernel/signal.c:4103:11: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:4105:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4105:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4105:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4107:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4107:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4107:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4155:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4155:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4155:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:69:34: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:442:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:442:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:442:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:529:35: sparse: sparse: dereference of noderef expression
   kernel/signal.c:557:52: sparse: sparse: dereference of noderef expression
>> include/linux/sched/signal.h:452:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:452:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:452:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:1035:13: sparse: sparse: dereference of noderef expression
   include/linux/sched/signal.h:442:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:442:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:442:9: sparse:     got struct lockdep_map [noderef] __rcu *
   include/linux/sched/signal.h:442:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:442:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:442:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:744:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:744:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:744:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1302:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   include/linux/sched/signal.h:442:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:442:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:442:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:723:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:744:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:744:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:744:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:744:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:744:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:744:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'send_sigqueue' - wrong count at exit
   kernel/signal.c:2060:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2060:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2060:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2060:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:442:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:442:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:442:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:2393:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2600:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2600:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2600:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2600:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2720:33: sparse: sparse: context imbalance in 'get_signal' - unexpected unlock
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:442:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   include/linux/sched/signal.h:442:9: sparse:     expected struct lockdep_map const *lock
   include/linux/sched/signal.h:442:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:4074:33: sparse: sparse: dereference of noderef expression
   kernel/signal.c:4163:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4163:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4163:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4169:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4169:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4169:33: sparse:     got struct spinlock [noderef] __rcu *

vim +452 include/linux/sched/signal.h

   449	
   450	static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
   451	{
 > 452		lockdep_assert_held(&t->sighand->siglock);
   453	
   454		if (resume)
   455			t->jobctl &= ~JOBCTL_TRACED;
   456	
   457		signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
   458	}
   459	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
