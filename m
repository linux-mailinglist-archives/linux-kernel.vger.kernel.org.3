Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7450BA35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446894AbiDVOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiDVOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:39:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13435BD16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650638183; x=1682174183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JFDdqTcIX1cgK2UYp8AZGiljDIwjZEo8m5QMnW4XxYE=;
  b=KeUSYmFl6gkXFhnaF8hlWDOjWB+GGyfbVLd+Zf81mwZXGMKmnDoNqKpm
   0lBwJoqkXygwXe9CGRfqFfGgBZ2E+xohOutizKqUCETBJJ+ZJLpTuuMw+
   MlpBgJJrnwaJfZpJF7TFmWwiIKbpSrAD158yPcTuiR4xbmw17dQbany4m
   QrApF5mo1Cx8jMcWeuRs5AbTwunsKGruZoxuTNMgN3Nvj/xz1sP9hKLG3
   OT5o4bgx3IYJ3QqVOA1i8c0VLfhESdz9SXjPA7m+5jbJFSATvKURkNAkr
   RP5u6aOSvGRHZSCu4XD4pdwaRejKV1Lnl0O2lX/HwGUkSaqi6vuYMf3q4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245262080"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="245262080"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 07:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="615427258"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Apr 2022 07:36:22 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhuOT-000AFP-MQ;
        Fri, 22 Apr 2022 14:36:21 +0000
Date:   Fri, 22 Apr 2022 22:35:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>
Subject: drivers/md/raid5.c:7055:9: sparse: sparse: cast removes address
 space '__percpu' of expression
Message-ID: <202204222216.4w3jpAqk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d569e86915b7f2f9795588591c8d5ea0b66481cb
commit: 770b1d216d7371c94c88713824da4be4bc39a4e0 md/raid5: play nice with PREEMPT_RT
date:   4 months ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220422/202204222216.4w3jpAqk-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=770b1d216d7371c94c88713824da4be4bc39a4e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 770b1d216d7371c94c88713824da4be4bc39a4e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/md/raid5.c: note: in included file:
   drivers/md/raid5.h:271:14: sparse: sparse: array of flexible structures
   drivers/md/raid5.c:641:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:641:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:641:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:643:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:643:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:643:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:667:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:667:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:667:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:669:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:669:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:669:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:1101:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:1101:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:1101:25: sparse:    struct md_rdev *
   drivers/md/raid5.c:1103:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:1103:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:1103:24: sparse:    struct md_rdev *
   drivers/md/raid5.c:3563:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3563:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3563:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:3689:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3689:48: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3689:48: sparse:    struct md_rdev *
   drivers/md/raid5.c:3696:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3696:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3696:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:3718:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3718:16: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3718:16: sparse:    struct md_rdev *
   drivers/md/raid5.c:4646:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4646:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4646:24: sparse:    struct md_rdev *
   drivers/md/raid5.c:4657:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4657:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4657:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:4704:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4704:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4704:49: sparse:    struct md_rdev *
   drivers/md/raid5.c:4717:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4717:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4717:49: sparse:    struct md_rdev *
   drivers/md/raid5.c:4726:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4726:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4726:49: sparse:    struct md_rdev *
   drivers/md/raid5.c:4748:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4748:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4748:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:5419:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:5419:16: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:5419:16: sparse:    struct md_rdev *
   drivers/md/raid5.c:5422:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:5422:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:5422:24: sparse:    struct md_rdev *
>> drivers/md/raid5.c:7055:9: sparse: sparse: cast removes address space '__percpu' of expression
>> drivers/md/raid5.c:7055:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map *lock @@     got struct lockdep_map [noderef] __percpu * @@
   drivers/md/raid5.c:7055:9: sparse:     expected struct lockdep_map *lock
   drivers/md/raid5.c:7055:9: sparse:     got struct lockdep_map [noderef] __percpu *
>> drivers/md/raid5.c:7055:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   drivers/md/raid5.c:7055:9: sparse:     expected struct local_lock_t [usertype] *l
   drivers/md/raid5.c:7055:9: sparse:     got struct local_lock_t [noderef] __percpu *
   drivers/md/raid5.c:7808:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:7808:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:7808:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:8021:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:8021:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:8021:25: sparse:    struct md_rdev *
   drivers/md/raid5.c:8037:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:8037:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:8037:25: sparse:    struct md_rdev *
   drivers/md/raid5.c:1476:16: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:1476:39: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2208:54: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2419:16: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2421:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2422:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7031:23: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7031:23: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7032:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7033:16: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7034:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7039:34: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7040:17: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7041:22: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:97:9: sparse: sparse: context imbalance in 'raid5_quiesce' - different lock contexts for basic block

vim +/__percpu +7055 drivers/md/raid5.c

  7036	
  7037	static int alloc_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu)
  7038	{
  7039		if (conf->level == 6 && !percpu->spare_page) {
  7040			percpu->spare_page = alloc_page(GFP_KERNEL);
  7041			if (!percpu->spare_page)
  7042				return -ENOMEM;
  7043		}
  7044	
  7045		if (scribble_alloc(percpu,
  7046				   max(conf->raid_disks,
  7047				       conf->previous_raid_disks),
  7048				   max(conf->chunk_sectors,
  7049				       conf->prev_chunk_sectors)
  7050				   / RAID5_STRIPE_SECTORS(conf))) {
  7051			free_scratch_buffer(conf, percpu);
  7052			return -ENOMEM;
  7053		}
  7054	
> 7055		local_lock_init(&percpu->lock);
  7056		return 0;
  7057	}
  7058	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
