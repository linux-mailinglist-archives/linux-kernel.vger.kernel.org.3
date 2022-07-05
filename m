Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E329566FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiGENql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiGENqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:46:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1982E684
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657026713; x=1688562713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VyDdqoWLz4OIVf46KW2WIULFj9OfrfF25dJV8piT9pI=;
  b=FqwlFjkfwnXd7X4Pl//jR2kYbG3ZeWrCseZBuefdWjyvmnasg9ddeTu6
   0K+oLMYJJm3aE/hubogq0VKNuNriOyQQHav1CL1z/oABvH2AHQt7oSJH0
   6HkCoDGFJomz5kE4I6po5Ytlp56MtnT4cF0vcNamNKKE4EkCoZHloAlz4
   E0Lz9cIzuAQnUh+8dXzwuzJvcSnjIPnqjk5ygTvrgC2UFcSyASbRu8cRr
   w7o9kXg7JfZevb8+pNOzy5Jjti0UjqzdSaDN4dJ6203SRRy7RjAdsFp5K
   3nAy1QrPWKiUN93r9/D/LQdix0MacjHQAbql9m46wIX28VCosmSdm15RV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284461771"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="284461771"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 06:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="660552511"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2022 06:11:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8iLF-000J6h-SE;
        Tue, 05 Jul 2022 13:11:49 +0000
Date:   Tue, 5 Jul 2022 21:11:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/sparse.c:653:13: sparse: sparse: symbol 'populate_section_memmap'
 was not declared. Should it be static?
Message-ID: <202207052117.j1h9ayCI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1084b6c5620a743f86947caca66d90f24060f56
commit: e9c0a3f05477e18d2dae816cb61b62be1b7e90d3 mm/sparsemem: convert kmalloc_section_memmap() to populate_section_memmap()
date:   3 years ago
config: ia64-randconfig-s031-20220703 (https://download.01.org/0day-ci/archive/20220705/202207052117.j1h9ayCI-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9c0a3f05477e18d2dae816cb61b62be1b7e90d3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e9c0a3f05477e18d2dae816cb61b62be1b7e90d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/sparse.c:213:6: sparse: sparse: symbol 'subsection_mask_set' was not declared. Should it be static?
>> mm/sparse.c:653:13: sparse: sparse: symbol 'populate_section_memmap' was not declared. Should it be static?

vim +/populate_section_memmap +653 mm/sparse.c

   638	
   639	static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
   640			struct vmem_altmap *altmap)
   641	{
   642		unsigned long start = (unsigned long) pfn_to_page(pfn);
   643		unsigned long end = start + nr_pages * sizeof(struct page);
   644	
   645		vmemmap_free(start, end, altmap);
   646	}
   647	static void free_map_bootmem(struct page *memmap)
   648	{
   649		unsigned long start = (unsigned long)memmap;
   650		unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
   651	
   652		vmemmap_free(start, end, NULL);
 > 653	}
   654	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
