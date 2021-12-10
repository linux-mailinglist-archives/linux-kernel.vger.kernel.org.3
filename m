Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E246FC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbhLJIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:05:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:8928 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbhLJIFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639123322; x=1670659322;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uEP02o6tIwqiW+U3TKFUGdzVpgKz1JDn/FUmqxmK8ZM=;
  b=Fcoigs8quJgrZz4LMDU5lOH0SZ9TIZIQHPPiQZrU3bRpCm1X3xCjtjFz
   p4gs1PcjsqRohL2ebOCWZiLcdh5DcMQvqkEjJVvhiuRmXQ9f6zQyDQdvm
   9bqri/p9VWmNq6TOC4Ff5Q/hcl+R+Q26aMRQWBITBhHhrCsJmruaRiBO7
   d9OpykAhX97+abCliJyBb9MWnUrDuaJjrBchoF9AVIYCDn38hlnxhIyz9
   9U41tRWFpb5mC32unwZdNjoKSsDpoFWMQG82Nleh4gE6NuovToq5/I+wO
   pGHgaXor52x6xRp4y4YB2rTokM2p86dR9aGicwHfGe2IfKIk0eX9Fwluh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225167694"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="225167694"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 00:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="565110379"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Dec 2021 00:01:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvaqs-0002wC-0p; Fri, 10 Dec 2021 08:01:58 +0000
Date:   Fri, 10 Dec 2021 16:01:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt-content 50/51] fs/ceph/file.c:1712:20: error:
 too many arguments to function call, expected 4, have 5
Message-ID: <202112101520.wAUVIMOO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt-content
head:   a7bdf8275eeb05b44be3426ce23ac0e99791ab80
commit: 81588e00b89cb14beb905a04b84198f99f5db059 [50/51] ceph: add read/modify/write to ceph_sync_write
config: riscv-randconfig-r014-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101520.wAUVIMOO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=81588e00b89cb14beb905a04b84198f99f5db059
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt-content
        git checkout 81588e00b89cb14beb905a04b84198f99f5db059
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/nvme/host/ fs/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ceph/file.c:11:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from fs/ceph/file.c:11:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from fs/ceph/file.c:11:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> fs/ceph/file.c:1712:20: error: too many arguments to function call, expected 4, have 5
                                                            write_len, GFP_KERNEL);
                                                                       ^~~~~~~~~~
   include/linux/gfp.h:324:20: note: expanded from macro 'GFP_KERNEL'
   #define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ceph/crypto.h:213:19: note: 'ceph_fscrypt_encrypt_pages' declared here
   static inline int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page,
                     ^
   7 warnings and 1 error generated.


vim +1712 fs/ceph/file.c

  1485	
  1486	/*
  1487	 * Synchronous write, straight from __user pointer or user pages.
  1488	 *
  1489	 * If write spans object boundary, just do multiple writes.  (For a
  1490	 * correct atomic write, we should e.g. take write locks on all
  1491	 * objects, rollback on failure, etc.)
  1492	 */
  1493	static ssize_t
  1494	ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
  1495			struct ceph_snap_context *snapc)
  1496	{
  1497		struct file *file = iocb->ki_filp;
  1498		struct inode *inode = file_inode(file);
  1499		struct ceph_inode_info *ci = ceph_inode(inode);
  1500		struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
  1501		struct ceph_osd_client *osdc = &fsc->client->osdc;
  1502		struct ceph_osd_request *req;
  1503		struct page **pages;
  1504		u64 len;
  1505		int num_pages;
  1506		int written = 0;
  1507		int ret;
  1508		bool check_caps = false;
  1509		struct timespec64 mtime = current_time(inode);
  1510		size_t count = iov_iter_count(from);
  1511	
  1512		if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
  1513			return -EROFS;
  1514	
  1515		dout("sync_write on file %p %lld~%u snapc %p seq %lld\n",
  1516		     file, pos, (unsigned)count, snapc, snapc->seq);
  1517	
  1518		ret = filemap_write_and_wait_range(inode->i_mapping,
  1519						   pos, pos + count - 1);
  1520		if (ret < 0)
  1521			return ret;
  1522	
  1523		ret = invalidate_inode_pages2_range(inode->i_mapping,
  1524						    pos >> PAGE_SHIFT,
  1525						    (pos + count - 1) >> PAGE_SHIFT);
  1526		if (ret < 0)
  1527			dout("invalidate_inode_pages2_range returned %d\n", ret);
  1528	
  1529		while ((len = iov_iter_count(from)) > 0) {
  1530			size_t left;
  1531			int n;
  1532			u64 write_pos = pos;
  1533			u64 write_len;
  1534			u64 objnum, objoff;
  1535			u32 objlen;
  1536			u64 assert_ver;
  1537			bool rmw;
  1538			struct iov_iter saved_iter = *from;
  1539			size_t off;
  1540	
  1541			/* clamp the length to the end of first object */
  1542			ceph_calc_file_object_mapping(&ci->i_layout, pos, len,
  1543							&objnum, &objoff, &objlen);
  1544			if (objlen < len)
  1545				len = objlen;
  1546	
  1547			write_len = len;
  1548			fscrypt_adjust_off_and_len(inode, &write_pos, &write_len);
  1549	
  1550			/*
  1551			 * If we had to adjust the length or position to align with a
  1552			 * crypto block, then we must do a read/modify/write cycle. We
  1553			 * use a version assertion to redrive the thing if something
  1554			 * changes in between.
  1555			 */
  1556			rmw = (pos != write_pos || len != write_len);
  1557	
  1558			/*
  1559			 * The data is emplaced into the page as it would be if it were in
  1560			 * an array of pagecache pages.
  1561			 */
  1562			num_pages = calc_pages_for(write_pos, write_len);
  1563			pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
  1564			if (IS_ERR(pages)) {
  1565				ret = PTR_ERR(pages);
  1566				break;
  1567			}
  1568	
  1569			/* Do we need to preload the pages? */
  1570			if (rmw) {
  1571				u64 first_pos = write_pos;
  1572				u64 last_pos = (write_pos + write_len) - CEPH_FSCRYPT_BLOCK_SIZE;
  1573				u64 read_len = CEPH_FSCRYPT_BLOCK_SIZE;
  1574				bool first = (pos != write_pos);
  1575				bool last = (len != write_len && first_pos != last_pos);
  1576	
  1577				/* We should only need to do this for encrypted inodes */
  1578				WARN_ON_ONCE(!IS_ENCRYPTED(inode));
  1579	
  1580				/*
  1581				 * Allocate a read request for one or two extents, depending
  1582				 * on how the request was aligned.
  1583				 */
  1584				req = ceph_osdc_new_request(osdc, &ci->i_layout,
  1585						ci->i_vino, first ? first_pos : last_pos,
  1586						&read_len, 0, (first && last) ? 2 : 1,
  1587						CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
  1588						NULL, ci->i_truncate_seq,
  1589						ci->i_truncate_size, false);
  1590				if (IS_ERR(req)) {
  1591					ceph_release_page_vector(pages, num_pages);
  1592					ret = PTR_ERR(req);
  1593					break;
  1594				}
  1595	
  1596				/* Something is misaligned! */
  1597				if (read_len != CEPH_FSCRYPT_BLOCK_SIZE) {
  1598					ret = -EIO;
  1599					break;
  1600				}
  1601	
  1602				/* Add extent for first block? */
  1603				if (first)
  1604					osd_req_op_extent_osd_data_pages(req, 0, pages,
  1605								 CEPH_FSCRYPT_BLOCK_SIZE,
  1606								 offset_in_page(first_pos),
  1607								 false, false);
  1608	
  1609				/* Add extent for last block */
  1610				if (last) {
  1611					/* Init the other extent if first extent has been used */
  1612					if (first) {
  1613						osd_req_op_extent_init(req, 1, CEPH_OSD_OP_READ,
  1614								last_pos, read_len,
  1615								ci->i_truncate_size,
  1616								ci->i_truncate_seq);
  1617					}
  1618	
  1619					osd_req_op_extent_osd_data_pages(req, first ? 1 : 0,
  1620								&pages[num_pages - 1],
  1621								CEPH_FSCRYPT_BLOCK_SIZE,
  1622								offset_in_page(last_pos),
  1623								false, false);
  1624				}
  1625	
  1626				ret = ceph_osdc_start_request(osdc, req, false);
  1627				if (!ret)
  1628					ret = ceph_osdc_wait_request(osdc, req);
  1629	
  1630				/* FIXME: length field is wrong if there are 2 extents */
  1631				ceph_update_read_metrics(&fsc->mdsc->metric,
  1632							 req->r_start_latency,
  1633							 req->r_end_latency,
  1634							 read_len, ret);
  1635	
  1636				/* Ok if object is not already present */
  1637				if (ret == -ENOENT) {
  1638					/*
  1639					 * If there is no object, then we can't assert
  1640					 * on its version. Clear rmw so that we don't try.
  1641					 */
  1642					ceph_osdc_put_request(req);
  1643					rmw = false;
  1644					ret = 0;
  1645	
  1646					/*
  1647					 * zero out the soon-to-be uncopied parts of the
  1648					 * first and last pages.
  1649					 */
  1650					if (first)
  1651						zero_user_segment(pages[0], 0,
  1652								  offset_in_page(first_pos));
  1653					if (last)
  1654						zero_user_segment(pages[num_pages - 1],
  1655								  offset_in_page(last_pos),
  1656								  PAGE_SIZE);
  1657				} else {
  1658					/* Grab assert version. It must be non-zero. */
  1659					assert_ver = req->r_version;
  1660					WARN_ON_ONCE(assert_ver == 0);
  1661	
  1662					ceph_osdc_put_request(req);
  1663					if (ret < 0) {
  1664						ceph_release_page_vector(pages, num_pages);
  1665						break;
  1666					}
  1667	
  1668					if (first) {
  1669						ret = ceph_fscrypt_decrypt_block_inplace(inode,
  1670								pages[0],
  1671								CEPH_FSCRYPT_BLOCK_SIZE,
  1672								offset_in_page(first_pos),
  1673								first_pos >> CEPH_FSCRYPT_BLOCK_SHIFT);
  1674						if (ret)
  1675							break;
  1676					}
  1677					if (last) {
  1678						ret = ceph_fscrypt_decrypt_block_inplace(inode,
  1679								pages[num_pages - 1],
  1680								CEPH_FSCRYPT_BLOCK_SIZE,
  1681								offset_in_page(last_pos),
  1682								last_pos >> CEPH_FSCRYPT_BLOCK_SHIFT);
  1683						if (ret)
  1684							break;
  1685					}
  1686				}
  1687			}
  1688	
  1689			left = len;
  1690			off = offset_in_page(pos);
  1691			for (n = 0; n < num_pages; n++) {
  1692				size_t plen = min_t(size_t, left, PAGE_SIZE - off);
  1693	
  1694				/* copy the data */
  1695				ret = copy_page_from_iter(pages[n], off, plen, from);
  1696				if (ret != plen) {
  1697					ret = -EFAULT;
  1698					break;
  1699				}
  1700				off = 0;
  1701				left -= ret;
  1702			}
  1703			if (ret < 0) {
  1704				dout("sync_write write failed with %d\n", ret);
  1705				ceph_release_page_vector(pages, num_pages);
  1706				break;
  1707			}
  1708	
  1709			if (IS_ENCRYPTED(inode)) {
  1710				ret = ceph_fscrypt_encrypt_pages(inode, pages,
  1711								 offset_in_page(write_pos),
> 1712								 write_len, GFP_KERNEL);
  1713				if (ret < 0) {
  1714					dout("encryption failed with %d\n", ret);
  1715					break;
  1716				}
  1717			}
  1718	
  1719			req = ceph_osdc_new_request(osdc, &ci->i_layout,
  1720						    ci->i_vino, write_pos, &write_len,
  1721						    rmw ? 1 : 0, rmw ? 2 : 1,
  1722						    CEPH_OSD_OP_WRITE,
  1723						    CEPH_OSD_FLAG_WRITE,
  1724						    snapc, ci->i_truncate_seq,
  1725						    ci->i_truncate_size, false);
  1726			if (IS_ERR(req)) {
  1727				ret = PTR_ERR(req);
  1728				ceph_release_page_vector(pages, num_pages);
  1729				break;
  1730			}
  1731	
  1732			osd_req_op_extent_osd_data_pages(req, rmw ? 1 : 0, pages, write_len,
  1733							 write_pos & ~CEPH_FSCRYPT_BLOCK_MASK,
  1734							 false, true);
  1735			req->r_inode = inode;
  1736			req->r_mtime = mtime;
  1737	
  1738			/* Set up the assertion */
  1739			if (rmw) {
  1740				/* Set up the assertion */
  1741				osd_req_op_init(req, 0, CEPH_OSD_OP_ASSERT_VER, 0);
  1742				req->r_ops[0].assert_ver.ver = assert_ver;
  1743			}
  1744	
  1745			ret = ceph_osdc_start_request(osdc, req, false);
  1746			if (!ret)
  1747				ret = ceph_osdc_wait_request(osdc, req);
  1748	
  1749			ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
  1750						  req->r_end_latency, len, ret);
  1751			ceph_osdc_put_request(req);
  1752			if (ret != 0) {
  1753				dout("sync_write osd write returned %d\n", ret);
  1754				/* Version changed! Must re-do the rmw cycle */
  1755				if (ret == -ERANGE || ret == -EOVERFLOW) {
  1756					/* We should only ever see this on a rmw */
  1757					WARN_ON_ONCE(!rmw);
  1758	
  1759					/* The version should never go backward */
  1760					WARN_ON_ONCE(ret == -EOVERFLOW);
  1761	
  1762					*from = saved_iter;
  1763	
  1764					/* FIXME: limit number of times we loop? */
  1765					continue;
  1766				}
  1767				ceph_set_error_write(ci);
  1768				break;
  1769			}
  1770			ceph_clear_error_write(ci);
  1771			pos += len;
  1772			written += len;
  1773			if (pos > i_size_read(inode)) {
  1774				check_caps = ceph_inode_set_size(inode, pos);
  1775				if (check_caps)
  1776					ceph_check_caps(ceph_inode(inode),
  1777							CHECK_CAPS_AUTHONLY,
  1778							NULL);
  1779			}
  1780	
  1781		}
  1782	
  1783		if (ret != -EOLDSNAPC && written > 0) {
  1784			ret = written;
  1785			iocb->ki_pos = pos;
  1786		}
  1787		dout("sync_write returning %d\n", ret);
  1788		return ret;
  1789	}
  1790	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
