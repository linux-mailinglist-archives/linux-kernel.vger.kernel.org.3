Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8F56C67B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 05:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGIDks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 23:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGIDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 23:40:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2385D57
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657338024; x=1688874024;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FlItoKzgG1e2LfT/0c16eahk8s9C2BA0261gC6/zr1Q=;
  b=W30PlrItttxLF5oxcdDe1yzQ1K89alV9GYPTxUiAHqnf2VEYKJSYxOjr
   b/WxyJ4m0u0ctdF+rseEJJu3Wk/WU+i8ENAVpgkMyxQzPoOrybFtKWRN2
   9QpAsjbyKNstO+2YscbXr3hZ5n5hYJaafag5B5WRg6HZXbx25l5f1Mw6M
   GeOgI/E/E3pSo4bp2TXlB3iu1ocfvPtxFP4EENKQgP11+KDfmkP0jpwIg
   4OPRlTacZoRmDLRoRvlS0Vd0tN9Rktwj0YeBI5z1hjJP1a8zsV9pIZVpE
   XbwDTCfD38ldGbgdbx3z2MrXQyByWUZWtHyNDRWUvHO/2tY7cYvMnA39h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="346090266"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="346090266"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 20:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="661975102"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2022 20:40:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA1KO-000OGM-QU;
        Sat, 09 Jul 2022 03:40:20 +0000
Date:   Sat, 9 Jul 2022 11:39:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [mcgrof-next:20220707-dm-zoned-npo2 1/13] block/ioctl.c:496:39:
 error: implicit declaration of function 'bdev_zone_sectors'; did you mean
 'bdev_nr_sectors'?
Message-ID: <202207091112.sD4WmjCs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20220707-dm-zoned-npo2
head:   3d1b6e41f76394610669e380da4f65bc5e7cf8ac
commit: a37ed4b355c02ec383a85c961f0e121df104cc1a [1/13] block: make bdev_nr_zones and disk_zone_no generic for npo2 zsze
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220709/202207091112.sD4WmjCs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=a37ed4b355c02ec383a85c961f0e121df104cc1a
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220707-dm-zoned-npo2
        git checkout a37ed4b355c02ec383a85c961f0e121df104cc1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   block/ioctl.c: In function 'blkdev_common_ioctl':
>> block/ioctl.c:496:39: error: implicit declaration of function 'bdev_zone_sectors'; did you mean 'bdev_nr_sectors'? [-Werror=implicit-function-declaration]
     496 |                 return put_uint(argp, bdev_zone_sectors(bdev));
         |                                       ^~~~~~~~~~~~~~~~~
         |                                       bdev_nr_sectors
   cc1: some warnings being treated as errors
--
   drivers/md/dm-table.c: In function 'device_area_is_invalid':
>> drivers/md/dm-table.c:251:45: error: implicit declaration of function 'bdev_zone_sectors'; did you mean 'bdev_nr_sectors'? [-Werror=implicit-function-declaration]
     251 |                 unsigned int zone_sectors = bdev_zone_sectors(bdev);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             bdev_nr_sectors
   cc1: some warnings being treated as errors


vim +496 block/ioctl.c

d8e4bb8103df02a Christoph Hellwig  2015-10-15  464  
d8e4bb8103df02a Christoph Hellwig  2015-10-15  465  /*
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  466   * Common commands that are handled the same way on native and compat
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  467   * user space. Note the separate arg/argp parameters that are needed
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  468   * to deal with the compat_ptr() conversion.
d8e4bb8103df02a Christoph Hellwig  2015-10-15  469   */
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  470  static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  471  				unsigned cmd, unsigned long arg, void __user *argp)
d8e4bb8103df02a Christoph Hellwig  2015-10-15  472  {
d8e4bb8103df02a Christoph Hellwig  2015-10-15  473  	unsigned int max_sectors;
d8e4bb8103df02a Christoph Hellwig  2015-10-15  474  
d8e4bb8103df02a Christoph Hellwig  2015-10-15  475  	switch (cmd) {
d8e4bb8103df02a Christoph Hellwig  2015-10-15  476  	case BLKFLSBUF:
d8e4bb8103df02a Christoph Hellwig  2015-10-15  477  		return blkdev_flushbuf(bdev, mode, cmd, arg);
d8e4bb8103df02a Christoph Hellwig  2015-10-15  478  	case BLKROSET:
d8e4bb8103df02a Christoph Hellwig  2015-10-15  479  		return blkdev_roset(bdev, mode, cmd, arg);
d8e4bb8103df02a Christoph Hellwig  2015-10-15  480  	case BLKDISCARD:
44abff2c0b970ae Christoph Hellwig  2022-04-15  481  		return blk_ioctl_discard(bdev, mode, arg);
d8e4bb8103df02a Christoph Hellwig  2015-10-15  482  	case BLKSECDISCARD:
44abff2c0b970ae Christoph Hellwig  2022-04-15  483  		return blk_ioctl_secure_erase(bdev, mode, argp);
d8e4bb8103df02a Christoph Hellwig  2015-10-15  484  	case BLKZEROOUT:
d8e4bb8103df02a Christoph Hellwig  2015-10-15  485  		return blk_ioctl_zeroout(bdev, mode, arg);
7957d93bf32bc21 Matteo Croce       2021-07-13  486  	case BLKGETDISKSEQ:
7957d93bf32bc21 Matteo Croce       2021-07-13  487  		return put_u64(argp, bdev->bd_disk->diskseq);
3ed05a987e0f63b Shaun Tancheff     2016-10-18  488  	case BLKREPORTZONE:
3ed05a987e0f63b Shaun Tancheff     2016-10-18  489  		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);
3ed05a987e0f63b Shaun Tancheff     2016-10-18  490  	case BLKRESETZONE:
e876df1fe0ad1b1 Ajay Joshi         2019-10-27  491  	case BLKOPENZONE:
e876df1fe0ad1b1 Ajay Joshi         2019-10-27  492  	case BLKCLOSEZONE:
e876df1fe0ad1b1 Ajay Joshi         2019-10-27  493  	case BLKFINISHZONE:
e876df1fe0ad1b1 Ajay Joshi         2019-10-27  494  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
72cd87576d1d885 Damien Le Moal     2018-10-12  495  	case BLKGETZONESZ:
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29 @496  		return put_uint(argp, bdev_zone_sectors(bdev));
65e4e3eee83d7a4 Damien Le Moal     2018-10-12  497  	case BLKGETNRZONES:
b623e347323f646 Christoph Hellwig  2022-07-06  498  		return put_uint(argp, bdev_nr_zones(bdev));
45048d0961cdbf7 Al Viro            2008-09-18  499  	case BLKROGET:
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  500  		return put_int(argp, bdev_read_only(bdev) != 0);
ac481c20ef8f6c6 Martin K. Petersen 2009-10-03  501  	case BLKSSZGET: /* get block device logical block size */
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  502  		return put_int(argp, bdev_logical_block_size(bdev));
ac481c20ef8f6c6 Martin K. Petersen 2009-10-03  503  	case BLKPBSZGET: /* get block device physical block size */
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  504  		return put_uint(argp, bdev_physical_block_size(bdev));
ac481c20ef8f6c6 Martin K. Petersen 2009-10-03  505  	case BLKIOMIN:
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  506  		return put_uint(argp, bdev_io_min(bdev));
ac481c20ef8f6c6 Martin K. Petersen 2009-10-03  507  	case BLKIOOPT:
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  508  		return put_uint(argp, bdev_io_opt(bdev));
ac481c20ef8f6c6 Martin K. Petersen 2009-10-03  509  	case BLKALIGNOFF:
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  510  		return put_int(argp, bdev_alignment_offset(bdev));
98262f2762f0067 Martin K. Petersen 2009-12-03  511  	case BLKDISCARDZEROES:
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  512  		return put_uint(argp, 0);
45048d0961cdbf7 Al Viro            2008-09-18  513  	case BLKSECTGET:
63f264965947ac6 Akinobu Mita       2014-05-25  514  		max_sectors = min_t(unsigned int, USHRT_MAX,
63f264965947ac6 Akinobu Mita       2014-05-25  515  				    queue_max_sectors(bdev_get_queue(bdev)));
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  516  		return put_ushort(argp, max_sectors);
ef00f59c95fe6e0 Martin K. Petersen 2012-01-11  517  	case BLKROTATIONAL:
10f0d2a517796b8 Christoph Hellwig  2022-04-15  518  		return put_ushort(argp, !bdev_nonrot(bdev));
45048d0961cdbf7 Al Viro            2008-09-18  519  	case BLKRASET:
45048d0961cdbf7 Al Viro            2008-09-18  520  	case BLKFRASET:
45048d0961cdbf7 Al Viro            2008-09-18  521  		if(!capable(CAP_SYS_ADMIN))
45048d0961cdbf7 Al Viro            2008-09-18  522  			return -EACCES;
a11d7fc2d05fb50 Christoph Hellwig  2021-08-09  523  		bdev->bd_disk->bdi->ra_pages = (arg * 512) / PAGE_SIZE;
45048d0961cdbf7 Al Viro            2008-09-18  524  		return 0;
45048d0961cdbf7 Al Viro            2008-09-18  525  	case BLKRRPART:
e16e506ccd673a3 Christoph Hellwig  2021-11-22  526  		if (!capable(CAP_SYS_ADMIN))
e16e506ccd673a3 Christoph Hellwig  2021-11-22  527  			return -EACCES;
e16e506ccd673a3 Christoph Hellwig  2021-11-22  528  		if (bdev_is_partition(bdev))
e16e506ccd673a3 Christoph Hellwig  2021-11-22  529  			return -EINVAL;
e16e506ccd673a3 Christoph Hellwig  2021-11-22  530  		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
45048d0961cdbf7 Al Viro            2008-09-18  531  	case BLKTRACESTART:
45048d0961cdbf7 Al Viro            2008-09-18  532  	case BLKTRACESTOP:
45048d0961cdbf7 Al Viro            2008-09-18  533  	case BLKTRACETEARDOWN:
d8e4bb8103df02a Christoph Hellwig  2015-10-15  534  		return blk_trace_ioctl(bdev, cmd, argp);
bbd3e064362e505 Christoph Hellwig  2015-10-15  535  	case IOC_PR_REGISTER:
bbd3e064362e505 Christoph Hellwig  2015-10-15  536  		return blkdev_pr_register(bdev, argp);
bbd3e064362e505 Christoph Hellwig  2015-10-15  537  	case IOC_PR_RESERVE:
bbd3e064362e505 Christoph Hellwig  2015-10-15  538  		return blkdev_pr_reserve(bdev, argp);
bbd3e064362e505 Christoph Hellwig  2015-10-15  539  	case IOC_PR_RELEASE:
bbd3e064362e505 Christoph Hellwig  2015-10-15  540  		return blkdev_pr_release(bdev, argp);
bbd3e064362e505 Christoph Hellwig  2015-10-15  541  	case IOC_PR_PREEMPT:
bbd3e064362e505 Christoph Hellwig  2015-10-15  542  		return blkdev_pr_preempt(bdev, argp, false);
bbd3e064362e505 Christoph Hellwig  2015-10-15  543  	case IOC_PR_PREEMPT_ABORT:
bbd3e064362e505 Christoph Hellwig  2015-10-15  544  		return blkdev_pr_preempt(bdev, argp, true);
bbd3e064362e505 Christoph Hellwig  2015-10-15  545  	case IOC_PR_CLEAR:
bbd3e064362e505 Christoph Hellwig  2015-10-15  546  		return blkdev_pr_clear(bdev, argp);
45048d0961cdbf7 Al Viro            2008-09-18  547  	default:
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  548  		return -ENOIOCTLCMD;
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  549  	}
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  550  }
9b81648cb5e3ae7 Arnd Bergmann      2019-11-29  551  

:::::: The code at line 496 was first introduced by commit
:::::: 9b81648cb5e3ae7296825f0c8d2f98e50631ee84 compat_ioctl: simplify up block/ioctl.c

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
