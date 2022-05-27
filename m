Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2135366B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353466AbiE0RtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiE0RtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:49:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0E941B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653673742; x=1685209742;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nZwZrgmp10Lo6IGffhdw7x51UPevZsm3AJnZZZr63AQ=;
  b=S2GphY7zJe8uj3lbrykxA+ZwODyZvtSRM1H/YsHCrVccDf5TUDFDtFXH
   /9a/aQShgsPIhOUybHmNnM5KXt7WckowJm1c2Q4kYPWKpNxTRRKFTdFfv
   mECAQBOkCwbjHLzbWSQ2H8FeNJlFFf4DH5hFc5BZMXxWE79conzFKgxVo
   G6FjgmWJSMGuBeWjWAmA5aAzAESTfyOXWPBGR6pX+8hCWsUzRoAkbZerP
   lHtQE7NFGwayqiJythszBeYg2m1e9MioW3ccz6sOBDs5K7bn09bbNnV+C
   OqonAL0z2Wkuety9eLHRbOGHg97DG3vbLNvMhQdyRXIqOQUsYMMRffuTE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274547223"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274547223"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 10:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="610418348"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2022 10:49:00 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nue56-00050X-8I;
        Fri, 27 May 2022 17:49:00 +0000
Date:   Sat, 28 May 2022 01:48:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baisong Zhong <zhongbaisong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not
 used
Message-ID: <202205280150.1w6rdhr4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 28f152cd0926596e69d412467b11b6fe6fe4e864 sched/rt: fix build error when CONFIG_SYSCTL is disable
date:   7 weeks ago
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220528/202205280150.1w6rdhr4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28f152cd0926596e69d412467b11b6fe6fe4e864
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28f152cd0926596e69d412467b11b6fe6fe4e864
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:43:
   kernel/sched/rt.c:309:6: warning: no previous prototype for 'unregister_rt_sched_group' [-Wmissing-prototypes]
     309 | void unregister_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:311:6: warning: no previous prototype for 'free_rt_sched_group' [-Wmissing-prototypes]
     311 | void free_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:313:5: warning: no previous prototype for 'alloc_rt_sched_group' [-Wmissing-prototypes]
     313 | int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:716:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     716 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not used [-Wunused-const-variable=]
       9 | static const u64 max_rt_runtime = MAX_BW;
         |                  ^~~~~~~~~~~~~~


vim +/max_rt_runtime +9 kernel/sched/rt.c

d505b8af58912a Huaixin Chang  2020-04-25  @9  static const u64 max_rt_runtime = MAX_BW;
ce0dbbbb30aee6 Clark Williams 2013-02-07  10  

:::::: The code at line 9 was first introduced by commit
:::::: d505b8af58912ae1e1a211fabc9995b19bd40828 sched: Defend cfs and rt bandwidth quota against overflow

:::::: TO: Huaixin Chang <changhuaixin@linux.alibaba.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
