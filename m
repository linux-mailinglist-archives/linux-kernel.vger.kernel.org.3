Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0119A56C72E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiGIE6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 00:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIE60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:58:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FA0140D5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 21:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657342705; x=1688878705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lPTPaQZLNZPArjlIMR5jDK+FGVRiuQGygDNlrhF2rfo=;
  b=PZJAqogFNtKZozGZheP+qzFjvZYFOUXlS+ibEGd68DhtOpa1N7PoVymU
   Xk2kw6b2xa3gqx9MUNwJSnzjSU+TPcJ1mSQzT5MgzFDsPjbG1Vp2HuA1+
   Gk6OAMfvd5f3VafNTZ4vqgPXF436aQs3OPfy3koV04RTvznazGuEVK/Oc
   ULim0U+7wPOg60TVdt2fAERFlS4CZFsLlV4Xpnzxheox8/ZDMPcpILJOf
   Sl1K4RS+xmI7XLPKEMVMu0qpms+vaARpQkkZKm1FKS7g7y5uSZZVQBg8z
   REejFYeBk+Yv645krmZnDkKgnvT8BuTsxMmpEL6KZBSrsCVaPRFWRxU4X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284430236"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="284430236"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 21:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="921215076"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2022 21:58:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA2Xv-000OKp-Q1;
        Sat, 09 Jul 2022 04:58:23 +0000
Date:   Sat, 9 Jul 2022 12:57:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [mcgrof-next:20220707-dm-zoned-npo2 2/13] block/blk-core.c:564:38:
 error: passing argument 1 of 'bdev_is_zone_start' from incompatible pointer
 type
Message-ID: <202207091216.V26XwOPw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20220707-dm-zoned-npo2
head:   3d1b6e41f76394610669e380da4f65bc5e7cf8ac
commit: 74b3d453820c74ad03aefe4d9ec44c27f6bffe00 [2/13] block: allow blk-zoned devices to have non-power-of-2 zone size
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220709/202207091216.V26XwOPw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=74b3d453820c74ad03aefe4d9ec44c27f6bffe00
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220707-dm-zoned-npo2
        git checkout 74b3d453820c74ad03aefe4d9ec44c27f6bffe00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   block/blk-core.c: In function 'bio_sector_zone_start':
>> block/blk-core.c:564:38: error: passing argument 1 of 'bdev_is_zone_start' from incompatible pointer type [-Werror=incompatible-pointer-types]
     564 |         return bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector);
         |                                   ~~~^~~~~~~~~
         |                                      |
         |                                      struct block_device *
   In file included from block/blk-core.c:18:
   include/linux/blkdev.h:772:55: note: expected 'struct gendisk *' but argument is of type 'struct block_device *'
     772 | static inline bool bdev_is_zone_start(struct gendisk *disk, sector_t sec)
         |                                       ~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/bdev_is_zone_start +564 block/blk-core.c

   561	
   562	static inline bool bio_sector_zone_start(struct bio *bio)
   563	{
 > 564		return bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector);
   565	}
   566	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
