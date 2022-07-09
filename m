Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E556C781
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGIGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:20:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5A7171D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657347627; x=1688883627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y8t77K0fkDLQwmEUTY9QUahRq1dvHvmEz2Yy76viBdY=;
  b=nMfZbhDk/cyiFYZoFLSS525ISq1u6nzBM5gzXRkEN1IYUJjADVcZJ3H4
   EPvtuqpWzlAKKP9QE8Qh0lo9XPLzXctCVrRNBP9jUJuVGgXl7q5zXASTP
   J3hUqXmbAYhpytEICJv/c/ymfehNbfKso72O0bNS81GfEyu9y75cSyDWL
   AYZKqu2/lx26MSrEzOHFzKEJfalbs2fUafKh4DngBJ4Mj+wnkycHlSFMO
   Zd08pNK1SnXbUqaenmaITwoCqoGzquPA/SXnEsBSnN6ltF7ARrAKU069h
   l0nhgK4HR9ab1SFpukE4p+sWiVGU3fd8eSp76MyTNvo1ENQQdrtCPj7S6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348398070"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="348398070"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 23:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="569189541"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 23:20:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA3pJ-000ONm-MZ;
        Sat, 09 Jul 2022 06:20:25 +0000
Date:   Sat, 9 Jul 2022 14:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof-next:20220707-dm-zoned-npo2 10/13]
 drivers/md/dm-table.c:253:40: error: passing argument 1 of
 'bdev_is_zone_start' from incompatible pointer type
Message-ID: <202207091412.HaT3RYs0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20220707-dm-zoned-npo2
head:   3d1b6e41f76394610669e380da4f65bc5e7cf8ac
commit: d7a44aa426f271934d5539d39454ef3acc45f9d8 [10/13] dm-table: use bdev_is_zone_start helper in device_area_is_invalid()
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220709/202207091412.HaT3RYs0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=d7a44aa426f271934d5539d39454ef3acc45f9d8
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220707-dm-zoned-npo2
        git checkout d7a44aa426f271934d5539d39454ef3acc45f9d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/md/dm-table.c: In function 'device_area_is_invalid':
   drivers/md/dm-table.c:251:45: error: implicit declaration of function 'bdev_zone_sectors'; did you mean 'bdev_nr_sectors'? [-Werror=implicit-function-declaration]
     251 |                 unsigned int zone_sectors = bdev_zone_sectors(bdev);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             bdev_nr_sectors
>> drivers/md/dm-table.c:253:40: error: passing argument 1 of 'bdev_is_zone_start' from incompatible pointer type [-Werror=incompatible-pointer-types]
     253 |                 if (bdev_is_zone_start(bdev, start)) {
         |                                        ^~~~
         |                                        |
         |                                        struct block_device *
   In file included from include/linux/blk-mq.h:5,
                    from drivers/md/dm-core.h:14,
                    from drivers/md/dm-table.c:8:
   include/linux/blkdev.h:772:55: note: expected 'struct gendisk *' but argument is of type 'struct block_device *'
     772 | static inline bool bdev_is_zone_start(struct gendisk *disk, sector_t sec)
         |                                       ~~~~~~~~~~~~~~~~^~~~
   drivers/md/dm-table.c:270:40: error: passing argument 1 of 'bdev_is_zone_start' from incompatible pointer type [-Werror=incompatible-pointer-types]
     270 |                 if (bdev_is_zone_start(bdev, len)) {
         |                                        ^~~~
         |                                        |
         |                                        struct block_device *
   In file included from include/linux/blk-mq.h:5,
                    from drivers/md/dm-core.h:14,
                    from drivers/md/dm-table.c:8:
   include/linux/blkdev.h:772:55: note: expected 'struct gendisk *' but argument is of type 'struct block_device *'
     772 | static inline bool bdev_is_zone_start(struct gendisk *disk, sector_t sec)
         |                                       ~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/bdev_is_zone_start +253 drivers/md/dm-table.c

   220	
   221	/*
   222	 * If possible, this checks an area of a destination device is invalid.
   223	 */
   224	static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
   225					  sector_t start, sector_t len, void *data)
   226	{
   227		struct queue_limits *limits = data;
   228		struct block_device *bdev = dev->bdev;
   229		sector_t dev_size = bdev_nr_sectors(bdev);
   230		unsigned short logical_block_size_sectors =
   231			limits->logical_block_size >> SECTOR_SHIFT;
   232	
   233		if (!dev_size)
   234			return 0;
   235	
   236		if ((start >= dev_size) || (start + len > dev_size)) {
   237			DMWARN("%s: %pg too small for target: "
   238			       "start=%llu, len=%llu, dev_size=%llu",
   239			       dm_device_name(ti->table->md), bdev,
   240			       (unsigned long long)start,
   241			       (unsigned long long)len,
   242			       (unsigned long long)dev_size);
   243			return 1;
   244		}
   245	
   246		/*
   247		 * If the target is mapped to zoned block device(s), check
   248		 * that the zones are not partially mapped.
   249		 */
   250		if (bdev_is_zoned(bdev)) {
   251			unsigned int zone_sectors = bdev_zone_sectors(bdev);
   252	
 > 253			if (bdev_is_zone_start(bdev, start)) {
   254				DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
   255				       dm_device_name(ti->table->md),
   256				       (unsigned long long)start,
   257				       zone_sectors, bdev);
   258				return 1;
   259			}
   260	
   261			/*
   262			 * Note: The last zone of a zoned block device may be smaller
   263			 * than other zones. So for a target mapping the end of a
   264			 * zoned block device with such a zone, len would not be zone
   265			 * aligned. We do not allow such last smaller zone to be part
   266			 * of the mapping here to ensure that mappings with multiple
   267			 * devices do not end up with a smaller zone in the middle of
   268			 * the sector range.
   269			 */
   270			if (bdev_is_zone_start(bdev, len)) {
   271				DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
   272				       dm_device_name(ti->table->md),
   273				       (unsigned long long)len,
   274				       zone_sectors, bdev);
   275				return 1;
   276			}
   277		}
   278	
   279		if (logical_block_size_sectors <= 1)
   280			return 0;
   281	
   282		if (start & (logical_block_size_sectors - 1)) {
   283			DMWARN("%s: start=%llu not aligned to h/w "
   284			       "logical block size %u of %pg",
   285			       dm_device_name(ti->table->md),
   286			       (unsigned long long)start,
   287			       limits->logical_block_size, bdev);
   288			return 1;
   289		}
   290	
   291		if (len & (logical_block_size_sectors - 1)) {
   292			DMWARN("%s: len=%llu not aligned to h/w "
   293			       "logical block size %u of %pg",
   294			       dm_device_name(ti->table->md),
   295			       (unsigned long long)len,
   296			       limits->logical_block_size, bdev);
   297			return 1;
   298		}
   299	
   300		return 0;
   301	}
   302	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
