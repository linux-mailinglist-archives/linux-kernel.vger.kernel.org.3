Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC0561F25
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiF3PWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiF3PWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:22:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0A3917E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656602519; x=1688138519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yiYz8vdooXhVk/sQ5P6PvDSLbmKcTaLw8bm48QtQlOU=;
  b=AUBwLkhVaxtFtnV/5Nuo94mboDVbSuzPtN3UrgzAOjQgUR9qFp5SbdES
   JNiTMY/T/HH21upFh2/5dul+/7qryK4Nc0Pvg/TOUVmgfjsiDnxB6YzBf
   gBYuYBkau4xzh00oIjJrvN5F1/kXwB0lZDPmHWDLGi4aALNbHliNkmTYW
   ki3g00FZVUuGA7JYWkzKLG3Hx0TxxCn9mQT8d+QUvom5iG3KWCCC56rCD
   t6m6E3g5TqcoequVDz7YxFFaXSb3iuAk85dUheudzycT9NFt8eWF7LrZ4
   EmAxbR9wAapsM0FRDOJ7O4CA1WLUXptjShfeTTLchbJzsNk4bD8UMMbOl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346368010"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="346368010"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="647931443"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2022 08:21:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6vzQ-000Cte-Ve;
        Thu, 30 Jun 2022 15:21:56 +0000
Date:   Thu, 30 Jun 2022 23:21:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 55/55]
 fs/netfs/truncate.c:202:18: warning: variable 'to' is uninitialized when
 used here
Message-ID: <202206302311.Gx0KZCgq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   e0aed6defb4fe6c570e77e8fd8d899651b40366e
commit: e0aed6defb4fe6c570e77e8fd8d899651b40366e [55/55] netfs: Implement truncation
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220630/202206302311.Gx0KZCgq-lkp@intel.com/config)
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

All warnings (new ones prefixed by >>):

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


vim +/to +202 fs/netfs/truncate.c

   133	
   134	/*
   135	 * Set up a pair of buffers with which we can perform an RMW cycle to
   136	 * reconstitute the block containing the EOF marker.  One buffer will hold the
   137	 * proposed modification in unencrypted form, the other will hold the
   138	 * encrypted/compressed data.
   139	 *
   140	 * We don't want to make our proposed changes to the pagecache yet as we would
   141	 * have to back them out if an error occurs.
   142	 */
   143	static int netfs_prepare_trunc_buffers(struct netfs_io_request *treq)
   144	{
   145		struct netfs_inode *ctx = netfs_inode(treq->inode);
   146		struct iov_iter iter;
   147		struct folio *folio;
   148		unsigned long long base;
   149		pgoff_t from, to, fto;
   150		size_t offset, seg;
   151		size_t bsize = max_t(size_t, 1UL << ctx->min_bshift, PAGE_SIZE);
   152		int ret;
   153	
   154		/* We want to hold the entire replacement block, but we round that out
   155		 * to a multiple of pages.
   156		 */
   157		base = round_down(treq->trunc_i_size, bsize);
   158		treq->start	= base;
   159		treq->len	= bsize;
   160		treq->first	= base / PAGE_SIZE;
   161		treq->last	= (base + bsize + 1) / PAGE_SIZE;
   162	
   163		ret = netfs_add_folios_to_buffer(&treq->buffer, treq->first, treq->last,
   164						 GFP_KERNEL);
   165		if (ret < 0)
   166			return ret;
   167	
   168		ret = netfs_add_folios_to_buffer(&treq->bounce, treq->first, treq->last,
   169						 GFP_KERNEL);
 > 170		if (ret < 0)
   171			return ret;
   172	
   173		/* We need to fill the buffer. */
   174		iov_iter_xarray(&iter, READ, &treq->buffer, base, base + bsize);
   175		do {
   176			folio = read_mapping_folio(treq->mapping, from, NULL);
   177			if (IS_ERR(folio))
   178				return PTR_ERR(folio);
   179			if (folio->index > from ||
   180			    folio->index + folio_nr_pages(folio) <= folio->index) {
   181				folio_put(folio);
   182				kleave("-EIO [unexpected folio %lx != %lx]", folio->index, from);
   183				return -EIO;
   184			}
   185	
   186			offset = (from - folio->index);
   187			fto = folio->index + folio_nr_pages(folio) - 1;
   188			seg = min(to, fto);
   189			seg = (seg - from) + 1;
   190			kdebug("buf=%lx-%lx fol=%lx-%lx s=%lx@%lx",
   191			       from, to, folio->index, fto, seg, offset);
   192			if (copy_folio_to_iter(folio, offset * PAGE_SIZE, seg * PAGE_SIZE, &iter)) {
   193				folio_put(folio);
   194				kleave(" = -EIO [copy failure]");
   195				return -EIO;
   196			}
   197	
   198			/* We keep the refs to discard later - we don't want read
   199			 * interfering with what we're up to.
   200			 */
   201			from = fto;
 > 202		} while (from < to);
   203	
   204		/* Lock the folios and clear the uptodate flag.  Read must wait. */
   205	
   206		/* Clear the region after the new EOF */
   207		iov_iter_xarray(&iter, READ, &treq->buffer, base, base + bsize);
   208		iov_iter_advance(&iter, treq->trunc_i_size - treq->start);
   209		iov_iter_zero(iov_iter_count(&iter), &iter);
   210		return 0;
   211	}
   212	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
