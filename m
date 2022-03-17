Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDB4DBDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 05:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiCQE6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 00:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiCQE6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 00:58:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F94130C16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647492061; x=1679028061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9lx9kBfb2shFNRSXys9QN4+obFN8Xp43lXl3H8h0nAk=;
  b=UcVU3+KEZl1bu++efBKhYWeVR6emrVVkdRM/Yl4Q8jv1fRarWwHWidQU
   QXsvuUZ5bAxNwgnLA/D3OV2gPe2Qq1Fo5lUni//PwzskztQmpAt0gIkR+
   peaI3BNlMxGurJ6I431I3uChHwSupQq7AWOdK/ehvhD5Edb33+1lwMQjj
   ejDtGb4enLSHV7TRHC8ifSM1NR+3UVNnas2YMUBn784Xi8ZzT6Wjiojda
   WpZVrpudOdfGZ7YqWPzWJuP3zFNN40/fSeQ/4LyXTu1OGKI2SFJRZuE2q
   wvif4OAa+meK/a2WK05+1eV8+qIQ6tLuCKsBQvSMzK1efV6vD+ZpuOAbN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238940370"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="238940370"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 21:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="557760430"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2022 21:18:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUhaa-000DHv-Em; Thu, 17 Mar 2022 04:18:16 +0000
Date:   Thu, 17 Mar 2022 12:17:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1440/2335] include/linux/rcupdate.h:381:9: error:
 dereferencing pointer to incomplete type 'struct task_struct'
Message-ID: <202203171240.Swhj47Ft-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 60aa8b48a7618b32090b091987090a4795b278cb [1440/2335] headers/deps: rcu/wait: Remove <linux/sched/task_flags.h> from <linux/rcuwait.h>
config: i386-randconfig-a001-20220314 (https://download.01.org/0day-ci/archive/20220317/202203171240.Swhj47Ft-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=60aa8b48a7618b32090b091987090a4795b278cb
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 60aa8b48a7618b32090b091987090a4795b278cb
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/rcuwait.h:5,
                    from include/linux/percpu_rwsem.h:7,
                    from include/linux/percpu_rwsem_api.h:2,
                    from fs/ext4/migrate.c:10:
   include/linux/rcuwait.h: In function 'rcuwait_active':
>> include/linux/rcupdate.h:381:9: error: dereferencing pointer to incomplete type 'struct task_struct'
     381 |  typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |         ^
   include/linux/rcupdate.h:492:31: note: in expansion of macro '__rcu_access_pointer'
     492 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/rcuwait.h:33:11: note: in expansion of macro 'rcu_access_pointer'
      33 |  return !!rcu_access_pointer(w->task);
         |           ^~~~~~~~~~~~~~~~~~


vim +381 include/linux/rcupdate.h

76c8eaafe4f061 Paul E. McKenney        2021-04-21  378  
24ba53017e188e Chun-Hung Tseng         2021-09-15  379  #define __rcu_access_pointer(p, local, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  380  ({ \
24ba53017e188e Chun-Hung Tseng         2021-09-15 @381  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  382) 	rcu_check_sparse(p, space); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  383  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  384  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  385  #define __rcu_dereference_check(p, local, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  386  ({ \
ac59853c06993a Pranith Kumar           2014-11-13  387  	/* Dependency order vs. p above. */ \
24ba53017e188e Chun-Hung Tseng         2021-09-15  388  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  389  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  390) 	rcu_check_sparse(p, space); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  391  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  392  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  393  #define __rcu_dereference_protected(p, local, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  394  ({ \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  395  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  396) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  397  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  398  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  399  #define __rcu_dereference_raw(p, local) \
995f1405610bd8 Paul E. McKenney        2016-07-01  400  ({ \
995f1405610bd8 Paul E. McKenney        2016-07-01  401  	/* Dependency order vs. p above. */ \
24ba53017e188e Chun-Hung Tseng         2021-09-15  402  	typeof(p) local = READ_ONCE(p); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  403  	((typeof(*p) __force __kernel *)(local)); \
995f1405610bd8 Paul E. McKenney        2016-07-01  404  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  405  #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  406  

:::::: The code at line 381 was first introduced by commit
:::::: 24ba53017e188e031f9cb8b290286fad52d2af00 rcu: Replace ________p1 and _________p1 with __UNIQUE_ID(rcu)

:::::: TO: Chun-Hung Tseng <henrybear327@gmail.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
