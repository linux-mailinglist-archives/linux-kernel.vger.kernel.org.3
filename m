Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB1A4F4877
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiDEVkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385438AbiDEPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:15:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1929830
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649165492; x=1680701492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bdphDZ6QVD3o+ex/31eD7W63EBBRI2T9KkGIGM5owj0=;
  b=dm9x/g6HwzI9a7evYSCIAbnyj39OwiofpnFpQmC/nIoAMOrHrR/neBEe
   gQVTd0H2y+WZe3jmRxNl4kyi4gHIPHqcq/wijkvKHeMRwq98PNykYltQ2
   JBf9SNT0UbebqOlpbZsPCM5unud6WCmgIzoCEA6vb8lYTCCY1fdBrvrRZ
   4Td1Z9NETYpNXCqTnkevv3PrbZKFQiejKOxqvZzpRPORzCqL0VQZd/c8T
   34sTXKrDfGlGDnhSvkEVTq2GYHxOL3eQxBO0jIMvSV9bWKza1nRTSD7NR
   QAM7j4tCpOqZZnzZ7xjytsNzn3u/zjNQEexsVxooe8yef2ywc3dj2Zfof
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260924662"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260924662"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523461840"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 06:31:30 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbjHN-0003KJ-IF;
        Tue, 05 Apr 2022 13:31:29 +0000
Date:   Tue, 5 Apr 2022 21:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 37/40]
 fs/netfs/buffered_flush.c:544:56: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202204052141.yq66Pdxo-lkp@intel.com>
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
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 5e5e24ad5bf0176cea69018da2e7118b84d041f8 [37/40] netfs: Generate a write request from ->writepages()
config: alpha-randconfig-s032-20220405 (https://download.01.org/0day-ci/archive/20220405/202204052141.yq66Pdxo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/5e5e24ad5bf0176cea69018da2e7118b84d041f8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 5e5e24ad5bf0176cea69018da2e7118b84d041f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/buffered_flush.c:544:56: sparse: sparse: Using plain integer as NULL pointer
   fs/netfs/buffered_flush.c:593:48: sparse: sparse: Using plain integer as NULL pointer

vim +544 fs/netfs/buffered_flush.c

   437	
   438	/*
   439	 * Flush some of the dirty queue, transforming a part of a sequence of dirty
   440	 * regions into a block we can flush.
   441	 *
   442	 * A number of things constrain us:
   443	 *  - The region we write out should not be undergoing modification
   444	 *  - We may need to expand or split the region for a number of reasons:
   445	 *    - Filesystem storage block/object size
   446	 *    - Filesystem RPC size (wsize)
   447	 *    - Cache block size
   448	 *    - Cache DIO block size
   449	 *    - Crypto/compression block size
   450	 *
   451	 * This may be entered multiple times simultaneously.  Automatic flushing by
   452	 * the VM is serialised on I_SYNC, but things like fsync() may enter multiple
   453	 * times simultaneously.
   454	 */
   455	static int netfs_flush_dirty(struct netfs_io_request *wreq,
   456				     struct writeback_control *wbc,
   457				     struct netfs_i_context *ctx,
   458				     struct ma_state *mas,
   459				     pgoff_t *_first, pgoff_t last,
   460				     struct netfs_dirty_region *spares[2])
   461	{
   462		struct netfs_dirty_region *region;
   463		struct folio *folio;
   464		unsigned long long end;
   465		pgoff_t first = *_first;
   466		pgoff_t csize = 1UL << ctx->cache_order;
   467		long ret;
   468	
   469		XA_STATE(xas, &wreq->mapping->i_pages, 0);
   470	
   471		/* Round out the range we're looking through to accommodate whole cache
   472		 * blocks.  The cache may only be able to store blocks of that size, in
   473		 * which case we may need to add non-dirty pages to the buffer too.
   474		 */
   475		if (ctx->cache_order) {
   476			first = round_down(first, csize);
   477			last = round_up_incl(last, csize);
   478		}
   479	
   480		_enter("%lx-%lx", first, last);
   481	
   482		rcu_read_lock();
   483		mtree_lock(&ctx->dirty_regions);
   484	
   485		/* Find the first dirty region that overlaps the requested range */
   486		mas_set(mas, first);
   487		do {
   488			region = mas_find(mas, last);
   489			if (!region)
   490				goto found_nothing;
   491		} while (netfs_mas_is_flushing(region) ||
   492			 (netfs_mas_is_valid(region) && region->waiting_on_wb));
   493	
   494		_debug("query D=%x %lx-%lx",
   495		       netfs_mas_is_valid(region) ? region->debug_id : 0,
   496		       mas->index, mas->last);
   497	
   498		wreq->first = max(mas->index, first);
   499		if (wreq->first > 0) {
   500			/* The first folio might extend backwards beyond the start of
   501			 * the proposed region - in which case we need to include that
   502			 * also.  But at least, in such a case, the folio size has to
   503			 * be an integer multiple of the cache blocksize.
   504			 */
   505			if (mas->index < wreq->first) {
   506				_debug("check folio %lx", wreq->first);
   507				xas_set(&xas, wreq->first);
   508				do {
   509					xas_reset(&xas);
   510					folio = xas_load(&xas);
   511				} while (xas_retry(&xas, folio));
   512	
   513				if (folio && !xa_is_value(folio)) {
   514					/* A region span *should not* end in the middle
   515					 * of a folio.
   516					 */
   517					BUG_ON(folio->index < mas->index);
   518					if (folio->index < wreq->first) {
   519						wreq->first = folio->index;
   520						mas_set_range(mas, wreq->first, mas->last);
   521					}
   522				}
   523			}
   524	
   525			if (mas->index < wreq->first) {
   526				pgoff_t saved_last = mas->last;
   527				_debug("splitf %lx-%lx %lx", mas->index, mas->last, first);
   528				netfs_split_off_front(ctx, mas, region, &spares[0], first - 1,
   529						      netfs_dirty_trace_split_off_front);
   530				mas_set_range(mas, first, saved_last);
   531			}
   532	
   533			wreq->last = mas->last;
   534		}
   535	
   536	
   537		end = wreq->start = wreq->first * PAGE_SIZE;
   538		while (mas->last < last) {
   539			_debug("flip %lx-%lx", mas->index, mas->last);
   540			wreq->last = mas->last;
   541			mas_store(mas, netfs_mas_set_flushing(region));
   542			if (region != NETFS_COPY_TO_CACHE) {
   543				list_add_tail(&region->flush_link, &wreq->regions);
 > 544				trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   545						  netfs_dirty_trace_flush);
   546				end = region->to;
   547			}
   548	
   549			region = mas_next(mas, mas->last + 1);
   550			if (!region || netfs_mas_is_flushing(region) ||
   551			    region->waiting_on_wb)
   552				goto no_more;
   553			if (mas->last >= last)
   554				break;
   555			_debug("query+ D=%x %lx-%lx",
   556			       netfs_mas_is_valid(region) ? region->debug_id : 0,
   557			       mas->index, mas->last);
   558		}
   559	
   560		/* Deal with the region we're looking at exceeding the specified range.
   561		 * In such a case, we need to split the region - and the last folio may
   562		 * extend beyond the end of the proposed region - in which case we need
   563		 * to include that also.  And, again, the folio size has to be an
   564		 * integer multiple of the cache blocksize.
   565		 */
   566		if (mas->last > last) {
   567			xas_set(&xas, last);
   568			do {
   569				xas_reset(&xas);
   570				folio = xas_load(&xas);
   571			} while (xas_retry(&xas, folio));
   572	
   573			if (folio && !xa_is_value(folio)) {
   574				pgoff_t flast = folio_next_index(folio) - 1;
   575	
   576				_debug("flast %lx %lx %lx", flast, mas->last, last);
   577				/* A region span *should not* end in the middle of a folio. */
   578				BUG_ON(flast > mas->last);
   579				if (flast > last) {
   580					last = flast;
   581					mas_set_range(mas, mas->index, last);
   582				}
   583			}
   584	
   585			region = netfs_split_off_front(ctx, mas, region, &spares[1], last,
   586						       netfs_dirty_trace_split_off_back);
   587		}
   588	
   589		wreq->last = mas->last;
   590		mas_store(mas, netfs_mas_set_flushing(region));
   591		if (region != NETFS_COPY_TO_CACHE) {
   592			list_add_tail(&region->flush_link, &wreq->regions);
   593			trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   594					  netfs_dirty_trace_flush2);
   595		}
   596	
   597	no_more:
   598		/* We've now got a contiguous span.  Some of the subspans may only need
   599		 * writing to the cache, whilst others need writing to both the server
   600		 * and the cache.
   601		 */
   602		_debug("span %lx-%lx", wreq->first, wreq->last);
   603		*_first = last + 1;
   604		mtree_unlock(&ctx->dirty_regions);
   605		rcu_read_unlock();
   606	
   607		if (wreq->i_size > end)
   608			end = min_t(unsigned long long, wreq->i_size, (wreq->last + 1) * PAGE_SIZE);
   609		wreq->len = end - wreq->start;
   610	
   611		/* Load the pages into the raw-data buffer and transition them over to
   612		 * the writeback state.
   613		 */
   614		ret = netfs_flush_get_pages(wreq, ctx);
   615		if (ret < 0)
   616			goto undo;
   617	
   618		if (wreq->buffering == NETFS_ENC_BUFFER_TO_BOUNCE) {
   619			ret = netfs_alloc_buffer(&wreq->bounce, wreq->first,
   620						 wreq->last - wreq->first + 1);
   621			if (ret < 0)
   622				goto undo;
   623		}
   624	
   625		netfs_writeback_lock(wreq);
   626		netfs_writeback_start(wreq);
   627	
   628		wbc->nr_to_write -= wreq->last - wreq->first + 1;
   629		*_first = wreq->last + 1;
   630		_leave(" = %lx [%lx]", wreq->last - wreq->first + 1, *_first);
   631		return 1;
   632	
   633	found_nothing:
   634		*_first = last + 1;
   635		mtree_unlock(&ctx->dirty_regions);
   636		rcu_read_unlock();
   637		return 0;
   638	
   639	undo:
   640		BUG(); // TODO
   641	}
   642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
