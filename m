Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130A158B3E3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 06:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiHFEou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 00:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbiHFEos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 00:44:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539112D2B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 21:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659761086; x=1691297086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YSo0e+cy946lYNx88cm/n5vNylBvX6pDpA82KHK3da8=;
  b=fGU8E4HJr9o02hAdgsgDbADqV0GwXjvTCA/iylQqamwoaSVW5o6XlStk
   Z8jF4nnWlbSHqjBriyvicsI55BwDNFZlYt0PPQdrtkb3zggQqTPC4G5nq
   9QvQUx0KogfUVB3/eDR3bG0IJ9PiyNY30bSI67sYnKVe//yrr+7YZW7n0
   f3kPxrf2i6yL/qbdwNjywKCrHh8XYvbxyw6xpUI9pXAmc/LuJkCMtVpBg
   Jlz0hy/0TEa5U2H97r64ZK7fJkGIO7ZqenlimK32wupzjRFebj+SXcg/o
   xc7YpCVxTNMLspRMP39N040nHTk2bt8//pUcsQ5i0QQHkpFziee2JOXTh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="291114130"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="291114130"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 21:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579738861"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 21:44:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKBg4-000K2l-0l;
        Sat, 06 Aug 2022 04:44:44 +0000
Date:   Sat, 6 Aug 2022 12:44:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: drivers/md/raid10.c:2647:60: sparse: sparse: incorrect type in
 argument 5 (different base types)
Message-ID: <202208061258.jAwlaAXe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: 4ce4c73f662bdb0ae5bfb058bc7ec6f6829ca078 md/core: Combine two sync_page_io() arguments
date:   3 weeks ago
config: alpha-randconfig-s042-20220804 (https://download.01.org/0day-ci/archive/20220806/202208061258.jAwlaAXe-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ce4c73f662bdb0ae5bfb058bc7ec6f6829ca078
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4ce4c73f662bdb0ae5bfb058bc7ec6f6829ca078
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash .// drivers/ kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/md/raid10.c:1946:37: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1946:37: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1946:37: sparse:    struct md_rdev *
   drivers/md/raid10.c:4919:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4919:33: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4919:33: sparse:    struct md_rdev *
   drivers/md/raid10.c:4922:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4922:33: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4922:33: sparse:    struct md_rdev *
   drivers/md/raid10.c:5011:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5011:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5011:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:5014:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5014:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5014:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:759:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:759:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:759:24: sparse:    struct md_rdev *
   drivers/md/raid10.c:762:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:762:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:762:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:1139:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/raid10.c:1139:30: sparse:     expected int const op
   drivers/md/raid10.c:1139:30: sparse:     got restricted blk_opf_t enum req_op
   drivers/md/raid10.c:1140:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:1140:52: sparse:     expected unsigned long const do_sync
   drivers/md/raid10.c:1140:52: sparse:     got restricted blk_opf_t
   drivers/md/raid10.c:1165:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1165:28: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1165:28: sparse:    struct md_rdev *
   drivers/md/raid10.c:1233:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/raid10.c:1234:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:1235:51: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_fua @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:1263:32: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted blk_opf_t enum req_op op @@     got int const op @@
   drivers/md/raid10.c:1263:44: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted blk_opf_t [usertype] op_flags @@     got unsigned long @@
   drivers/md/raid10.c:1303:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1303:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1303:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:1304:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1304:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1304:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:1434:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1434:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1434:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:1435:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1435:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1435:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:1744:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1744:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1744:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:1745:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1745:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1745:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:1913:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1913:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1913:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:2142:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2142:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2142:25: sparse:    struct md_rdev *
   drivers/md/raid10.c:2156:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2156:17: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2156:17: sparse:    struct md_rdev *
>> drivers/md/raid10.c:2647:60: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got int rw @@
   drivers/md/raid10.c:2716:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2716:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2716:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:2769:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2769:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2769:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:2803:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2803:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2803:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:3313:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3313:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3313:49: sparse:    struct md_rdev *
   drivers/md/raid10.c:3388:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3388:33: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3388:33: sparse:    struct md_rdev *
   drivers/md/raid10.c:3389:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3389:36: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3389:36: sparse:    struct md_rdev *
   drivers/md/raid10.c:3459:56: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3459:56: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3459:56: sparse:    struct md_rdev *
   drivers/md/raid10.c:3476:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3476:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3476:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:3679:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3679:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3679:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:3709:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3709:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3709:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:4452:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4452:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4452:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:4468:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4468:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4468:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:5096:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5096:48: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5096:48: sparse:    struct md_rdev *
   drivers/md/raid10.c:5192:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5192:48: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5192:48: sparse:    struct md_rdev *
   drivers/md/raid10.c:5195:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5195:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5195:32: sparse:    struct md_rdev *

vim +2647 drivers/md/raid10.c

  2637	
  2638	static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
  2639				    int sectors, struct page *page, int rw)
  2640	{
  2641		sector_t first_bad;
  2642		int bad_sectors;
  2643	
  2644		if (is_badblock(rdev, sector, sectors, &first_bad, &bad_sectors)
  2645		    && (rw == READ || test_bit(WriteErrorSeen, &rdev->flags)))
  2646			return -1;
> 2647		if (sync_page_io(rdev, sector, sectors << 9, page, rw, false))
  2648			/* success */
  2649			return 1;
  2650		if (rw == WRITE) {
  2651			set_bit(WriteErrorSeen, &rdev->flags);
  2652			if (!test_and_set_bit(WantReplacement, &rdev->flags))
  2653				set_bit(MD_RECOVERY_NEEDED,
  2654					&rdev->mddev->recovery);
  2655		}
  2656		/* need to record an error - either for the block or the device */
  2657		if (!rdev_set_badblocks(rdev, sector, sectors, 0))
  2658			md_error(rdev->mddev, rdev);
  2659		return 0;
  2660	}
  2661	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
