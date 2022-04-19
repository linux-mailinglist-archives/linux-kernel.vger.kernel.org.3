Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC875063EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348634AbiDSFiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348616AbiDSFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:38:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10D1839F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650346529; x=1681882529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=moEDYQi821syybv/L6rBTg7sfIiLoHXLqV+f14vG31Y=;
  b=H4Dqwf3nfj1jIh4W2hviY6TFVZZTET2l0ZAFTDeAUiz7wqyi714ZuUUL
   RyTlsqSHDvHhk7Z7BVRUTzA3WZlEP6nV7MdRrK8F7rC7b4c4ky+Y98oTq
   W/mYC1stNuLJVkkE23C4E/0etZy1NChS2oAQ0rVEY8UsJ2721M+Ygu5AQ
   HtYbwBsnTw6GkbE2hXzATk5WJmRWxmBDvBD/km7q+bFSNs2je2Sez7Cj4
   /QvzRDvm/3Vgv2+YXGgKIqFlYjyXraldwQeY243k6OT3mSh0M+LQEOwpl
   EoMhFjTeKIXdRWTZTSGe5UaiGhvPQG0W7GW57XbbX2D4e17lk2mQgbOrX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324121892"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="324121892"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="510007997"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2022 22:35:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nggWN-0005OS-3u;
        Tue, 19 Apr 2022 05:35:27 +0000
Date:   Tue, 19 Apr 2022 13:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1596/2356] fs/afs/internal.h:1540:25:
 error: 'filemap_dirty_folio' undeclared here (not in a function); did you
 mean 'filemap_get_folio'?
Message-ID: <202204191327.d4qQoDQb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 7e7c34dad109b0245ba45f78111ffae60c364e51 [1596/2356] headers/deps: writeback: Remove the <linux/writeback_api.h> header from <linux/writeback.h>
config: x86_64-randconfig-a006-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191327.d4qQoDQb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7e7c34dad109b0245ba45f78111ffae60c364e51
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 7e7c34dad109b0245ba45f78111ffae60c364e51
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/bus/ drivers/crypto/ fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/afs/file.c:31:
>> fs/afs/internal.h:1540:25: error: 'filemap_dirty_folio' undeclared here (not in a function); did you mean 'filemap_get_folio'?
    1540 | #define afs_dirty_folio filemap_dirty_folio
         |                         ^~~~~~~~~~~~~~~~~~~
   fs/afs/file.c:67:27: note: in expansion of macro 'afs_dirty_folio'
      67 |         .dirty_folio    = afs_dirty_folio,
         |                           ^~~~~~~~~~~~~~~
--
   In file included from fs/ceph/super.c:30:
   fs/ceph/cache.h: In function 'ceph_fscache_dirty_folio':
>> fs/ceph/cache.h:130:16: error: implicit declaration of function 'filemap_dirty_folio'; did you mean 'filemap_get_folio'? [-Werror=implicit-function-declaration]
     130 |         return filemap_dirty_folio(mapping, folio);
         |                ^~~~~~~~~~~~~~~~~~~
         |                filemap_get_folio
   cc1: some warnings being treated as errors
--
>> fs/vboxsf/file.c:365:24: error: 'filemap_dirty_folio' undeclared here (not in a function); did you mean 'filemap_get_folio'?
     365 |         .dirty_folio = filemap_dirty_folio,
         |                        ^~~~~~~~~~~~~~~~~~~
         |                        filemap_get_folio


vim +1540 fs/afs/internal.h

08e0e7c82eeade David Howells           2007-04-26  1533  
31143d5d515ece David Howells           2007-05-09  1534  /*
31143d5d515ece David Howells           2007-05-09  1535   * write.c
31143d5d515ece David Howells           2007-05-09  1536   */
c7f75ef33b6dcd David Howells           2020-02-06  1537  #ifdef CONFIG_AFS_FSCACHE
8fb72b4a76933a Matthew Wilcox (Oracle  2022-02-09  1538) bool afs_dirty_folio(struct address_space *, struct folio *);
c7f75ef33b6dcd David Howells           2020-02-06  1539  #else
8fb72b4a76933a Matthew Wilcox (Oracle  2022-02-09 @1540) #define afs_dirty_folio filemap_dirty_folio
c7f75ef33b6dcd David Howells           2020-02-06  1541  #endif
15b4650e55e06d Nicholas Piggin         2008-10-15  1542  extern int afs_write_begin(struct file *file, struct address_space *mapping,
15b4650e55e06d Nicholas Piggin         2008-10-15  1543  			loff_t pos, unsigned len, unsigned flags,
15b4650e55e06d Nicholas Piggin         2008-10-15  1544  			struct page **pagep, void **fsdata);
15b4650e55e06d Nicholas Piggin         2008-10-15  1545  extern int afs_write_end(struct file *file, struct address_space *mapping,
15b4650e55e06d Nicholas Piggin         2008-10-15  1546  			loff_t pos, unsigned len, unsigned copied,
15b4650e55e06d Nicholas Piggin         2008-10-15  1547  			struct page *page, void *fsdata);
31143d5d515ece David Howells           2007-05-09  1548  extern int afs_writepage(struct page *, struct writeback_control *);
31143d5d515ece David Howells           2007-05-09  1549  extern int afs_writepages(struct address_space *, struct writeback_control *);
50b5551d1719c8 Al Viro                 2014-04-03  1550  extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
02c24a82187d5a Josef Bacik             2011-07-16  1551  extern int afs_fsync(struct file *, loff_t, loff_t, int);
0722f186205976 Souptick Joarder        2018-08-23  1552  extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
4343d00872e1de David Howells           2017-11-02  1553  extern void afs_prune_wb_keys(struct afs_vnode *);
a42442dd736941 Matthew Wilcox (Oracle  2022-02-09  1554) int afs_launder_folio(struct folio *);
31143d5d515ece David Howells           2007-05-09  1555  

:::::: The code at line 1540 was first introduced by commit
:::::: 8fb72b4a76933ae6f86725cc8e4a8190ba84d755 fscache: Convert fscache_set_page_dirty() to fscache_dirty_folio()

:::::: TO: Matthew Wilcox (Oracle) <willy@infradead.org>
:::::: CC: Matthew Wilcox (Oracle) <willy@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
