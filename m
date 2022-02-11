Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0987B4B2E45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353264AbiBKUNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353209AbiBKUNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:13:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11892CE9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644610389; x=1676146389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Al74JFqogcxgbZJcXGo6QKFdU0v78iBAUWrAI3yUfA=;
  b=U612oyIiURrAbeYGgx7XRG3BfEQKwKro5+AEhuj4ucuYWIKAYZb0N7le
   Y3oCR6Tuv/9i2e5o/xBU5fvOcpD8wlbib+IfNtI4x92iCyhCLM3IO14bH
   K4x78OZSjEOkcrT5RR9635KlmNV5wK2VfM/NSonqmplwMc4GtQIiFUtHR
   BgULp2T3LU+UzXb9wvd9pHdcpJsKom1bP+TlRWcC1/vYjFDVDJ/uMXiYa
   VL7ezKMttPIziZhY+U1WZb/UUq5xKBCApon5O7Ig8YmPsjbiUNfo3GxFL
   qR+JufHTI3NYIvlYsN19yQ84+jJT2HZ/4AKxt7uINiCeh9Q99eQSfN65N
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="250008663"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="250008663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="488661241"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2022 12:13:07 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIcHy-00058n-Fd; Fri, 11 Feb 2022 20:13:06 +0000
Date:   Sat, 12 Feb 2022 04:12:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 34/35]
 fs/netfs/flush.c:400:56: sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202202120413.rYahW6Tp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: e9340673baaf1ff587aed3391aa411cf554bc42e [34/35] netfs: Slice a writeback from a dirty region
config: sparc-randconfig-s031-20220210 (https://download.01.org/0day-ci/archive/20220212/202202120413.rYahW6Tp-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/e9340673baaf1ff587aed3391aa411cf554bc42e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout e9340673baaf1ff587aed3391aa411cf554bc42e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/flush.c:400:56: sparse: sparse: Using plain integer as NULL pointer
   fs/netfs/flush.c:448:48: sparse: sparse: Using plain integer as NULL pointer

vim +400 fs/netfs/flush.c

   293	
   294	/*
   295	 * Flush some of the dirty queue, transforming a part of a sequence of dirty
   296	 * regions into a block we can flush.
   297	 *
   298	 * A number of things constrain us:
   299	 *  - The region we write out should not be undergoing modification
   300	 *  - We may need to expand or split the region for a number of reasons:
   301	 *    - Filesystem storage block/object size
   302	 *    - Filesystem RPC size (wsize)
   303	 *    - Cache block size
   304	 *    - Cache DIO block size
   305	 *    - Crypto/compression block size
   306	 *
   307	 * This may be entered multiple times simultaneously.  Automatic flushing by
   308	 * the VM is serialised on I_SYNC, but things like fsync() may enter multiple
   309	 * times simultaneously.
   310	 */
   311	static int netfs_flush_dirty(struct netfs_writeback *wback,
   312				     struct writeback_control *wbc,
   313				     struct netfs_i_context *ctx,
   314				     struct ma_state *mas,
   315				     pgoff_t *_first, pgoff_t last,
   316				     struct netfs_dirty_region *spares[2])
   317	{
   318		struct netfs_dirty_region *region;
   319		struct folio *folio;
   320		pgoff_t first = *_first;
   321		pgoff_t csize = 1UL << ctx->cache_order;
   322		long ret;
   323	
   324		XA_STATE(xas, &wback->mapping->i_pages, 0);
   325	
   326		/* Round out the range we're looking through to accommodate whole cache
   327		 * blocks.  The cache may only be able to store blocks of that size, in
   328		 * which case we may need to add non-dirty pages to the buffer too.
   329		 */
   330		if (ctx->cache_order) {
   331			first = round_down(first, csize);
   332			last = round_up_incl(last, csize);
   333		}
   334	
   335		_enter("%lx-%lx", first, last);
   336	
   337		rcu_read_lock();
   338		mtree_lock(&ctx->dirty_regions);
   339	
   340		/* Find the first dirty region that overlaps the requested range */
   341		mas_set(mas, first);
   342		do {
   343			region = mas_find(mas, last);
   344			if (!region)
   345				goto found_nothing;
   346		} while (netfs_mas_is_flushing(region));
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
   398				netfs_get_dirty_region(ctx, region, netfs_region_trace_get_wback);
   399				list_add_tail(&region->flush_link, &wback->regions);
 > 400				trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   401						  netfs_dirty_trace_flush);
   402			}
   403	
   404			region = mas_next(mas, mas->last + 1);
   405			if (!region || netfs_mas_is_flushing(region))
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
   446			netfs_get_dirty_region(ctx, region, netfs_region_trace_get_wback);
   447			list_add_tail(&region->flush_link, &wback->regions);
   448			trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   449					  netfs_dirty_trace_flush2);
   450		}
   451	
   452	no_more:
   453		/* We've now got a contiguous span.  Some of the subspans may only need
   454		 * writing to the cache, whilst others need writing to both the server
   455		 * and the cache.
   456		 */
   457		_debug("span %lx-%lx", wback->first, wback->last);
   458		*_first = last + 1;
   459		mtree_unlock(&ctx->dirty_regions);
   460		rcu_read_unlock();
   461	
   462		/* Load the pages into the raw-data buffer and transition them over to
   463		 * the writeback state.
   464		 */
   465		ret = netfs_flush_get_pages(wback, ctx);
   466		if (ret < 0)
   467			goto undo;
   468	
   469		netfs_writeback_lock(wback);
   470		netfs_writeback_start(wback);
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
