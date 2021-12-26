Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC847F852
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhLZQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 11:54:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:1088 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhLZQy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 11:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640537697; x=1672073697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1YNIGshGtHHnN4HiOmEkAs1ZFUSxiN1gFX5ws+wPBE8=;
  b=RiXZxvtMXEfKVUPU9DNuIgI+YiWJilVDw2TmPZwel70dnah+WBjiK4Pg
   84wawk1zUlU2NKF6fIGcQWTEqvSQZmPC8XeD+jpvMRI0KQnyF7gm/u745
   6ywNVfIlU7+pO6VArq0zvWk74O4vOJ+rcYDUdHmiLHtVEoyUGpHA69YDO
   wd2Ht3N5TjeNLXvnjj5XCyB1hxfgMTbNrhbLp02D93ZXKcXyX7aRxEOyH
   QHlpcUXe3NRN6AkDZdaeqI9qC8vcgFb3kxSi6aOor37RTwo3p68U51uuc
   AtTa5BqYAERgpZEXVEVCMvKPRgrIG5tgfJvxUI/KucLpcnzbzETXm5IAL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="238657564"
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; 
   d="scan'208";a="238657564"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 08:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; 
   d="scan'208";a="469512187"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Dec 2021 08:54:54 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1WnO-0005aD-3P; Sun, 26 Dec 2021 16:54:54 +0000
Date:   Mon, 27 Dec 2021 00:54:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/compaction.c:463:20: warning: unused function 'isolation_suitable'
Message-ID: <202112270015.F1tSBi9z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   438645193e59e91761ccb3fa55f6ce70b615ff93
commit: 9df41314390b81a541ca6e84c8340bad0959e4b5 mm/compaction: do page isolation first in compaction
date:   1 year ago
config: mips-randconfig-c004-20211226 (https://download.01.org/0day-ci/archive/20211227/202112270015.F1tSBi9z-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project a9e8b1ee7fd44b53c555a7823ae8fd1a8209c520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9df41314390b81a541ca6e84c8340bad0959e4b5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9df41314390b81a541ca6e84c8340bad0959e4b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/compaction.c:56:27: warning: unused variable 'HPAGE_FRAG_CHECK_INTERVAL_MSEC'
   static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
   ^
>> mm/compaction.c:463:20: warning: unused function 'isolation_suitable'
   static inline bool isolation_suitable(struct compact_control
   ^
>> mm/compaction.c:469:20: warning: unused function 'pageblock_skip_persistent'
   static inline bool pageblock_skip_persistent(struct page
   ^
>> mm/compaction.c:474:20: warning: unused function 'update_pageblock_skip'
   static inline void update_pageblock_skip(struct compact_control
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set noat
   .set push
   .set arch=r4000
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $2 # __cmpxchg_asm
   bne $0, ${3:z}, 2f
   .set pop
   move $$1, ${4:z}
   .set arch=r4000
   sc $$1, $1
   beqz $$1, 1b
   .set pop
   2: .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 0c553cc1af2e4c14100df6cf4a6fc91987e778e6)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-0c553cc1af/bin
   clang-14: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net scripts security sound source usr virt


vim +/isolation_suitable +463 mm/compaction.c

e380bebe477154 Mel Gorman      2019-03-05  440  
bb13ffeb9f6bfe Mel Gorman      2012-10-08  441  /*
bb13ffeb9f6bfe Mel Gorman      2012-10-08  442   * If no pages were isolated then mark this pageblock to be skipped in the
62997027ca5b3d Mel Gorman      2012-10-08  443   * future. The information is later cleared by __reset_isolation_suitable().
bb13ffeb9f6bfe Mel Gorman      2012-10-08  444   */
c89511ab2f8fe2 Mel Gorman      2012-10-08  445  static void update_pageblock_skip(struct compact_control *cc,
d097a6f6352254 Mel Gorman      2019-03-05  446  			struct page *page, unsigned long pfn)
bb13ffeb9f6bfe Mel Gorman      2012-10-08  447  {
c89511ab2f8fe2 Mel Gorman      2012-10-08  448  	struct zone *zone = cc->zone;
6815bf3f233e0b Joonsoo Kim     2013-12-18  449  
2583d6713267a4 Vlastimil Babka 2017-11-17  450  	if (cc->no_set_skip_hint)
6815bf3f233e0b Joonsoo Kim     2013-12-18  451  		return;
6815bf3f233e0b Joonsoo Kim     2013-12-18  452  
bb13ffeb9f6bfe Mel Gorman      2012-10-08  453  	if (!page)
bb13ffeb9f6bfe Mel Gorman      2012-10-08  454  		return;
bb13ffeb9f6bfe Mel Gorman      2012-10-08  455  
bb13ffeb9f6bfe Mel Gorman      2012-10-08  456  	set_pageblock_skip(page);
c89511ab2f8fe2 Mel Gorman      2012-10-08  457  
35979ef3393110 David Rientjes  2014-06-04  458  	/* Update where async and sync compaction should restart */
35979ef3393110 David Rientjes  2014-06-04  459  	if (pfn < zone->compact_cached_free_pfn)
c89511ab2f8fe2 Mel Gorman      2012-10-08  460  		zone->compact_cached_free_pfn = pfn;
c89511ab2f8fe2 Mel Gorman      2012-10-08  461  }
bb13ffeb9f6bfe Mel Gorman      2012-10-08  462  #else
bb13ffeb9f6bfe Mel Gorman      2012-10-08 @463  static inline bool isolation_suitable(struct compact_control *cc,
bb13ffeb9f6bfe Mel Gorman      2012-10-08  464  					struct page *page)
bb13ffeb9f6bfe Mel Gorman      2012-10-08  465  {
bb13ffeb9f6bfe Mel Gorman      2012-10-08  466  	return true;
bb13ffeb9f6bfe Mel Gorman      2012-10-08  467  }
bb13ffeb9f6bfe Mel Gorman      2012-10-08  468  
b527cfe5bc2320 Vlastimil Babka 2017-11-17 @469  static inline bool pageblock_skip_persistent(struct page *page)
21dc7e023611fb David Rientjes  2017-11-17  470  {
21dc7e023611fb David Rientjes  2017-11-17  471  	return false;
21dc7e023611fb David Rientjes  2017-11-17  472  }
21dc7e023611fb David Rientjes  2017-11-17  473  
21dc7e023611fb David Rientjes  2017-11-17 @474  static inline void update_pageblock_skip(struct compact_control *cc,
d097a6f6352254 Mel Gorman      2019-03-05  475  			struct page *page, unsigned long pfn)
e380bebe477154 Mel Gorman      2019-03-05  476  {
e380bebe477154 Mel Gorman      2019-03-05  477  }
e380bebe477154 Mel Gorman      2019-03-05  478  

:::::: The code at line 463 was first introduced by commit
:::::: bb13ffeb9f6bfeb301443994dfbf29f91117dfb3 mm: compaction: cache if a pageblock was scanned and no pages were isolated

:::::: TO: Mel Gorman <mgorman@suse.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
