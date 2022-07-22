Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4357E7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiGVUJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiGVUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:08:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68343AFB69
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658520519; x=1690056519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DwrcezuiQePvR/61szpC2NYNV6mBUjPJJjE6w1E3dd8=;
  b=Vu5L1JZAwfq+NQe1+0zJiV7MJ0Da+3T/DZcshBN9bbUu45sJbP7w4LEz
   GSYDLHS8bYALzMyOBJ3Z9lRsbtzipVGWHeIBkZjgTQc41G2M3cwJeaHHG
   XHsJ5bmRYT9bw6CvHME4jzNB+iF7fwVKuXK9R+0j4zpLe7wug04//pVpj
   QryJ4SXRB+Oh/wXCS//dYBMzdak2K9SrMF+T9xa2rrZMjzDhsbmXiprvE
   cPWYQEwdRUqfP+dk0EjMBrz7nXl9KzG08riROAhtRrL+K4DYOd7PIuC51
   MbJDx5YsIB13LQH5XFMiCfx2tskH1MOjlMukDgki3Okf3iQymSzSHPmNd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="349095878"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="349095878"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 13:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="549290942"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Jul 2022 13:08:37 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEywu-0001nB-1n;
        Fri, 22 Jul 2022 20:08:36 +0000
Date:   Sat, 23 Jul 2022 04:08:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djiang:cxl-security 10/16] arch/x86/include/asm/cacheflush.h:15:9:
 error: implicit declaration of function 'wbinvd_on_all_cpus'
Message-ID: <202207230443.XqQnDddU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git cxl-security
head:   a9e386b59eef5db739f0706d734daa39759dab96
commit: abef64ac4e6fcd42bddc34994ee00ee33b7d6686 [10/16] cxl/pmem: Add "Unlock" security command support
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220723/202207230443.XqQnDddU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=abef64ac4e6fcd42bddc34994ee00ee33b7d6686
        git remote add djiang https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git
        git fetch --no-tags djiang cxl-security
        git checkout abef64ac4e6fcd42bddc34994ee00ee33b7d6686
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/bio.h:10,
                    from include/linux/libnvdimm.h:14,
                    from drivers/cxl/security.c:3:
   drivers/cxl/security.c: In function 'cxl_pmem_security_unlock':
>> arch/x86/include/asm/cacheflush.h:15:9: error: implicit declaration of function 'wbinvd_on_all_cpus' [-Werror=implicit-function-declaration]
      15 |         wbinvd_on_all_cpus();   \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/cxl/security.c:133:9: note: in expansion of macro 'flush_cache_all'
     133 |         flush_cache_all();
         |         ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/wbinvd_on_all_cpus +15 arch/x86/include/asm/cacheflush.h

b2bba72c10cdd9 include/asm-x86/cacheflush.h      Thomas Gleixner 2007-10-15  12  
86257bb97c28b5 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  13  #define flush_cache_all()	\
86257bb97c28b5 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  14  do {				\
86257bb97c28b5 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12 @15  	wbinvd_on_all_cpus();	\
86257bb97c28b5 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  16  } while (0);			\
86257bb97c28b5 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  17  

:::::: The code at line 15 was first introduced by commit
:::::: 86257bb97c28b5c4c183ae2395db09e76fde198a x86: define flush_cache_all as global wbinvd

:::::: TO: Davidlohr Bueso <dave@stgolabs.net>
:::::: CC: Dave Jiang <dave.jiang@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
