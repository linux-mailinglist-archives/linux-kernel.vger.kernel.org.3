Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912345741D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGNDZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiGNDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:24:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1590E25C58
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657769098; x=1689305098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u6lR+76d80x1IB+UfGQk+tDSVcnyMxJ6+ZS37u89qXI=;
  b=A7Rf2RKGaPNRirhb3IQFM0gVrLZwie3WDA8N3GlNDELDLIBf9HOHF7ZD
   T5j4SjTmcmaG/MfCRzGzlUYZ7tqwgElzUa6KHb6rRYVlYJuTrWzt6f0zs
   hfKHudX8mr5Qgc6H1Zih8UH/x6jKre1Zzm3nSRv7Ae9IFXlzt/hwdQX8I
   rVo1iPamzD72a5SNR6JZSRDbp+/hU6MSmbBH1YsdGmntdxJ89CkM61A1n
   yiI98BOADhsZLFhHiPS4z78Lqn/RIFVbubUxMhCKrkoZlNg4nRseDcHZb
   /gdtUkPXOPaCvE8gFjNkpObOKajrYTCDN+7PBJ8VRDh378Xt+GJCIrW9y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265191697"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265191697"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 20:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="841996015"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2022 20:24:56 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBpTE-00008f-4k;
        Thu, 14 Jul 2022 03:24:56 +0000
Date:   Thu, 14 Jul 2022 11:23:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chunkuang-hu:pagecaller 3/3] mm/vmstat.c:1548:30: warning: unused
 variable 'symbol'
Message-ID: <202207141128.kaFVoGy9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git pagecaller
head:   7b43af7f4b48c1abb6df811dbaa644a0c7800366
commit: 7b43af7f4b48c1abb6df811dbaa644a0c7800366 [3/3] mm: vmstat: add pagecaller information
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220714/202207141128.kaFVoGy9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?id=7b43af7f4b48c1abb6df811dbaa644a0c7800366
        git remote add chunkuang-hu https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git
        git fetch --no-tags chunkuang-hu pagecaller
        git checkout 7b43af7f4b48c1abb6df811dbaa644a0c7800366
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/vmstat.c: In function 'dump_pagecaller':
   mm/vmstat.c:1548:37: error: 'KSYM_SYMBOL_LEN' undeclared (first use in this function)
    1548 |                         char symbol[KSYM_SYMBOL_LEN];
         |                                     ^~~~~~~~~~~~~~~
   mm/vmstat.c:1548:37: note: each undeclared identifier is reported only once for each function it appears in
   mm/vmstat.c:1549:25: error: implicit declaration of function 'kallsyms_lookup' [-Werror=implicit-function-declaration]
    1549 |                         kallsyms_lookup(pagecaller[i], NULL, NULL, NULL, symbol);
         |                         ^~~~~~~~~~~~~~~
>> mm/vmstat.c:1548:30: warning: unused variable 'symbol' [-Wunused-variable]
    1548 |                         char symbol[KSYM_SYMBOL_LEN];
         |                              ^~~~~~
   cc1: some warnings being treated as errors


vim +/symbol +1548 mm/vmstat.c

  1531	
  1532	static void dump_pagecaller(struct seq_file *m)
  1533	{
  1534		unsigned long i;
  1535	
  1536		seq_printf(m, "max_pfn = %lu\n", max_pfn);
  1537		seq_printf(m, "pagecaller_nr = %lu\n", pagecaller_nr);
  1538	
  1539		for (i = 0; i < pagecaller_nr; i++)
  1540			if (pagecaller[i] == 0) {
  1541				seq_printf(m, "0x%016lx %16lu [Free memory]\n",
  1542					   pagecaller[i], pagecaller_cnt[i] * 4);
  1543			} else if (pagecaller[i] == 0xffffffffffffffff) {
  1544				seq_printf(m, "0x%016lx %16lu [Reserved memory]\n",
  1545					   pagecaller[i], pagecaller_cnt[i] * 4);
  1546			} else {
  1547	#ifdef CONFIG_KALLSYMS
> 1548				char symbol[KSYM_SYMBOL_LEN];
  1549				kallsyms_lookup(pagecaller[i], NULL, NULL, NULL, symbol);
  1550				seq_printf(m, "0x%016lx %16lu %s\n", pagecaller[i],
  1551					   pagecaller_cnt[i] * 4, symbol);
  1552	#else
  1553				seq_printf(m, "0x%016lx %16lu\n", pagecaller[i],
  1554					   pagecaller_cnt[i] * 4);
  1555	#endif
  1556			}
  1557	}
  1558	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
