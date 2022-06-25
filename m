Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FC555A698
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 05:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiFYDW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 23:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiFYDWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:22:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C554EA3B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656127370; x=1687663370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cM1qclPTxlTD+zcDk4opEl1qtzgKK8RAj5HxPWaBdrA=;
  b=OGxCrR+72HmL5z9NRJwGFKMqI/3uvtUnWzF+2xVMOTUG8K1lnPCrxsX3
   8OPhmDg6oCJGtSAm+rlVGKX0OdIC8UjInE8Djl+Y/Tii0nsGltSPD0NPV
   UB8d5dTHneK0iDpwqitdmxAxURAXHJ8yB/jUgmNz6Z6T0R8NLyUVvejN8
   RwZ728v9+MpvQUrXNl3tFMjAC8bldh6twlWjflNdu0721mQfkwk4GZv7f
   I/j5AQEyrqf4oPYHbN0aUL+RuVg7yRmInlJXlq9tDAJWyJgVfJuJzATlJ
   0uYETbtkA0r8DO0De3TRLb2iUj3Hh0A+x67dZwzewCtnFtcdMP/BCWekB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="264184973"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="264184973"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 20:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="586799650"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2022 20:22:48 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4wNj-0005IQ-S5;
        Sat, 25 Jun 2022 03:22:47 +0000
Date:   Sat, 25 Jun 2022 11:22:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 54/57] kernel/power/swap.c:279:45:
 error: 'op' undeclared; did you mean 'opf'?
Message-ID: <202206251130.Su38MOOM-lkp@intel.com>
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

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   1dcb3ec8225b66570ecb07a784df045e3944e6ed
commit: 1ee1fd29d2216a7ce21a47ebd4e2fa1b8480f041 [54/57] PM: Use the enum req_op and blk_opf_t types
config: i386-defconfig
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/1ee1fd29d2216a7ce21a47ebd4e2fa1b8480f041
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 1ee1fd29d2216a7ce21a47ebd4e2fa1b8480f041
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/power/swap.c: In function 'hib_submit_io':
>> kernel/power/swap.c:279:45: error: 'op' undeclared (first use in this function); did you mean 'opf'?
     279 |         bio = bio_alloc(hib_resume_bdev, 1, op | op_flags,
         |                                             ^~
         |                                             opf
   kernel/power/swap.c:279:45: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/power/swap.c:279:50: error: 'op_flags' undeclared (first use in this function); did you mean 'bip_flags'?
     279 |         bio = bio_alloc(hib_resume_bdev, 1, op | op_flags,
         |                                                  ^~~~~~~~
         |                                                  bip_flags


vim +279 kernel/power/swap.c

343df3c79c62b6 Christoph Hellwig 2015-05-19  271  
1ee1fd29d2216a Bart Van Assche   2022-06-17  272  static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
343df3c79c62b6 Christoph Hellwig 2015-05-19  273  			 struct hib_bio_batch *hb)
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
