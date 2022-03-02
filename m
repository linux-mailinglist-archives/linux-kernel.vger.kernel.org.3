Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE764CB3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiCCAJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiCCAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:09:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045BD005F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646266103; x=1677802103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ow/G1HUyZJQjbP2PDwC7GvXViqED8DqmZrdYtb6x7pA=;
  b=QkKOpCok3poebLqOcSZ3NiBQl32sE0zjOMl0U/8g2Nblp1SvnfSik6W6
   azurWJ0BehzCjWwFQcP58vkYMT9cj+UJ7akdXw3u0TngqOLrP2YxM0sgm
   bDNaAbkRmuNBd5tt2b2gOcUEomzl32RkaKtQqM8U+lsI6SxcghnrADMJD
   BmecHzkNAlyRXTsJtdInh5976iC6jtwu+vMkD0nhpSi3laBmNjyxIMih3
   14cICDUeIQUm4oDbFxMgvdzGC4giUBSsNQIbiOdMBBMCNp5xbMLkEgAlX
   ecXWITE9vb0Q/hgtuzWfi/3XIAOJltO6C9iMS85maCL8HKEAWzwqFQjDm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253254891"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253254891"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:01:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="511181734"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 15:00:58 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPXxp-00022P-TT; Wed, 02 Mar 2022 23:00:57 +0000
Date:   Thu, 3 Mar 2022 07:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Badhri Jagan Sridharan <Badhri@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.14-p-release
 75/6167] drivers/md/dm-linear.c:104:5: warning: no previous declaration for
 'dm_linear_end_io'
Message-ID: <202203030654.25RQedXH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badhri,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.14-p-release
head:   0ca5d5ac9152d01b3494fb2efb5390319eb9904a
commit: 539de6b39dcce96f93d6bb19439d00f870f8fa3a [75/6167] ANDROID: dm: android-verity: rebase for 4.9
config: i386-randconfig-r024-20211019 (https://download.01.org/0day-ci/archive/20220303/202203030654.25RQedXH-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/539de6b39dcce96f93d6bb19439d00f870f8fa3a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.14-p-release
        git checkout 539de6b39dcce96f93d6bb19439d00f870f8fa3a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/md/ kernel/cgroup/ kernel/sched/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/md/dm-linear.c:29:5: warning: no previous declaration for 'dm_linear_ctr' [-Wmissing-declarations]
    int dm_linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
        ^~~~~~~~~~~~~
   drivers/md/dm-linear.c:72:6: warning: no previous declaration for 'dm_linear_dtr' [-Wmissing-declarations]
    void dm_linear_dtr(struct dm_target *ti)
         ^~~~~~~~~~~~~
   drivers/md/dm-linear.c:97:5: warning: no previous declaration for 'dm_linear_map' [-Wmissing-declarations]
    int dm_linear_map(struct dm_target *ti, struct bio *bio)
        ^~~~~~~~~~~~~
>> drivers/md/dm-linear.c:104:5: warning: no previous declaration for 'dm_linear_end_io' [-Wmissing-declarations]
    int dm_linear_end_io(struct dm_target *ti, struct bio *bio,
        ^~~~~~~~~~~~~~~~
   drivers/md/dm-linear.c:116:6: warning: no previous declaration for 'dm_linear_status' [-Wmissing-declarations]
    void dm_linear_status(struct dm_target *ti, status_type_t type,
         ^~~~~~~~~~~~~~~~
   drivers/md/dm-linear.c:133:5: warning: no previous declaration for 'dm_linear_prepare_ioctl' [-Wmissing-declarations]
    int dm_linear_prepare_ioctl(struct dm_target *ti,
        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/md/dm-linear.c:150:5: warning: no previous declaration for 'dm_linear_iterate_devices' [-Wmissing-declarations]
    int dm_linear_iterate_devices(struct dm_target *ti,
        ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/md/dm-linear.c:158:6: warning: no previous declaration for 'dm_linear_dax_direct_access' [-Wmissing-declarations]
    long dm_linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/md/dm-linear.c:175:8: warning: no previous declaration for 'dm_linear_dax_copy_from_iter' [-Wmissing-declarations]
    size_t dm_linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dm_linear_end_io +104 drivers/md/dm-linear.c

   103	
 > 104	int dm_linear_end_io(struct dm_target *ti, struct bio *bio,
   105				 blk_status_t *error)
   106	{
   107		struct linear_c *lc = ti->private;
   108	
   109		if (!*error && bio_op(bio) == REQ_OP_ZONE_REPORT)
   110			dm_remap_zone_report(ti, bio, lc->start);
   111	
   112		return DM_ENDIO_DONE;
   113	}
   114	EXPORT_SYMBOL_GPL(dm_linear_end_io);
   115	
   116	void dm_linear_status(struct dm_target *ti, status_type_t type,
   117				  unsigned status_flags, char *result, unsigned maxlen)
   118	{
   119		struct linear_c *lc = (struct linear_c *) ti->private;
   120	
   121		switch (type) {
   122		case STATUSTYPE_INFO:
   123			result[0] = '\0';
   124			break;
   125	
   126		case STATUSTYPE_TABLE:
   127			snprintf(result, maxlen, "%s %llu", lc->dev->name,
   128					(unsigned long long)lc->start);
   129			break;
   130		}
   131	}
   132	
   133	int dm_linear_prepare_ioctl(struct dm_target *ti,
   134			struct block_device **bdev, fmode_t *mode)
   135	{
   136		struct linear_c *lc = (struct linear_c *) ti->private;
   137		struct dm_dev *dev = lc->dev;
   138	
   139		*bdev = dev->bdev;
   140	
   141		/*
   142		 * Only pass ioctls through if the device sizes match exactly.
   143		 */
   144		if (lc->start ||
   145		    ti->len != i_size_read(dev->bdev->bd_inode) >> SECTOR_SHIFT)
   146			return 1;
   147		return 0;
   148	}
   149	
   150	int dm_linear_iterate_devices(struct dm_target *ti,
   151					  iterate_devices_callout_fn fn, void *data)
   152	{
   153		struct linear_c *lc = ti->private;
   154	
   155		return fn(ti, lc->dev, lc->start, ti->len, data);
   156	}
   157	
 > 158	long dm_linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
   159			long nr_pages, void **kaddr, pfn_t *pfn)
   160	{
   161		long ret;
   162		struct linear_c *lc = ti->private;
   163		struct block_device *bdev = lc->dev->bdev;
   164		struct dax_device *dax_dev = lc->dev->dax_dev;
   165		sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
   166	
   167		dev_sector = linear_map_sector(ti, sector);
   168		ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
   169		if (ret)
   170			return ret;
   171		return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
   172	}
   173	EXPORT_SYMBOL_GPL(dm_linear_dax_direct_access);
   174	
 > 175	size_t dm_linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
   176			void *addr, size_t bytes, struct iov_iter *i)
   177	{
   178		struct linear_c *lc = ti->private;
   179		struct block_device *bdev = lc->dev->bdev;
   180		struct dax_device *dax_dev = lc->dev->dax_dev;
   181		sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
   182	
   183		dev_sector = linear_map_sector(ti, sector);
   184		if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
   185			return 0;
   186		return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
   187	}
   188	EXPORT_SYMBOL_GPL(dm_linear_dax_copy_from_iter);
   189	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
