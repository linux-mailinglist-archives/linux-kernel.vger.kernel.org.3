Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84058E3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiHJADN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 20:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiHJADK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 20:03:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A080484
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660089789; x=1691625789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u7PXuYLeNbx2u6WjADyQmyEYqr2jDTJ9vlhBnJRguFA=;
  b=e0CmMcytbOMeyV7KtpOxGO40lvjgK/wUNejMCEGJfcBf67WFYfEZA/od
   eLT2ocCdlMaNSBaQBy8oCezeDI/u2A3mlCmFBvJfMZB3PcpfxwMUeTb00
   UMiRf9WgLQmQA483vFOZ03h1PaYDY2iPsSspgMp/QeRvYm5QPwXMvjbJe
   Q+yBXBHrqC5X3BB21UoHXsGe7XZlpGrL4WA9bnXWAK9KwON/YDQHf4DF3
   BWptQHj9y5NGyK1ibDl/xIm1dOBtuBDVIIi8St2U5gpkzBgaW2N+ms4Hv
   +bBydGC24G6ZamQbYYrEu8DdaR2J12/Fxr278zyLBzTiNtIApfzq+J8LP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="352692667"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="352692667"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 17:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="555531849"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2022 17:03:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLZBe-000NMd-31;
        Wed, 10 Aug 2022 00:03:02 +0000
Date:   Wed, 10 Aug 2022 08:02:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:md-raid10 1/1] drivers/md/raid10.c:2648:17: error: 'rw'
 undeclared; did you mean 'rq'?
Message-ID: <202208100709.3WYowHQE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux md-raid10
head:   31d1ab290843e8d1c00cfdbdd7bfccb907f5d64c
commit: 31d1ab290843e8d1c00cfdbdd7bfccb907f5d64c [1/1] md/raid10: Fix a recently introduced sparse warning
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220810/202208100709.3WYowHQE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/31d1ab290843e8d1c00cfdbdd7bfccb907f5d64c
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche md-raid10
        git checkout 31d1ab290843e8d1c00cfdbdd7bfccb907f5d64c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/md/raid10.c: In function 'r10_sync_page_io':
>> drivers/md/raid10.c:2648:17: error: 'rw' undeclared (first use in this function); did you mean 'rq'?
    2648 |             && (rw == READ || test_bit(WriteErrorSeen, &rdev->flags)))
         |                 ^~
         |                 rq
   drivers/md/raid10.c:2648:17: note: each undeclared identifier is reported only once for each function it appears in


vim +2648 drivers/md/raid10.c

1e50915fe0bbf7 Robert Becker   2009-12-14  2640  
3cb03002000f13 NeilBrown       2011-10-11  2641  static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
31d1ab290843e8 Bart Van Assche 2022-08-09  2642  			    int sectors, struct page *page, enum req_op op)
58c54fcca3bac5 NeilBrown       2011-07-28  2643  {
58c54fcca3bac5 NeilBrown       2011-07-28  2644  	sector_t first_bad;
58c54fcca3bac5 NeilBrown       2011-07-28  2645  	int bad_sectors;
58c54fcca3bac5 NeilBrown       2011-07-28  2646  
58c54fcca3bac5 NeilBrown       2011-07-28  2647  	if (is_badblock(rdev, sector, sectors, &first_bad, &bad_sectors)
58c54fcca3bac5 NeilBrown       2011-07-28 @2648  	    && (rw == READ || test_bit(WriteErrorSeen, &rdev->flags)))
58c54fcca3bac5 NeilBrown       2011-07-28  2649  		return -1;
31d1ab290843e8 Bart Van Assche 2022-08-09  2650  	if (sync_page_io(rdev, sector, sectors << 9, page, op, false))
58c54fcca3bac5 NeilBrown       2011-07-28  2651  		/* success */
58c54fcca3bac5 NeilBrown       2011-07-28  2652  		return 1;
b7044d41b5a09c NeilBrown       2011-12-23  2653  	if (rw == WRITE) {
58c54fcca3bac5 NeilBrown       2011-07-28  2654  		set_bit(WriteErrorSeen, &rdev->flags);
b7044d41b5a09c NeilBrown       2011-12-23  2655  		if (!test_and_set_bit(WantReplacement, &rdev->flags))
b7044d41b5a09c NeilBrown       2011-12-23  2656  			set_bit(MD_RECOVERY_NEEDED,
b7044d41b5a09c NeilBrown       2011-12-23  2657  				&rdev->mddev->recovery);
b7044d41b5a09c NeilBrown       2011-12-23  2658  	}
58c54fcca3bac5 NeilBrown       2011-07-28  2659  	/* need to record an error - either for the block or the device */
58c54fcca3bac5 NeilBrown       2011-07-28  2660  	if (!rdev_set_badblocks(rdev, sector, sectors, 0))
58c54fcca3bac5 NeilBrown       2011-07-28  2661  		md_error(rdev->mddev, rdev);
58c54fcca3bac5 NeilBrown       2011-07-28  2662  	return 0;
58c54fcca3bac5 NeilBrown       2011-07-28  2663  }
58c54fcca3bac5 NeilBrown       2011-07-28  2664  

:::::: The code at line 2648 was first introduced by commit
:::::: 58c54fcca3bac5bf9290cfed31c76e4c4bfbabaf md/raid10: handle further errors during fix_read_error better.

:::::: TO: NeilBrown <neilb@suse.de>
:::::: CC: NeilBrown <neilb@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
