Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C49552173
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiFTPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbiFTPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:44:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498A1AD92
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655739890; x=1687275890;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1oYOE8hSsPq2OivSAvYFzTxc8OIE4rMleIdzOr/mgCY=;
  b=SlBLRxI32KvdtZkT/zfg+q0/jkm4c9fBZNGBXGsQhk+vaFu/w8j4JU5y
   3nFQ5f8/Vne2QFdczLzIuBL7HGjaoPTMmgtTKjz8PKPEyTdBLMzduqemg
   oV5DdlMAwWdtigXOI0Iz29xkOuxHTLXlfX3ytV84kWBxQolQ9Ry25vgbS
   fboyNZxBP9Xv1z3mo2ZIweP0X1OIfW9Osp0ad3wBkUFyIwvFGJauVWI/e
   Rs0SKvBlr8bhCQtNKg6yaeYCiit3oBem285carFpJqGC2T/cs73AhVZSf
   7BboT506+sh6YBSB5eWJB0ecv2b0mglIJw0KOldekNLnqUalHTNilitvY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="279976210"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="279976210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="562002842"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2022 08:44:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3Ja4-000U1A-7Z;
        Mon, 20 Jun 2022 15:44:48 +0000
Date:   Mon, 20 Jun 2022 23:44:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 15/15] kernel/power/swap.c:279:50:
 sparse: sparse: restricted blk_mq_opf_t degrades to integer
Message-ID: <202206202333.blYnLQ0m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   031ccdd616b11c4e774e56aa7eae906188ab24cc
commit: 031ccdd616b11c4e774e56aa7eae906188ab24cc [15/15] block: Introduce the type blk_mq_opf_t
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220620/202206202333.blYnLQ0m-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/bvanassche/linux/commit/031ccdd616b11c4e774e56aa7eae906188ab24cc
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 031ccdd616b11c4e774e56aa7eae906188ab24cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/btrfs/ kernel/power/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/power/swap.c:279:50: sparse: sparse: restricted blk_mq_opf_t degrades to integer
>> kernel/power/swap.c:279:48: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted blk_mq_opf_t [usertype] opf @@     got unsigned int @@
   kernel/power/swap.c:279:48: sparse:     expected restricted blk_mq_opf_t [usertype] opf
   kernel/power/swap.c:279:48: sparse:     got unsigned int
--
>> fs/btrfs/check-integrity.c:2059:47: sparse: sparse: restricted blk_mq_opf_t degrades to integer
   fs/btrfs/check-integrity.c:2067:47: sparse: sparse: restricted blk_mq_opf_t degrades to integer
>> fs/btrfs/check-integrity.c:2669:64: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected int submit_bio_bh_rw @@     got restricted blk_mq_opf_t [usertype] bi_opf @@
   fs/btrfs/check-integrity.c:2669:64: sparse:     expected int submit_bio_bh_rw
   fs/btrfs/check-integrity.c:2669:64: sparse:     got restricted blk_mq_opf_t [usertype] bi_opf
>> fs/btrfs/check-integrity.c:2687:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected int submit_bio_bh_rw @@     got restricted blk_mq_opf_t [usertype] bi_opf @@
   fs/btrfs/check-integrity.c:2687:41: sparse:     expected int submit_bio_bh_rw
   fs/btrfs/check-integrity.c:2687:41: sparse:     got restricted blk_mq_opf_t [usertype] bi_opf

vim +279 kernel/power/swap.c

343df3c79c62b6 Christoph Hellwig 2015-05-19  271  
031ccdd616b11c Bart Van Assche   2022-06-16  272  static int hib_submit_io(enum req_op op, blk_mq_opf_t op_flags,
031ccdd616b11c Bart Van Assche   2022-06-16  273  			 pgoff_t page_off, void *addr, struct hib_bio_batch *hb)
343df3c79c62b6 Christoph Hellwig 2015-05-19  274  {
343df3c79c62b6 Christoph Hellwig 2015-05-19  275  	struct page *page = virt_to_page(addr);
343df3c79c62b6 Christoph Hellwig 2015-05-19  276  	struct bio *bio;
343df3c79c62b6 Christoph Hellwig 2015-05-19  277  	int error = 0;
343df3c79c62b6 Christoph Hellwig 2015-05-19  278  
07888c665b405b Christoph Hellwig 2022-01-24 @279  	bio = bio_alloc(hib_resume_bdev, 1, op | op_flags,
07888c665b405b Christoph Hellwig 2022-01-24  280  			GFP_NOIO | __GFP_HIGH);
343df3c79c62b6 Christoph Hellwig 2015-05-19  281  	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
343df3c79c62b6 Christoph Hellwig 2015-05-19  282  
343df3c79c62b6 Christoph Hellwig 2015-05-19  283  	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
64ec72a1ece37d Joe Perches       2017-09-27  284  		pr_err("Adding page to bio failed at %llu\n",
343df3c79c62b6 Christoph Hellwig 2015-05-19  285  		       (unsigned long long)bio->bi_iter.bi_sector);
343df3c79c62b6 Christoph Hellwig 2015-05-19  286  		bio_put(bio);
343df3c79c62b6 Christoph Hellwig 2015-05-19  287  		return -EFAULT;
343df3c79c62b6 Christoph Hellwig 2015-05-19  288  	}
343df3c79c62b6 Christoph Hellwig 2015-05-19  289  
343df3c79c62b6 Christoph Hellwig 2015-05-19  290  	if (hb) {
343df3c79c62b6 Christoph Hellwig 2015-05-19  291  		bio->bi_end_io = hib_end_io;
343df3c79c62b6 Christoph Hellwig 2015-05-19  292  		bio->bi_private = hb;
343df3c79c62b6 Christoph Hellwig 2015-05-19  293  		atomic_inc(&hb->count);
4e49ea4a3d2763 Mike Christie     2016-06-05  294  		submit_bio(bio);
343df3c79c62b6 Christoph Hellwig 2015-05-19  295  	} else {
4e49ea4a3d2763 Mike Christie     2016-06-05  296  		error = submit_bio_wait(bio);
343df3c79c62b6 Christoph Hellwig 2015-05-19  297  		bio_put(bio);
343df3c79c62b6 Christoph Hellwig 2015-05-19  298  	}
343df3c79c62b6 Christoph Hellwig 2015-05-19  299  
343df3c79c62b6 Christoph Hellwig 2015-05-19  300  	return error;
343df3c79c62b6 Christoph Hellwig 2015-05-19  301  }
343df3c79c62b6 Christoph Hellwig 2015-05-19  302  

:::::: The code at line 279 was first introduced by commit
:::::: 07888c665b405b1cd3577ddebfeb74f4717a84c4 block: pass a block_device and opf to bio_alloc

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
