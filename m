Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2564D1092
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbiCHG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiCHG6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:58:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D573D1FF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646722637; x=1678258637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D1kau0Gf2c0jROmNZZREX/0/XIzgkyEtmW63B+fgCfc=;
  b=Hm9gp/JWn/7fAhud/TtHCWzUrAF/TpyLfC/fwF78ugQa1kHUjutpTWZM
   G6HT7EKtdCBMvNucHhiXwaNq62YcLmb1VDRVrKc2KCFj5jP0eQnoGB2cK
   xpi8pND/jW1qeTPmOYhFV6rFSJ1AZKBXtQL2B1w5Lxjl4lR0UYokkmsvj
   5N1tv5e8dQHKC1xFRBAiqc3i1XqMb9lPWLH7VqrdmpzB6Ar6RWrib8QbF
   Ir6rDuNWARUtjaR9+rAAasrrF/BHpnABHsEwqnQaXmeyCHtTL8S/Wt2il
   poc6SxHazB3JdhClziBnUfxBaJBS0D3i8mpdBlDoSm3/0vrVGJ5InOIge
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="242046961"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="242046961"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 22:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="537452115"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2022 22:57:15 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRTmU-000149-NG; Tue, 08 Mar 2022 06:57:14 +0000
Date:   Tue, 8 Mar 2022 14:57:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Biggers <ebiggers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ebiggers:testing 7/7] fs/iomap/direct-io.c:318:6: error: 'struct
 bio' has no member named 'bi_write_hint'
Message-ID: <202203081440.duJrxm0u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git testing
head:   236f1f551e0af2da4cbfe428d92361244534b1f3
commit: 236f1f551e0af2da4cbfe428d92361244534b1f3 [7/7] Merge remote-tracking branch 'fscrypt/master' into testing
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220308/202203081440.duJrxm0u-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=236f1f551e0af2da4cbfe428d92361244534b1f3
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers testing
        git checkout 236f1f551e0af2da4cbfe428d92361244534b1f3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/iomap/direct-io.c: In function 'iomap_dio_bio_iter':
>> fs/iomap/direct-io.c:318:6: error: 'struct bio' has no member named 'bi_write_hint'
     318 |   bio->bi_write_hint = dio->iocb->ki_hint;
         |      ^~


vim +318 fs/iomap/direct-io.c

c3b0e880bbfafa Naohiro Aota      2021-02-04  227  
a6d3d49587d10d Christoph Hellwig 2021-08-10  228  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
a6d3d49587d10d Christoph Hellwig 2021-08-10  229  		struct iomap_dio *dio)
db074436f42196 Darrick J. Wong   2019-07-15  230  {
a6d3d49587d10d Christoph Hellwig 2021-08-10  231  	const struct iomap *iomap = &iter->iomap;
a6d3d49587d10d Christoph Hellwig 2021-08-10  232  	struct inode *inode = iter->inode;
db074436f42196 Darrick J. Wong   2019-07-15  233  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
db074436f42196 Darrick J. Wong   2019-07-15  234  	unsigned int fs_block_size = i_blocksize(inode), pad;
db074436f42196 Darrick J. Wong   2019-07-15  235  	unsigned int align = iov_iter_alignment(dio->submit.iter);
a6d3d49587d10d Christoph Hellwig 2021-08-10  236  	loff_t length = iomap_length(iter);
a6d3d49587d10d Christoph Hellwig 2021-08-10  237  	loff_t pos = iter->pos;
c3b0e880bbfafa Naohiro Aota      2021-02-04  238  	unsigned int bio_opf;
db074436f42196 Darrick J. Wong   2019-07-15  239  	struct bio *bio;
db074436f42196 Darrick J. Wong   2019-07-15  240  	bool need_zeroout = false;
db074436f42196 Darrick J. Wong   2019-07-15  241  	bool use_fua = false;
db074436f42196 Darrick J. Wong   2019-07-15  242  	int nr_pages, ret = 0;
db074436f42196 Darrick J. Wong   2019-07-15  243  	size_t copied = 0;
f550ee9b85fd47 Jan Kara          2019-11-26  244  	size_t orig_count;
db074436f42196 Darrick J. Wong   2019-07-15  245  
db074436f42196 Darrick J. Wong   2019-07-15  246  	if ((pos | length | align) & ((1 << blkbits) - 1))
db074436f42196 Darrick J. Wong   2019-07-15  247  		return -EINVAL;
db074436f42196 Darrick J. Wong   2019-07-15  248  
db074436f42196 Darrick J. Wong   2019-07-15  249  	if (iomap->type == IOMAP_UNWRITTEN) {
db074436f42196 Darrick J. Wong   2019-07-15  250  		dio->flags |= IOMAP_DIO_UNWRITTEN;
db074436f42196 Darrick J. Wong   2019-07-15  251  		need_zeroout = true;
db074436f42196 Darrick J. Wong   2019-07-15  252  	}
db074436f42196 Darrick J. Wong   2019-07-15  253  
db074436f42196 Darrick J. Wong   2019-07-15  254  	if (iomap->flags & IOMAP_F_SHARED)
db074436f42196 Darrick J. Wong   2019-07-15  255  		dio->flags |= IOMAP_DIO_COW;
db074436f42196 Darrick J. Wong   2019-07-15  256  
db074436f42196 Darrick J. Wong   2019-07-15  257  	if (iomap->flags & IOMAP_F_NEW) {
db074436f42196 Darrick J. Wong   2019-07-15  258  		need_zeroout = true;
db074436f42196 Darrick J. Wong   2019-07-15  259  	} else if (iomap->type == IOMAP_MAPPED) {
db074436f42196 Darrick J. Wong   2019-07-15  260  		/*
db074436f42196 Darrick J. Wong   2019-07-15  261  		 * Use a FUA write if we need datasync semantics, this is a pure
db074436f42196 Darrick J. Wong   2019-07-15  262  		 * data IO that doesn't require any metadata updates (including
db074436f42196 Darrick J. Wong   2019-07-15  263  		 * after IO completion such as unwritten extent conversion) and
db074436f42196 Darrick J. Wong   2019-07-15  264  		 * the underlying device supports FUA. This allows us to avoid
db074436f42196 Darrick J. Wong   2019-07-15  265  		 * cache flushes on IO completion.
db074436f42196 Darrick J. Wong   2019-07-15  266  		 */
db074436f42196 Darrick J. Wong   2019-07-15  267  		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
db074436f42196 Darrick J. Wong   2019-07-15  268  		    (dio->flags & IOMAP_DIO_WRITE_FUA) &&
db074436f42196 Darrick J. Wong   2019-07-15  269  		    blk_queue_fua(bdev_get_queue(iomap->bdev)))
db074436f42196 Darrick J. Wong   2019-07-15  270  			use_fua = true;
db074436f42196 Darrick J. Wong   2019-07-15  271  	}
db074436f42196 Darrick J. Wong   2019-07-15  272  
db074436f42196 Darrick J. Wong   2019-07-15  273  	/*
f550ee9b85fd47 Jan Kara          2019-11-26  274  	 * Save the original count and trim the iter to just the extent we
f550ee9b85fd47 Jan Kara          2019-11-26  275  	 * are operating on right now.  The iter will be re-expanded once
f550ee9b85fd47 Jan Kara          2019-11-26  276  	 * we are done.
db074436f42196 Darrick J. Wong   2019-07-15  277  	 */
f550ee9b85fd47 Jan Kara          2019-11-26  278  	orig_count = iov_iter_count(dio->submit.iter);
f550ee9b85fd47 Jan Kara          2019-11-26  279  	iov_iter_truncate(dio->submit.iter, length);
db074436f42196 Darrick J. Wong   2019-07-15  280  
3e1a88ec962592 Pavel Begunkov    2021-01-09  281  	if (!iov_iter_count(dio->submit.iter))
f550ee9b85fd47 Jan Kara          2019-11-26  282  		goto out;
db074436f42196 Darrick J. Wong   2019-07-15  283  
f79d474905fec0 Christoph Hellwig 2021-10-12  284  	/*
f79d474905fec0 Christoph Hellwig 2021-10-12  285  	 * We can only poll for single bio I/Os.
f79d474905fec0 Christoph Hellwig 2021-10-12  286  	 */
f79d474905fec0 Christoph Hellwig 2021-10-12  287  	if (need_zeroout ||
f79d474905fec0 Christoph Hellwig 2021-10-12  288  	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
f79d474905fec0 Christoph Hellwig 2021-10-12  289  		dio->iocb->ki_flags &= ~IOCB_HIPRI;
f79d474905fec0 Christoph Hellwig 2021-10-12  290  
db074436f42196 Darrick J. Wong   2019-07-15  291  	if (need_zeroout) {
db074436f42196 Darrick J. Wong   2019-07-15  292  		/* zero out from the start of the block to the write offset */
db074436f42196 Darrick J. Wong   2019-07-15  293  		pad = pos & (fs_block_size - 1);
db074436f42196 Darrick J. Wong   2019-07-15  294  		if (pad)
a6d3d49587d10d Christoph Hellwig 2021-08-10  295  			iomap_dio_zero(iter, dio, pos - pad, pad);
db074436f42196 Darrick J. Wong   2019-07-15  296  	}
db074436f42196 Darrick J. Wong   2019-07-15  297  
c3b0e880bbfafa Naohiro Aota      2021-02-04  298  	/*
c3b0e880bbfafa Naohiro Aota      2021-02-04  299  	 * Set the operation flags early so that bio_iov_iter_get_pages
c3b0e880bbfafa Naohiro Aota      2021-02-04  300  	 * can set up the page vector appropriately for a ZONE_APPEND
c3b0e880bbfafa Naohiro Aota      2021-02-04  301  	 * operation.
c3b0e880bbfafa Naohiro Aota      2021-02-04  302  	 */
c3b0e880bbfafa Naohiro Aota      2021-02-04  303  	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
c3b0e880bbfafa Naohiro Aota      2021-02-04  304  
a8affc03a9b375 Christoph Hellwig 2021-03-11  305  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
db074436f42196 Darrick J. Wong   2019-07-15  306  	do {
db074436f42196 Darrick J. Wong   2019-07-15  307  		size_t n;
db074436f42196 Darrick J. Wong   2019-07-15  308  		if (dio->error) {
db074436f42196 Darrick J. Wong   2019-07-15  309  			iov_iter_revert(dio->submit.iter, copied);
f550ee9b85fd47 Jan Kara          2019-11-26  310  			copied = ret = 0;
f550ee9b85fd47 Jan Kara          2019-11-26  311  			goto out;
db074436f42196 Darrick J. Wong   2019-07-15  312  		}
db074436f42196 Darrick J. Wong   2019-07-15  313  
07888c665b405b Christoph Hellwig 2022-01-24  314  		bio = bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
489734ef94f4f7 Eric Biggers      2022-01-28  315  		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
489734ef94f4f7 Eric Biggers      2022-01-28  316  					  GFP_KERNEL);
db074436f42196 Darrick J. Wong   2019-07-15  317  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
db074436f42196 Darrick J. Wong   2019-07-15 @318  		bio->bi_write_hint = dio->iocb->ki_hint;
db074436f42196 Darrick J. Wong   2019-07-15  319  		bio->bi_ioprio = dio->iocb->ki_ioprio;
db074436f42196 Darrick J. Wong   2019-07-15  320  		bio->bi_private = dio;
db074436f42196 Darrick J. Wong   2019-07-15  321  		bio->bi_end_io = iomap_dio_bio_end_io;
db074436f42196 Darrick J. Wong   2019-07-15  322  
f550ee9b85fd47 Jan Kara          2019-11-26  323  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
db074436f42196 Darrick J. Wong   2019-07-15  324  		if (unlikely(ret)) {
db074436f42196 Darrick J. Wong   2019-07-15  325  			/*
db074436f42196 Darrick J. Wong   2019-07-15  326  			 * We have to stop part way through an IO. We must fall
db074436f42196 Darrick J. Wong   2019-07-15  327  			 * through to the sub-block tail zeroing here, otherwise
db074436f42196 Darrick J. Wong   2019-07-15  328  			 * this short IO may expose stale data in the tail of
db074436f42196 Darrick J. Wong   2019-07-15  329  			 * the block we haven't written data to.
db074436f42196 Darrick J. Wong   2019-07-15  330  			 */
db074436f42196 Darrick J. Wong   2019-07-15  331  			bio_put(bio);
db074436f42196 Darrick J. Wong   2019-07-15  332  			goto zero_tail;
db074436f42196 Darrick J. Wong   2019-07-15  333  		}
db074436f42196 Darrick J. Wong   2019-07-15  334  
db074436f42196 Darrick J. Wong   2019-07-15  335  		n = bio->bi_iter.bi_size;
db074436f42196 Darrick J. Wong   2019-07-15  336  		if (dio->flags & IOMAP_DIO_WRITE) {
db074436f42196 Darrick J. Wong   2019-07-15  337  			task_io_account_write(n);
db074436f42196 Darrick J. Wong   2019-07-15  338  		} else {
db074436f42196 Darrick J. Wong   2019-07-15  339  			if (dio->flags & IOMAP_DIO_DIRTY)
db074436f42196 Darrick J. Wong   2019-07-15  340  				bio_set_pages_dirty(bio);
db074436f42196 Darrick J. Wong   2019-07-15  341  		}
db074436f42196 Darrick J. Wong   2019-07-15  342  
db074436f42196 Darrick J. Wong   2019-07-15  343  		dio->size += n;
db074436f42196 Darrick J. Wong   2019-07-15  344  		copied += n;
db074436f42196 Darrick J. Wong   2019-07-15  345  
3e1a88ec962592 Pavel Begunkov    2021-01-09  346  		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
a8affc03a9b375 Christoph Hellwig 2021-03-11  347  						 BIO_MAX_VECS);
f79d474905fec0 Christoph Hellwig 2021-10-12  348  		/*
f79d474905fec0 Christoph Hellwig 2021-10-12  349  		 * We can only poll for single bio I/Os.
f79d474905fec0 Christoph Hellwig 2021-10-12  350  		 */
f79d474905fec0 Christoph Hellwig 2021-10-12  351  		if (nr_pages)
f79d474905fec0 Christoph Hellwig 2021-10-12  352  			dio->iocb->ki_flags &= ~IOCB_HIPRI;
a6d3d49587d10d Christoph Hellwig 2021-08-10  353  		iomap_dio_submit_bio(iter, dio, bio, pos);
8cecd0ba854799 Goldwyn Rodrigues 2019-05-14  354  		pos += n;
db074436f42196 Darrick J. Wong   2019-07-15  355  	} while (nr_pages);
db074436f42196 Darrick J. Wong   2019-07-15  356  
db074436f42196 Darrick J. Wong   2019-07-15  357  	/*
db074436f42196 Darrick J. Wong   2019-07-15  358  	 * We need to zeroout the tail of a sub-block write if the extent type
db074436f42196 Darrick J. Wong   2019-07-15  359  	 * requires zeroing or the write extends beyond EOF. If we don't zero
db074436f42196 Darrick J. Wong   2019-07-15  360  	 * the block tail in the latter case, we can expose stale data via mmap
db074436f42196 Darrick J. Wong   2019-07-15  361  	 * reads of the EOF block.
db074436f42196 Darrick J. Wong   2019-07-15  362  	 */
db074436f42196 Darrick J. Wong   2019-07-15  363  zero_tail:
db074436f42196 Darrick J. Wong   2019-07-15  364  	if (need_zeroout ||
db074436f42196 Darrick J. Wong   2019-07-15  365  	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
db074436f42196 Darrick J. Wong   2019-07-15  366  		/* zero out from the end of the write to the end of the block */
db074436f42196 Darrick J. Wong   2019-07-15  367  		pad = pos & (fs_block_size - 1);
db074436f42196 Darrick J. Wong   2019-07-15  368  		if (pad)
a6d3d49587d10d Christoph Hellwig 2021-08-10  369  			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
db074436f42196 Darrick J. Wong   2019-07-15  370  	}
f550ee9b85fd47 Jan Kara          2019-11-26  371  out:
f550ee9b85fd47 Jan Kara          2019-11-26  372  	/* Undo iter limitation to current extent */
f550ee9b85fd47 Jan Kara          2019-11-26  373  	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
e9f930ac88a893 Jan Stancek       2019-11-11  374  	if (copied)
e9f930ac88a893 Jan Stancek       2019-11-11  375  		return copied;
e9f930ac88a893 Jan Stancek       2019-11-11  376  	return ret;
db074436f42196 Darrick J. Wong   2019-07-15  377  }
db074436f42196 Darrick J. Wong   2019-07-15  378  

:::::: The code at line 318 was first introduced by commit
:::::: db074436f421967f4f30cfbb6fbc2a728f3e62b3 iomap: move the direct IO code into a separate file

:::::: TO: Darrick J. Wong <darrick.wong@oracle.com>
:::::: CC: Darrick J. Wong <darrick.wong@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
