Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB13E5633EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiGANCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiGANCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:02:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22A427C0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656680566; x=1688216566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gYEPIylGjAzEs46RObgXfTOqBonNLrGDPH+tMbIcZOo=;
  b=n1bfPHDGWAVFxI/h6BGH0Xa0hiqIjYyspiBubyvRzmU9Wmg9cc+Bl8kg
   vwHRhee0PSazyDhBoBYPVxEocdaK/hssog9ySto5F/kB/qQgvTDuwvbvB
   2W881z8R+s+hHZXXqdxWJQQyp/Fx5t3R6SCJnQObWzKyaIZKW2TXG76wS
   XhxVc8zoiWSPS/CVSiRZMMcMrxGupKW6PfA7tGR33H150aaZxFrh7CuUB
   X6b09+NeEf5SJETK3eRGeB1CuZrkLyNEDfkzg1J3mENXz7gCuGd/uwLxb
   uH9PiW7qqiTvU/nfSD3Hsdq+3OemvW7GtH8jy77JVk5CDQFM63Hz4Fb1I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="344331635"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="344331635"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="648340127"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2022 06:02:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7GIG-000Dwk-7L;
        Fri, 01 Jul 2022 13:02:44 +0000
Date:   Fri, 1 Jul 2022 21:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: kernel/sched/rt.c:257:6: warning: no previous declaration for
 'unregister_rt_sched_group'
Message-ID: <202207012028.flmyTBwm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a175eca0f3d747599f1fdfac04cc9195b71ec996
commit: b027789e5e50494c2325cc70c8642e7fd6059479 sched/fair: Prevent dead task groups from regaining cfs_rq's
date:   8 months ago
config: i386-randconfig-a001-20220613 (https://download.01.org/0day-ci/archive/20220701/202207012028.flmyTBwm-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b027789e5e50494c2325cc70c8642e7fd6059479
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b027789e5e50494c2325cc70c8642e7fd6059479
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/rt.c:257:6: warning: no previous declaration for 'unregister_rt_sched_group' [-Wmissing-declarations]
    void unregister_rt_sched_group(struct task_group *tg) { }
         ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:259:6: warning: no previous declaration for 'free_rt_sched_group' [-Wmissing-declarations]
    void free_rt_sched_group(struct task_group *tg) { }
         ^~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:261:5: warning: no previous declaration for 'alloc_rt_sched_group' [-Wmissing-declarations]
    int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
        ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:675:6: warning: no previous declaration for 'sched_rt_bandwidth_account' [-Wmissing-declarations]
    bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/unregister_rt_sched_group +257 kernel/sched/rt.c

   256	
 > 257	void unregister_rt_sched_group(struct task_group *tg) { }
   258	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
