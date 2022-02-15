Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3F4B7B81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbiBPAAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:00:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBPAAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:00:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F80BCA70D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644969618; x=1676505618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aBeJ0UNMTywv9hUz9/9KjpxfPt84E4zAbeirFT2NsRw=;
  b=FNQeY8MPzN6rbHC6eGo1BwPRGiQyHYdQ7V8Nz/LQ3jZWUmSHvzHVXAZW
   xlkdRbNUWDpN29Om5qDbqtQJPAW4HYkjZTPfo2m9I3iM7dY3/ow0WrnK1
   CJ2O6aDDtUjgmct16hOXYHQoXyCYNwl/Ur0Amq/+prBnK9sw9A6eyK2IK
   yx4A66iOQnSbCfF09QXLhNfwX65/e5HReSPtv/YP7laX7ZmhgvF6mKBnF
   TKK6fr8uEbgFluNO3i6fVlnHw8nw0mvi7pSKfvcAkThxC97K7eo7fiKIm
   5p1/+WbGVmHhi6flLQrw3bNVCAFzEJftSNaJtQNpGPrvL0h6WeLrbUBB6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230450027"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230450027"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486490996"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2022 16:00:16 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK7jz-000AAj-3U; Wed, 16 Feb 2022 00:00:15 +0000
Date:   Wed, 16 Feb 2022 07:59:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 43/43]
 fs/netfs/flush.c:470:9: error: implicit declaration of function
 'netfs_proc_add_writeback'; did you mean 'netfs_proc_add_wback'?
Message-ID: <202202160750.mCa1PQLO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   d40df0841e9f8de3713a19dd3f0ba283c860cb93
commit: d40df0841e9f8de3713a19dd3f0ba283c860cb93 [43/43] netfs: Provide /proc/fs/netfs/writebacks to display writeback slices
config: arc-randconfig-r031-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160750.mCa1PQLO-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d40df0841e9f8de3713a19dd3f0ba283c860cb93
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout d40df0841e9f8de3713a19dd3f0ba283c860cb93
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/netfs/flush.c: In function 'netfs_flush_dirty':
>> fs/netfs/flush.c:470:9: error: implicit declaration of function 'netfs_proc_add_writeback'; did you mean 'netfs_proc_add_wback'? [-Werror=implicit-function-declaration]
     470 |         netfs_proc_add_writeback(wback);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         netfs_proc_add_wback
   At top level:
   fs/netfs/flush.c:38:13: warning: 'netfs_flush_region' defined but not used [-Wunused-function]
      38 | static void netfs_flush_region(struct netfs_i_context *ctx,
         |             ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   fs/netfs/objects.c: In function 'netfs_put_writeback':
>> fs/netfs/objects.c:160:25: error: implicit declaration of function 'netfs_proc_del_writeback'; did you mean 'netfs_proc_del_wback'? [-Werror=implicit-function-declaration]
     160 |                         netfs_proc_del_writeback(wback);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
         |                         netfs_proc_del_wback
   cc1: some warnings being treated as errors


vim +470 fs/netfs/flush.c

   292	
   293	/*
   294	 * Flush some of the dirty queue, transforming a part of a sequence of dirty
   295	 * regions into a block we can flush.
   296	 *
   297	 * A number of things constrain us:
   298	 *  - The region we write out should not be undergoing modification
   299	 *  - We may need to expand or split the region for a number of reasons:
   300	 *    - Filesystem storage block/object size
   301	 *    - Filesystem RPC size (wsize)
   302	 *    - Cache block size
   303	 *    - Cache DIO block size
   304	 *    - Crypto/compression block size
   305	 *
   306	 * This may be entered multiple times simultaneously.  Automatic flushing by
   307	 * the VM is serialised on I_SYNC, but things like fsync() may enter multiple
   308	 * times simultaneously.
   309	 */
   310	static int netfs_flush_dirty(struct netfs_writeback *wback,
   311				     struct writeback_control *wbc,
   312				     struct netfs_i_context *ctx,
   313				     struct ma_state *mas,
   314				     pgoff_t *_first, pgoff_t last,
   315				     struct netfs_dirty_region *spares[2])
   316	{
   317		struct netfs_dirty_region *region;
   318		struct folio *folio;
   319		pgoff_t first = *_first;
   320		pgoff_t csize = 1UL << ctx->cache_order;
   321		long ret;
   322	
   323		XA_STATE(xas, &wback->mapping->i_pages, 0);
   324	
   325		/* Round out the range we're looking through to accommodate whole cache
   326		 * blocks.  The cache may only be able to store blocks of that size, in
   327		 * which case we may need to add non-dirty pages to the buffer too.
   328		 */
   329		if (ctx->cache_order) {
   330			first = round_down(first, csize);
   331			last = round_up_incl(last, csize);
   332		}
   333	
   334		_enter("%lx-%lx", first, last);
   335	
   336		rcu_read_lock();
   337		mtree_lock(&ctx->dirty_regions);
   338	
   339		/* Find the first dirty region that overlaps the requested range */
   340		mas_set(mas, first);
   341		do {
   342			region = mas_find(mas, last);
   343			if (!region)
   344				goto found_nothing;
   345		} while (netfs_mas_is_flushing(region) ||
   346			 (netfs_mas_is_valid(region) && region->waiting_on_wb));
   347	
   348		_debug("query D=%x %lx-%lx",
   349		       netfs_mas_is_valid(region) ? region->debug_id : 0,
   350		       mas->index, mas->last);
   351	
   352		wback->first = max(mas->index, first);
   353		if (wback->first > 0) {
   354			_debug("nonz %lx", wback->first);
   355	
   356			/* The first folio might extend backwards beyond the start of
   357			 * the proposed region - in which case we need to include that
   358			 * also.  But at least, in such a case, the folio size has to
   359			 * be an integer multiple of the cache blocksize.
   360			 */
   361			if (mas->index < wback->first) {
   362				_debug("check folio %lx", wback->first);
   363				xas_set(&xas, wback->first);
   364				do {
   365					xas_reset(&xas);
   366					folio = xas_load(&xas);
   367				} while (xas_retry(&xas, folio));
   368	
   369				if (folio && !xa_is_value(folio)) {
   370					_debug("check folio %lx", folio->index);
   371					/* A region span *should not* end in the middle of a folio. */
   372					BUG_ON(folio->index < mas->index);
   373					if (folio->index < wback->first) {
   374						wback->first = folio->index;
   375						mas_set_range(mas, wback->first, mas->last);
   376					}
   377				}
   378			}
   379	
   380			_debug("fol %lx", wback->first);
   381	
   382			if (mas->index < wback->first) {
   383				pgoff_t saved_last = mas->last;
   384				_debug("splitf %lx-%lx %lx", mas->index, mas->last, first);
   385				netfs_split_off_front(ctx, mas, region, &spares[0], first - 1,
   386						      netfs_dirty_trace_split_off_front);
   387				mas_set_range(mas, first, saved_last);
   388			}
   389	
   390			wback->last = mas->last;
   391		}
   392	
   393		while (mas->last < last) {
   394			_debug("store %lx-%lx", mas->index, mas->last);
   395			wback->last = mas->last;
   396			mas_store(mas, netfs_mas_set_flushing(region));
   397			if (region != NETFS_COPY_TO_CACHE) {
   398				list_add_tail(&region->flush_link, &wback->regions);
   399				trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   400						  netfs_dirty_trace_flush);
   401			}
   402	
   403			region = mas_next(mas, mas->last + 1);
   404			if (!region || netfs_mas_is_flushing(region) ||
   405			    region->waiting_on_wb)
   406				goto no_more;
   407			if (mas->last >= last)
   408				break;
   409			_debug("query+ D=%x %lx-%lx",
   410			       netfs_mas_is_valid(region) ? region->debug_id : 0,
   411			       mas->index, mas->last);
   412		}
   413	
   414		/* Deal with the region we're looking at exceeding the specified range.
   415		 * In such a case, we need to split the region - and the last folio may
   416		 * extend beyond the end of the proposed region - in which case we need
   417		 * to include that also.  And, again, the folio size has to be an
   418		 * integer multiple of the cache blocksize.
   419		 */
   420		if (mas->last > last) {
   421			xas_set(&xas, last);
   422			do {
   423				xas_reset(&xas);
   424				folio = xas_load(&xas);
   425			} while (xas_retry(&xas, folio));
   426	
   427			if (folio && !xa_is_value(folio)) {
   428				pgoff_t flast = folio_next_index(folio) - 1;
   429	
   430				_debug("flast %lx %lx %lx", flast, mas->last, last);
   431				/* A region span *should not* end in the middle of a folio. */
   432				BUG_ON(flast > mas->last);
   433				if (flast > last) {
   434					last = flast;
   435					mas_set_range(mas, mas->index, last);
   436				}
   437			}
   438	
   439			region = netfs_split_off_front(ctx, mas, region, &spares[1], last,
   440						       netfs_dirty_trace_split_off_back);
   441		}
   442	
   443		wback->last = mas->last;
   444		mas_store(mas, netfs_mas_set_flushing(region));
   445		if (region != NETFS_COPY_TO_CACHE) {
   446			list_add_tail(&region->flush_link, &wback->regions);
   447			trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   448					  netfs_dirty_trace_flush2);
   449		}
   450	
   451	no_more:
   452		/* We've now got a contiguous span.  Some of the subspans may only need
   453		 * writing to the cache, whilst others need writing to both the server
   454		 * and the cache.
   455		 */
   456		_debug("span %lx-%lx", wback->first, wback->last);
   457		*_first = last + 1;
   458		mtree_unlock(&ctx->dirty_regions);
   459		rcu_read_unlock();
   460	
   461		/* Load the pages into the raw-data buffer and transition them over to
   462		 * the writeback state.
   463		 */
   464		ret = netfs_flush_get_pages(wback, ctx);
   465		if (ret < 0)
   466			goto undo;
   467	
   468		netfs_writeback_lock(wback);
   469		netfs_writeback_start(wback);
 > 470		netfs_proc_add_writeback(wback);
   471		trace_netfs_wback(wback);
   472	
   473		wbc->nr_to_write -= wback->last - wback->first + 1;
   474		*_first = wback->last + 1;
   475		_leave(" = %lx [%lx]", wback->last - wback->first + 1, *_first);
   476		return 1;
   477	
   478	found_nothing:
   479		*_first = last + 1;
   480		mtree_unlock(&ctx->dirty_regions);
   481		rcu_read_unlock();
   482		return 0;
   483	
   484	undo:
   485		BUG(); // TODO
   486	}
   487	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
