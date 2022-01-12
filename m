Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2E48C48F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiALNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:15:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:55272 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240633AbiALNPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641993348; x=1673529348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lfvkePIADNtvsOM3O+4EOfaKJDRflYFfJEeZtR9jA5w=;
  b=PM3CYZI/SRWp9YaQdPsl4ekNRzsSSDzbG5ynZNbb5MRRPYGhLAGcY4Xo
   vOl0+0F2bgmBn5VVNO3I1QxOWwmLq3/B+a/zDpnd3SzUIgjGyDC63U3l9
   vt6Q+SbeRRyWlVwWbtkpCnuXBbEeDfzj4z92kPU4BRe5hozd6Y09676vZ
   RJbO4HK1d18Ki9HRKrgvOMBZ8DXldoo9w+Xk+HO/IeX9D7toW5k+adjzo
   JZYMf0322RNlq2J6oiSbnhZIcyNX6dAhXhJCY/NAK3W8RddrLagEeVaJ1
   JYZXWJTut4b+701LrPhIdR6jW/MoJhLetF2Y3Jz3m+DYm+f4CGjkA2ytl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243929860"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243929860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="515481084"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Jan 2022 05:15:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7dTe-0005qA-FJ; Wed, 12 Jan 2022 13:15:46 +0000
Date:   Wed, 12 Jan 2022 21:15:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1470/2375] include/linux/rcupdate.h:380:9: error:
 dereferencing pointer to incomplete type 'struct task_struct'
Message-ID: <202201122122.PcOklMwO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   391ce485ced0e47bf8d2ce8bc32bb87887e16656
commit: 4d8fbe77fc63f683b6c14ba02bc96f6f53cc5fc1 [1470/2375] headers/deps: rcu/wait: Remove <linux/sched/task_flags.h> from <linux/rcuwait.h>
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220112/202201122122.PcOklMwO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4d8fbe77fc63f683b6c14ba02bc96f6f53cc5fc1
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 4d8fbe77fc63f683b6c14ba02bc96f6f53cc5fc1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/rcuwait.h:5,
                    from include/linux/percpu_rwsem.h:7,
                    from include/linux/percpu_rwsem_api.h:2,
                    from kernel/locking/locktorture.c:16:
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
