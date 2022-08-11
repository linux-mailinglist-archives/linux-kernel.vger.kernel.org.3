Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3708458F63E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiHKDDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiHKDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:02:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D189915
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660186879; x=1691722879;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dUFZ2TF0jqs21nzGIjniypmxxoqhDNsINmf0i9qYRWM=;
  b=KuyMK8lKROfMMZafUK/00YobmO7gokQvBWvXQ44g1yb8iWaKFwlCbCGN
   QycBTkwaF7KdtBsdCBtgX68jPQe7sYYnEBLMR8LwuzO84O1G6Uiqej8ns
   1FtTLFWPpdC3y7F3MALtjqd19NxJvdnKgOnf54IbWDOty/R8Av4ervoGb
   k4m+zkSpxzpw7p2W8qzUUs/sTgZqOqqbRfxBMvn1DWt213sI6jiDj0C6b
   Jvlo3NqFgqtMLo56BHEgrexCpDdV8mxMZw69FO+hN9QHJcGndsk5x7NDA
   nvTSbHVT1OkeQiCs3Garbc7sBltqNiyyBpfgQvI/xpztjLWEqwPcTq9qt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="355246609"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="355246609"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 20:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="747656086"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2022 20:01:17 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLyRg-00011G-2W;
        Thu, 11 Aug 2022 03:01:16 +0000
Date:   Thu, 11 Aug 2022 11:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djiang:cxl-security 10/18] arch/x86/include/asm/cacheflush.h:15:9:
 error: implicit declaration of function 'wbinvd_on_all_cpus'
Message-ID: <202208111011.CGpGPHmA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git cxl-security
head:   6dfac91d7af3a05b518c7063b10fe5e86cc96412
commit: be69ae055fb2ad4a855deab9a535f62450af7ba3 [10/18] cxl/pmem: Add "Unlock" security command support
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220811/202208111011.CGpGPHmA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=be69ae055fb2ad4a855deab9a535f62450af7ba3
        git remote add djiang https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git
        git fetch --no-tags djiang cxl-security
        git checkout be69ae055fb2ad4a855deab9a535f62450af7ba3
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
   drivers/cxl/security.c:123:9: note: in expansion of macro 'flush_cache_all'
     123 |         flush_cache_all();
         |         ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/wbinvd_on_all_cpus +15 arch/x86/include/asm/cacheflush.h

b2bba72c10cdd90 include/asm-x86/cacheflush.h      Thomas Gleixner 2007-10-15  12  
647bce130827c98 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  13  #define flush_cache_all()	\
647bce130827c98 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  14  do {				\
647bce130827c98 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12 @15  	wbinvd_on_all_cpus();	\
647bce130827c98 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  16  } while (0);			\
647bce130827c98 arch/x86/include/asm/cacheflush.h Davidlohr Bueso 2022-07-12  17  

:::::: The code at line 15 was first introduced by commit
:::::: 647bce130827c98324f56ab35d377978e7262c57 x86: define flush_cache_all as global wbinvd

:::::: TO: Davidlohr Bueso <dave@stgolabs.net>
:::::: CC: Dave Jiang <dave.jiang@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
