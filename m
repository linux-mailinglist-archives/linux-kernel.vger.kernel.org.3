Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C6449A12B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850006AbiAXX1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:27:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:60041 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1588228AbiAXWbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643063503; x=1674599503;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HxEmsutpEhk10QOpy3SMMDCGI2DgW2SDgMOjz2vX2gs=;
  b=Qeok7sOkJYLajeLsGAEHHKZBJnSoDDF+7og+8HYAsUqG4sRl8+CWCKUu
   jRpzhfa7xUNNmKVs8xkOG4hWZcrLb/Bf0inLObK2zHvG947eIvRU4LANY
   pavNwMl6t2plngPhcohpPPogwAx9kePBZJuoXaVpLXf2IxQ9CEn4WlEUx
   lQTZY25KbplKzM7rDzKewHIZMYMNuXHZib+cslFCAgAhEeGiOxXASxf10
   UwcQ1dg++T4WurBn2W531RzZIGQPOrrevIuVxDK81xOn2AEVP5wYfcA1w
   FT9a4egc/9giZtBHJTSS4IxrJPstHbXD9yocVyeWSmYC3Q2mBYj747Cuv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233526828"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="233526828"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 14:25:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="494778239"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2022 14:25:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC7lt-000J0a-TP; Mon, 24 Jan 2022 22:25:09 +0000
Date:   Tue, 25 Jan 2022 06:24:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1471/2384] include/linux/rcupdate.h:380:9:
 error: dereferencing pointer to incomplete type 'struct task_struct'
Message-ID: <202201250610.CvFrmXWz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

FYI, the error/warning still remains.

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 2343c4a8035421263b16ea777e945cc1b0cbd22f [1471/2384] headers/deps: rcu/wait: Remove <linux/sched/task_flags.h> from <linux/rcuwait.h>
config: i386-randconfig-a002-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250610.CvFrmXWz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=2343c4a8035421263b16ea777e945cc1b0cbd22f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 2343c4a8035421263b16ea777e945cc1b0cbd22f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mm_types.h:16,
                    from include/asm-generic/fixmap.h:19,
                    from arch/x86/include/asm/fixmap.h:192,
                    from arch/x86/include/asm/apic.h:13,
                    from arch/x86/kernel/apic/hw_nmi.c:15:
   include/linux/rcuwait.h: In function 'rcuwait_active':
>> include/linux/rcupdate.h:380:9: error: dereferencing pointer to incomplete type 'struct task_struct'
     380 |  typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
         |         ^
   include/linux/rcupdate.h:490:31: note: in expansion of macro '__rcu_access_pointer'
     490 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/rcuwait.h:33:11: note: in expansion of macro 'rcu_access_pointer'
      33 |  return !!rcu_access_pointer(w->task);
         |           ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/workqueue.h:16,
                    from include/linux/workqueue_api.h:2,
                    from arch/x86/kvm/lapic.c:19:
   include/linux/rcuwait.h: In function 'rcuwait_active':
>> include/linux/rcupdate.h:380:9: error: dereferencing pointer to incomplete type 'struct task_struct'
     380 |  typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
         |         ^
   include/linux/rcupdate.h:490:31: note: in expansion of macro '__rcu_access_pointer'
     490 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/rcuwait.h:33:11: note: in expansion of macro 'rcu_access_pointer'
      33 |  return !!rcu_access_pointer(w->task);
         |           ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/rcuwait_api.h:1,
                    from arch/x86/kvm/lapic.c:20:
   include/linux/rcuwait.h:34:1: error: control reaches end of non-void function [-Werror=return-type]
      34 | }
         | ^
   cc1: some warnings being treated as errors


vim +380 include/linux/rcupdate.h

76c8eaafe4f061 Paul E. McKenney        2021-04-21  377  
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  378  #define __rcu_access_pointer(p, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  379  ({ \
7d0ae8086b8283 Paul E. McKenney        2015-03-03 @380  	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  381) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  382  	((typeof(*p) __force __kernel *)(_________p1)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  383  })
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  384  #define __rcu_dereference_check(p, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  385  ({ \
ac59853c06993a Pranith Kumar           2014-11-13  386  	/* Dependency order vs. p above. */ \
506458efaf153c Will Deacon             2017-10-24  387  	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  388  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  389) 	rcu_check_sparse(p, space); \
ac59853c06993a Pranith Kumar           2014-11-13  390  	((typeof(*p) __force __kernel *)(________p1)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  391  })
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  392  #define __rcu_dereference_protected(p, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  393  ({ \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  394  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  395) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  396  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  397  })
995f1405610bd8 Paul E. McKenney        2016-07-01  398  #define rcu_dereference_raw(p) \
995f1405610bd8 Paul E. McKenney        2016-07-01  399  ({ \
995f1405610bd8 Paul E. McKenney        2016-07-01  400  	/* Dependency order vs. p above. */ \
506458efaf153c Will Deacon             2017-10-24  401  	typeof(p) ________p1 = READ_ONCE(p); \
995f1405610bd8 Paul E. McKenney        2016-07-01  402  	((typeof(*p) __force __kernel *)(________p1)); \
995f1405610bd8 Paul E. McKenney        2016-07-01  403  })
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  404  

:::::: The code at line 380 was first introduced by commit
:::::: 7d0ae8086b828311250c6afdf800b568ac9bd693 rcu: Convert ACCESS_ONCE() to READ_ONCE() and WRITE_ONCE()

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
