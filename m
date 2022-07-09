Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360456C742
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGIF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 01:29:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3CC4B0E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657344567; x=1688880567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3K7w/tIlYLrOa4jUTP//uIjlXlGF6BYOKmT/TEJGKZo=;
  b=iDvd5j9Gob9AhSU6hfFeN0aYtwUjLF55YXxC5syV3ib+kFmrm7mSP2RB
   6K4JNWaCBv1uh7GVtYiQYltDi35ki+sGLZPw6vUu0rOeZYVTfN24o0mE0
   chhyUHmHx1e1Ysw6o6C8OJtI9caeibys0nVv+glUAJJGC69HzlB2zMt/z
   sj9gyizandAUUwiCNWsc4oxPLmqOfiYYphfAzNfFxglcJFFPR5SoMF+7T
   YsVNqKOVMLsOnhFe/CGSCQyIjth3ZYAkr931Up3FfhfXFp9mvLKj+/GC2
   M1lxeGlNe0gHQ/NenfBKwtZ4jcvn8uxZBtV2BobPiXEtEUrbtdLvsFnrX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284432040"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="284432040"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 22:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736559161"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 22:29:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA31w-000OLv-DI;
        Sat, 09 Jul 2022 05:29:24 +0000
Date:   Sat, 9 Jul 2022 13:29:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [mcgrof-next:20220707-dm-zoned-npo2 2/13] block/blk-core.c:564:28:
 error: incompatible pointer types passing 'struct block_device *' to
 parameter of type 'struct gendisk *'
Message-ID: <202207091323.KEhcYltc-lkp@intel.com>
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
config: hexagon-randconfig-r041-20220707 (https://download.01.org/0day-ci/archive/20220709/202207091323.KEhcYltc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 77a38f6839980bfac61babb40d83772c51427011)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=74b3d453820c74ad03aefe4d9ec44c27f6bffe00
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220707-dm-zoned-npo2
        git checkout 74b3d453820c74ad03aefe4d9ec44c27f6bffe00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> block/blk-core.c:564:28: error: incompatible pointer types passing 'struct block_device *' to parameter of type 'struct gendisk *' [-Werror,-Wincompatible-pointer-types]
           return bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector);
                                     ^~~~~~~~~~~~
   include/linux/blkdev.h:772:55: note: passing argument to parameter 'disk' here
   static inline bool bdev_is_zone_start(struct gendisk *disk, sector_t sec)
                                                         ^
   1 error generated.


vim +564 block/blk-core.c

   561	
   562	static inline bool bio_sector_zone_start(struct bio *bio)
   563	{
 > 564		return bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector);
   565	}
   566	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
