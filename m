Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F1953AEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiFAVka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiFAVk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:40:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B88C24
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654119625; x=1685655625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F1raApfcs620B/kgahY5y8OKGmxj85IM7DVX5FLddLs=;
  b=EUW2Nt6HGvLv3GUqbPRbYO5HhTBxGcQpBjULqZHF3FYqFZ3lcYwRtPRB
   W4P+JQsCZBbVxE/exPPuWIWmErZU6AflB+RvbLX+yE6Yj/jTrD93700h1
   fdFZVdnNycEZUCpM2mt0WfF3kYoXPwxOZwbTHI7vmqy7SrVZsh5WCKwPP
   Z+hIGBlHL++TV6YaHUtLVliN/tLJSKth4A8Y7IOdRmm1J5Jlj2zthsYdU
   mTUOOcYdZwn1am0yRuX/9zKmUDN631LVYnaw7T/TdPSw4eqYeEOFa5LcQ
   MF8wEB3HF89/8OWFJp2oVEZNH5azsWev29oi8kvBvEgfTQGqrveArWay4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257809432"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="257809432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 14:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="562997118"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2022 14:40:23 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwW4k-0004Qy-KV;
        Wed, 01 Jun 2022 21:40:22 +0000
Date:   Thu, 2 Jun 2022 05:40:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 58/59]
 fs/netfs/buffered_flush.c:411:16: warning: comparison of distinct pointer
 types ('typeof (hard_align) *' (aka 'unsigned int *') and 'typeof (((1UL) <<
 12) << ctx->cache_order) *' (aka 'unsigned long *'))
Message-ID: <202206020513.KecvF1iO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   22ecc2fcdab4616e624408911ec1d54644e82030
commit: ff509dc49891f934a7a774e277b87729018db753 [58/59] netfs: Use flush from afs_writeback
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220602/202206020513.KecvF1iO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ff509dc49891f934a7a774e277b87729018db753
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout ff509dc49891f934a7a774e277b87729018db753
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/netfs/buffered_flush.c:408:16: warning: comparison of distinct pointer types ('typeof (hard_align) *' (aka 'unsigned int *') and 'typeof (1UL << __builtin_choose_expr(((!!(sizeof ((typeof (ctx->min_bshift) *)1 == (typeof (ctx->crypto_bshift) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(ctx->min_bshift) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(ctx->crypto_bshift) * 0L)) : (int *)8))))), ((ctx->min_bshift) > (ctx->crypto_bshift) ? (ctx->min_bshift) : (ctx->crypto_bshift)), ({
       typeof (ctx->min_bshift) __UNIQUE_ID___x312 = (ctx->min_bshift);
       typeof (ctx->crypto_bshift) __UNIQUE_ID___y313 = (ctx->crypto_bshift);
       ((__UNIQUE_ID___x312) > (__UNIQUE_ID___y313) ? (__UNIQUE_ID___x312) : (__UNIQUE_ID___y313));
   }))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   hard_align = max(hard_align,
                                ^~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> fs/netfs/buffered_flush.c:411:16: warning: comparison of distinct pointer types ('typeof (hard_align) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12) << ctx->cache_order) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   hard_align = max(hard_align, PAGE_SIZE << ctx->cache_order);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> fs/netfs/buffered_flush.c:413:10: warning: comparison of distinct pointer types ('typeof (hard_align) *' (aka 'unsigned int *') and 'typeof ((1UL << (0 ? 4 : 6)) * ((1UL) << 12)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           align = min(hard_align, XA_CHUNK_SIZE * PAGE_SIZE);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/buffered_flush.c:533:22: warning: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Wformat]
           _leave(" ok [%zx]", wreq->last);
                        ~~~    ^~~~~~~~~~
                        %lx
   fs/netfs/internal.h:299:65: note: expanded from macro '_leave'
   #define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
                                                ~~~                ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/netfs/buffered_flush.c:545:26: warning: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Wformat]
           _leave(" cancel [%zx]", wreq->last);
                            ~~~    ^~~~~~~~~~
                            %lx
   fs/netfs/internal.h:299:65: note: expanded from macro '_leave'
   #define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
                                                ~~~                ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/netfs/buffered_flush.c:348:33: warning: unused function 'netfs_find_writeback' [-Wunused-function]
   static struct netfs_io_request *netfs_find_writeback(struct netfs_i_context *ctx,
                                   ^
   fs/netfs/buffered_flush.c:364:13: warning: unused function 'netfs_wait_for_writeback' [-Wunused-function]
   static void netfs_wait_for_writeback(struct netfs_io_request *wreq,
               ^
   7 warnings generated.


vim +411 fs/netfs/buffered_flush.c

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
   408			hard_align = max(hard_align,
   409					 1UL << max(ctx->min_bshift, ctx->crypto_bshift));
   410		if (ctx->cache_order)
 > 411			hard_align = max(hard_align, PAGE_SIZE << ctx->cache_order);
   412	
 > 413		align = min(hard_align, XA_CHUNK_SIZE * PAGE_SIZE);
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
