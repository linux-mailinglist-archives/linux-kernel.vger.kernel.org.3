Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6083569419
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiGFVQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiGFVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:16:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D6B3B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657142170; x=1688678170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8qI4YHbhu6O/YG8aTCHPhFJTUUy7Q5y621oe1o7I/ZE=;
  b=h1lyj/EFgESDDOMLhFjv5eDc+qN/Kqz/uqy+1h/dQiq6swjr9ZZAkx9U
   JPxiYO/EPsql1RBmN5zUQTxNFFWw1kir1kryPhZXVYzfqRZGYuMCnOHK7
   zeo3m+cZQNzye6Yxa3su4vybJXZeeKyg3DeCuGrxNB0bZi0RYzopCD8VS
   MP/EFa0Uv7G/GCwvfw0d8hVP8D4l6gyNsz797g17m/MPxZMcj3TyD1GGI
   0ctNhU+EUUEH2WSKs50l9zTQg3yLzOyZDrCDmxr/xboHUsXnuWoEIPMbE
   /lCVQylIn38Tjx9s2ik9k2c9kONeKzyzvQkdGQ0xVF/6RJaPOs1CjnpJ/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="264286888"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="264286888"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 14:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="650847936"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 14:16:08 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9CNT-000L3b-Nj;
        Wed, 06 Jul 2022 21:16:07 +0000
Date:   Thu, 7 Jul 2022 05:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 46/61]
 fs/netfs/buffered_flush.c:431:30: sparse: sparse: incompatible types in
 comparison expression (different type sizes):
Message-ID: <202207070501.QZjJMny3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: 2dc27084e13c29183f0a6853b81e5fa2941948e3 [46/61] netfs: Generate a write request from ->writepages()
config: sparc-randconfig-s032-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070501.QZjJMny3-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/2dc27084e13c29183f0a6853b81e5fa2941948e3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 2dc27084e13c29183f0a6853b81e5fa2941948e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/buffered_flush.c:431:30: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/netfs/buffered_flush.c:431:30: sparse:    unsigned int *
>> fs/netfs/buffered_flush.c:431:30: sparse:    unsigned long *
   fs/netfs/buffered_flush.c:434:30: sparse: sparse: incompatible types in comparison expression (different type sizes):
   fs/netfs/buffered_flush.c:434:30: sparse:    unsigned int *
   fs/netfs/buffered_flush.c:434:30: sparse:    unsigned long *
   fs/netfs/buffered_flush.c:436:17: sparse: sparse: incompatible types in comparison expression (different type sizes):
   fs/netfs/buffered_flush.c:436:17: sparse:    unsigned int *
   fs/netfs/buffered_flush.c:436:17: sparse:    unsigned long *

vim +431 fs/netfs/buffered_flush.c

   395	
   396	/*
   397	 * Extend the region to be written back to include subsequent contiguously
   398	 * dirty pages if possible, but don't sleep while doing so.
   399	 *
   400	 * If this page holds new content, then we can include filler zeros in the
   401	 * writeback.
   402	 */
   403	static void netfs_extend_writeback(struct netfs_io_request *wreq,
   404					   struct writeback_control *wbc,
   405					   struct netfs_inode *ctx,
   406					   struct netfs_dirty_region *region)
   407	{
   408		struct folio_batch fbatch;
   409		struct folio *folio;
   410		unsigned int i;
   411		pgoff_t index = wreq->last + 1, stop_mask, stop_at, max_pages;
   412		ssize_t max_size;
   413		size_t align, hard_align;
   414		bool stop = true, dirty;
   415		int ret;
   416	
   417		XA_STATE(xas, &wreq->mapping->i_pages, index);
   418	
   419		_enter("%lx", index);
   420	
   421		/* We have a number of criteria by which we can decide where to stop
   422		 * extension of this writeback:
   423		 *
   424		 *  1) The maximum I/O size (but wbacks can be subdivided)
   425		 *  2) Boundaries within the filesystem (eg. ceph object size)
   426		 *  3) Local boundaries (cache granules, VM radix node sizes)
   427		 *  4) Content crypto/compression boundaries
   428		 */
   429		hard_align = PAGE_SIZE;
   430		if (ctx->min_bshift || ctx->crypto_bshift)
 > 431			hard_align = max(hard_align,
   432					 1UL << max(ctx->min_bshift, ctx->crypto_bshift));
   433		if (ctx->cache_order)
   434			hard_align = max(hard_align, PAGE_SIZE << ctx->cache_order);
   435	
   436		align = min(hard_align, XA_CHUNK_SIZE * PAGE_SIZE);
   437		if (wreq->alignment > align)
   438			align = wreq->alignment;
   439	
   440		stop_mask = (align - 1) / PAGE_SIZE;
   441	
   442		max_size = XA_CHUNK_SIZE * PAGE_SIZE;
   443		if (wreq->wsize > max_size)
   444			max_size = roundup_pow_of_two(wreq->wsize);
   445	
   446		_debug("LIMITS al=%zx ha=%zx mx=%zx", align, hard_align, max_size);
   447	
   448		max_pages = max_size / PAGE_SIZE;
   449		max_pages &= ~stop_mask;
   450		_debug("MAX_PAGES %lx %lx", max_pages, stop_mask);
   451		if (wreq->last - wreq->first + 1 >= max_pages) {
   452			_leave(" [already hit wsize %lx %lx]",
   453			       wreq->last - wreq->first + 1, max_pages);
   454			return;
   455		}
   456	
   457		stop_at = wreq->first + max_pages;
   458		if (stop_at < wreq->first)
   459			stop_at = ULONG_MAX;
   460		else
   461			stop_at = round_down(stop_at, align / PAGE_SIZE);
   462		_debug("STOP_AT %lx (%lx %lx %lx)", stop_at, wreq->first, max_pages, align / PAGE_SIZE);
   463	
   464		if (index >= stop_at || wbc->nr_to_write <= 0 || wreq->len > max_size) {
   465			_leave(" [prestop]");
   466			return;
   467		}
   468	
   469		do {
   470			/* Firstly, we gather up a batch of contiguous dirty folios
   471			 * under the RCU read lock - but we can't clear the dirty flags
   472			 * there if any of those folios are mapped.
   473			 */
   474			folio_batch_init(&fbatch);
   475			_debug("extend %lx %lx", index, xas.xa_index);
   476			rcu_read_lock();
   477	
   478			xas_for_each(&xas, folio, ULONG_MAX) {
   479				stop = true;
   480				if (xas_retry(&xas, folio))
   481					continue;
   482				if (xa_is_value(folio))
   483					break;
   484				if (folio_index(folio) != index)
   485					break;
   486	
   487				if (!folio_try_get_rcu(folio)) {
   488					xas_reset(&xas);
   489					continue;
   490				}
   491	
   492				/* Has the folio moved or been split? */
   493				if (unlikely(folio != xas_reload(&xas))) {
   494					folio_put(folio);
   495					break;
   496				}
   497	
   498				if (!folio_trylock(folio)) {
   499					folio_put(folio);
   500					break;
   501				}
   502				if (!folio_test_dirty(folio) ||
   503				    folio_test_writeback(folio)) {
   504					folio_unlock(folio);
   505					folio_put(folio);
   506					break;
   507				}
   508	
   509				wreq->len += folio_size(folio);
   510				index += folio_nr_pages(folio);
   511				stop = index >= stop_at || wbc->nr_to_write <= 0;
   512	
   513				if (!folio_batch_add(&fbatch, folio))
   514					break;
   515				if (stop)
   516					break;
   517			}
   518	
   519			if (!stop)
   520				xas_pause(&xas);
   521			rcu_read_unlock();
   522	
   523			/* Now, if we obtained any pages, we can shift them to being
   524			 * writable and mark them for caching.
   525			 */
   526			if (!folio_batch_count(&fbatch))
   527				break;
   528	
   529			for (i = 0; i < folio_batch_count(&fbatch); i++) {
   530				folio = fbatch.folios[i];
   531				//_debug("found [%x] %lx", i, folio->index);
   532				trace_netfs_folio_dirty(wreq->mapping, folio,
   533							netfs_folio_trace_store_ex);
   534	
   535				dirty = folio_clear_dirty_for_io(folio);
   536				if (folio_start_writeback(folio)) {
   537					_debug("! no wb");
   538					goto nomem_redirty;
   539				}
   540	
   541				ret = netfs_xa_store_and_mark(&wreq->buffer, folio->index, folio,
   542							      true, true, dirty, GFP_NOFS);
   543				if (ret < 0) {
   544					_debug("! no buffer");
   545					goto nomem_cancel_wb;
   546				}
   547				wbc->nr_to_write -= folio_nr_pages(folio);
   548				index = folio_next_index(folio);
   549				wreq->last = index - 1;
   550				folio_unlock(folio);
   551			}
   552	
   553			cond_resched();
   554		} while (!stop);
   555	
   556		_leave(" ok [%zx]", wreq->last);
   557		return;
   558	
   559	nomem_cancel_wb:
   560		folio_end_writeback(folio);
   561	nomem_redirty:
   562		if (dirty)
   563			folio_redirty_for_writepage(wbc, folio);
   564		for (; i < folio_batch_count(&fbatch); i++) {
   565			folio_unlock(folio);
   566			folio_put(folio);
   567		}
   568		_leave(" cancel [%zx]", wreq->last);
   569	}
   570	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
