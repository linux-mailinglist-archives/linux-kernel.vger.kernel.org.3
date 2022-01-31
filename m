Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89014A4453
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378236AbiAaL2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:28:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:12918 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378216AbiAaLTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643627992; x=1675163992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5JrPttF53yk0cR8vMW+WeMw6didWDvy3oIQC4TtgCQ=;
  b=EYL1NDwm6+h6vObUZ+hF/B1OSGayeICsP4Hs5WR/K646rnTyN01HJOFs
   JJOuYa6sA1KqWvfFGtj8ApoTblIvN1VM42jtJ386a/jRsR7Yc5o9sbqvz
   LlW2rimU9QlI/BmJPNUjNJV0QczMNk1/ucGGP61zoXOud/ws85OT1e3Gm
   dREg1TR0QweuvRAoWHMQXAo4m9tXdrlKFjMB8WsL4LjYrrECN0MosOqJu
   p6cZwBS8XjI7ONMu2NDe56zZS/g0IkhWNsigC8U92a0hAtQVMmqC6JnYP
   c2M158f0Y4Yk5oZMTJT6k3dDSCZyWFBuFCeCZJ5tf15oHl9OKiGQD5Vpb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="227411272"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="227411272"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="619350847"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2022 03:16:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEUfV-000Rpa-9J; Mon, 31 Jan 2022 11:16:21 +0000
Date:   Mon, 31 Jan 2022 19:16:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Nguyen Dinh Phi <phind.uet@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: make a couple of functions static
Message-ID: <202201311901.HT4PtVja-lkp@intel.com>
References: <20220131071006.1764343-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131071006.1764343-1-phind.uet@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nguyen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Nguyen-Dinh-Phi/staging-vc04_services-make-a-couple-of-functions-static/20220131-151209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 64b2d6ffff862c0e7278198b4229e42e1abb3bb1
config: arm-randconfig-r002-20220130 (https://download.01.org/0day-ci/archive/20220131/202201311901.HT4PtVja-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1b64825a2b5b3312ae309c1714239df049b018ac
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nguyen-Dinh-Phi/staging-vc04_services-make-a-couple-of-functions-static/20220131-151209
        git checkout 1b64825a2b5b3312ae309c1714239df049b018ac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/staging/vc04_services/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function 'free_pagelist':
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:434:25: warning: argument 2 null where non-null expected [-Wnonnull]
     434 |                         memcpy((char *)kmap(pages[0]) +
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     435 |                                 pagelist->offset,
         |                                 ~~~~~~~~~~~~~~~~~
     436 |                                 fragments,
         |                                 ~~~~~~~~~~
     437 |                                 head_bytes);
         |                                 ~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
   arch/arm/include/asm/string.h:20:15: note: in a call to function 'memcpy' declared 'nonnull'
      20 | extern void * memcpy(void *, const void *, __kernel_size_t);
         |               ^~~~~~


vim +434 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c

7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  398  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  399  static void
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  400  free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  401  	      int actual)
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  402  {
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  403  	struct pagelist *pagelist = pagelistinfo->pagelist;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  404  	struct page **pages = pagelistinfo->pages;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  405  	unsigned int num_pages = pagelistinfo->num_pages;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  406  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  407  	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK, %d",
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  408  			__func__, pagelistinfo->pagelist, actual);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  409  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  410  	/*
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  411  	 * NOTE: dma_unmap_sg must be called before the
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  412  	 * cpu can touch any of the data/pages.
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  413  	 */
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  414  	dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  415  		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  416  	pagelistinfo->scatterlist_mapped = 0;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  417  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  418  	/* Deal with any partial cache lines (fragments) */
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  419  	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS) {
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  420  		char *fragments = g_fragments_base +
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  421  			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  422  			g_fragments_size;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  423  		int head_bytes, tail_bytes;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  424  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  425  		head_bytes = (g_cache_line_size - pagelist->offset) &
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  426  			(g_cache_line_size - 1);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  427  		tail_bytes = (pagelist->offset + actual) &
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  428  			(g_cache_line_size - 1);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  429  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  430  		if ((actual >= 0) && (head_bytes != 0)) {
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  431  			if (head_bytes > actual)
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  432  				head_bytes = actual;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  433  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21 @434  			memcpy((char *)kmap(pages[0]) +
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  435  				pagelist->offset,
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  436  				fragments,
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  437  				head_bytes);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  438  			kunmap(pages[0]);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  439  		}
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  440  		if ((actual >= 0) && (head_bytes < actual) &&
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  441  		    (tail_bytes != 0)) {
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  442  			memcpy((char *)kmap(pages[num_pages - 1]) +
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  443  				((pagelist->offset + actual) &
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  444  				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  445  				fragments + g_cache_line_size,
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  446  				tail_bytes);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  447  			kunmap(pages[num_pages - 1]);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  448  		}
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  449  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  450  		down(&g_free_fragments_mutex);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  451  		*(char **)fragments = g_free_fragments;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  452  		g_free_fragments = fragments;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  453  		up(&g_free_fragments_mutex);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  454  		up(&g_free_fragments_sema);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  455  	}
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  456  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  457  	/* Need to mark all the pages dirty. */
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  458  	if (pagelist->type != PAGELIST_WRITE &&
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  459  	    pagelistinfo->pages_need_release) {
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  460  		unsigned int i;
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  461  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  462  		for (i = 0; i < num_pages; i++)
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  463  			set_page_dirty(pages[i]);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  464  	}
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  465  
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  466  	cleanup_pagelistinfo(pagelistinfo);
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  467  }
7b9148dcb74a00 Ojaswin Mujoo 2021-07-21  468  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
