Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC847B497
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhLTU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:57:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:47190 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhLTU50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640033846; x=1671569846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v369quL2hlwPT6CoQJBNJFo0swKWyrAmyZLW3tNOF+M=;
  b=NjAByRQuREr1p6vusCYXX6IkGsdfHBnECyxm+wMMoaYneiAdez+LiW6o
   WuwIr5c0qHDcbpZ/HGzfC/986sZIScE4v/SEl0xjYTr3vl0l7Oyoe5qBu
   HVaa0r7WK0HjVaVadCQMewEhBUtkF6UKuv8lJBXL8dm5rO64eBCnQl3aR
   FWLnTXQXp7ArxAEyT+BI8iK1pc4i81xtPI+5ki/BxHSNUDGnq5ag5dvWA
   UsQCkvsYhtp9CKWkQyHGK1Gq52dPQieemz/AS+w51jvilCSmWQatW1ik5
   J8CRZVg3RCJsUPKBM5BLErVhbzh1ySfy8h8W//ku3go/eOm7rTgphXOiD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303640515"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="303640515"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 12:57:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="507824797"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2021 12:57:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzPik-0008Ej-5I; Mon, 20 Dec 2021 20:57:22 +0000
Date:   Tue, 21 Dec 2021 04:56:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 2/9] fs/f2fs/gc.c:1522:56: error: 'struct
 f2fs_inode_info' has no member named 'i_dax_task'
Message-ID: <202112210432.DuobYbvq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   d08999836fd60ab725eee1f5a5fb3b00f7bcefd3
commit: cb4f6683be8c466d963c263ea71dc4164f1eca10 [2/9] f2fs: support dax file operations
config: microblaze-randconfig-r015-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210432.DuobYbvq-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=cb4f6683be8c466d963c263ea71dc4164f1eca10
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout cb4f6683be8c466d963c263ea71dc4164f1eca10
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/f2fs/gc.c:8:
   fs/f2fs/gc.c: In function 'gc_data_segment':
>> fs/f2fs/gc.c:1522:56: error: 'struct f2fs_inode_info' has no member named 'i_dax_task'
    1522 |                                 if (IS_DAX(inode) && fi->i_dax_task == current)
         |                                                        ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   fs/f2fs/gc.c:1522:33: note: in expansion of macro 'if'
    1522 |                                 if (IS_DAX(inode) && fi->i_dax_task == current)
         |                                 ^~
>> fs/f2fs/gc.c:1522:56: error: 'struct f2fs_inode_info' has no member named 'i_dax_task'
    1522 |                                 if (IS_DAX(inode) && fi->i_dax_task == current)
         |                                                        ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   fs/f2fs/gc.c:1522:33: note: in expansion of macro 'if'
    1522 |                                 if (IS_DAX(inode) && fi->i_dax_task == current)
         |                                 ^~
>> fs/f2fs/gc.c:1522:56: error: 'struct f2fs_inode_info' has no member named 'i_dax_task'
    1522 |                                 if (IS_DAX(inode) && fi->i_dax_task == current)
         |                                                        ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   fs/f2fs/gc.c:1522:33: note: in expansion of macro 'if'
    1522 |                                 if (IS_DAX(inode) && fi->i_dax_task == current)
         |                                 ^~


vim +1522 fs/f2fs/gc.c

  1405	
  1406	/*
  1407	 * This function tries to get parent node of victim data block, and identifies
  1408	 * data block validity. If the block is valid, copy that with cold status and
  1409	 * modify parent node.
  1410	 * If the parent node is not valid or the data block address is different,
  1411	 * the victim data block is ignored.
  1412	 */
  1413	static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
  1414			struct gc_inode_list *gc_list, unsigned int segno, int gc_type,
  1415			bool force_migrate)
  1416	{
  1417		struct super_block *sb = sbi->sb;
  1418		struct f2fs_summary *entry;
  1419		block_t start_addr;
  1420		int off;
  1421		int phase = 0;
  1422		int submitted = 0;
  1423		unsigned int usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
  1424	
  1425		start_addr = START_BLOCK(sbi, segno);
  1426	
  1427	next_step:
  1428		entry = sum;
  1429	
  1430		for (off = 0; off < usable_blks_in_seg; off++, entry++) {
  1431			struct page *data_page;
  1432			struct inode *inode;
  1433			struct node_info dni; /* dnode info for the data */
  1434			unsigned int ofs_in_node, nofs;
  1435			block_t start_bidx;
  1436			nid_t nid = le32_to_cpu(entry->nid);
  1437	
  1438			/*
  1439			 * stop BG_GC if there is not enough free sections.
  1440			 * Or, stop GC if the segment becomes fully valid caused by
  1441			 * race condition along with SSR block allocation.
  1442			 */
  1443			if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
  1444				(!force_migrate && get_valid_blocks(sbi, segno, true) ==
  1445								BLKS_PER_SEC(sbi)))
  1446				return submitted;
  1447	
  1448			if (check_valid_map(sbi, segno, off) == 0)
  1449				continue;
  1450	
  1451			if (phase == 0) {
  1452				f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
  1453								META_NAT, true);
  1454				continue;
  1455			}
  1456	
  1457			if (phase == 1) {
  1458				f2fs_ra_node_page(sbi, nid);
  1459				continue;
  1460			}
  1461	
  1462			/* Get an inode by ino with checking validity */
  1463			if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs))
  1464				continue;
  1465	
  1466			if (phase == 2) {
  1467				f2fs_ra_node_page(sbi, dni.ino);
  1468				continue;
  1469			}
  1470	
  1471			ofs_in_node = le16_to_cpu(entry->ofs_in_node);
  1472	
  1473			if (phase == 3) {
  1474				inode = f2fs_iget(sb, dni.ino);
  1475				if (IS_ERR(inode) || is_bad_inode(inode) ||
  1476						special_file(inode->i_mode))
  1477					continue;
  1478	
  1479				if (!down_write_trylock(
  1480					&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
  1481					iput(inode);
  1482					sbi->skipped_gc_rwsem++;
  1483					continue;
  1484				}
  1485	
  1486				start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
  1487									ofs_in_node;
  1488	
  1489				if (f2fs_post_read_required(inode)) {
  1490					int err = ra_data_block(inode, start_bidx);
  1491	
  1492					up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
  1493					if (err) {
  1494						iput(inode);
  1495						continue;
  1496					}
  1497					add_gc_inode(gc_list, inode);
  1498					continue;
  1499				}
  1500	
  1501				data_page = f2fs_get_read_data_page(inode,
  1502							start_bidx, REQ_RAHEAD, true);
  1503				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
  1504				if (IS_ERR(data_page)) {
  1505					iput(inode);
  1506					continue;
  1507				}
  1508	
  1509				f2fs_put_page(data_page, 0);
  1510				add_gc_inode(gc_list, inode);
  1511				continue;
  1512			}
  1513	
  1514			/* phase 4 */
  1515			inode = find_gc_inode(gc_list, dni.ino);
  1516			if (inode) {
  1517				struct f2fs_inode_info *fi = F2FS_I(inode);
  1518				bool locked = false;
  1519				int err;
  1520	
  1521				if (S_ISREG(inode->i_mode)) {
> 1522					if (IS_DAX(inode) && fi->i_dax_task == current)
  1523						goto move_data;
  1524					if (!down_write_trylock(&fi->i_gc_rwsem[READ])) {
  1525						sbi->skipped_gc_rwsem++;
  1526						continue;
  1527					}
  1528					if (!down_write_trylock(
  1529							&fi->i_gc_rwsem[WRITE])) {
  1530						sbi->skipped_gc_rwsem++;
  1531						up_write(&fi->i_gc_rwsem[READ]);
  1532						continue;
  1533					}
  1534					locked = true;
  1535	
  1536					/* wait for all inflight aio data */
  1537					inode_dio_wait(inode);
  1538				}
  1539	
  1540	move_data:
  1541				start_bidx = f2fs_start_bidx_of_node(nofs, inode)
  1542									+ ofs_in_node;
  1543				if (f2fs_post_read_required(inode))
  1544					err = move_data_block(inode, start_bidx,
  1545								gc_type, segno, off);
  1546				else
  1547					err = move_data_page(inode, start_bidx, gc_type,
  1548									segno, off);
  1549	
  1550				if (!err && (gc_type == FG_GC ||
  1551						f2fs_post_read_required(inode)))
  1552					submitted++;
  1553	
  1554				if (locked) {
  1555					up_write(&fi->i_gc_rwsem[WRITE]);
  1556					up_write(&fi->i_gc_rwsem[READ]);
  1557				}
  1558	
  1559				stat_inc_data_blk_count(sbi, 1, gc_type);
  1560			}
  1561		}
  1562	
  1563		if (++phase < 5)
  1564			goto next_step;
  1565	
  1566		return submitted;
  1567	}
  1568	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
