Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB55B57ECC0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiGWIaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiGWIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:30:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AECD2BE6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658565014; x=1690101014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l+WRDwDn8RFs/v3cxwM8NeQyyKRnZQ8u4KQSj/cx4oQ=;
  b=IeXcyBabDbkXCyIkYMa40pP8gIp/RvsAwN5iS7gg4ocAHPuP4Qyb1VUa
   gQLVKCYQWnIgl9cmq0NMfGSG3h0eBt/EVHLl0xvyRk+JGAhqFphNX6qK6
   ERDRwY/iaD37/HBOrvQfuj39NUUgI3Tm5y+by0BQoMXM2Z1CCNb/TcDbh
   IEtAZwpP0bjMbdrA/9lJLHn4LH9ys4WLCTg+UnUVwW6L0bKTzCswd6+do
   NsKmIFtM+jsRW0Sfam24GxJlTwHM7Qb7UOUw3/dxiydeSPvw+mhlgLXxN
   T3uwbOZ4QBhPnwVA/VlzE4Rixhq5de55ie+hpOfloioBtxo+6wlfaiCW1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="373760259"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="373760259"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 01:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="631817685"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2022 01:30:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFAWZ-0002Qn-0z;
        Sat, 23 Jul 2022 08:30:11 +0000
Date:   Sat, 23 Jul 2022 16:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tj/cgroup/for-next 7/8]
 kernel/cgroup/cgroup.c:1310:32: error: use of undeclared identifier
 'CGRP_ROOT_FAVOR_DYNMODS'
Message-ID: <202207231608.bk36zznz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tj/cgroup/for-next
head:   c87b1452249c69cdec70d5de64ea81f56e1ba3f8
commit: 79276d9e0dda30071b9a98045a3efa7e0a76938b [7/8] cgroup: Make !percpu threadgroup_rwsem operations optional
config: hexagon-randconfig-r041-20220722 (https://download.01.org/0day-ci/archive/20220723/202207231608.bk36zznz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/79276d9e0dda30071b9a98045a3efa7e0a76938b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tj/cgroup/for-next
        git checkout 79276d9e0dda30071b9a98045a3efa7e0a76938b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/cgroup/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:1310:32: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
           bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
                                         ^
   kernel/cgroup/cgroup.c:1315:18: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                   root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
                                  ^
   kernel/cgroup/cgroup.c:1318:19: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                   root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
                                   ^
>> kernel/cgroup/cgroup.c:1308:6: warning: no previous prototype for function 'cgroup_favor_dynmods' [-Wmissing-prototypes]
   void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
        ^
   kernel/cgroup/cgroup.c:1308:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
   ^
   static 
   kernel/cgroup/cgroup.c:1912:17: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                   ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
                                 ^
   kernel/cgroup/cgroup.c:1915:18: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                   ctx->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
                                  ^
   kernel/cgroup/cgroup.c:1942:23: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                                        root_flags & CGRP_ROOT_FAVOR_DYNMODS);
                                                     ^
   kernel/cgroup/cgroup.c:1960:28: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
           if (cgrp_dfl_root.flags & CGRP_ROOT_FAVOR_DYNMODS)
                                     ^
   kernel/cgroup/cgroup.c:2013:30: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
           root->flags = ctx->flags & ~CGRP_ROOT_FAVOR_DYNMODS;
                                       ^
   1 warning and 8 errors generated.
--
>> kernel/cgroup/cgroup-v1.c:878:20: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
           if (root->flags & CGRP_ROOT_FAVOR_DYNMODS)
                             ^
   kernel/cgroup/cgroup-v1.c:970:17: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                   ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
                                 ^
   kernel/cgroup/cgroup-v1.c:973:18: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                   ctx->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
                                  ^
>> kernel/cgroup/cgroup-v1.c:1227:3: error: call to undeclared function 'cgroup_favor_dynmods'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   cgroup_favor_dynmods(root, ctx->flags & CGRP_ROOT_FAVOR_DYNMODS);
                   ^
   kernel/cgroup/cgroup-v1.c:1227:43: error: use of undeclared identifier 'CGRP_ROOT_FAVOR_DYNMODS'
                   cgroup_favor_dynmods(root, ctx->flags & CGRP_ROOT_FAVOR_DYNMODS);
                                                           ^
   5 errors generated.


vim +/CGRP_ROOT_FAVOR_DYNMODS +1310 kernel/cgroup/cgroup.c

  1307	
> 1308	void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
  1309	{
> 1310		bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
  1311	
  1312		/* see the comment above CGRP_ROOT_FAVOR_DYNMODS definition */
  1313		if (favor && !favoring) {
  1314			rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
  1315			root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
  1316		} else if (!favor && favoring) {
  1317			rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
  1318			root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
  1319		}
  1320	}
  1321	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
