Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA73358BCC1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 21:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiHGTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHGThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 15:37:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11F26541
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659901072; x=1691437072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HSd5PMHsXUlOEH63ygVVEqWzIkFwdmaf39QVq1+D0L8=;
  b=YztwN/zxVjU1EmHfY/slfSAZIvnBmdskRVElH2/Xsi9fV1jgR6d0hw/R
   ZiP3pR1teyqUNXOVP9KgMzwoF1IF3oeblmVI2J4SsSgXIfNFlnycOIv4O
   1O2lCHf7dGWViuVnT8wv9CbQibVjpMG9tpCtDrnwP2rpVe5TYLeS7G7KC
   0WtzYFFb0HSwnWZJM1BUED1mQU9Ibj+SAZ2uH7SRJ9WJ7PRdIaDu7oOHo
   y4zTyZpZB8+0VtLF9UyeeUBKzqvjf0YfiEFNzBXADtXF64R0ALUFQc/TR
   BS/YTIn8+MGQsSvSH/LaYMycHeAIqUsH2slb8jpYPKMFbeEs0KBkDoURe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="289217495"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="289217495"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 12:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672233948"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 12:37:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKm5u-000LcD-1k;
        Sun, 07 Aug 2022 19:37:50 +0000
Date:   Mon, 8 Aug 2022 03:37:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 3/10] fs/f2fs/gc.c:1512:15: error: implicit
 declaration of function 'bdev_dax_pgoff'
Message-ID: <202208080337.vXkQIuAF-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   42f73c9b2a369f724de6c1df5acb0bbde2688e35
commit: 468c7e7ff767ab4dfe194022a427e252863ded0e [3/10] f2fs: support migrate page in dax device
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220808/202208080337.vXkQIuAF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=468c7e7ff767ab4dfe194022a427e252863ded0e
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 468c7e7ff767ab4dfe194022a427e252863ded0e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the chao/feature/dax HEAD 42f73c9b2a369f724de6c1df5acb0bbde2688e35 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   fs/f2fs/gc.c: In function 'dax_move_data_page':
>> fs/f2fs/gc.c:1512:15: error: implicit declaration of function 'bdev_dax_pgoff' [-Werror=implicit-function-declaration]
    1512 |         err = bdev_dax_pgoff(bdev, SECTOR_FROM_BLOCK(old_blkaddr),
         |               ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bdev_dax_pgoff +1512 fs/f2fs/gc.c

  1457	
  1458	#ifdef CONFIG_FS_DAX
  1459	static int dax_move_data_page(struct inode *inode, block_t bidx,
  1460					int gc_type, unsigned int segno, int off)
  1461	{
  1462		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
  1463		struct block_device *bdev = inode->i_sb->s_bdev;
  1464		struct dax_device *dax_dev = sbi->s_daxdev;
  1465		struct dnode_of_data dn;
  1466		struct f2fs_summary sum;
  1467		struct node_info ni;
  1468		block_t old_blkaddr, new_blkaddr;
  1469		void *old_addr, *new_addr;
  1470		int err = 0, id;
  1471		long map_len;
  1472		pgoff_t pgoff;
  1473		pfn_t pfn;
  1474	
  1475		f2fs_bug_on(sbi, f2fs_is_atomic_file(inode));
  1476	
  1477		if (!check_valid_map(sbi, segno, off))
  1478			return -ENOENT;
  1479	
  1480		if (!down_write_trylock(&inode->i_mapping->invalidate_lock))
  1481			return -EAGAIN;
  1482	
  1483		unmap_mapping_range(inode->i_mapping, (loff_t)bidx << PAGE_SHIFT,
  1484								PAGE_SIZE, true);
  1485		/* find the old block address */
  1486		set_new_dnode(&dn, inode, NULL, NULL, 0);
  1487		err = f2fs_get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
  1488		if (err)
  1489			goto out_up;
  1490	
  1491		/* This page is already truncated */
  1492		if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
  1493			err = -ENOENT;
  1494			goto out_put;
  1495		}
  1496	
  1497		err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
  1498		if (err)
  1499			goto out_put;
  1500	
  1501		old_blkaddr = dn.data_blkaddr;
  1502		set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
  1503	
  1504		/* allocate a new block address */
  1505		f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &new_blkaddr,
  1506						&sum, CURSEG_COLD_DATA, NULL);
  1507	
  1508		/* copy data page from old to new address in dax_bdev */
  1509		id = dax_read_lock();
  1510	
  1511		/* get virtual address of original page */
> 1512		err = bdev_dax_pgoff(bdev, SECTOR_FROM_BLOCK(old_blkaddr),
  1513							PAGE_SIZE, &pgoff);
  1514		if (err)
  1515			goto out_recover;
  1516		map_len = dax_direct_access(dax_dev, pgoff, 1,
  1517					DAX_ACCESS, &old_addr, &pfn);
  1518		if (map_len < 0) {
  1519			err = map_len;
  1520			goto out_recover;
  1521		}
  1522	
  1523		/* get virtual address of target page */
  1524		err = bdev_dax_pgoff(bdev, SECTOR_FROM_BLOCK(new_blkaddr),
  1525							PAGE_SIZE, &pgoff);
  1526		if (err)
  1527			goto out_recover;
  1528		map_len = dax_direct_access(dax_dev, pgoff, 1,
  1529					DAX_ACCESS, &new_addr, &pfn);
  1530		if (map_len < 0) {
  1531			err = map_len;
  1532			goto out_recover;
  1533		}
  1534	
  1535		copy_page((void __force *)new_addr, (void __force *)old_addr);
  1536	
  1537		f2fs_update_data_blkaddr(&dn, new_blkaddr);
  1538		set_inode_flag(inode, FI_APPEND_WRITE);
  1539		if (bidx == 0)
  1540			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
  1541	
  1542	out_recover:
  1543		if (err)
  1544			f2fs_do_replace_block(sbi, &sum, new_blkaddr, old_blkaddr,
  1545								true, true, true);
  1546		dax_read_unlock(id);
  1547	out_put:
  1548		f2fs_put_dnode(&dn);
  1549	out_up:
  1550		unmap_mapping_range(inode->i_mapping, (loff_t)bidx << PAGE_SHIFT,
  1551								PAGE_SIZE, true);
  1552		filemap_invalidate_unlock(inode->i_mapping);
  1553		return err;
  1554	}
  1555	#else
  1556	static int dax_move_data_page(struct inode *inode, block_t bidx,
  1557					int gc_type, unsigned int segno, int off)
  1558	{
  1559		return 0;
  1560	}
  1561	#endif
  1562	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
