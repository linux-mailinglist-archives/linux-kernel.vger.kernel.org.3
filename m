Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D4561F26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiF3PWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiF3PWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:22:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E338BCF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656602519; x=1688138519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NQGy06/U2G+0psO5WXP5C7p2qYQfABgL8TnPlZrZJn8=;
  b=THwDCutzQGCVBYtRRWNDR24T81lHdwegwlhkq5riooOop1YdOt6IZufE
   EPcDHn2uBk9dVEJFm+FfJPDByXUQOFJZlRgBskBtnGNsuwEpBrfx50SRs
   0en3+ZYbQ6XvaOS++SZ1jLAsW1TZ7wN0UJ0cBX7RhOoIAZhrcPU+pino0
   UbPwMjNTGA2xPx+h8cWkrPM61k/MRMzfRd8JZKzXcdL8MBCrrIwgcyIso
   zw2S4dRfHk3t+N5F9tVphndbl2fPwHtW7w2TiyIyDonn1NOA4t69AgkFH
   m6+oy0o/2U0qYqY0qC6W8o5LhwbHqgI8JQcGPYBTNEQBjxt2UJFVkEsPn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="265411090"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="265411090"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="681011567"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2022 08:21:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6vzR-000Ctg-0U;
        Thu, 30 Jun 2022 15:21:57 +0000
Date:   Thu, 30 Jun 2022 23:21:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 55/55]
 fs/netfs/buffered_flush.c:219:7: error: use of undeclared identifier 'p'
Message-ID: <202206302347.OXqFhZY3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   e0aed6defb4fe6c570e77e8fd8d899651b40366e
commit: e0aed6defb4fe6c570e77e8fd8d899651b40366e [55/55] netfs: Implement truncation
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220630/202206302347.OXqFhZY3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e0aed6defb4fe6c570e77e8fd8d899651b40366e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout e0aed6defb4fe6c570e77e8fd8d899651b40366e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> fs/netfs/buffered_flush.c:219:7: error: use of undeclared identifier 'p'
                   if (p->first > r->first) {
                       ^
>> fs/netfs/buffered_flush.c:219:18: error: use of undeclared identifier 'r'
                   if (p->first > r->first) {
                                  ^
   fs/netfs/buffered_flush.c:220:8: error: use of undeclared identifier 'p'
                           if (p->last + 1 < r->first) {
                               ^
   fs/netfs/buffered_flush.c:220:22: error: use of undeclared identifier 'r'
                           if (p->last + 1 < r->first) {
                                             ^
>> fs/netfs/buffered_flush.c:168:8: error: use of undeclared label 'out'
                   goto out;
                        ^
>> fs/netfs/buffered_flush.c:176:10: error: use of undeclared label 'splice'
                                   goto splice;
                                        ^
   6 errors generated.
--
>> fs/netfs/truncate.c:202:18: warning: variable 'to' is uninitialized when used here [-Wuninitialized]
           } while (from < to);
                           ^~
   fs/netfs/truncate.c:149:18: note: initialize the variable 'to' to silence this warning
           pgoff_t from, to, fto;
                           ^
                            = 0
>> fs/netfs/truncate.c:170:6: warning: variable 'from' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (ret < 0)
               ^~~~~~~
   fs/netfs/truncate.c:176:45: note: uninitialized use occurs here
                   folio = read_mapping_folio(treq->mapping, from, NULL);
                                                             ^~~~
   fs/netfs/truncate.c:170:2: note: remove the 'if' if its condition is always true
           if (ret < 0)
           ^~~~~~~~~~~~
   fs/netfs/truncate.c:149:14: note: initialize the variable 'from' to silence this warning
           pgoff_t from, to, fto;
                       ^
                        = 0
   2 warnings generated.


vim +/p +219 fs/netfs/buffered_flush.c

   103	
   104	/*
   105	 * The write failed to some extent.  We need to work out which bits we managed
   106	 * to do - for instance, we might have managed to write stuff to the cache, but
   107	 * not upload to the server.
   108	 */
   109	static void netfs_redirty_range(struct netfs_io_request *wreq)
   110	{
   111		struct netfs_io_subrequest *subreq;
   112		struct netfs_io_chain *chain;
   113		struct netfs_dirty_region *d, *d2, *w, *tmp;
   114		struct netfs_inode *ctx = netfs_inode(wreq->inode);
   115		unsigned long long from, to;
   116		unsigned int c;
   117		bool upload_failed = false;
   118		LIST_HEAD(discards);
   119	
   120		trace_netfs_rreq(wreq, netfs_rreq_trace_redirty);
   121	
   122		if (list_empty(&wreq->regions))
   123			return netfs_clean_dirty_range(wreq);
   124	
   125		/* Ask the filesystem how it wants to handle things if an upload
   126		 * failed.  It has two choices: redirty everything or leave everything
   127		 * clean.
   128		 */
   129		for (c = 0; c < wreq->nr_chains; c++)
   130			if (chain->source != NETFS_WRITE_TO_CACHE && chain->error)
   131				upload_failed = true;
   132	
   133		if (upload_failed &&
   134		    wreq->netfs_ops->redirty_on_failure &&
   135		    !wreq->netfs_ops->redirty_on_failure(wreq))
   136			return netfs_clean_dirty_range(wreq);
   137	
   138		/* First of all, we step through the list of regions that were to be
   139		 * written back and see if we can discard/shorten anything that got
   140		 * partially stored.
   141		 *
   142		 * Don't retry write failures to the cache.  If the cache got a fatal
   143		 * error, it will have gone offline and retrying is pointless; if it
   144		 * ran out of space, it probably won't be able to supply us with space
   145		 * on the second attempt.
   146		 */
   147		list_for_each_entry_safe(w, tmp, &wreq->regions, dirty_link) {
   148			if (w->type == NETFS_COPY_TO_CACHE) {
   149				list_del_init(&w->dirty_link);
   150				netfs_put_dirty_region(ctx, w, netfs_region_trace_put_clear);
   151			}
   152		}
   153	
   154		w = list_first_entry_or_null(&wreq->regions,
   155					     struct netfs_dirty_region, dirty_link);
   156		if (!w)
   157			return;
   158	
   159		/* Step through the the uncompleted regions and reintegrate them into
   160		 * the dirty list.
   161		 */
   162		spin_lock(&ctx->dirty_lock);
   163	
   164		d = list_first_entry_or_null(&ctx->dirty_regions,
   165					     struct netfs_dirty_region, dirty_link);
   166		if (!d) {
   167			list_splice_tail_init(&wreq->regions, &ctx->dirty_regions);
 > 168			goto out;
   169		}
   170	
   171		while (d && w) {
   172			/* Dirty region before writeback region and not touching. */
   173			if (d->last < w->first && d->last != w->first - 1) {
   174				d = netfs_next_region(ctx, d);
   175				if (!d)
 > 176					goto splice;
   177				continue;
   178			}
   179	
   180			/* Dirty region overlaps with writeback region. */
   181			if (d->first <= w->last) {
   182				if (d->last == w->first - 1 &&
   183				    !netfs_are_regions_mergeable(ctx, d, d2)) {
   184					d = netfs_next_region(ctx, d);
   185					if (!d)
   186						goto splice;
   187					continue;
   188				}
   189	
   190				d->first = min(d->first, w->first);
   191				d->last  = max(d->last, w->last);
   192				d->from  = min(d->from, w->from);
   193				d->to    = max(d->to, w->to);
   194				trace_netfs_dirty(ctx, d, w, netfs_dirty_trace_redirty_merge);
   195	
   196				d2 = netfs_next_region(ctx, d);
   197				if (d2 && d->last >= d2->first - 1 &&
   198				    netfs_are_regions_mergeable(ctx, d, d2)) {
   199					d->last = d2->last;
   200					d->to   = d2->to;
   201					list_move(&d2->dirty_link, &discards);
   202					trace_netfs_dirty(ctx, d, d2, netfs_dirty_trace_bridged);
   203				}
   204	
   205				w = netfs_rreq_next_region(wreq, w);
   206				continue;
   207			}
   208	
   209			/* Dirty region after writeback region and touching. */
   210			if (d->first == w->last - 1 &&
   211			    !netfs_are_regions_mergeable(ctx, d, d2)) {
   212				d->first = min(d->first, w->first);
   213				d->from  = min(d->from, w->from);
   214				trace_netfs_dirty(ctx, d, w, netfs_dirty_trace_redirty_merge);
   215				w = netfs_rreq_next_region(wreq, w);
   216				continue;
   217			}
   218	
 > 219			if (p->first > r->first) {
   220				if (p->last + 1 < r->first) {
   221	
   222				}
   223			} else {
   224			}
   225		}
   226	
   227		spin_unlock(&ctx->dirty_lock);
   228	
   229		BUG();
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
