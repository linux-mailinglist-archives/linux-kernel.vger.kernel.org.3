Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD552B1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiERFD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiERFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:03:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14354D9F0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652850200; x=1684386200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7DuxE0WCUtxO+T4rCB3adYXiuDDXl1rbvd8WQ47eyFQ=;
  b=kersee+6iKXb+ecjUB2VITTzhe5Mg6uDYUnhdr1ERgT0IOTZOL1IYjWE
   YUIYcivlUzVIhPVycobz1XXXvHH7PEDMBpFuIrly70MKT/ZTEHjoFNPgR
   88rBDojihFmSrM5e4nBQ/sLJy8GJmKGMi51aBSwytjxljDKAZz1ofgJd8
   wDJUtPT/R2mBbn820SeRlwhktQxLZ7qX6yEpsZEzBP1fJi3F31Zsz9NKO
   VSjF2055t9kFvClSPNV9skXGmBNdD5sjS2JF9otuICcKyftTcry6phpLo
   dNsx3DA+NOUDm6xBKjsO6txcp89KbtJ+3YevP7PYy+VRUhpmf7ePwHaz2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332098887"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="332098887"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 22:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="700422997"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 22:03:19 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrBqA-0001oV-DT;
        Wed, 18 May 2022 05:03:18 +0000
Date:   Wed, 18 May 2022 13:03:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-netfs-llist 47/51] fs/netfs/buffered_read.c:51:41:
 warning: variable 'caching' set but not used
Message-ID: <202205181302.jLGZzh6l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-netfs-llist
head:   33ef80e1351d57c7496e3dfb6974767f4493dd91
commit: 9d12233e09a18b8beb5206a8a2a4b67e8dcc1163 [47/51] netfs: don't mark destination pages dirty after read op
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220518/202205181302.jLGZzh6l-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=9d12233e09a18b8beb5206a8a2a4b67e8dcc1163
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-netfs-llist
        git checkout 9d12233e09a18b8beb5206a8a2a4b67e8dcc1163
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/netfs/buffered_read.c: In function 'netfs_rreq_unlock_folios':
>> fs/netfs/buffered_read.c:51:41: warning: variable 'caching' set but not used [-Wunused-but-set-variable]
      51 |                 bool pg_failed = false, caching = false;
         |                                         ^~~~~~~


vim +/caching +51 fs/netfs/buffered_read.c

16211268fcb366 David Howells 2022-03-01  11  
16211268fcb366 David Howells 2022-03-01  12  /*
16211268fcb366 David Howells 2022-03-01  13   * Unlock the folios in a read operation.  We need to set PG_fscache on any
16211268fcb366 David Howells 2022-03-01  14   * folios we're going to write back before we unlock them.
16211268fcb366 David Howells 2022-03-01  15   */
16211268fcb366 David Howells 2022-03-01  16  void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
16211268fcb366 David Howells 2022-03-01  17  {
16211268fcb366 David Howells 2022-03-01  18  	struct netfs_io_subrequest *subreq;
16211268fcb366 David Howells 2022-03-01  19  	struct folio *folio;
16211268fcb366 David Howells 2022-03-01  20  	unsigned int iopos, account = 0;
16211268fcb366 David Howells 2022-03-01  21  	pgoff_t start_page = rreq->start / PAGE_SIZE;
16211268fcb366 David Howells 2022-03-01  22  	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
16211268fcb366 David Howells 2022-03-01  23  	bool subreq_failed = false;
16211268fcb366 David Howells 2022-03-01  24  
16211268fcb366 David Howells 2022-03-01  25  	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
16211268fcb366 David Howells 2022-03-01  26  
16211268fcb366 David Howells 2022-03-01  27  	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
16211268fcb366 David Howells 2022-03-01  28  		__clear_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
16211268fcb366 David Howells 2022-03-01  29  		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
16211268fcb366 David Howells 2022-03-01  30  			__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
16211268fcb366 David Howells 2022-03-01  31  		}
16211268fcb366 David Howells 2022-03-01  32  	}
16211268fcb366 David Howells 2022-03-01  33  
16211268fcb366 David Howells 2022-03-01  34  	/* Walk through the pagecache and the I/O request lists simultaneously.
16211268fcb366 David Howells 2022-03-01  35  	 * We may have a mixture of cached and uncached sections and we only
16211268fcb366 David Howells 2022-03-01  36  	 * really want to write out the uncached sections.  This is slightly
16211268fcb366 David Howells 2022-03-01  37  	 * complicated by the possibility that we might have huge pages with a
16211268fcb366 David Howells 2022-03-01  38  	 * mixture inside.
16211268fcb366 David Howells 2022-03-01  39  	 */
16211268fcb366 David Howells 2022-03-01  40  	subreq = list_first_entry(&rreq->subrequests,
16211268fcb366 David Howells 2022-03-01  41  				  struct netfs_io_subrequest, rreq_link);
16211268fcb366 David Howells 2022-03-01  42  	iopos = 0;
16211268fcb366 David Howells 2022-03-01  43  	subreq_failed = (subreq->error < 0);
16211268fcb366 David Howells 2022-03-01  44  
16211268fcb366 David Howells 2022-03-01  45  	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
16211268fcb366 David Howells 2022-03-01  46  
16211268fcb366 David Howells 2022-03-01  47  	rcu_read_lock();
16211268fcb366 David Howells 2022-03-01  48  	xas_for_each(&xas, folio, last_page) {
16211268fcb366 David Howells 2022-03-01  49  		unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
16211268fcb366 David Howells 2022-03-01  50  		unsigned int pgend = pgpos + folio_size(folio);
6a2bc74cfa2f46 David Howells 2021-07-07 @51  		bool pg_failed = false, caching = false;
16211268fcb366 David Howells 2022-03-01  52  
16211268fcb366 David Howells 2022-03-01  53  		for (;;) {
16211268fcb366 David Howells 2022-03-01  54  			if (!subreq) {
16211268fcb366 David Howells 2022-03-01  55  				pg_failed = true;
16211268fcb366 David Howells 2022-03-01  56  				break;
16211268fcb366 David Howells 2022-03-01  57  			}
6a2bc74cfa2f46 David Howells 2021-07-07  58  			caching = test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
16211268fcb366 David Howells 2022-03-01  59  			pg_failed |= subreq_failed;
16211268fcb366 David Howells 2022-03-01  60  			if (pgend < iopos + subreq->len)
16211268fcb366 David Howells 2022-03-01  61  				break;
16211268fcb366 David Howells 2022-03-01  62  
16211268fcb366 David Howells 2022-03-01  63  			account += subreq->transferred;
16211268fcb366 David Howells 2022-03-01  64  			iopos += subreq->len;
16211268fcb366 David Howells 2022-03-01  65  			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
16211268fcb366 David Howells 2022-03-01  66  				subreq = list_next_entry(subreq, rreq_link);
16211268fcb366 David Howells 2022-03-01  67  				subreq_failed = (subreq->error < 0);
16211268fcb366 David Howells 2022-03-01  68  			} else {
16211268fcb366 David Howells 2022-03-01  69  				subreq = NULL;
16211268fcb366 David Howells 2022-03-01  70  				subreq_failed = false;
16211268fcb366 David Howells 2022-03-01  71  			}
16211268fcb366 David Howells 2022-03-01  72  			if (pgend == iopos)
16211268fcb366 David Howells 2022-03-01  73  				break;
16211268fcb366 David Howells 2022-03-01  74  		}
16211268fcb366 David Howells 2022-03-01  75  
16211268fcb366 David Howells 2022-03-01  76  		if (!pg_failed) {
16211268fcb366 David Howells 2022-03-01  77  			flush_dcache_folio(folio);
16211268fcb366 David Howells 2022-03-01  78  			folio_mark_uptodate(folio);
9d12233e09a18b Jeff Layton   2022-05-17  79  #if 0
6a2bc74cfa2f46 David Howells 2021-07-07  80  			if (caching)
6a2bc74cfa2f46 David Howells 2021-07-07  81  				folio_mark_dirty(folio);
9d12233e09a18b Jeff Layton   2022-05-17  82  #endif
16211268fcb366 David Howells 2022-03-01  83  		}
16211268fcb366 David Howells 2022-03-01  84  
16211268fcb366 David Howells 2022-03-01  85  		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
16211268fcb366 David Howells 2022-03-01  86  			if (folio_index(folio) == rreq->no_unlock_folio &&
16211268fcb366 David Howells 2022-03-01  87  			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
16211268fcb366 David Howells 2022-03-01  88  				_debug("no unlock");
16211268fcb366 David Howells 2022-03-01  89  			else
16211268fcb366 David Howells 2022-03-01  90  				folio_unlock(folio);
16211268fcb366 David Howells 2022-03-01  91  		}
16211268fcb366 David Howells 2022-03-01  92  	}
16211268fcb366 David Howells 2022-03-01  93  	rcu_read_unlock();
16211268fcb366 David Howells 2022-03-01  94  
16211268fcb366 David Howells 2022-03-01  95  	task_io_account_read(account);
16211268fcb366 David Howells 2022-03-01  96  	if (rreq->netfs_ops->done)
16211268fcb366 David Howells 2022-03-01  97  		rreq->netfs_ops->done(rreq);
16211268fcb366 David Howells 2022-03-01  98  }
16211268fcb366 David Howells 2022-03-01  99  

:::::: The code at line 51 was first introduced by commit
:::::: 6a2bc74cfa2f46d146438e369ae93ba2bc25a714 netfs: Do copy-to-cache-on-read through VM writeback

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: Jeff Layton <jlayton@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
