Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6F46E555
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhLIJSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:18:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:31968 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhLIJSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639041319; x=1670577319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4lv+KKRGqMdfqQoS+EObqydcLgYEnYODWadSEAktKow=;
  b=nuHWiEdPw6UyYRQowbak73A3JXnf121BMWagLxh17iv8tMDtf3TgDED1
   a988j6YAiKlSvr2XqxqBoSD5CxU2xAsw0bIzNMh9eXy1tfulKfZPA+qPj
   rlkMKvBF2XvcqLlKagrsyQ/wW93k6xJSookuhIlD9HdBVTMlus9nnZ/Ou
   BykRYzAkmJwAOe4zt8g/V/cZreAuNjZKaxmboGsWTP9PwTIYOfB55mSpp
   RdX2luXgNU17CV4e75qOpHgwfsm2og9QX9jM7iO2HEBaxDMS5Dh8qdjJy
   08VPQHoqpMuU1/ILkHYpDnrQ+rjmQ2dSIODra0YoebEtfwzXwIPRCw3yK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237859573"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="237859573"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 01:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="480268801"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2021 01:15:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvFWG-0001iX-56; Thu, 09 Dec 2021 09:15:16 +0000
Date:   Thu, 9 Dec 2021 17:15:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [willy-pagecache:for-next 46/48] mm/shmem.c:154:5: warning: no
 previous prototype for 'shmem_get_folio'
Message-ID: <202112091729.kMRPshvJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   9244dddc51b5e46444a334c881372aa66138f74a
commit: 1be265f951d0eefea0f8a2aafef4dd18d8ad2719 [46/48] truncate,shmem: Handle truncates that split large folios
config: arc-randconfig-r043-20211207 (https://download.01.org/0day-ci/archive/20211209/202112091729.kMRPshvJ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 1be265f951d0eefea0f8a2aafef4dd18d8ad2719
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/shmem.c:154:5: warning: no previous prototype for 'shmem_get_folio' [-Wmissing-prototypes]
     154 | int shmem_get_folio(struct inode *inode, pgoff_t index,
         |     ^~~~~~~~~~~~~~~
   In file included from include/linux/perf_event.h:25,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from mm/shmem.c:75:
   arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                           ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~


vim +/shmem_get_folio +154 mm/shmem.c

   153	
 > 154	int shmem_get_folio(struct inode *inode, pgoff_t index,
   155			struct folio **foliop, enum sgp_type sgp)
   156	{
   157		struct page *page = NULL;
   158		int ret = shmem_getpage(inode, index, &page, sgp);
   159	
   160		if (page)
   161			*foliop = page_folio(page);
   162		else
   163			*foliop = NULL;
   164		return ret;
   165	}
   166	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
