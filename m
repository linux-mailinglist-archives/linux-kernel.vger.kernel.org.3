Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0458BC9E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiHGS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiHGS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:56:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B397126EC
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659898610; x=1691434610;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rIQCpedyAorKPn4o7Y0gNAWmu8VDk+xzhxwY/SC3lTA=;
  b=e7XKlHU0bPZoZWrrXsMM0vtPEKOyairDmWPo1mWdlYhb9lCdPgQtqWKC
   cPvwwYlFidZJTsbglvDqmC9hWqkytjMkPvT81YCkIQJJcuMG+Q0DSsJwt
   aFo7ZxMbWzhTpWMFMYCbPWNVdc98DpVSs2fBj6+/pbtCFF6/yvcBLiKvj
   xJoGksTJ4NVapQ1qqssTtwXLpetM4Es/9WAMWm8Vag7LwlIkVNZcSgGkm
   LeZl0zLu60zESuUrtzM784rdq1mjQH8iN2EmCDKpxD9cOk73tIHA3I/P+
   Qu266KxtEtS92Nk9jCg0RpTYaFHBljTEwdSpiPA4UoBn0gR4lbfpOAPa3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="273505213"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="273505213"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 11:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="746394800"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2022 11:56:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKlSC-000LaB-0p;
        Sun, 07 Aug 2022 18:56:48 +0000
Date:   Mon, 8 Aug 2022 02:56:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 2/10] fs/f2fs/gc.c:1578:30: error: no member named
 'i_dax_task' in 'struct f2fs_inode_info'
Message-ID: <202208080241.iWx0JT7w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   42f73c9b2a369f724de6c1df5acb0bbde2688e35
commit: 15bc70a98edfc1462941d6451185a04b70f46fe3 [2/10] f2fs: support dax file operations
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220808/202208080241.iWx0JT7w-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=15bc70a98edfc1462941d6451185a04b70f46fe3
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 15bc70a98edfc1462941d6451185a04b70f46fe3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/f2fs/gc.c:1578:30: error: no member named 'i_dax_task' in 'struct f2fs_inode_info'
                                   if (IS_DAX(inode) && fi->i_dax_task == current)
                                                        ~~  ^
   1 error generated.


vim +1578 fs/f2fs/gc.c

  1453	
  1454	/*
  1455	 * This function tries to get parent node of victim data block, and identifies
  1456	 * data block validity. If the block is valid, copy that with cold status and
  1457	 * modify parent node.
  1458	 * If the parent node is not valid or the data block address is different,
  1459	 * the victim data block is ignored.
  1460	 */
  1461	static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
  1462			struct gc_inode_list *gc_list, unsigned int segno, int gc_type,
  1463			bool force_migrate)
  1464	{
  1465		struct super_block *sb = sbi->sb;
  1466		struct f2fs_summary *entry;
  1467		block_t start_addr;
  1468		int off;
  1469		int phase = 0;
  1470		int submitted = 0;
  1471		unsigned int usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
  1472	
  1473		start_addr = START_BLOCK(sbi, segno);
  1474	
  1475	next_step:
  1476		entry = sum;
  1477	
  1478		for (off = 0; off < usable_blks_in_seg; off++, entry++) {
  1479			struct page *data_page;
  1480			struct inode *inode;
  1481			struct node_info dni; /* dnode info for the data */
  1482			unsigned int ofs_in_node, nofs;
  1483			block_t start_bidx;
  1484			nid_t nid = le32_to_cpu(entry->nid);
  1485	
  1486			/*
  1487			 * stop BG_GC if there is not enough free sections.
  1488			 * Or, stop GC if the segment becomes fully valid caused by
  1489			 * race condition along with SSR block allocation.
  1490			 */
  1491			if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
  1492				(!force_migrate && get_valid_blocks(sbi, segno, true) ==
  1493								CAP_BLKS_PER_SEC(sbi)))
  1494				return submitted;
  1495	
  1496			if (check_valid_map(sbi, segno, off) == 0)
  1497				continue;
  1498	
  1499			if (phase == 0) {
  1500				f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
  1501								META_NAT, true);
  1502				continue;
  1503			}
  1504	
  1505			if (phase == 1) {
  1506				f2fs_ra_node_page(sbi, nid);
  1507				continue;
  1508			}
  1509	
  1510			/* Get an inode by ino with checking validity */
  1511			if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs))
  1512				continue;
  1513	
  1514			if (phase == 2) {
  1515				f2fs_ra_node_page(sbi, dni.ino);
  1516				continue;
  1517			}
  1518	
  1519			ofs_in_node = le16_to_cpu(entry->ofs_in_node);
  1520	
  1521			if (phase == 3) {
  1522				int err;
  1523	
  1524				inode = f2fs_iget(sb, dni.ino);
  1525				if (IS_ERR(inode) || is_bad_inode(inode) ||
  1526						special_file(inode->i_mode))
  1527					continue;
  1528	
  1529				err = f2fs_gc_pinned_control(inode, gc_type, segno);
  1530				if (err == -EAGAIN) {
  1531					iput(inode);
  1532					return submitted;
  1533				}
  1534	
  1535				if (!f2fs_down_write_trylock(
  1536					&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
  1537					iput(inode);
  1538					sbi->skipped_gc_rwsem++;
  1539					continue;
  1540				}
  1541	
  1542				start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
  1543									ofs_in_node;
  1544	
  1545				if (f2fs_post_read_required(inode)) {
  1546					int err = ra_data_block(inode, start_bidx);
  1547	
  1548					f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
  1549					if (err) {
  1550						iput(inode);
  1551						continue;
  1552					}
  1553					add_gc_inode(gc_list, inode);
  1554					continue;
  1555				}
  1556	
  1557				data_page = f2fs_get_read_data_page(inode,
  1558							start_bidx, REQ_RAHEAD, true);
  1559				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
  1560				if (IS_ERR(data_page)) {
  1561					iput(inode);
  1562					continue;
  1563				}
  1564	
  1565				f2fs_put_page(data_page, 0);
  1566				add_gc_inode(gc_list, inode);
  1567				continue;
  1568			}
  1569	
  1570			/* phase 4 */
  1571			inode = find_gc_inode(gc_list, dni.ino);
  1572			if (inode) {
  1573				struct f2fs_inode_info *fi = F2FS_I(inode);
  1574				bool locked = false;
  1575				int err;
  1576	
  1577				if (S_ISREG(inode->i_mode)) {
> 1578					if (IS_DAX(inode) && fi->i_dax_task == current)
  1579						goto move_data;
  1580					if (!f2fs_down_write_trylock(&fi->i_gc_rwsem[READ])) {
  1581						sbi->skipped_gc_rwsem++;
  1582						continue;
  1583					}
  1584					if (!f2fs_down_write_trylock(
  1585							&fi->i_gc_rwsem[WRITE])) {
  1586						sbi->skipped_gc_rwsem++;
  1587						f2fs_up_write(&fi->i_gc_rwsem[READ]);
  1588						continue;
  1589					}
  1590					locked = true;
  1591	
  1592					/* wait for all inflight aio data */
  1593					inode_dio_wait(inode);
  1594				}
  1595	
  1596	move_data:
  1597				start_bidx = f2fs_start_bidx_of_node(nofs, inode)
  1598									+ ofs_in_node;
  1599				if (f2fs_post_read_required(inode))
  1600					err = move_data_block(inode, start_bidx,
  1601								gc_type, segno, off);
  1602				else
  1603					err = move_data_page(inode, start_bidx, gc_type,
  1604									segno, off);
  1605	
  1606				if (!err && (gc_type == FG_GC ||
  1607						f2fs_post_read_required(inode)))
  1608					submitted++;
  1609	
  1610				if (locked) {
  1611					f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
  1612					f2fs_up_write(&fi->i_gc_rwsem[READ]);
  1613				}
  1614	
  1615				stat_inc_data_blk_count(sbi, 1, gc_type);
  1616			}
  1617		}
  1618	
  1619		if (++phase < 5)
  1620			goto next_step;
  1621	
  1622		return submitted;
  1623	}
  1624	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
