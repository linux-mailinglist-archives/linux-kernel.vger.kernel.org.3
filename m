Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFC561FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiF3QCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiF3QCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:02:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E438BD5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656604924; x=1688140924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=haMnF6yagbAO7UNiHiEeFD6q+diMkTPVk3w5GTGVIvs=;
  b=K+DL4O8L3tUlOXX+vHxUW6RsM6oAK56P5y4Nz0Is7pyfpPLHAD4gfyF7
   gWHXH2lx1ol5qhOs1UIncA61HCj0HbFh3GtMMSbMK+DgZg4Fh24IoMln8
   c6C3ov+Gq3e3rerznt62RlWY5k+efTK/tciVuWSYTa/WfdrPeqbzg0q+a
   Ys+0wV3rIVUxwVmNpncHfk5DhA3E2f+JGMIJRDARH394GoWdU2hGA5G59
   isgnnw7Rmtz9fcerY5DNs53+Ks4+h6x99DLOiBFSxMfcoWeJo/TqT0bX9
   jyMR6j+zlBYKcCObncvx5ZEvgLlcEEhZamsDrg5C+w0hFs8yey3VLhzId
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262791016"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262791016"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 09:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="918103001"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 09:01:59 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6wcA-000CwM-Vq;
        Thu, 30 Jun 2022 16:01:58 +0000
Date:   Fri, 1 Jul 2022 00:01:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 55/55]
 fs/netfs/truncate.c:191:39: warning: format specifies type 'unsigned long'
 but the argument has type 'size_t' (aka 'unsigned int')
Message-ID: <202206302322.xyUBUa80-lkp@intel.com>
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
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220630/202206302322.xyUBUa80-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/truncate.c:191:39: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                          from, to, folio->index, fto, seg, offset);
                                                       ^~~
   fs/netfs/internal.h:282:43: note: expanded from macro 'kdebug'
   #define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
                                      ~~~    ^~~~~~~~~~~
   fs/netfs/internal.h:278:46: note: expanded from macro 'dbgprintk'
           printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
                             ~~~                       ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/netfs/truncate.c:191:44: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                          from, to, folio->index, fto, seg, offset);
                                                            ^~~~~~
   fs/netfs/internal.h:282:43: note: expanded from macro 'kdebug'
   #define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
                                      ~~~    ^~~~~~~~~~~
   fs/netfs/internal.h:278:46: note: expanded from macro 'dbgprintk'
           printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
                             ~~~                       ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/netfs/truncate.c:202:18: warning: variable 'to' is uninitialized when used here [-Wuninitialized]
           } while (from < to);
                           ^~
   fs/netfs/truncate.c:149:18: note: initialize the variable 'to' to silence this warning
           pgoff_t from, to, fto;
                           ^
                            = 0
   fs/netfs/truncate.c:170:6: warning: variable 'from' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
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
   4 warnings generated.


vim +191 fs/netfs/truncate.c

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
   170		if (ret < 0)
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
 > 191			       from, to, folio->index, fto, seg, offset);
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
   202		} while (from < to);
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
