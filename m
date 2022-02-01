Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1658B4A553A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiBAC0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:26:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:15103 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbiBAC0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643682368; x=1675218368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YQ/6K8JVlDEps0ImdFVt/QCjowH7QDab+zSfJOVunHw=;
  b=GdwZz1LonyR2SGE9R8AB7S9j+DINCGs35ysyYO/DB8dcfesOL3xoIrB7
   wLXNRwFzcL0qzlyaHDH4H2CbUqJc95cO+8k6R9u+8HEsfDrPDgdfDsART
   +Ek2F43E0lMDZyRtoJgOAtkOED4QANhNQZUr7tFRiAJfCCpjGKXWUwT5G
   cnTBVbhj4/qXw/ffVP2Zz63VzgWL3jAImoG5MYdND/mFyAtSIGHg8Cc5w
   sPhER7KiKeBl4ooqbXE5lL+x8dAA1IeCP5awHnxW5gm06HmzLuc3aZSba
   ePuh2ivVTTuCfWbJkcMDyIawAoUn0SybKq9tUmjGTvkQlb3AV4ndhc2n+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308339376"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="308339376"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 18:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="482030413"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2022 18:26:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEiru-000ScC-6d; Tue, 01 Feb 2022 02:26:06 +0000
Date:   Tue, 1 Feb 2022 10:25:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1907/2384] include/linux/rcupdate.h:396:11: error:
 dereferencing pointer to incomplete type 'struct bpf_prog'
Message-ID: <202202011049.F4KJNSg3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 9148be2620e41284eaeab31d70b5baa9130ec96b [1907/2384] headers/deps: net: Optimize <net/sock.h>, remove <linux/filter.h> inclusion
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202011049.F4KJNSg3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9148be2620e41284eaeab31d70b5baa9130ec96b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 9148be2620e41284eaeab31d70b5baa9130ec96b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/percpu-refcount-api.h:59,
                    from include/linux/percpu-refcount.h:6,
                    from include/linux/mm_api.h:42,
                    from include/linux/highmem-internal.h:5,
                    from include/linux/highmem.h:12,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff_types.h:14,
                    from include/linux/netdevice_types.h:24,
                    from include/linux/netdevice.h:5,
                    from include/linux/netdevice_api.h:24,
                    from include/net/sch_generic_types.h:6,
                    from include/net/sch_generic_api.h:6,
                    from include/net/pkt_sched.h:5,
                    from drivers/net/ethernet/mellanox/mlx4/en_netdev.c:34:
   drivers/net/ethernet/mellanox/mlx4/en_netdev.c: In function 'mlx4_en_try_alloc_resources':
>> include/linux/rcupdate.h:396:11: error: dereferencing pointer to incomplete type 'struct bpf_prog'
     396 |  ((typeof(*p) __force __kernel *)(p)); \
         |           ^
   include/linux/rcupdate.h:585:2: note: in expansion of macro '__rcu_dereference_protected'
     585 |  __rcu_dereference_protected((p), (c), __rcu)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx4/en_netdev.c:2325:13: note: in expansion of macro 'rcu_dereference_protected'
    2325 |  xdp_prog = rcu_dereference_protected(
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/skbuff_api.h:13,
                    from drivers/net/ethernet/sfc/net_driver.h:13,
                    from drivers/net/ethernet/sfc/efx_common.c:11:
   drivers/net/ethernet/sfc/efx_common.c: In function 'efx_change_mtu':
>> include/linux/rcupdate.h:396:11: error: dereferencing pointer to incomplete type 'struct bpf_prog'
     396 |  ((typeof(*p) __force __kernel *)(p)); \
         |           ^
   include/linux/rcupdate.h:585:2: note: in expansion of macro '__rcu_dereference_protected'
     585 |  __rcu_dereference_protected((p), (c), __rcu)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rtnetlink.h:81:2: note: in expansion of macro 'rcu_dereference_protected'
      81 |  rcu_dereference_protected(p, lockdep_rtnl_is_held())
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/efx_common.c:312:6: note: in expansion of macro 'rtnl_dereference'
     312 |  if (rtnl_dereference(efx->xdp_prog) &&
         |      ^~~~~~~~~~~~~~~~


vim +396 include/linux/rcupdate.h

76c8eaafe4f061f Paul E. McKenney        2021-04-21  377  
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  378  #define __rcu_access_pointer(p, space) \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  379  ({ \
7d0ae8086b82831 Paul E. McKenney        2015-03-03  380  	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
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
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28 @396  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  397  })
995f1405610bd84 Paul E. McKenney        2016-07-01  398  #define rcu_dereference_raw(p) \
995f1405610bd84 Paul E. McKenney        2016-07-01  399  ({ \
995f1405610bd84 Paul E. McKenney        2016-07-01  400  	/* Dependency order vs. p above. */ \
506458efaf153c1 Will Deacon             2017-10-24  401  	typeof(p) ________p1 = READ_ONCE(p); \
995f1405610bd84 Paul E. McKenney        2016-07-01  402  	((typeof(*p) __force __kernel *)(________p1)); \
995f1405610bd84 Paul E. McKenney        2016-07-01  403  })
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  404  

:::::: The code at line 396 was first introduced by commit
:::::: ca5ecddfa8fcbd948c95530e7e817cee9fb43a3d rcu: define __rcu address space modifier for sparse

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
