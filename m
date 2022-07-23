Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDDC57EC8F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiGWHuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGWHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:50:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FCB1EB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658562612; x=1690098612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2DPWEocs9So/VlQFT3+uJ204CFqtkS0MP6MrUFITSao=;
  b=kS8j1XMGT4YM+hDHtFclXKixRwAUHciW6am07ecXyaqfe+KEYWlRCoeT
   YYlD9zusVwr1zcw0NK7EYSqmvPvByaBoVbpUQUN0xgdG+5lGjhk7cs39k
   lQYarHSsAS4P/x2wBkE1WCLjEVqv6+UGAsN67M2ExjIr60qFYrCL8i8EZ
   CP9R9Wc4y2JT5XReMSUPg/8J+a7iV9fRXGflrL+teHw32YqlzlvWljyL+
   ysFLODQ55sCmHVHIycOacvP5LfV9gQ+ubZn1dhU1A7OVm1QPXnoO8uFMV
   h2QhJXRKA3fWp7iOkxHstmpmQiXm1eNbgN/tlIFElnETovLQSeRJsK5mV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="288632081"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="288632081"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 00:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="926306442"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2022 00:50:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF9tp-0002PN-2A;
        Sat, 23 Jul 2022 07:50:09 +0000
Date:   Sat, 23 Jul 2022 15:49:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tj/cgroup/for-next 7/8]
 kernel/cgroup/cgroup.c:1310:39: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared
Message-ID: <202207231547.F1PGIJ5n-lkp@intel.com>
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
config: arm64-buildonly-randconfig-r001-20220721 (https://download.01.org/0day-ci/archive/20220723/202207231547.F1PGIJ5n-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/79276d9e0dda30071b9a98045a3efa7e0a76938b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tj/cgroup/for-next
        git checkout 79276d9e0dda30071b9a98045a3efa7e0a76938b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/cgroup/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:1308:6: warning: no previous prototype for 'cgroup_favor_dynmods' [-Wmissing-prototypes]
    1308 | void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
         |      ^~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c: In function 'cgroup_favor_dynmods':
>> kernel/cgroup/cgroup.c:1310:39: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
    1310 |         bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c:1310:39: note: each undeclared identifier is reported only once for each function it appears in
   kernel/cgroup/cgroup.c: In function 'cgroup2_parse_param':
   kernel/cgroup/cgroup.c:1912:31: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
    1912 |                 ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
         |                               ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c: In function 'apply_cgroup_root_flags':
   kernel/cgroup/cgroup.c:1942:51: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
    1942 |                                      root_flags & CGRP_ROOT_FAVOR_DYNMODS);
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c: In function 'cgroup_show_options':
   kernel/cgroup/cgroup.c:1960:35: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
    1960 |         if (cgrp_dfl_root.flags & CGRP_ROOT_FAVOR_DYNMODS)
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup.c: In function 'init_cgroup_root':
   kernel/cgroup/cgroup.c:2013:37: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
    2013 |         root->flags = ctx->flags & ~CGRP_ROOT_FAVOR_DYNMODS;
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
--
   kernel/cgroup/cgroup-v1.c: In function 'cgroup1_show_options':
>> kernel/cgroup/cgroup-v1.c:878:27: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
     878 |         if (root->flags & CGRP_ROOT_FAVOR_DYNMODS)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup-v1.c:878:27: note: each undeclared identifier is reported only once for each function it appears in
   kernel/cgroup/cgroup-v1.c: In function 'cgroup1_parse_param':
   kernel/cgroup/cgroup-v1.c:970:31: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
     970 |                 ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
         |                               ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup-v1.c: In function 'cgroup1_root_to_use':
>> kernel/cgroup/cgroup-v1.c:1227:17: error: implicit declaration of function 'cgroup_favor_dynmods' [-Werror=implicit-function-declaration]
    1227 |                 cgroup_favor_dynmods(root, ctx->flags & CGRP_ROOT_FAVOR_DYNMODS);
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/cgroup/cgroup-v1.c:1227:57: error: 'CGRP_ROOT_FAVOR_DYNMODS' undeclared (first use in this function)
    1227 |                 cgroup_favor_dynmods(root, ctx->flags & CGRP_ROOT_FAVOR_DYNMODS);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
