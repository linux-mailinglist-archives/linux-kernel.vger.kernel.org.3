Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3544880BA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiAHBxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:53:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:61995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbiAHBxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641606812; x=1673142812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p8E+Qmznw6VKhvWNfDYlWw7TOx1oLVz8+XydTYShsdc=;
  b=c1KUDRmZHzEunaEkIZ1IK1eRsl+uyW49hr0sMKsN/3OoTimTqobPRR3e
   K9vfHcI2aCtYoYwvvD2SmQ+ZE4u2/2iofFJqzdh3w+bH9AHUdgJNe7pwX
   2yQcac8oowT6KsOJPT7YRo9F+siAZqQiyxODLCsZ6AflfFwqztJtbOhCh
   2td9urTODepRgwPYpo8FiC80bJmUl21gffS8NV2TDSFFS5bzjuCHqt4aQ
   dzW6A7AIjKX8xYvwBU2fMKpT1noWSFXrqS0hsUa1ic4aQPFBiUIkEI2jT
   vYSrbZ+ruqIv89MeT09d2s1MDMG6Uiyn95g86PY0lIrQHzRoTjPib42c3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240525746"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="240525746"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 17:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="473524766"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jan 2022 17:53:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n60vB-0000AE-9i; Sat, 08 Jan 2022 01:53:29 +0000
Date:   Sat, 8 Jan 2022 09:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1463/2372] include/linux/rcupdate.h:380:9:
 error: dereferencing pointer to incomplete type 'struct task_struct'
Message-ID: <202201080905.8oMAlQM1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: 65823a0df74cc06f6e926155ba09845aa643fe78 [1463/2372] headers/deps: rcu/wait: Remove <linux/sched/task_flags.h> from <linux/rcuwait.h>
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220108/202201080905.8oMAlQM1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=65823a0df74cc06f6e926155ba09845aa643fe78
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 65823a0df74cc06f6e926155ba09845aa643fe78
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/kernel/ kernel/ lib/

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
