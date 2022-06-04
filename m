Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827ED53D720
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiFDN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiFDN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:56:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B952650E33
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654351001; x=1685887001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IBULINJaGy6M9HxKHXNr6wkab0MKcoPGV6i+u2nC4Zo=;
  b=T+IVE3bTEFtiVwVriPSWC0M932ZaKf32QpDzd6IlfCcEHdbrMOwObh7G
   dAtw93ylfyc0p/QYDBrDPA2mazSdaZU4vJhFsk5cAxrCZvzf1fkFD8lXs
   xY++DjKWRLSEPGaPdbnow3GfXWl3wPe8CsvmBjpRTRJqhi2iTmXb/kW27
   r8N3TfpvGpUAVMLa18MFvJscQ4PS0ueoW7b30shphBYc1r5+YFb7q4vOK
   A4977KUKvSmX6J1toi+0TpED3MVGY/BXRN4RTdViD2paoRSRpkgG1fEgs
   RIqz8j/DzDm/6wzqDGvJG1Q2Tm70Ijere9ib/Hp5OKy9ydl3xKWF/Fhei
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="301814660"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="301814660"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 06:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="668842957"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2022 06:56:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxUGc-000Avn-J8;
        Sat, 04 Jun 2022 13:56:38 +0000
Date:   Sat, 4 Jun 2022 21:55:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [akpm-mm:mm-unstable 168/180] mm/memory-failure.c:1740:7: error:
 call to undeclared function 'mf_generic_kill_procs'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202206042127.sGqAcR3f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   f06e3c5104126b9a6660b58f29619b53bfa33b2b
commit: 92eb33ec5ea377357ff8087197209cbfbf40dbf9 [168/180] mm: factor helpers for memory_failure_dev_pagemap
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220604/202206042127.sGqAcR3f-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=92eb33ec5ea377357ff8087197209cbfbf40dbf9
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 92eb33ec5ea377357ff8087197209cbfbf40dbf9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/memory-failure.c:1740:7: error: call to undeclared function 'mf_generic_kill_procs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           rc = mf_generic_kill_procs(pfn, flags, pgmap);
                ^
   1 error generated.


vim +/mf_generic_kill_procs +1740 mm/memory-failure.c

  1723	
  1724	static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
  1725			struct dev_pagemap *pgmap)
  1726	{
  1727		struct page *page = pfn_to_page(pfn);
  1728		int rc = -ENXIO;
  1729	
  1730		if (flags & MF_COUNT_INCREASED)
  1731			/*
  1732			 * Drop the extra refcount in case we come from madvise().
  1733			 */
  1734			put_page(page);
  1735	
  1736		/* device metadata space is not recoverable */
  1737		if (!pgmap_pfn_valid(pgmap, pfn))
  1738			goto out;
  1739	
> 1740		rc = mf_generic_kill_procs(pfn, flags, pgmap);
  1741	out:
  1742		/* drop pgmap ref acquired in caller */
  1743		put_dev_pagemap(pgmap);
  1744		action_result(pfn, MF_MSG_DAX, rc ? MF_FAILED : MF_RECOVERED);
  1745		return rc;
  1746	}
  1747	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
