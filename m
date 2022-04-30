Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35519515A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 07:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiD3FP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 01:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiD3FP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 01:15:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A14CFE69
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651295557; x=1682831557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BzmKMW/rAuAj3+U4XkzGRq/gA5XyA9PcnJ2z0+T1mZg=;
  b=BO/+Xh4IdvpAsVyS4SZAlKXTO7ioBBtyySaIZAjtQdXrHqDdIAhfA3Ds
   +8odg5LnO2k3MUfKWLhzihxo1B7won+usg2pdbOfQ4OBDCkCcZe8dUIEZ
   j9qCbmN9IBmBDj+OwDGOx6hIYTYg60jqWexUIEq13jnX3mxAc2lDm9Hqv
   fDO+mt120D21HX/QTR4zeg4pGOQdJYsSFkrVaYgugALfDxHm/mRUFhC94
   fb+Zt+i3sLgxTouXG+gHOAND0RcKf7cQPNlhn/Uq8HUCI0WdEIwL3lPtM
   r3sWtg/hYNKyYvyysYkpAn9zC8H/2wSWZQQkFmTyeIRnALo51PDZ4mSWx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266667758"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="266667758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 22:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="706869825"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2022 22:12:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkfPG-0006tt-QO;
        Sat, 30 Apr 2022 05:12:34 +0000
Date:   Sat, 30 Apr 2022 13:11:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 60/69] fs/ntfs/aops.c:378:12: warning:
 stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio'
Message-ID: <202204301355.hFVoSOPa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   00da6d4b7219d455e5f7e8870e4f93aaef4fc0d2
commit: 6f2714680bb3e7007433d39bc36389198f98c96c [60/69] ntfs: Convert ntfs to read_folio
config: hexagon-randconfig-r041-20220428 (https://download.01.org/0day-ci/archive/20220430/202204301355.hFVoSOPa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 6f2714680bb3e7007433d39bc36389198f98c96c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/ntfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]
   static int ntfs_read_folio(struct file *file, struct folio *folio)
              ^
   1 warning generated.


vim +/ntfs_read_folio +378 fs/ntfs/aops.c

   359	
   360	/**
   361	 * ntfs_read_folio - fill a @folio of a @file with data from the device
   362	 * @file:	open file to which the folio @folio belongs or NULL
   363	 * @folio:	page cache folio to fill with data
   364	 *
   365	 * For non-resident attributes, ntfs_read_folio() fills the @folio of the open
   366	 * file @file by calling the ntfs version of the generic block_read_full_folio()
   367	 * function, ntfs_read_block(), which in turn creates and reads in the buffers
   368	 * associated with the folio asynchronously.
   369	 *
   370	 * For resident attributes, OTOH, ntfs_read_folio() fills @folio by copying the
   371	 * data from the mft record (which at this stage is most likely in memory) and
   372	 * fills the remainder with zeroes. Thus, in this case, I/O is synchronous, as
   373	 * even if the mft record is not cached at this point in time, we need to wait
   374	 * for it to be read in before we can do the copy.
   375	 *
   376	 * Return 0 on success and -errno on error.
   377	 */
 > 378	static int ntfs_read_folio(struct file *file, struct folio *folio)
   379	{
   380		struct page *page = &folio->page;
   381		loff_t i_size;
   382		struct inode *vi;
   383		ntfs_inode *ni, *base_ni;
   384		u8 *addr;
   385		ntfs_attr_search_ctx *ctx;
   386		MFT_RECORD *mrec;
   387		unsigned long flags;
   388		u32 attr_len;
   389		int err = 0;
   390	
   391	retry_readpage:
   392		BUG_ON(!PageLocked(page));
   393		vi = page->mapping->host;
   394		i_size = i_size_read(vi);
   395		/* Is the page fully outside i_size? (truncate in progress) */
   396		if (unlikely(page->index >= (i_size + PAGE_SIZE - 1) >>
   397				PAGE_SHIFT)) {
   398			zero_user(page, 0, PAGE_SIZE);
   399			ntfs_debug("Read outside i_size - truncated?");
   400			goto done;
   401		}
   402		/*
   403		 * This can potentially happen because we clear PageUptodate() during
   404		 * ntfs_writepage() of MstProtected() attributes.
   405		 */
   406		if (PageUptodate(page)) {
   407			unlock_page(page);
   408			return 0;
   409		}
   410		ni = NTFS_I(vi);
   411		/*
   412		 * Only $DATA attributes can be encrypted and only unnamed $DATA
   413		 * attributes can be compressed.  Index root can have the flags set but
   414		 * this means to create compressed/encrypted files, not that the
   415		 * attribute is compressed/encrypted.  Note we need to check for
   416		 * AT_INDEX_ALLOCATION since this is the type of both directory and
   417		 * index inodes.
   418		 */
   419		if (ni->type != AT_INDEX_ALLOCATION) {
   420			/* If attribute is encrypted, deny access, just like NT4. */
   421			if (NInoEncrypted(ni)) {
   422				BUG_ON(ni->type != AT_DATA);
   423				err = -EACCES;
   424				goto err_out;
   425			}
   426			/* Compressed data streams are handled in compress.c. */
   427			if (NInoNonResident(ni) && NInoCompressed(ni)) {
   428				BUG_ON(ni->type != AT_DATA);
   429				BUG_ON(ni->name_len);
   430				return ntfs_read_compressed_block(page);
   431			}
   432		}
   433		/* NInoNonResident() == NInoIndexAllocPresent() */
   434		if (NInoNonResident(ni)) {
   435			/* Normal, non-resident data stream. */
   436			return ntfs_read_block(page);
   437		}
   438		/*
   439		 * Attribute is resident, implying it is not compressed or encrypted.
   440		 * This also means the attribute is smaller than an mft record and
   441		 * hence smaller than a page, so can simply zero out any pages with
   442		 * index above 0.  Note the attribute can actually be marked compressed
   443		 * but if it is resident the actual data is not compressed so we are
   444		 * ok to ignore the compressed flag here.
   445		 */
   446		if (unlikely(page->index > 0)) {
   447			zero_user(page, 0, PAGE_SIZE);
   448			goto done;
   449		}
   450		if (!NInoAttr(ni))
   451			base_ni = ni;
   452		else
   453			base_ni = ni->ext.base_ntfs_ino;
   454		/* Map, pin, and lock the mft record. */
   455		mrec = map_mft_record(base_ni);
   456		if (IS_ERR(mrec)) {
   457			err = PTR_ERR(mrec);
   458			goto err_out;
   459		}
   460		/*
   461		 * If a parallel write made the attribute non-resident, drop the mft
   462		 * record and retry the read_folio.
   463		 */
   464		if (unlikely(NInoNonResident(ni))) {
   465			unmap_mft_record(base_ni);
   466			goto retry_readpage;
   467		}
   468		ctx = ntfs_attr_get_search_ctx(base_ni, mrec);
   469		if (unlikely(!ctx)) {
   470			err = -ENOMEM;
   471			goto unm_err_out;
   472		}
   473		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
   474				CASE_SENSITIVE, 0, NULL, 0, ctx);
   475		if (unlikely(err))
   476			goto put_unm_err_out;
   477		attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
   478		read_lock_irqsave(&ni->size_lock, flags);
   479		if (unlikely(attr_len > ni->initialized_size))
   480			attr_len = ni->initialized_size;
   481		i_size = i_size_read(vi);
   482		read_unlock_irqrestore(&ni->size_lock, flags);
   483		if (unlikely(attr_len > i_size)) {
   484			/* Race with shrinking truncate. */
   485			attr_len = i_size;
   486		}
   487		addr = kmap_atomic(page);
   488		/* Copy the data to the page. */
   489		memcpy(addr, (u8*)ctx->attr +
   490				le16_to_cpu(ctx->attr->data.resident.value_offset),
   491				attr_len);
   492		/* Zero the remainder of the page. */
   493		memset(addr + attr_len, 0, PAGE_SIZE - attr_len);
   494		flush_dcache_page(page);
   495		kunmap_atomic(addr);
   496	put_unm_err_out:
   497		ntfs_attr_put_search_ctx(ctx);
   498	unm_err_out:
   499		unmap_mft_record(base_ni);
   500	done:
   501		SetPageUptodate(page);
   502	err_out:
   503		unlock_page(page);
   504		return err;
   505	}
   506	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
