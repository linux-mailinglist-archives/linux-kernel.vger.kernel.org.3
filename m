Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3945C550D32
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiFSV1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiFSV1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 17:27:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B337AE4E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655674032; x=1687210032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x2Fosbh2K2030b5HTjWGhL/dARfSy6FmGL22NukHdMc=;
  b=XwbhzRD4BX5XV/xsEAKTzZXz1GFs/7G0iBUGUw9Q2LTDKnMtASbN+fwc
   8NPDnpr6VqqKC4k1kL4qWzOqhB6K5Hs7se6bb59owz0mUKFfvnv77r7vn
   b0LNhDzWfQfkhY2m3NWjggEpSB1hmHtYm0fnaBRVTuGUWbIfJIu/TbYoV
   GB0Rk2bmGJfe8jgTe2SS/twPcZrgK8+Z5j1kD3wSeyxRtPUFgDoQVtrhB
   zB7xVovhHJ3o3049KF+LuoD061N9iWHmjvQjfGQKsUo+OXmD2231Ex9b8
   3p6dsHm0n8OsrZkn6Bwl2fZ9oH8YVZR9ZzOEME85c4WCldVynsAAIJk7g
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278535934"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278535934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 14:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="689156646"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2022 14:27:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o32Rq-000RYl-KX;
        Sun, 19 Jun 2022 21:27:10 +0000
Date:   Mon, 20 Jun 2022 05:27:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 15/15]
 drivers/block/pktcdvd.c:1232:18: sparse: sparse: incorrect type in argument
 5 (different base types)
Message-ID: <202206200524.TTdzNLDl-lkp@intel.com>
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

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   031ccdd616b11c4e774e56aa7eae906188ab24cc
commit: 031ccdd616b11c4e774e56aa7eae906188ab24cc [15/15] block: Introduce the type blk_mq_opf_t
config: riscv-randconfig-s031-20220619 (https://download.01.org/0day-ci/archive/20220620/202206200524.TTdzNLDl-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/bvanassche/linux/commit/031ccdd616b11c4e774e56aa7eae906188ab24cc
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 031ccdd616b11c4e774e56aa7eae906188ab24cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/block/pktcdvd.c:1232:18: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted blk_mq_opf_t [usertype] opf @@     got int @@
   drivers/block/pktcdvd.c:1232:18: sparse:     expected restricted blk_mq_opf_t [usertype] opf
   drivers/block/pktcdvd.c:1232:18: sparse:     got int
--
>> drivers/block/zram/zram_drv.c:749:41: sparse: sparse: restricted blk_mq_opf_t degrades to integer
>> drivers/block/zram/zram_drv.c:749:39: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted blk_mq_opf_t [usertype] opf @@     got unsigned int @@
   drivers/block/zram/zram_drv.c:749:39: sparse:     expected restricted blk_mq_opf_t [usertype] opf
   drivers/block/zram/zram_drv.c:749:39: sparse:     got unsigned int
   drivers/block/zram/zram_drv.c: note: in included file (through include/linux/list_bl.h, include/linux/rculist_bl.h, include/linux/dcache.h, ...):
   include/linux/bit_spinlock.h:41:19: sparse: sparse: context imbalance in 'zram_slot_trylock' - different lock contexts for basic block
   include/linux/bit_spinlock.h:35:9: sparse: sparse: context imbalance in 'zram_slot_lock' - wrong count at exit
   include/linux/bit_spinlock.h:63:25: sparse: sparse: context imbalance in 'zram_slot_unlock' - unexpected unlock

vim +1232 drivers/block/pktcdvd.c

5f03414d4098b5 Christoph Hellwig 2021-04-12  1222  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1223  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  1224   * Assemble a bio to write one packet and queue the bio for processing
^1da177e4c3f41 Linus Torvalds    2005-04-16  1225   * by the underlying block device.
^1da177e4c3f41 Linus Torvalds    2005-04-16  1226   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1227  static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1228  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1229  	int f;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1230  
852ad96cb03621 Christoph Hellwig 2022-04-06  1231  	bio_init(pkt->w_bio, pd->bdev, pkt->w_bio->bi_inline_vecs, pkt->frames,
852ad96cb03621 Christoph Hellwig 2022-04-06 @1232  		 REQ_OP_WRITE);
4f024f3797c43c Kent Overstreet   2013-10-11  1233  	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
ffb25dc60ff14f Kent Overstreet   2012-09-04  1234  	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
ffb25dc60ff14f Kent Overstreet   2012-09-04  1235  	pkt->w_bio->bi_private = pkt;
ffb25dc60ff14f Kent Overstreet   2012-09-04  1236  
ffb25dc60ff14f Kent Overstreet   2012-09-04  1237  	/* XXX: locking? */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1238  	for (f = 0; f < pkt->frames; f++) {
feebd568725775 Christoph Hellwig 2016-10-27  1239  		struct page *page = pkt->pages[(f * CD_FRAMESIZE) / PAGE_SIZE];
feebd568725775 Christoph Hellwig 2016-10-27  1240  		unsigned offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
feebd568725775 Christoph Hellwig 2016-10-27  1241  
feebd568725775 Christoph Hellwig 2016-10-27  1242  		if (!bio_add_page(pkt->w_bio, page, CD_FRAMESIZE, offset))
ffb25dc60ff14f Kent Overstreet   2012-09-04  1243  			BUG();
^1da177e4c3f41 Linus Torvalds    2005-04-16  1244  	}
844aa7974395df Joe Perches       2013-09-11  1245  	pkt_dbg(2, pd, "vcnt=%d\n", pkt->w_bio->bi_vcnt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1246  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1247  	/*
72772323746805 Peter Osterlund   2006-02-14  1248  	 * Fill-in bvec with data from orig_bios.
^1da177e4c3f41 Linus Torvalds    2005-04-16  1249  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1250  	spin_lock(&pkt->lock);
45db54d58de0b7 Kent Overstreet   2018-05-08  1251  	bio_list_copy_data(pkt->w_bio, pkt->orig_bios.head);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1252  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1253  	pkt_set_state(pkt, PACKET_WRITE_WAIT_STATE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1254  	spin_unlock(&pkt->lock);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1255  
844aa7974395df Joe Perches       2013-09-11  1256  	pkt_dbg(2, pd, "Writing %d frames for zone %llx\n",
ffb25dc60ff14f Kent Overstreet   2012-09-04  1257  		pkt->write_size, (unsigned long long)pkt->sector);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1258  
feebd568725775 Christoph Hellwig 2016-10-27  1259  	if (test_bit(PACKET_MERGE_SEGS, &pd->flags) || (pkt->write_size < pkt->frames))
^1da177e4c3f41 Linus Torvalds    2005-04-16  1260  		pkt->cache_valid = 1;
feebd568725775 Christoph Hellwig 2016-10-27  1261  	else
^1da177e4c3f41 Linus Torvalds    2005-04-16  1262  		pkt->cache_valid = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1263  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1264  	/* Start the write request */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1265  	atomic_set(&pkt->io_wait, 1);
46c271bedd2c84 Peter Osterlund   2005-06-23  1266  	pkt_queue_bio(pd, pkt->w_bio);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1267  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  1268  

:::::: The code at line 1232 was first introduced by commit
:::::: 852ad96cb03621f7995764b4b31cbff9801d8bcd pktcdvd: stop using bio_reset

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
