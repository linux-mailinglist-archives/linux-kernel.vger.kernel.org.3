Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7F58BCCA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 21:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiHGTr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiHGTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 15:47:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB06275
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 12:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659901673; x=1691437673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d/xvYp1VCehjRNvJUzLG6cF0D0kPjM+Ficqfi1Bv4GE=;
  b=fQZf1Z5MHJZW1EiYxaRmDvQ6Rjg0YoQOMhmQyr/RXoDVvtK/w7+n7Gfo
   RKg6glxp5L9eXjJqWnxetzlrrL9pfnM0RlnoE0h7yVvoZ/6dFOxurK/Gl
   gTJkna573W2qZO+WWnofXPOTzENGu8S+g4qDJe4TMu/XSdOa2ZrO5QMIJ
   lJZMFsW/ylRXa8+tUnresX7bmj54fXM9nMb6gjhaS3AWDFn4QfjV/hfqk
   qvXO0n0E/qpZE9xWCYNDfykrJHEkbypHXxdUiOlt4pM2tFy7KMbKt/b5l
   JdQNgR1mX7voiNZAVQub4dJLP63Wd3nCCPOgV2FUOfzlLvWXWe3HCl1Gz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="316364387"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="316364387"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 12:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="931789785"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 12:47:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKmFb-000Lcq-0L;
        Sun, 07 Aug 2022 19:47:51 +0000
Date:   Mon, 8 Aug 2022 03:47:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 1/10] fs/f2fs/super.c:1635:9: error: implicit
 declaration of function 'fs_put_dax'
Message-ID: <202208080338.veD16BFU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   42f73c9b2a369f724de6c1df5acb0bbde2688e35
commit: 7df0eb556b0ee20e66872600b62542a7f39d444c [1/10] f2fs: support iomap operation
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220808/202208080338.veD16BFU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=7df0eb556b0ee20e66872600b62542a7f39d444c
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 7df0eb556b0ee20e66872600b62542a7f39d444c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/f2fs/super.c: In function 'f2fs_put_super':
>> fs/f2fs/super.c:1635:9: error: implicit declaration of function 'fs_put_dax' [-Werror=implicit-function-declaration]
    1635 |         fs_put_dax(sbi->s_daxdev);
         |         ^~~~~~~~~~
   fs/f2fs/super.c: In function 'f2fs_fill_super':
>> fs/f2fs/super.c:4037:25: error: implicit declaration of function 'fs_dax_get_by_bdev'; did you mean 'blkdev_get_by_dev'? [-Werror=implicit-function-declaration]
    4037 |         sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
         |                         ^~~~~~~~~~~~~~~~~~
         |                         blkdev_get_by_dev
   fs/f2fs/super.c:4037:23: warning: assignment to 'struct dax_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    4037 |         sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
         |                       ^
   cc1: some warnings being treated as errors


vim +/fs_put_dax +1635 fs/f2fs/super.c

  1531	
  1532	static void f2fs_put_super(struct super_block *sb)
  1533	{
  1534		struct f2fs_sb_info *sbi = F2FS_SB(sb);
  1535		int i;
  1536		bool dropped;
  1537	
  1538		/* unregister procfs/sysfs entries in advance to avoid race case */
  1539		f2fs_unregister_sysfs(sbi);
  1540	
  1541		f2fs_quota_off_umount(sb);
  1542	
  1543		/* prevent remaining shrinker jobs */
  1544		mutex_lock(&sbi->umount_mutex);
  1545	
  1546		/*
  1547		 * flush all issued checkpoints and stop checkpoint issue thread.
  1548		 * after then, all checkpoints should be done by each process context.
  1549		 */
  1550		f2fs_stop_ckpt_thread(sbi);
  1551	
  1552		/*
  1553		 * We don't need to do checkpoint when superblock is clean.
  1554		 * But, the previous checkpoint was not done by umount, it needs to do
  1555		 * clean checkpoint again.
  1556		 */
  1557		if ((is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
  1558				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))) {
  1559			struct cp_control cpc = {
  1560				.reason = CP_UMOUNT,
  1561			};
  1562			f2fs_write_checkpoint(sbi, &cpc);
  1563		}
  1564	
  1565		/* be sure to wait for any on-going discard commands */
  1566		dropped = f2fs_issue_discard_timeout(sbi);
  1567	
  1568		if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
  1569						!sbi->discard_blks && !dropped) {
  1570			struct cp_control cpc = {
  1571				.reason = CP_UMOUNT | CP_TRIMMED,
  1572			};
  1573			f2fs_write_checkpoint(sbi, &cpc);
  1574		}
  1575	
  1576		/*
  1577		 * normally superblock is clean, so we need to release this.
  1578		 * In addition, EIO will skip do checkpoint, we need this as well.
  1579		 */
  1580		f2fs_release_ino_entry(sbi, true);
  1581	
  1582		f2fs_leave_shrinker(sbi);
  1583		mutex_unlock(&sbi->umount_mutex);
  1584	
  1585		/* our cp_error case, we can wait for any writeback page */
  1586		f2fs_flush_merged_writes(sbi);
  1587	
  1588		f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
  1589	
  1590		f2fs_bug_on(sbi, sbi->fsync_node_num);
  1591	
  1592		f2fs_destroy_compress_inode(sbi);
  1593	
  1594		iput(sbi->node_inode);
  1595		sbi->node_inode = NULL;
  1596	
  1597		iput(sbi->meta_inode);
  1598		sbi->meta_inode = NULL;
  1599	
  1600		/*
  1601		 * iput() can update stat information, if f2fs_write_checkpoint()
  1602		 * above failed with error.
  1603		 */
  1604		f2fs_destroy_stats(sbi);
  1605	
  1606		/* destroy f2fs internal modules */
  1607		f2fs_destroy_node_manager(sbi);
  1608		f2fs_destroy_segment_manager(sbi);
  1609	
  1610		f2fs_destroy_post_read_wq(sbi);
  1611	
  1612		kvfree(sbi->ckpt);
  1613	
  1614		sb->s_fs_info = NULL;
  1615		if (sbi->s_chksum_driver)
  1616			crypto_free_shash(sbi->s_chksum_driver);
  1617		kfree(sbi->raw_super);
  1618	
  1619		destroy_device_list(sbi);
  1620		f2fs_destroy_page_array_cache(sbi);
  1621		f2fs_destroy_xattr_caches(sbi);
  1622		mempool_destroy(sbi->write_io_dummy);
  1623	#ifdef CONFIG_QUOTA
  1624		for (i = 0; i < MAXQUOTAS; i++)
  1625			kfree(F2FS_OPTION(sbi).s_qf_names[i]);
  1626	#endif
  1627		fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
  1628		destroy_percpu_info(sbi);
  1629		f2fs_destroy_iostat(sbi);
  1630		for (i = 0; i < NR_PAGE_TYPE; i++)
  1631			kvfree(sbi->write_io[i]);
  1632	#if IS_ENABLED(CONFIG_UNICODE)
  1633		utf8_unload(sb->s_encoding);
  1634	#endif
> 1635		fs_put_dax(sbi->s_daxdev);
  1636		kfree(sbi);
  1637	}
  1638	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
