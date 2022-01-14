Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69DD48E222
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiANB2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:28:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:40526 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbiANB2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642123700; x=1673659700;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mWMDgej6uot+0DRGM53qdr4l1XU7cxzO10PqdAjoqFo=;
  b=f30EPcBgzqyYb/QhIb6EUv7US951YAz4DupZ8YnssFj7NV+qNuCIvMMN
   ryFv3RcMCU3JOe2+GI+dLiik64uMccOYYXg4/stM/3FHdC3qFQbVvtNJG
   eDtvFKChV7JAbbLxcmzN4uH6zkzoyZyymy3/AVrMtaRqsoUk0bVSyJklN
   PZ7BMla50vpum+Kt9r8JDvIbSX8u6zUFugsTmKbXx3NfbujDWJwAIpFbH
   jgm0bBGg7hB7RxZfYTv3vSoEI5O47wi7r7sj8DDFn/bimxCjNiIFJ0IZA
   QlYX1QSvAJI/fqqhpXlc7rBU99ABEiun+XlaRdCKkvYQjyzWjO5BeDvO2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224141291"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="224141291"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="692020034"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 17:28:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8BO5-0007ti-QM; Fri, 14 Jan 2022 01:28:17 +0000
Date:   Fri, 14 Jan 2022 09:27:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1471/2382] include/linux/rcupdate.h:380:9: error:
 dereferencing pointer to incomplete type 'struct task_struct'
Message-ID: <202201140915.k0d5wA8g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: 2343c4a8035421263b16ea777e945cc1b0cbd22f [1471/2382] headers/deps: rcu/wait: Remove <linux/sched/task_flags.h> from <linux/rcuwait.h>
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220114/202201140915.k0d5wA8g-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=2343c4a8035421263b16ea777e945cc1b0cbd22f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 2343c4a8035421263b16ea777e945cc1b0cbd22f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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
--
   In file included from include/linux/rcuwait.h:5,
                    from include/linux/irq_work.h:7,
                    from arch/x86/include/asm/nmi.h:5,
                    from arch/x86/kernel/cpu/perfctr-watchdog.c:20:
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


vim +380 include/linux/rcupdate.h

76c8eaafe4f061f Paul E. McKenney        2021-04-21  377  
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  378  #define __rcu_access_pointer(p, space) \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  379  ({ \
7d0ae8086b82831 Paul E. McKenney        2015-03-03 @380  	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
423a86a610cad12 Joel Fernandes (Google  2018-12-12  381) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  382  	((typeof(*p) __force __kernel *)(_________p1)); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  383  })
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  384  #define __rcu_dereference_check(p, c, space) \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  385  ({ \
ac59853c06993a4 Pranith Kumar           2014-11-13  386  	/* Dependency order vs. p above. */ \
506458efaf153c1 Will Deacon             2017-10-24  387  	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
f78f5b90c4ffa55 Paul E. McKenney        2015-06-18  388  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
423a86a610cad12 Joel Fernandes (Google  2018-12-12  389) 	rcu_check_sparse(p, space); \
ac59853c06993a4 Pranith Kumar           2014-11-13  390  	((typeof(*p) __force __kernel *)(________p1)); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  391  })
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  392  #define __rcu_dereference_protected(p, c, space) \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  393  ({ \
f78f5b90c4ffa55 Paul E. McKenney        2015-06-18  394  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
423a86a610cad12 Joel Fernandes (Google  2018-12-12  395) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  396  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  397  })
995f1405610bd84 Paul E. McKenney        2016-07-01  398  #define rcu_dereference_raw(p) \
995f1405610bd84 Paul E. McKenney        2016-07-01  399  ({ \
995f1405610bd84 Paul E. McKenney        2016-07-01  400  	/* Dependency order vs. p above. */ \
506458efaf153c1 Will Deacon             2017-10-24  401  	typeof(p) ________p1 = READ_ONCE(p); \
995f1405610bd84 Paul E. McKenney        2016-07-01  402  	((typeof(*p) __force __kernel *)(________p1)); \
995f1405610bd84 Paul E. McKenney        2016-07-01  403  })
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  404  

:::::: The code at line 380 was first introduced by commit
:::::: 7d0ae8086b828311250c6afdf800b568ac9bd693 rcu: Convert ACCESS_ONCE() to READ_ONCE() and WRITE_ONCE()

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
