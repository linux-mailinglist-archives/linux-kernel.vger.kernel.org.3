Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAD4B9296
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiBPUpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:45:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiBPUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:45:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA72A4162
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645044291; x=1676580291;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MB5X3iOXEfPI+tB2HTKE+d+rNMuZUmgFZIunOMJeSOI=;
  b=bpOsUqsX71i/AuYy/tBbuu0s8yZ9IOhOqfNJhsPc4bm/2Kal5e/aDifO
   5p+s78C5Rpv+la7GkAU9oFkSgCL+wEWCRmFk3Yf3SDO0KTXcFDrj21MSf
   jxFYTXTUlPOpzP0BSJjHVGNKDbt/I2eolfirQq5azzyS14pXMF7zTvnRT
   hWIkykB2Nm3oKT8ZMBu1E5Of3r2FnWdP7ncE74dYJqyOzbTp3iJ75ybWJ
   fSaApTZCS/CyQ2C2kVnPIiU/qmrCb3OdgpWR/R38lA+2Rc5lBtBsXYcKU
   lGHxLkv2pL1K2zwpdH1YCIm5bc9GrnHgF4PCz+arczy8iFnWxNaiskDX9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275303452"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="275303452"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 12:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="636698003"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 12:44:49 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKRAP-000B73-07; Wed, 16 Feb 2022 20:44:49 +0000
Date:   Thu, 17 Feb 2022 04:44:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 29/42]
 fs/netfs/buffered_write.c:610:58: error: 'struct netfs_i_context' has no
 member named 'cache'
Message-ID: <202202170410.fCsMg7GT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   5cb7f190822d09757b30cd9539e57eef72552d1f
commit: 261cd621bd0477d43de460dea6c7bf7fa81824be [29/42] netfs: Implement buffered writes through netfs_file_write_iter()
config: powerpc64-randconfig-m031-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170410.fCsMg7GT-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/261cd621bd0477d43de460dea6c7bf7fa81824be
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 261cd621bd0477d43de460dea6c7bf7fa81824be
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/netfs/buffered_write.c: In function 'netfs_perform_write':
>> fs/netfs/buffered_write.c:610:58: error: 'struct netfs_i_context' has no member named 'cache'
     610 |                                 fscache_update_cookie(ctx->cache, NULL, &pos);
         |                                                          ^~


vim +610 fs/netfs/buffered_write.c

   453	
   454	/*
   455	 * Write data into a prereserved region of the pagecache attached to a netfs
   456	 * inode.
   457	 */
   458	static ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter)
   459	{
   460		struct netfs_dirty_region *spare_region = NULL;
   461		struct file *file = iocb->ki_filp;
   462		struct netfs_i_context *ctx = netfs_i_context(file_inode(file));
   463		struct folio *folio;
   464		enum netfs_handle_nonuptodate nupt;
   465		ssize_t written = 0, ret;
   466		loff_t i_size, pos = iocb->ki_pos;
   467		bool always_fill = false;
   468		bool locked = false;
   469	
   470		MA_STATE(mas, &ctx->dirty_regions, pos / PAGE_SIZE,
   471			 (pos + iov_iter_count(iter) - 1) / PAGE_SIZE);
   472	
   473		ret = ctx->ops->validate_for_write(file_inode(file), file);
   474		if (ret < 0)
   475			return ret;
   476	
   477		do {
   478			size_t plen;
   479			size_t offset;	/* Offset into pagecache folio */
   480			size_t bytes;	/* Bytes to write to folio */
   481			size_t copied;	/* Bytes copied from user */
   482	
   483			folio = netfs_grab_folio_for_write(file->f_mapping,
   484							   pos / PAGE_SIZE,
   485							   iov_iter_count(iter));
   486			if (!folio) {
   487				ret = -ENOMEM;
   488				goto out;
   489			}
   490	
   491			plen = folio_size(folio);
   492			offset = pos - folio_file_pos(folio);
   493			bytes = min_t(size_t, plen - offset, iov_iter_count(iter));
   494			locked = true;
   495	
   496			if (!folio_test_uptodate(folio)) {
   497				folio_unlock(folio); /* Avoid deadlocking fault-in */
   498				locked = false;
   499			}
   500	
   501			/* Bring in the user page that we will copy from _first_.
   502			 * Otherwise there's a nasty deadlock on copying from the same
   503			 * page as we're writing to, without it being marked
   504			 * up-to-date.
   505			 *
   506			 * Not only is this an optimisation, but it is also required to
   507			 * check that the address is actually valid, when atomic
   508			 * usercopies are used, below.
   509			 */
   510			if (unlikely(fault_in_iov_iter_readable(iter, bytes))) {
   511				ret = -EFAULT;
   512				goto error_folio;
   513			}
   514	
   515			if (fatal_signal_pending(current)) {
   516				ret = -EINTR;
   517				goto error_folio;
   518			}
   519	
   520			if (!locked) {
   521				ret = folio_lock_killable(folio);
   522				if (ret < 0)
   523					goto error_folio;
   524			}
   525	
   526	redo_prefetch:
   527			/* See if we need to prefetch the area we're going to modify.
   528			 * We need to do this before we get a lock on the folio in case
   529			 * there's more than one writer competing for the same cache
   530			 * block.
   531			 */
   532			nupt = netfs_handle_nonuptodate_folio(ctx, file, folio,
   533							      offset, bytes, always_fill);
   534			_debug("nupt %u", nupt);
   535			switch (nupt) {
   536			case NETFS_JUST_PREFETCH:
   537				ret = netfs_prefetch_for_write(file, folio, bytes);
   538				if (ret < 0) {
   539					_debug("prefetch = %zd", ret);
   540					goto error_folio;
   541				}
   542				nupt = NETFS_FOLIO_IS_UPTODATE;
   543				fallthrough;
   544			case NETFS_FOLIO_IS_UPTODATE:
   545				break;
   546			case NETFS_MODIFY_AND_CLEAR:
   547				zero_user_segment(&folio->page, 0, offset);
   548				break;
   549			case NETFS_WHOLE_FOLIO_MODIFY:
   550				break;
   551			}
   552	
   553			/* Preallocate the space we need in the dirty region list. */
   554			ret = mas_expected_entries(&mas, 1);
   555			if (ret < 0)
   556				goto error_folio;
   557	
   558			if (!spare_region) {
   559				spare_region = netfs_alloc_dirty_region();
   560				if (IS_ERR(spare_region)) {
   561					ret = PTR_ERR(spare_region);
   562					spare_region = NULL;
   563					goto error_folio;
   564				}
   565			}
   566	
   567			if (mapping_writably_mapped(folio_file_mapping(folio)))
   568				flush_dcache_folio(folio);
   569			copied = copy_folio_from_iter_atomic(folio, offset, bytes, iter);
   570			flush_dcache_folio(folio);
   571	
   572			/*  Deal with a (partially) failed copy */
   573			if (!folio_test_uptodate(folio)) {
   574				if (copied == 0) {
   575					ret = -EFAULT;
   576					goto error_folio;
   577				}
   578				if (copied < bytes) {
   579					iov_iter_revert(iter, copied);
   580					always_fill = true;
   581					goto redo_prefetch;
   582				}
   583				switch (nupt) {
   584				case NETFS_JUST_PREFETCH:
   585				case NETFS_FOLIO_IS_UPTODATE:
   586					/* We have the folio locked, so it really ought
   587					 * to be uptodate.
   588					 */
   589					WARN(true, "Locked folio %lx became non-uptodate\n",
   590					     folio_index(folio));
   591					ret = -EIO;
   592					goto error_folio;
   593				case NETFS_MODIFY_AND_CLEAR:
   594					zero_user_segment(&folio->page, offset + copied, plen);
   595					fallthrough;
   596				case NETFS_WHOLE_FOLIO_MODIFY:
   597					folio_mark_uptodate(folio);
   598					break;
   599				}
   600			}
   601	
   602			/* Update the inode size if we moved the EOF marker */
   603			pos += copied;
   604			i_size = i_size_read(file_inode(file));
   605			if (pos > i_size) {
   606				if (ctx->ops->update_i_size) {
   607					ctx->ops->update_i_size(file, pos);
   608				} else {
   609					i_size_write(file_inode(file), pos);
 > 610					fscache_update_cookie(ctx->cache, NULL, &pos);
   611				}
   612			}
   613	
   614			netfs_commit_folio(ctx, file, &spare_region, &mas,
   615					   folio, offset, copied);
   616	
   617			folio_mark_dirty(folio);
   618			folio_unlock(folio);
   619			folio_put(folio);
   620			folio = NULL;
   621	
   622			cond_resched();
   623	
   624			written += copied;
   625	
   626			balance_dirty_pages_ratelimited(file->f_mapping);
   627		} while (iov_iter_count(iter));
   628	
   629	out:
   630		if (likely(written)) {
   631			netfs_commit_region(ctx, &mas, iocb->ki_pos, written);
   632	
   633			iocb->ki_pos += written;
   634	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
