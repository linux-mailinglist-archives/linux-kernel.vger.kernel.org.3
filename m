Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C853D874
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiFDToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbiFDTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:43:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE662CDD4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654371833; x=1685907833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tOQ8VAJpzYvKga6lKE6bIur877r1cX9OMmJlMNQc8o8=;
  b=YWKernko7gON+QoM6AC/cq7kXmP42AlRn+Ns1XQwQDw0EFOTBapyyc93
   Ub7GnrznK5SrltTy9Crsh49oxP0gnS+w93ljobR4iocwb44EkKAcaJldy
   +UmFXfb4zjHlyavF/y+sblVIUm9SRK+fzXHCZNsTeQo9MaA7U9gwQUzbS
   NDt5ch84tX1Nmz9ZDELTOhPFTHbNDsXdJUoq25H5sv7nYUDyXSxH8IWIy
   R2kkyerbBQ2824/WXR3+rEjpK19SxEL0tMnJFZDEMCDmN2v8vWG8193Ip
   M/nAtA/BA66x8FFHMq2C2WU2q3DFpkMmq8lLNulUAG4u8mQqg7HVUpepC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276233512"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="276233512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 12:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="613719284"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2022 12:43:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxZgc-000B9z-Nh;
        Sat, 04 Jun 2022 19:43:50 +0000
Date:   Sun, 5 Jun 2022 03:43:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 58/59]
 fs/netfs/buffered_flush.c:408:30: sparse: sparse: incompatible types in
 comparison expression (different type sizes):
Message-ID: <202206050354.7iGBqref-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   22ecc2fcdab4616e624408911ec1d54644e82030
commit: ff509dc49891f934a7a774e277b87729018db753 [58/59] netfs: Use flush from afs_writeback
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220605/202206050354.7iGBqref-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/ff509dc49891f934a7a774e277b87729018db753
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout ff509dc49891f934a7a774e277b87729018db753
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/buffered_flush.c:408:30: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/netfs/buffered_flush.c:408:30: sparse:    unsigned int *
>> fs/netfs/buffered_flush.c:408:30: sparse:    unsigned long *
   fs/netfs/buffered_flush.c:411:30: sparse: sparse: incompatible types in comparison expression (different type sizes):
   fs/netfs/buffered_flush.c:411:30: sparse:    unsigned int *
   fs/netfs/buffered_flush.c:411:30: sparse:    unsigned long *
   fs/netfs/buffered_flush.c:413:17: sparse: sparse: incompatible types in comparison expression (different type sizes):
   fs/netfs/buffered_flush.c:413:17: sparse:    unsigned int *
   fs/netfs/buffered_flush.c:413:17: sparse:    unsigned long *

vim +408 fs/netfs/buffered_flush.c

   372	
   373	/*
   374	 * Extend the region to be written back to include subsequent contiguously
   375	 * dirty pages if possible, but don't sleep while doing so.
   376	 *
   377	 * If this page holds new content, then we can include filler zeros in the
   378	 * writeback.
   379	 */
   380	static void netfs_extend_writeback(struct netfs_io_request *wreq,
   381					   struct writeback_control *wbc,
   382					   struct netfs_i_context *ctx,
   383					   struct netfs_dirty_region *region)
   384	{
   385		struct folio_batch fbatch;
   386		struct folio *folio;
   387		unsigned int i;
   388		pgoff_t index = wreq->last + 1, stop_mask, stop_at, max_pages;
   389		ssize_t max_size;
   390		size_t align, hard_align;
   391		bool stop = true, dirty;
   392		int ret;
   393	
   394		XA_STATE(xas, &wreq->mapping->i_pages, index);
   395	
   396		_enter("%lx", index);
   397	
   398		/* We have a number of criteria by which we can decide where to stop
   399		 * extension of this writeback:
   400		 *
   401		 *  1) The maximum I/O size (but wbacks can be subdivided)
   402		 *  2) Boundaries within the filesystem (eg. ceph object size)
   403		 *  3) Local boundaries (cache granules, VM radix node sizes)
   404		 *  4) Content crypto/compression boundaries
   405		 */
   406		hard_align = PAGE_SIZE;
   407		if (ctx->min_bshift || ctx->crypto_bshift)
 > 408			hard_align = max(hard_align,
   409					 1UL << max(ctx->min_bshift, ctx->crypto_bshift));
   410		if (ctx->cache_order)
   411			hard_align = max(hard_align, PAGE_SIZE << ctx->cache_order);
   412	
   413		align = min(hard_align, XA_CHUNK_SIZE * PAGE_SIZE);
   414		if (wreq->alignment > align)
   415			align = wreq->alignment;
   416	
   417		stop_mask = (align - 1) / PAGE_SIZE;
   418	
   419		max_size = XA_CHUNK_SIZE * PAGE_SIZE;
   420		if (wreq->wsize > max_size)
   421			max_size = roundup_pow_of_two(wreq->wsize);
   422	
   423		_debug("LIMITS al=%zx ha=%zx mx=%zx", align, hard_align, max_size);
   424	
   425		max_pages = max_size / PAGE_SIZE;
   426		max_pages &= ~stop_mask;
   427		_debug("MAX_PAGES %lx %lx", max_pages, stop_mask);
   428		if (wreq->last - wreq->first + 1 >= max_pages) {
   429			_leave(" [already hit wsize %lx %lx]",
   430			       wreq->last - wreq->first + 1, max_pages);
   431			return;
   432		}
   433	
   434		stop_at = wreq->first + max_pages;
   435		if (stop_at < wreq->first)
   436			stop_at = ULONG_MAX;
   437		else
   438			stop_at = round_down(stop_at, align / PAGE_SIZE);
   439		_debug("STOP_AT %lx (%lx %lx %lx)", stop_at, wreq->first, max_pages, align / PAGE_SIZE);
   440	
   441		if (index >= stop_at || wbc->nr_to_write <= 0 || wreq->len > max_size) {
   442			_leave(" [prestop]");
   443			return;
   444		}
   445	
   446		do {
   447			/* Firstly, we gather up a batch of contiguous dirty folios
   448			 * under the RCU read lock - but we can't clear the dirty flags
   449			 * there if any of those folios are mapped.
   450			 */
   451			folio_batch_init(&fbatch);
   452			_debug("extend %lx %lx", index, xas.xa_index);
   453			rcu_read_lock();
   454	
   455			xas_for_each(&xas, folio, ULONG_MAX) {
   456				stop = true;
   457				if (xas_retry(&xas, folio))
   458					continue;
   459				if (xa_is_value(folio))
   460					break;
   461				if (folio_index(folio) != index)
   462					break;
   463	
   464				if (!folio_try_get_rcu(folio)) {
   465					xas_reset(&xas);
   466					continue;
   467				}
   468	
   469				/* Has the folio moved or been split? */
   470				if (unlikely(folio != xas_reload(&xas))) {
   471					folio_put(folio);
   472					break;
   473				}
   474	
   475				if (!folio_trylock(folio)) {
   476					folio_put(folio);
   477					break;
   478				}
   479				if (!folio_test_dirty(folio) ||
   480				    folio_test_writeback(folio)) {
   481					folio_unlock(folio);
   482					folio_put(folio);
   483					break;
   484				}
   485	
   486				wreq->len += folio_size(folio);
   487				index += folio_nr_pages(folio);
   488				stop = index >= stop_at || wbc->nr_to_write <= 0;
   489	
   490				if (!folio_batch_add(&fbatch, folio))
   491					break;
   492				if (stop)
   493					break;
   494			}
   495	
   496			if (!stop)
   497				xas_pause(&xas);
   498			rcu_read_unlock();
   499	
   500			/* Now, if we obtained any pages, we can shift them to being
   501			 * writable and mark them for caching.
   502			 */
   503			if (!folio_batch_count(&fbatch))
   504				break;
   505	
   506			for (i = 0; i < folio_batch_count(&fbatch); i++) {
   507				folio = fbatch.folios[i];
   508				//_debug("found [%x] %lx", i, folio->index);
   509				trace_netfs_folio_dirty(wreq->mapping, folio,
   510							netfs_folio_trace_store_ex);
   511	
   512				dirty = folio_clear_dirty_for_io(folio);
   513				if (folio_start_writeback(folio)) {
   514					_debug("! no wb");
   515					goto nomem_redirty;
   516				}
   517	
   518				ret = netfs_xa_store_and_mark(&wreq->buffer, folio->index, folio,
   519							      true, true, dirty, GFP_NOFS);
   520				if (ret < 0) {
   521					_debug("! no buffer");
   522					goto nomem_cancel_wb;
   523				}
   524				wbc->nr_to_write -= folio_nr_pages(folio);
   525				index = folio_next_index(folio);
   526				wreq->last = index - 1;
   527				folio_unlock(folio);
   528			}
   529	
   530			cond_resched();
   531		} while (!stop);
   532	
   533		_leave(" ok [%zx]", wreq->last);
   534		return;
   535	
   536	nomem_cancel_wb:
   537		folio_end_writeback(folio);
   538	nomem_redirty:
   539		if (dirty)
   540			folio_redirty_for_writepage(wbc, folio);
   541		for (; i < folio_batch_count(&fbatch); i++) {
   542			folio_unlock(folio);
   543			folio_put(folio);
   544		}
   545		_leave(" cancel [%zx]", wreq->last);
   546	}
   547	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
