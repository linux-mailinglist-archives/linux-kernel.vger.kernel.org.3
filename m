Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B913557A95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiFWMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiFWMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:44:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4637A93
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655988280; x=1687524280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BFbAMACBm8TDlyXmQJtQstcYXw4c11FwG4ToNhazoJg=;
  b=UHMoR5LVi1uU6Jeut52h8a3xPnQ/rk1bQHYv7fDvyU1TUAIJvEgoiELR
   /PnaitzN5IfrQ3VX66QMpiar3JSHmIjBvG4S5XiMxAtY8RBSfwZFfWFIN
   6pUZf02vCG+zjnWJyoGKdpRrGjrURiPTUVAMuyu9/TaYCmYrFLES2ttYA
   oH0Prb/3M4VmYuFVpjDKpUEDVffbx4mMewmg82/UQVH+Y/AnNIwWjfVsv
   RiaNm6hGYJk53DGIy3+RAdbGTHrXU/SMGh0zm8I3PPWwrGEvHp/4yg+1p
   eUv81oMAxFGceZm7+STenbkeyYB3asEa4JRlawgY+X8rIgtSVFetZ0wV8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281437808"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="281437808"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 05:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="765282867"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2022 05:44:39 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4MCM-0001GU-7b;
        Thu, 23 Jun 2022 12:44:38 +0000
Date:   Thu, 23 Jun 2022 20:44:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 12/50] fs/ntfs3/fsntfs.c:1488:60:
 sparse: sparse: incorrect type in argument 3 (different base types)
Message-ID: <202206231848.pQZIrKC6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   cdae45bfee03111b49b421b4c01dcddb643f64a2
commit: 7852822e9b1bd84a693fa1d56b7c872f6c0cf6ba [12/50] block: Use the new blk_opf_t type
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220623/202206231848.pQZIrKC6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/bvanassche/linux/commit/7852822e9b1bd84a693fa1d56b7c872f6c0cf6ba
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 7852822e9b1bd84a693fa1d56b7c872f6c0cf6ba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ntfs3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ntfs3/fsntfs.c:1488:60: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got unsigned int [usertype] op @@
   fs/ntfs3/fsntfs.c:1488:60: sparse:     expected restricted blk_opf_t [usertype] opf
   fs/ntfs3/fsntfs.c:1488:60: sparse:     got unsigned int [usertype] op

vim +1488 fs/ntfs3/fsntfs.c

82cae269cfa953 Konstantin Komarov 2021-08-13  1445  
e8b8e97f91b80f Kari Argillander   2021-08-03  1446  /*
e8b8e97f91b80f Kari Argillander   2021-08-03  1447   * ntfs_bio_pages - Read/write pages from/to disk.
e8b8e97f91b80f Kari Argillander   2021-08-03  1448   */
82cae269cfa953 Konstantin Komarov 2021-08-13  1449  int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
82cae269cfa953 Konstantin Komarov 2021-08-13  1450  		   struct page **pages, u32 nr_pages, u64 vbo, u32 bytes,
82cae269cfa953 Konstantin Komarov 2021-08-13  1451  		   u32 op)
82cae269cfa953 Konstantin Komarov 2021-08-13  1452  {
82cae269cfa953 Konstantin Komarov 2021-08-13  1453  	int err = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  1454  	struct bio *new, *bio = NULL;
82cae269cfa953 Konstantin Komarov 2021-08-13  1455  	struct super_block *sb = sbi->sb;
82cae269cfa953 Konstantin Komarov 2021-08-13  1456  	struct block_device *bdev = sb->s_bdev;
82cae269cfa953 Konstantin Komarov 2021-08-13  1457  	struct page *page;
82cae269cfa953 Konstantin Komarov 2021-08-13  1458  	u8 cluster_bits = sbi->cluster_bits;
82cae269cfa953 Konstantin Komarov 2021-08-13  1459  	CLST lcn, clen, vcn, vcn_next;
82cae269cfa953 Konstantin Komarov 2021-08-13  1460  	u32 add, off, page_idx;
82cae269cfa953 Konstantin Komarov 2021-08-13  1461  	u64 lbo, len;
82cae269cfa953 Konstantin Komarov 2021-08-13  1462  	size_t run_idx;
82cae269cfa953 Konstantin Komarov 2021-08-13  1463  	struct blk_plug plug;
82cae269cfa953 Konstantin Komarov 2021-08-13  1464  
82cae269cfa953 Konstantin Komarov 2021-08-13  1465  	if (!bytes)
82cae269cfa953 Konstantin Komarov 2021-08-13  1466  		return 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  1467  
82cae269cfa953 Konstantin Komarov 2021-08-13  1468  	blk_start_plug(&plug);
82cae269cfa953 Konstantin Komarov 2021-08-13  1469  
e8b8e97f91b80f Kari Argillander   2021-08-03  1470  	/* Align vbo and bytes to be 512 bytes aligned. */
82cae269cfa953 Konstantin Komarov 2021-08-13  1471  	lbo = (vbo + bytes + 511) & ~511ull;
82cae269cfa953 Konstantin Komarov 2021-08-13  1472  	vbo = vbo & ~511ull;
82cae269cfa953 Konstantin Komarov 2021-08-13  1473  	bytes = lbo - vbo;
82cae269cfa953 Konstantin Komarov 2021-08-13  1474  
82cae269cfa953 Konstantin Komarov 2021-08-13  1475  	vcn = vbo >> cluster_bits;
82cae269cfa953 Konstantin Komarov 2021-08-13  1476  	if (!run_lookup_entry(run, vcn, &lcn, &clen, &run_idx)) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1477  		err = -ENOENT;
82cae269cfa953 Konstantin Komarov 2021-08-13  1478  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  1479  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  1480  	off = vbo & sbi->cluster_mask;
82cae269cfa953 Konstantin Komarov 2021-08-13  1481  	page_idx = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  1482  	page = pages[0];
82cae269cfa953 Konstantin Komarov 2021-08-13  1483  
82cae269cfa953 Konstantin Komarov 2021-08-13  1484  	for (;;) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1485  		lbo = ((u64)lcn << cluster_bits) + off;
82cae269cfa953 Konstantin Komarov 2021-08-13  1486  		len = ((u64)clen << cluster_bits) - off;
82cae269cfa953 Konstantin Komarov 2021-08-13  1487  new_bio:
07888c665b405b Christoph Hellwig  2022-01-24 @1488  		new = bio_alloc(bdev, nr_pages - page_idx, op, GFP_NOFS);
82cae269cfa953 Konstantin Komarov 2021-08-13  1489  		if (bio) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1490  			bio_chain(bio, new);
82cae269cfa953 Konstantin Komarov 2021-08-13  1491  			submit_bio(bio);
82cae269cfa953 Konstantin Komarov 2021-08-13  1492  		}
82cae269cfa953 Konstantin Komarov 2021-08-13  1493  		bio = new;
82cae269cfa953 Konstantin Komarov 2021-08-13  1494  		bio->bi_iter.bi_sector = lbo >> 9;
82cae269cfa953 Konstantin Komarov 2021-08-13  1495  
82cae269cfa953 Konstantin Komarov 2021-08-13  1496  		while (len) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1497  			off = vbo & (PAGE_SIZE - 1);
82cae269cfa953 Konstantin Komarov 2021-08-13  1498  			add = off + len > PAGE_SIZE ? (PAGE_SIZE - off) : len;
82cae269cfa953 Konstantin Komarov 2021-08-13  1499  
82cae269cfa953 Konstantin Komarov 2021-08-13  1500  			if (bio_add_page(bio, page, add, off) < add)
82cae269cfa953 Konstantin Komarov 2021-08-13  1501  				goto new_bio;
82cae269cfa953 Konstantin Komarov 2021-08-13  1502  
82cae269cfa953 Konstantin Komarov 2021-08-13  1503  			if (bytes <= add)
82cae269cfa953 Konstantin Komarov 2021-08-13  1504  				goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  1505  			bytes -= add;
82cae269cfa953 Konstantin Komarov 2021-08-13  1506  			vbo += add;
82cae269cfa953 Konstantin Komarov 2021-08-13  1507  
82cae269cfa953 Konstantin Komarov 2021-08-13  1508  			if (add + off == PAGE_SIZE) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1509  				page_idx += 1;
82cae269cfa953 Konstantin Komarov 2021-08-13  1510  				if (WARN_ON(page_idx >= nr_pages)) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1511  					err = -EINVAL;
82cae269cfa953 Konstantin Komarov 2021-08-13  1512  					goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  1513  				}
82cae269cfa953 Konstantin Komarov 2021-08-13  1514  				page = pages[page_idx];
82cae269cfa953 Konstantin Komarov 2021-08-13  1515  			}
82cae269cfa953 Konstantin Komarov 2021-08-13  1516  
82cae269cfa953 Konstantin Komarov 2021-08-13  1517  			if (len <= add)
82cae269cfa953 Konstantin Komarov 2021-08-13  1518  				break;
82cae269cfa953 Konstantin Komarov 2021-08-13  1519  			len -= add;
82cae269cfa953 Konstantin Komarov 2021-08-13  1520  			lbo += add;
82cae269cfa953 Konstantin Komarov 2021-08-13  1521  		}
82cae269cfa953 Konstantin Komarov 2021-08-13  1522  
82cae269cfa953 Konstantin Komarov 2021-08-13  1523  		vcn_next = vcn + clen;
82cae269cfa953 Konstantin Komarov 2021-08-13  1524  		if (!run_get_entry(run, ++run_idx, &vcn, &lcn, &clen) ||
82cae269cfa953 Konstantin Komarov 2021-08-13  1525  		    vcn != vcn_next) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1526  			err = -ENOENT;
82cae269cfa953 Konstantin Komarov 2021-08-13  1527  			goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  1528  		}
82cae269cfa953 Konstantin Komarov 2021-08-13  1529  		off = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  1530  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  1531  out:
82cae269cfa953 Konstantin Komarov 2021-08-13  1532  	if (bio) {
82cae269cfa953 Konstantin Komarov 2021-08-13  1533  		if (!err)
82cae269cfa953 Konstantin Komarov 2021-08-13  1534  			err = submit_bio_wait(bio);
82cae269cfa953 Konstantin Komarov 2021-08-13  1535  		bio_put(bio);
82cae269cfa953 Konstantin Komarov 2021-08-13  1536  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  1537  	blk_finish_plug(&plug);
82cae269cfa953 Konstantin Komarov 2021-08-13  1538  
82cae269cfa953 Konstantin Komarov 2021-08-13  1539  	return err;
82cae269cfa953 Konstantin Komarov 2021-08-13  1540  }
82cae269cfa953 Konstantin Komarov 2021-08-13  1541  

:::::: The code at line 1488 was first introduced by commit
:::::: 07888c665b405b1cd3577ddebfeb74f4717a84c4 block: pass a block_device and opf to bio_alloc

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
