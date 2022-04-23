Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3F50CAE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiDWOAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiDWOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:00:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD152FE67
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650722218; x=1682258218;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sGlIQT8sLP/zhXUZ3TFcSAq8ZjTKyQCmeMeWRnVfTqc=;
  b=fg9HvIRFTO1j6YYdJTM4zHe6pq3zFXq5Up8vj/HHNdI6esfESYUQcWvY
   NJsRlLI3sWK+Dy90EqwlgZdK6Xswgm7QzswzU+sQ4/WSpeLeFFDdJl96M
   hMYzXlrVpH7W9oNbj8VTKX1sToNvDrxv80NgH982iln2IEohMlznnd3jx
   2euMjYfGUUI8xqXKW1UhRmbmu6Yz1bqbjBRLUSni4Wm5ssmOIbys0CBYh
   4Zsxdd4BwGbH95ejYSC2634HtplYyOdFzmuwvnU7ptiarhFGPtnAErpsc
   4N1DgTkrT9mXoqrFZAWxJMsmj4r4T6jbXwVHiIRcb3Bn+3FzI+It55dDQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246807742"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="246807742"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 06:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="728941702"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 06:56:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niGFr-00005Z-Rg;
        Sat, 23 Apr 2022 13:56:55 +0000
Date:   Sat, 23 Apr 2022 21:56:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 39/44]
 fs/netfs/buffered_flush.c:545:56: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202204232113.9ZYFjNl3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 42a9ba6b52c29bc596f92921805d734c19a34cb3 [39/44] netfs: Generate a write request from ->writepages()
config: arc-randconfig-s032-20220422 (https://download.01.org/0day-ci/archive/20220423/202204232113.9ZYFjNl3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/42a9ba6b52c29bc596f92921805d734c19a34cb3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 42a9ba6b52c29bc596f92921805d734c19a34cb3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/netfs/buffered_flush.c:545:56: sparse: sparse: Using plain integer as NULL pointer
   fs/netfs/buffered_flush.c:595:48: sparse: sparse: Using plain integer as NULL pointer

vim +545 fs/netfs/buffered_flush.c

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
   543				__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
   544				list_add_tail(&region->flush_link, &wreq->regions);
 > 545				trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   546						  netfs_dirty_trace_flush);
   547				end = region->to;
   548			}
   549	
   550			region = mas_next(mas, mas->last + 1);
   551			if (!region || netfs_mas_is_flushing(region) ||
   552			    region->waiting_on_wb)
   553				goto no_more;
   554			if (mas->last >= last)
   555				break;
   556			_debug("query+ D=%x %lx-%lx",
   557			       netfs_mas_is_valid(region) ? region->debug_id : 0,
   558			       mas->index, mas->last);
   559		}
   560	
   561		/* Deal with the region we're looking at exceeding the specified range.
   562		 * In such a case, we need to split the region - and the last folio may
   563		 * extend beyond the end of the proposed region - in which case we need
   564		 * to include that also.  And, again, the folio size has to be an
   565		 * integer multiple of the cache blocksize.
   566		 */
   567		if (mas->last > last) {
   568			xas_set(&xas, last);
   569			do {
   570				xas_reset(&xas);
   571				folio = xas_load(&xas);
   572			} while (xas_retry(&xas, folio));
   573	
   574			if (folio && !xa_is_value(folio)) {
   575				pgoff_t flast = folio_next_index(folio) - 1;
   576	
   577				_debug("flast %lx %lx %lx", flast, mas->last, last);
   578				/* A region span *should not* end in the middle of a folio. */
   579				BUG_ON(flast > mas->last);
   580				if (flast > last) {
   581					last = flast;
   582					mas_set_range(mas, mas->index, last);
   583				}
   584			}
   585	
   586			region = netfs_split_off_front(ctx, mas, region, &spares[1], last,
   587						       netfs_dirty_trace_split_off_back);
   588		}
   589	
   590		wreq->last = mas->last;
   591		mas_store(mas, netfs_mas_set_flushing(region));
   592		if (region != NETFS_COPY_TO_CACHE) {
   593			__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
   594			list_add_tail(&region->flush_link, &wreq->regions);
   595			trace_netfs_dirty(ctx, region, 0, mas->index, mas->last,
   596					  netfs_dirty_trace_flush2);
   597		}
   598	
   599	no_more:
   600		/* We've now got a contiguous span.  Some of the subspans may only need
   601		 * writing to the cache, whilst others need writing to both the server
   602		 * and the cache.
   603		 */
   604		_debug("span %lx-%lx", wreq->first, wreq->last);
   605		*_first = last + 1;
   606		mtree_unlock(&ctx->dirty_regions);
   607		rcu_read_unlock();
   608	
   609		if (wreq->i_size > end)
   610			end = min_t(unsigned long long, wreq->i_size, (wreq->last + 1) * PAGE_SIZE);
   611		wreq->len = end - wreq->start;
   612	
   613		/* Load the pages into the raw-data buffer and transition them over to
   614		 * the writeback state.
   615		 */
   616		ret = netfs_flush_get_pages(wreq, ctx);
   617		if (ret < 0)
   618			goto undo;
   619	
   620		if (wreq->buffering == NETFS_ENC_BUFFER_TO_BOUNCE) {
   621			ret = netfs_alloc_buffer(&wreq->bounce, wreq->first,
   622						 wreq->last - wreq->first + 1);
   623			if (ret < 0)
   624				goto undo;
   625		}
   626	
   627		netfs_writeback_lock(wreq);
   628		netfs_writeback_start(wreq);
   629	
   630		wbc->nr_to_write -= wreq->last - wreq->first + 1;
   631		*_first = wreq->last + 1;
   632		_leave(" = %lx [%lx]", wreq->last - wreq->first + 1, *_first);
   633		return 1;
   634	
   635	found_nothing:
   636		*_first = last + 1;
   637		mtree_unlock(&ctx->dirty_regions);
   638		rcu_read_unlock();
   639		return 0;
   640	
   641	undo:
   642		BUG(); // TODO
   643	}
   644	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
