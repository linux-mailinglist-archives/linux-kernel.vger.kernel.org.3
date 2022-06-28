Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8279755E60E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbiF1PaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346765AbiF1PaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:30:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0B114
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656430201; x=1687966201;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P2zQaS5+/7/G4ruJNmxzKwuDLArztaWRuMYk31GeaVg=;
  b=ZQdAZoaKw2dDCxqYvJEyKYqrXA6pF6pr2vmpau3z4RKQGD8l8dzsxKpP
   PjXlZ7M97ioHUYAQN4rLL2vVC3s3+3K0dHCvs98tzB3bpfCRRYt9GsA+h
   hortJF9PnhBo1aJ6m7Qr/D+MJIUACR75fQwSH3HN/8TYGy+uu+zXQVlXt
   VIxd1GRqrkC2V03G3brO5iVhq7RcIX5REuuqPQZyxYCdaOu0lomShbvlp
   PTiuDPSKf/PmtT+/H4WSZa1fBlBRAXRl2tOvSJxCu88NVQ/smFpQB5c0W
   apJ8MOrKi2nkgsvFbsl0KfAswcJYCWUcDO8MI5EFJjPAmibX4FIAWUHo2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270531211"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="270531211"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 08:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="836720310"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2022 08:29:58 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6DA6-000AJo-1o;
        Tue, 28 Jun 2022 15:29:58 +0000
Date:   Tue, 28 Jun 2022 23:29:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 26/58] drivers/md/raid1.c:1993:60:
 sparse: sparse: incorrect type in argument 5 (different base types)
Message-ID: <202206282329.SSMaK1Qi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   0bd8feaed1580090a37f1a1aff32e3e9bcb9bdd1
commit: ae4e00689c13aebb4ab4162d7f964624f9a86a74 [26/58] md/core: Combine two sync_page_io() arguments
config: nios2-randconfig-s032-20220627 (https://download.01.org/0day-ci/archive/20220628/202206282329.SSMaK1Qi-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/bvanassche/linux/commit/ae4e00689c13aebb4ab4162d7f964624f9a86a74
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout ae4e00689c13aebb4ab4162d7f964624f9a86a74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/md/raid1.c:646:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:646:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:646:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:777:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:777:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:777:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:1223:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/raid1.c:1223:30: sparse:     expected int const op
   drivers/md/raid1.c:1223:30: sparse:     got restricted blk_opf_t enum req_op
   drivers/md/raid1.c:1224:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
   drivers/md/raid1.c:1224:52: sparse:     expected unsigned long const do_sync
   drivers/md/raid1.c:1224:52: sparse:     got restricted blk_opf_t
   drivers/md/raid1.c:1241:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1241:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1241:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:1404:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1404:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1404:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1635:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1635:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1635:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1707:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1707:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1707:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1824:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1824:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1824:25: sparse:    struct md_rdev *
   drivers/md/raid1.c:1835:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1835:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1835:25: sparse:    struct md_rdev *
>> drivers/md/raid1.c:1993:60: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got int rw @@
   drivers/md/raid1.c:2298:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2298:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2298:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2334:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2334:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2334:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2351:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2351:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2351:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2767:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2767:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2767:24: sparse:    struct md_rdev *
--
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

vim +1993 drivers/md/raid1.c

  1989	
  1990	static int r1_sync_page_io(struct md_rdev *rdev, sector_t sector,
  1991				   int sectors, struct page *page, int rw)
  1992	{
> 1993		if (sync_page_io(rdev, sector, sectors << 9, page, rw, false))
  1994			/* success */
  1995			return 1;
  1996		if (rw == WRITE) {
  1997			set_bit(WriteErrorSeen, &rdev->flags);
  1998			if (!test_and_set_bit(WantReplacement,
  1999					      &rdev->flags))
  2000				set_bit(MD_RECOVERY_NEEDED, &
  2001					rdev->mddev->recovery);
  2002		}
  2003		/* need to record an error - either for the block or the device */
  2004		if (!rdev_set_badblocks(rdev, sector, sectors, 0))
  2005			md_error(rdev->mddev, rdev);
  2006		return 0;
  2007	}
  2008	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
