Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B179481C41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhL3Myz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:54:55 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32883 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235469AbhL3Myy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:54:54 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A9k1gvK0++LUHey9J9vbD5QRzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJhzom1mMCx2oYWW2DPP6JYDTwcoxxYYW2oEgDvpCAzYA2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4Ef9WlTdhSMkj/jRHOGkULS?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?lm7rhc0AMKlLQFVjTzCQGHfH4214b+XdaPqUTbZLwbW9VljGIlpZ1wcpEsZiYS?=
 =?us-ascii?q?AEzP6SKlv51vxxwSnsvbPIcouOvzX+X9Jb7I1f9W2HjxPFiE1AwFZYF4esxCmZ?=
 =?us-ascii?q?LndQbIi0MahzGjuay6La6UfV3wJx6as7xM+s3vnBm0CGcDvs8R53Ha7vF6MUe3?=
 =?us-ascii?q?zoqgM1KW/HEaKIkhZBHBPjbS0QQYRFOUst4wrfu1iS5aTBG7kmbv+wx7nS78eC?=
 =?us-ascii?q?465C1WPK9RzBAbZw9cp6km1/7?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+U345qMLNUXkAsBcTkujsMiBIKoaSvp033AC?=
 =?us-ascii?q?zEpxSQNYf4ixiqmV7bwmPHjP+VEssRAb6LS90MvpewK+yXcb2/hyAV7JZmfbUV?=
 =?us-ascii?q?WTXf1fBOfZskbd88OXzJ8V6U9PG5IOeuEYJ2IK/voTeGKDYqAdKODuytHeuQ81?=
 =?us-ascii?q?p00dOD2CEpsQmzuRdDzrd3GeHzM2eutGKHP03KMuzFedkFssH7WG7xI+LpD+Tr?=
 =?us-ascii?q?Pw5evbiSBtPW9c1ODit1yVAcXBYn6lNhx1aUIz/V78ywKo8mzEz5TmtPf+wgTX?=
 =?us-ascii?q?1m/N4/1t6avc9uc=3D?=
X-IronPort-AV: E=Sophos;i="5.88,248,1635199200"; 
   d="scan'208";a="12997224"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 13:54:53 +0100
Date:   Thu, 30 Dec 2021 13:54:52 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 27/33] fs/btrfs/file.c:1517:19-21: ERROR: reference
 preceded by free on line 1516 (fwd)
Message-ID: <alpine.DEB.2.22.394.2112301354190.15550@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Thu, 30 Dec 2021 19:59:25 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [goldwynr:iomap 27/33] fs/btrfs/file.c:1517:19-21: ERROR: reference
    preceded by free on line 1516

CC: kbuild-all@lists.01.org
CC: linux-kernel@vger.kernel.org
TO: Goldwyn Rodrigues <rgoldwyn@suse.com>

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: f3623890897fee87c24f37ae01a2f1a5c35a39d9 [27/33] btrfs: use srcmap for read-before-write cases
:::::: branch date: 13 hours ago
:::::: commit date: 18 hours ago
config: i386-randconfig-c001-20211228 (https://download.01.org/0day-ci/archive/20211230/202112301901.eLLE2zEp-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


cocci warnings: (new ones prefixed by >>)
>> fs/btrfs/file.c:1517:19-21: ERROR: reference preceded by free on line 1516

vim +1517 fs/btrfs/file.c

e95dc238df949a Goldwyn Rodrigues 2021-05-11  1489
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1490  static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1491  		loff_t length, unsigned flags, struct iomap *iomap,
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1492  		struct iomap *srcmap)
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1493  {
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1494  	int ret;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1495  	size_t write_bytes = length;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1496  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1497  	size_t sector_offset = pos & (fs_info->sectorsize - 1);
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1498  	struct btrfs_iomap *bi;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1499  	loff_t end = pos + length;
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1500
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1501  	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1502  	if (!bi)
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1503  		return -ENOMEM;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1504
f3623890897fee Goldwyn Rodrigues 2021-04-21  1505  	if ((pos & (PAGE_SIZE - 1) || end & (PAGE_SIZE - 1))) {
f3623890897fee Goldwyn Rodrigues 2021-04-21  1506  		loff_t isize = i_size_read(inode);
f3623890897fee Goldwyn Rodrigues 2021-04-21  1507  		if (pos >= isize) {
f3623890897fee Goldwyn Rodrigues 2021-04-21  1508  			srcmap->addr = IOMAP_NULL_ADDR;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1509  			srcmap->type = IOMAP_HOLE;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1510  			srcmap->offset = isize;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1511  			srcmap->length = end - isize;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1512  		} else {
f3623890897fee Goldwyn Rodrigues 2021-04-21  1513  			bi->em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
f3623890897fee Goldwyn Rodrigues 2021-04-21  1514  					pos - sector_offset, length);
f3623890897fee Goldwyn Rodrigues 2021-04-21  1515  			if (IS_ERR(bi->em)) {
f3623890897fee Goldwyn Rodrigues 2021-04-21 @1516  				kfree(bi);
f3623890897fee Goldwyn Rodrigues 2021-04-21 @1517  				return PTR_ERR(bi->em);
f3623890897fee Goldwyn Rodrigues 2021-04-21  1518  			}
f3623890897fee Goldwyn Rodrigues 2021-04-21  1519  			btrfs_em_to_iomap(inode, bi->em, srcmap,
f3623890897fee Goldwyn Rodrigues 2021-04-21  1520  					pos - sector_offset);
f3623890897fee Goldwyn Rodrigues 2021-04-21  1521  		}
f3623890897fee Goldwyn Rodrigues 2021-04-21  1522  	}
f3623890897fee Goldwyn Rodrigues 2021-04-21  1523
f3623890897fee Goldwyn Rodrigues 2021-04-21  1524  	if ((srcmap->type != IOMAP_HOLE) &&
f3623890897fee Goldwyn Rodrigues 2021-04-21  1525  			(end > srcmap->offset + srcmap->length))
f3623890897fee Goldwyn Rodrigues 2021-04-21  1526  			write_bytes = srcmap->offset + srcmap->length - pos;
f3623890897fee Goldwyn Rodrigues 2021-04-21  1527
f3623890897fee Goldwyn Rodrigues 2021-04-21  1528
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1529  	ret = btrfs_check_data_free_space(BTRFS_I(inode),
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1530  			&bi->data_reserved, pos, write_bytes);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1531  	if (ret < 0) {
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1532  		/*
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1533  		 * If we don't have to COW at the offset, reserve
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1534  		 * metadata only. write_bytes may get smaller than
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1535  		 * requested here.
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1536  		 */
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1537  		if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1538  					&write_bytes) > 0)
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1539  			bi->metadata_only = true;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1540  		else
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1541  			return ret;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1542  	}
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1543
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1544  	bi->reserved_bytes = round_up(write_bytes + sector_offset,
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1545  			fs_info->sectorsize);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1546  	WARN_ON(bi->reserved_bytes == 0);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1547  	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1548  			bi->reserved_bytes);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1549  	if (ret) {
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1550  		if (!bi->metadata_only)
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1551  			btrfs_free_reserved_data_space(BTRFS_I(inode),
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1552  					bi->data_reserved, pos,
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1553  					write_bytes);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1554  		else
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1555  			btrfs_check_nocow_unlock(BTRFS_I(inode));
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1556  		return ret;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1557  	}
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1558
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1559  	if (pos < inode->i_size) {
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1560  		bi->lockstart = round_down(pos, fs_info->sectorsize);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1561  		bi->lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1562  		btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1563  				bi->lockstart, bi->lockend,
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1564  				&bi->cached_state);
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1565  		bi->extents_locked = true;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1566  	}
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1567
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1568  	iomap->private = bi;
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1569  	iomap->length = round_up(write_bytes + sector_offset,
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1570  			         fs_info->sectorsize);
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1571  	iomap->offset = round_down(pos, fs_info->sectorsize);
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1572  	iomap->addr = IOMAP_NULL_ADDR;
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1573  	iomap->type = IOMAP_DELALLOC;
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1574  	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1575  	iomap->page_ops = &btrfs_iomap_page_ops;
f4ecee4435f363 Goldwyn Rodrigues 2021-04-21  1576
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1577  	return 0;
b192ee8d4db510 Goldwyn Rodrigues 2021-04-21  1578

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
