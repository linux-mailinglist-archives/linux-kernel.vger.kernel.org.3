Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F14BAA18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiBQTrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:47:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244843AbiBQTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:47:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E42654B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127224; x=1676663224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xv6pcA5dxgACBVYnbVuiAe1cTKMxE6gTqfXo+UBD0dU=;
  b=cjghv1UqOHj9b/c8IQKFwTrGt1rSDffBHykMioDCgcv03iOq3pmWJ5IO
   KR/ONm2/m6MzRU/QZMdn4WmY6+EdstnPDNADHyPASyTKuwmo04rJaCUZg
   ByH6Ic0Q+IWYK9BA+rizmT4peAuw4I63ccbO/msKkKlk+TOPOxTnWKbzR
   DmoRjWGnrCDaH/3Tf3Wjb+tzGdX+icYrGZyNT+FcaOUqw3t3iW7rB7LtS
   dAepnnPiTtACDpEXUSFuQ36YU7RQvcsqzto2avQP79SC/QSUEZokTKCXc
   vo90AnfVKCJzTWXLymHa/nIvT8boOYKuUqC1b2JE+31RE7cI1wzNjCA5Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="337404433"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="337404433"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="605157230"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2022 11:47:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmk1-0000Ty-3I; Thu, 17 Feb 2022 19:47:01 +0000
Date:   Fri, 18 Feb 2022 03:46:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 237/343] arch/powerpc/mm/book3s64/pgtable.c:540:15:
 warning: no previous prototype for 'memremap_compat_align'
Message-ID: <202202172347.lJ6oYVOE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   8857950589bc3b4920d69c3e0b2c06d33f445d21
commit: 236e08e72c118cbb20e780cc853378e2c341825c [237/343] mm: don't include <linux/memremap.h> in <linux/mm.h>
config: powerpc64-randconfig-m031-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172347.lJ6oYVOE-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/236e08e72c118cbb20e780cc853378e2c341825c
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 236e08e72c118cbb20e780cc853378e2c341825c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/book3s64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/mm/book3s64/pgtable.c:540:15: warning: no previous prototype for 'memremap_compat_align' [-Wmissing-prototypes]
     540 | unsigned long memremap_compat_align(void)
         |               ^~~~~~~~~~~~~~~~~~~~~


vim +/memremap_compat_align +540 arch/powerpc/mm/book3s64/pgtable.c

20626177c9de72 Nicholas Piggin 2021-12-02  531  
387e220a2e5e63 Nicholas Piggin 2021-12-02  532  #if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_HAS_MEMREMAP_COMPAT_ALIGN)
20626177c9de72 Nicholas Piggin 2021-12-02  533  /*
20626177c9de72 Nicholas Piggin 2021-12-02  534   * Override the generic version in mm/memremap.c.
20626177c9de72 Nicholas Piggin 2021-12-02  535   *
20626177c9de72 Nicholas Piggin 2021-12-02  536   * With hash translation, the direct-map range is mapped with just one
20626177c9de72 Nicholas Piggin 2021-12-02  537   * page size selected by htab_init_page_sizes(). Consult
20626177c9de72 Nicholas Piggin 2021-12-02  538   * mmu_psize_defs[] to determine the minimum page size alignment.
20626177c9de72 Nicholas Piggin 2021-12-02  539  */
20626177c9de72 Nicholas Piggin 2021-12-02 @540  unsigned long memremap_compat_align(void)

:::::: The code at line 540 was first introduced by commit
:::::: 20626177c9de726c48802c15e8635cc154645588 powerpc: make memremap_compat_align 64s-only

:::::: TO: Nicholas Piggin <npiggin@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
