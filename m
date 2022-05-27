Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7BB536835
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354658AbiE0Ur2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349662AbiE0UrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:47:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFC26BFC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653684440; x=1685220440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5am+C3HGZjdoCovdtVHqfOQZs1qNAkwbyGo81rAvbqI=;
  b=ToyuiC2M9UKWpRHIoTN9G+tJi5ZtJ2AleUSyKFdcbvQyx8GrAzZ7xnjF
   v2Y+yCBBAXJ+7Fig/7djVdhd5W3QrXZSCfzHKZS8tzsXmb9RSrXjPmV2r
   Pnec9Ywl3e1D6OeBoC889amTP1Lt5Tunoeth2a5NsH3F0v97suUM5IEl9
   1xnIzOTxQcPYZ7M0hop4IvhgmwRvcF0qkw7fx7f7Sy3vjVHmh+w1T/uw0
   SqSYSEgdCCV0BnuB21OIqHCnELV/B5xGK9RIFtmpcRMzsk/prGpP8dApd
   kI+FSC3MOZGpA4PT0kK/2XfmDiO/yY2OHkXbwIjWVlj8fFcSX2KaV33FB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274301580"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274301580"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="631767444"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2022 13:47:18 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nugrd-00057L-UL;
        Fri, 27 May 2022 20:47:17 +0000
Date:   Sat, 28 May 2022 04:46:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: drivers/md/raid5-ppl.c:632:57: sparse: sparse: incorrect type in
 argument 3 (different base types)
Message-ID: <202205280426.NVpnRyuP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: b0920ede081b3f1659872f80ce552305610675a6 md/raid5: Add __rcu annotation to struct disk_info
date:   5 weeks ago
config: csky-randconfig-s032-20220524 (https://download.01.org/0day-ci/archive/20220528/202205280426.NVpnRyuP-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0920ede081b3f1659872f80ce552305610675a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b0920ede081b3f1659872f80ce552305610675a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/md/raid5-ppl.c: note: in included file:
   drivers/md/raid5.h:271:14: sparse: sparse: array of flexible structures
>> drivers/md/raid5-ppl.c:632:57: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int opf @@     got restricted gfp_t [usertype] @@
   drivers/md/raid5-ppl.c:632:57: sparse:     expected unsigned int opf
   drivers/md/raid5-ppl.c:632:57: sparse:     got restricted gfp_t [usertype]
>> drivers/md/raid5-ppl.c:633:61: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted gfp_t [usertype] gfp_mask @@     got unsigned long long @@
   drivers/md/raid5-ppl.c:633:61: sparse:     expected restricted gfp_t [usertype] gfp_mask
   drivers/md/raid5-ppl.c:633:61: sparse:     got unsigned long long
   drivers/md/raid5-ppl.c:886:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
   drivers/md/raid5-ppl.c:886:30: sparse:     expected struct md_rdev *rdev
   drivers/md/raid5-ppl.c:886:30: sparse:     got struct md_rdev [noderef] __rcu *rdev
   drivers/md/raid5-ppl.c:937:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct md_rdev *parity_rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
   drivers/md/raid5-ppl.c:937:29: sparse:     expected struct md_rdev *parity_rdev
   drivers/md/raid5-ppl.c:937:29: sparse:     got struct md_rdev [noderef] __rcu *rdev
   drivers/md/raid5-ppl.c:1407:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct md_rdev *rdev @@     got struct md_rdev [noderef] __rcu *rdev @@
   drivers/md/raid5-ppl.c:1407:54: sparse:     expected struct md_rdev *rdev
   drivers/md/raid5-ppl.c:1407:54: sparse:     got struct md_rdev [noderef] __rcu *rdev

vim +632 drivers/md/raid5-ppl.c

1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  607  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  608  static void ppl_do_flush(struct ppl_io_unit *io)
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  609  {
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  610  	struct ppl_log *log = io->log;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  611  	struct ppl_conf *ppl_conf = log->ppl_conf;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  612  	struct r5conf *conf = ppl_conf->mddev->private;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  613  	int raid_disks = conf->raid_disks;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  614  	int flushed_disks = 0;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  615  	int i;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  616  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  617  	atomic_set(&io->pending_flushes, raid_disks);
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  618  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  619  	for_each_set_bit(i, &log->disk_flush_bitmap, raid_disks) {
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  620  		struct md_rdev *rdev;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  621  		struct block_device *bdev = NULL;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  622  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  623  		rcu_read_lock();
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  624  		rdev = rcu_dereference(conf->disks[i].rdev);
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  625  		if (rdev && !test_bit(Faulty, &rdev->flags))
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  626  			bdev = rdev->bdev;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  627  		rcu_read_unlock();
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  628  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  629  		if (bdev) {
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  630  			struct bio *bio;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  631  
609be1066731fe Christoph Hellwig 2022-01-24 @632  			bio = bio_alloc_bioset(bdev, 0, GFP_NOIO,
609be1066731fe Christoph Hellwig 2022-01-24 @633  					       REQ_OP_WRITE | REQ_PREFLUSH,
609be1066731fe Christoph Hellwig 2022-01-24  634  					       &ppl_conf->flush_bs);
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  635  			bio->bi_private = io;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  636  			bio->bi_end_io = ppl_flush_endio;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  637  
c7dec4623c9cde Christoph Hellwig 2022-03-04  638  			pr_debug("%s: dev: %ps\n", __func__, bio->bi_bdev);
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  639  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  640  			submit_bio(bio);
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  641  			flushed_disks++;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  642  		}
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  643  	}
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  644  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  645  	log->disk_flush_bitmap = 0;
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  646  
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  647  	for (i = flushed_disks ; i < raid_disks; i++) {
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  648  		if (atomic_dec_and_test(&io->pending_flushes))
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  649  			ppl_io_unit_finished(io);
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  650  	}
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  651  }
1532d9e87e8b23 Tomasz Majchrzak  2017-12-27  652  

:::::: The code at line 632 was first introduced by commit
:::::: 609be1066731fea86436f5f91022f82e592ab456 block: pass a block_device and opf to bio_alloc_bioset

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
