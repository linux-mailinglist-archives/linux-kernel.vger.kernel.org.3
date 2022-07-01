Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F846563BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiGAVlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiGAVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:41:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8C358FE1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656711668; x=1688247668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zyicbhnpwSBO58N7CjcObF3NGPBO7eS9T3qcunuEXMQ=;
  b=X6adKtE6CQpp+uUKO/z5g8ATk0Yt1vODIhdGUlZP9fRfmk044CLiWA61
   BWMYV0yoayvNE7hKoR3vGDKOgM1I4ZZBfZvCa/lrO58mDDaqKQyynZKSv
   Ss3gQSTGjkvS53tBKauwmXA5q5qHp43iQbDYkFbYwy9FPplA35QUSAiHl
   Bdep/CdohPjCTJQm85W3ZzCbnXThQNF0C+ASKOXY9cIaOyBo0smaVIgaQ
   pqPFCkn/l+KCyWTLZAEk4Adv3b2d7wofMDik5RKNcPRvWFPKtTkyvaMK+
   9v7OCdHjl58pSm2fMZ2yFbUcfs34BeiIPubKcZtP1Ap9xPZ2/Lbj5IofH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="283481723"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="283481723"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 14:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="596405867"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2022 14:41:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7ONt-000ENo-EW;
        Fri, 01 Jul 2022 21:41:05 +0000
Date:   Sat, 2 Jul 2022 05:40:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof-next:20220615-dm-zoned-npo2 13/13]
 drivers/md/dm-zoned-npo2-target.c:62:13: warning: variable 'ret' set but not
 used
Message-ID: <202207020515.LhdrBdTo-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20220615-dm-zoned-npo2
head:   83ef82d1e5f86bc596bc3d9c02410465f0dfc26f
commit: 83ef82d1e5f86bc596bc3d9c02410465f0dfc26f [13/13] dm: add non power of 2 zoned target
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20220702/202207020515.LhdrBdTo-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=83ef82d1e5f86bc596bc3d9c02410465f0dfc26f
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220615-dm-zoned-npo2
        git checkout 83ef82d1e5f86bc596bc3d9c02410465f0dfc26f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/md/dm-zoned-npo2-target.c: In function 'dmz_npo2_ctr':
>> drivers/md/dm-zoned-npo2-target.c:62:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
      62 |         int ret = 0;
         |             ^~~


vim +/ret +62 drivers/md/dm-zoned-npo2-target.c

    53	
    54	/*
    55	 * <dev-path>
    56	 * This target works on the complete zoned device. Partial mapping is not
    57	 * supported
    58	 */
    59	static int dmz_npo2_ctr(struct dm_target *ti, unsigned int argc, char **argv)
    60	{
    61		struct dmz_npo2_target *dmh = NULL;
  > 62		int ret = 0;
    63		sector_t zsze;
    64		sector_t disk_size;
    65	
    66		if (argc < 1)
    67			return -EINVAL;
    68	
    69		dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
    70		if (!dmh)
    71			return -ENOMEM;
    72	
    73		ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
    74				    &dmh->dev);
    75	
    76		zsze = blk_queue_zone_sectors(bdev_get_queue(dmh->dev->bdev));
    77	
    78		disk_size = get_capacity(dmh->dev->bdev->bd_disk);
    79	
    80		if (ti->len != disk_size || ti->begin) {
    81			DMERR("%pg Partial mapping of the target not supported",
    82			      dmh->dev->bdev);
    83			return -EINVAL;
    84		}
    85	
    86		if (is_power_of_2(zsze)) {
    87			DMERR("%pg zone size is power of 2", dmh->dev->bdev);
    88			return -EINVAL;
    89		}
    90	
    91		dmh->zsze = zsze;
    92		dmh->zsze_po2 = 1 << get_count_order_long(zsze);
    93		dmh->zsze_diff = dmh->zsze_po2 - dmh->zsze;
    94	
    95		ti->private = dmh;
    96		ti->num_flush_bios = 1;
    97		ti->num_discard_bios = 1;
    98		ti->num_secure_erase_bios = 1;
    99		ti->num_write_zeroes_bios = 1;
   100	
   101		dmh->nr_zones = npo2_zone_no(dmh, ti->len);
   102		ti->len = dmh->zsze_po2 * dmh->nr_zones;
   103	
   104		return 0;
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
