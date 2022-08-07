Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41458BC39
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiHGSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiHGSFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:05:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCEEE6C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659895547; x=1691431547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cjKiqE4IUoiK79Tij+gwJvkNz0gNHDZblibnwc/raMk=;
  b=cWvoE2SF2tYg25Q6Rz/STO+z7LY08++b/37zMM5uyouJdd1cdfqHQXht
   lkTb2Epgx6AWyJWAJfQc6tj8TgxWcAfa1LZBpkwm5xabZMYGCQJPuNsDE
   /aqP5vDAW6N7DJj0uzw6Kp66lh/08F17H1cUtRnideFFrQklSj4y2jlMl
   X2feLrDRUL6gr8fgBIq1z4aX6DbiDDTbc7u/sL0w0VobidUu2MkaT1g+Z
   WDsJbjpftVpwi/fjlAHX2CJFIAzQXI4agj42+0rSmoBt0ryAw2mUdLeYL
   XgAsvWYJWZrJNoTfPXP4FAE8o25RgSu2wm0By0Sq3rBbs0cv3BCuNlQIA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="288018720"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="288018720"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 11:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672220398"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 11:05:45 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKkem-000LXT-30;
        Sun, 07 Aug 2022 18:05:44 +0000
Date:   Mon, 8 Aug 2022 02:05:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 1/10] fs/f2fs/super.c:4037:23: warning: assignment
 to 'struct dax_device *' from 'int' makes pointer from integer without a
 cast
Message-ID: <202208080125.P6YgBICb-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   42f73c9b2a369f724de6c1df5acb0bbde2688e35
commit: 7df0eb556b0ee20e66872600b62542a7f39d444c [1/10] f2fs: support iomap operation
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220808/202208080125.P6YgBICb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=7df0eb556b0ee20e66872600b62542a7f39d444c
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 7df0eb556b0ee20e66872600b62542a7f39d444c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/f2fs/super.c: In function 'f2fs_put_super':
   fs/f2fs/super.c:1635:9: error: implicit declaration of function 'fs_put_dax' [-Werror=implicit-function-declaration]
    1635 |         fs_put_dax(sbi->s_daxdev);
         |         ^~~~~~~~~~
   fs/f2fs/super.c: In function 'f2fs_fill_super':
   fs/f2fs/super.c:4037:25: error: implicit declaration of function 'fs_dax_get_by_bdev'; did you mean 'blkdev_get_by_dev'? [-Werror=implicit-function-declaration]
    4037 |         sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
         |                         ^~~~~~~~~~~~~~~~~~
         |                         blkdev_get_by_dev
>> fs/f2fs/super.c:4037:23: warning: assignment to 'struct dax_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    4037 |         sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
         |                       ^
   cc1: some warnings being treated as errors


vim +4037 fs/f2fs/super.c

  4011	
  4012	static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
  4013	{
  4014		struct f2fs_sb_info *sbi;
  4015		struct f2fs_super_block *raw_super;
  4016		struct inode *root;
  4017		int err;
  4018		bool skip_recovery = false, need_fsck = false;
  4019		char *options = NULL;
  4020		int recovery, i, valid_super_block;
  4021		struct curseg_info *seg_i;
  4022		int retry_cnt = 1;
  4023	
  4024	try_onemore:
  4025		err = -EINVAL;
  4026		raw_super = NULL;
  4027		valid_super_block = -1;
  4028		recovery = 0;
  4029	
  4030		/* allocate memory for f2fs-specific super block info */
  4031		sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
  4032		if (!sbi)
  4033			return -ENOMEM;
  4034	
  4035		sbi->sb = sb;
  4036	
> 4037		sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
  4038	
  4039		/* Load the checksum driver */
  4040		sbi->s_chksum_driver = crypto_alloc_shash("crc32", 0, 0);
  4041		if (IS_ERR(sbi->s_chksum_driver)) {
  4042			f2fs_err(sbi, "Cannot load crc32 driver.");
  4043			err = PTR_ERR(sbi->s_chksum_driver);
  4044			sbi->s_chksum_driver = NULL;
  4045			goto free_sbi;
  4046		}
  4047	
  4048		/* set a block size */
  4049		if (unlikely(!sb_set_blocksize(sb, F2FS_BLKSIZE))) {
  4050			f2fs_err(sbi, "unable to set blocksize");
  4051			goto free_sbi;
  4052		}
  4053	
  4054		err = read_raw_super_block(sbi, &raw_super, &valid_super_block,
  4055									&recovery);
  4056		if (err)
  4057			goto free_sbi;
  4058	
  4059		sb->s_fs_info = sbi;
  4060		sbi->raw_super = raw_super;
  4061	
  4062		/* precompute checksum seed for metadata */
  4063		if (f2fs_sb_has_inode_chksum(sbi))
  4064			sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
  4065							sizeof(raw_super->uuid));
  4066	
  4067		default_options(sbi);
  4068		/* parse mount options */
  4069		options = kstrdup((const char *)data, GFP_KERNEL);
  4070		if (data && !options) {
  4071			err = -ENOMEM;
  4072			goto free_sb_buf;
  4073		}
  4074	
  4075		err = parse_options(sb, options, false);
  4076		if (err)
  4077			goto free_options;
  4078	
  4079		sb->s_maxbytes = max_file_blocks(NULL) <<
  4080					le32_to_cpu(raw_super->log_blocksize);
  4081		sb->s_max_links = F2FS_LINK_MAX;
  4082	
  4083		err = f2fs_setup_casefold(sbi);
  4084		if (err)
  4085			goto free_options;
  4086	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
