Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D998F558AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiFWVhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiFWVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:37:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80984F457
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656020264; x=1687556264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X+Fu+IYtOXy7Z7jjxYt12Y5ve5dihyNWHmzBMUKkYNk=;
  b=WuudsgXS6V9ebYGcP5omaSBnvkHklVnCCWhreCXvJxKKWkKMvyLkbDtH
   wyITq9pxEwtnRf2b01hW3L02CQz3mEjdc7l43JL1njB4gIXzmkiyncuqn
   2mieV8SuMUjMGL6bujDKKgNkRU95PzmTjq0MpPn+dOLUStcRggzYSYw38
   ziJvdxftNd+sNKUunqKJxEV8sJkA8Nem/DU5XAncezuxZjeJA88DGGn9O
   XZLed60bENOABaY7Mo+HyHL2aweXNQqf00d7DbIpkXFVS3iNfLYFqZPyZ
   siNvrhdxrphP6Dh4eyi50sBcOWn/Xkebsnzw8ZJgM8r4akW6FPqOb63vE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="263884315"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="263884315"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 14:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="592899367"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2022 14:37:43 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4UWE-0003Bz-Fl;
        Thu, 23 Jun 2022 21:37:42 +0000
Date:   Fri, 24 Jun 2022 05:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: kernel/sched/rt.c:257:6: warning: no previous declaration for
 'unregister_rt_sched_group'
Message-ID: <202206240552.NqXLKyZT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92f20ff72066d8d7e2ffb655c2236259ac9d1c5d
commit: b027789e5e50494c2325cc70c8642e7fd6059479 sched/fair: Prevent dead task groups from regaining cfs_rq's
date:   7 months ago
config: i386-randconfig-a004-20220620 (https://download.01.org/0day-ci/archive/20220624/202206240552.NqXLKyZT-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b027789e5e50494c2325cc70c8642e7fd6059479
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b027789e5e50494c2325cc70c8642e7fd6059479
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

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
