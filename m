Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678D74B3335
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 06:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiBLFZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 00:25:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiBLFZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 00:25:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A93328E2A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 21:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644643527; x=1676179527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h37GbzHXLOjLnumzY1OjP3t0xgSy/CHirznPlcX44Tk=;
  b=RhrfvP9nTIC3izx1nFAQeu0I6YXJ+TO/I5wKHrIY27MhUuSkSkNnXz0W
   /kOhB/tEwQ+DfT3Aq4WVS3rCfgt8rGJO/5Z1UglIlV9Pfs03TC6dNiQ3S
   cPUrYi72n1kdRZWnBmT87XISTJKyVdIrddcVUVRuTkEL8D79PO8PxO9Uz
   0yz0am538bAL8H74j2puFZp+8UpRlTq0qghoK/YMUIBuKuWpFRBXPgYIB
   xo19MVh9nO+I0/Aw0A1EbGaQX1RNM8+eWXGgITQwxewv8uGpYOhxDSBuU
   +4lVfHUWTYmFN/ahVyhZhaUFwnPt/nL12Y2QcXi/06tB+CyMK/V9pkW8l
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="237260572"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="237260572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 21:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="527208526"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2022 21:25:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIkuS-0005fg-1N; Sat, 12 Feb 2022 05:25:24 +0000
Date:   Sat, 12 Feb 2022 13:24:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:locking/core 6/7] kernel/locking/lockdep.c:6017:57:
 error: 'offset' undeclared; did you mean 'off_t'?
Message-ID: <202202121348.Uty03Al8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
head:   2300c94a775d0f2a733ef11285cc0abe8126edf6
commit: 065af96d73df2653a2d7da572cf8ba57218479ef [6/7] locking/lockdep: Cleanup reinit_class()
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220212/202202121348.Uty03Al8-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=065af96d73df2653a2d7da572cf8ba57218479ef
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue locking/core
        git checkout 065af96d73df2653a2d7da572cf8ba57218479ef
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   kernel/locking/lockdep.c: In function 'reinit_class':
>> kernel/locking/lockdep.c:6017:57: error: 'offset' undeclared (first use in this function); did you mean 'off_t'?
    6017 |  BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
         |                                                         ^~~~~~
   include/linux/compiler_types.h:326:9: note: in definition of macro '__compiletime_assert'
     326 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:346:2: note: in expansion of macro '_compiletime_assert'
     346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   kernel/locking/lockdep.c:6017:2: note: in expansion of macro 'BUILD_BUG_ON'
    6017 |  BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
         |  ^~~~~~~~~~~~
   kernel/locking/lockdep.c:6017:57: note: each undeclared identifier is reported only once for each function it appears in
    6017 |  BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
         |                                                         ^~~~~~
   include/linux/compiler_types.h:326:9: note: in definition of macro '__compiletime_assert'
     326 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:346:2: note: in expansion of macro '_compiletime_assert'
     346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   kernel/locking/lockdep.c:6017:2: note: in expansion of macro 'BUILD_BUG_ON'
    6017 |  BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
         |  ^~~~~~~~~~~~


vim +6017 kernel/locking/lockdep.c

  6011	
  6012	static void reinit_class(struct lock_class *class)
  6013	{
  6014		WARN_ON_ONCE(!class->lock_entry.next);
  6015		WARN_ON_ONCE(!list_empty(&class->locks_after));
  6016		WARN_ON_ONCE(!list_empty(&class->locks_before));
> 6017		BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
  6018		BUILD_BUG_ON(offsetof(struct lock_class, locks_after) > offset);
  6019		BUILD_BUG_ON(offsetof(struct lock_class, locks_before) > offset);
  6020		memset_startat(class, 0, key);
  6021	}
  6022	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
