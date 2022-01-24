Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D1497A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbiAXIQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:16:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:58474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242062AbiAXIPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643012124; x=1674548124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HujrP6/5teoeAUcPVfeZHIAMjk1F8hBwcrvkJpHJEIw=;
  b=V7S+Dg20JK34m/N4Yk9mbf9lCRSLFv5PBvoK25fyTe7ozaXsM6KJsNHQ
   GAe1pSMaMgnMN4VWPWKB5Hhr5SlDaG4gUSzPoXspiMGs8hvLaoy5uHHL+
   P5Va7G48+kXVxTGyceGLpRPFnwSzms5w776X5fMYp2UPKXI6tUFOGemtQ
   1g294HZeNI3poy5EDCo0INrjvElpoo+IMo0vm1WA+E0AP0pTmYaXhMaZN
   aaIEa3dFRlf0jSvbU7zn31p4xSgUrLL7T7kidOiTKL/ItJEo5pfzApgKY
   vzJ1V0F4/d28FgvRjbO4ykYhfBXq6TyRLMaXRwUAQW4OMPa+jSF6I321K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306708799"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306708799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="519852305"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2022 00:15:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBuVV-000Hxj-Im; Mon, 24 Jan 2022 08:15:21 +0000
Date:   Mon, 24 Jan 2022 16:14:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxim Mikityanskiy <maximmi@mellanox.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: [ammarfaizi2-block:mellanox/linux/queue-next 106/133]
 include/linux/rcupdate.h:390:9: error: dereferencing pointer to incomplete
 type 'struct mlx5e_selq_params'
Message-ID: <202201241612.OX49g5Am-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block mellanox/linux/queue-next
head:   32b13b2dd056afa99be1f0904e767d4fc980d6e2
commit: 96e88d9f06884769fac7248d445d5c031da26484 [106/133] net/mlx5e: Use select queue parameters to sync with control flow
config: i386-randconfig-a005-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241612.OX49g5Am-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/96e88d9f06884769fac7248d445d5c031da26484
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block mellanox/linux/queue-next
        git checkout 96e88d9f06884769fac7248d445d5c031da26484
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/rculist.h:11,
                    from include/linux/dcache.h:8,
                    from include/linux/fs.h:8,
                    from include/linux/highmem.h:5,
                    from drivers/net/ethernet/mellanox/mlx5/core/main.c:33:
   drivers/net/ethernet/mellanox/mlx5/core/en/selq.h: In function 'mlx5e_selq_get_params':
>> include/linux/rcupdate.h:390:9: error: dereferencing pointer to incomplete type 'struct mlx5e_selq_params'
     390 |  typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
         |         ^
   include/linux/rcupdate.h:544:2: note: in expansion of macro '__rcu_dereference_check'
     544 |  __rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:605:31: note: in expansion of macro 'rcu_dereference_bh_check'
     605 | #define rcu_dereference_bh(p) rcu_dereference_bh_check(p, 0)
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/selq.h:21:9: note: in expansion of macro 'rcu_dereference_bh'
      21 |  return rcu_dereference_bh(selq->active);
         |         ^~~~~~~~~~~~~~~~~~


vim +390 include/linux/rcupdate.h

76c8eaafe4f061 Paul E. McKenney        2021-04-21  380  
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  381  #define __rcu_access_pointer(p, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  382  ({ \
7d0ae8086b8283 Paul E. McKenney        2015-03-03  383  	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  384) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  385  	((typeof(*p) __force __kernel *)(_________p1)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  386  })
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  387  #define __rcu_dereference_check(p, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  388  ({ \
ac59853c06993a Pranith Kumar           2014-11-13  389  	/* Dependency order vs. p above. */ \
506458efaf153c Will Deacon             2017-10-24 @390  	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  391  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  392) 	rcu_check_sparse(p, space); \
ac59853c06993a Pranith Kumar           2014-11-13  393  	((typeof(*p) __force __kernel *)(________p1)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  394  })
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  395  #define __rcu_dereference_protected(p, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  396  ({ \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  397  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  398) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  399  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  400  })
995f1405610bd8 Paul E. McKenney        2016-07-01  401  #define rcu_dereference_raw(p) \
995f1405610bd8 Paul E. McKenney        2016-07-01  402  ({ \
995f1405610bd8 Paul E. McKenney        2016-07-01  403  	/* Dependency order vs. p above. */ \
506458efaf153c Will Deacon             2017-10-24  404  	typeof(p) ________p1 = READ_ONCE(p); \
995f1405610bd8 Paul E. McKenney        2016-07-01  405  	((typeof(*p) __force __kernel *)(________p1)); \
995f1405610bd8 Paul E. McKenney        2016-07-01  406  })
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  407  

:::::: The code at line 390 was first introduced by commit
:::::: 506458efaf153c1ea480591c5602a5a3ba5a3b76 locking/barriers: Convert users of lockless_dereference() to READ_ONCE()

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
