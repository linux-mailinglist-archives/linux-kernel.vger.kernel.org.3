Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B676E4AC033
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389199AbiBGNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350009AbiBGN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:26:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A971C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644240392; x=1675776392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jwkzm8rlM42MAJem1ebz1/ephF2+kPSW8EADgQDGZmU=;
  b=gU5lkKguLTy3NqyF3xKn2SQwZaCev/sEIdVrtZNe/ay3JJvXSuGHt7rW
   Y/3t1ndxh3f0opQk4Sm2ESZnZKxJeohqHXCCrxb4PjoqVBuz5A3OkNeB8
   z1Dj2vGPof19KIR35dIqaB6HfwEkjcRK7Khqupa/Qu7QqdbEhNuscFFm7
   0vMGI4MkcBoFagSY8Na0OMWezjuzpI6nrYev39+t1j5sbyFG0QcHV5lHN
   iUFOKJmDRiyRFTW7PfaTgca6J76n3Wsr83a7mvkXLqbTSbqhyLkv1/V8I
   A9zW1HyykAn+B71DqE6U1jDnLO5SFZ5gkM7cUsY7xin4AJAYuitTlDzE1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="247547105"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="247547105"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 05:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="567476063"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 05:26:30 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH42H-0000Z7-Kz; Mon, 07 Feb 2022 13:26:29 +0000
Date:   Mon, 7 Feb 2022 21:25:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>
Subject: drivers/md/raid5.c:7055:9: sparse: sparse: cast removes address
 space '__percpu' of expression
Message-ID: <202202072158.7y7wxNRC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfd42facf1e4ada021b939b4e19c935dcdd55566
commit: 770b1d216d7371c94c88713824da4be4bc39a4e0 md/raid5: play nice with PREEMPT_RT
date:   5 weeks ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220207/202202072158.7y7wxNRC-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=770b1d216d7371c94c88713824da4be4bc39a4e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 770b1d216d7371c94c88713824da4be4bc39a4e0
        # save the config file to linux build tree
        mkdir build_dir
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
