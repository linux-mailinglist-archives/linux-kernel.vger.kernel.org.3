Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0956AF96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiGHBEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiGHBEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:04:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1914D72EC0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657242275; x=1688778275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ma9rZZnCdGdKeHUCVAWir9UFoJyJj1en/kCKZhlY9I=;
  b=C2bjianntCy9iHaAfUPQmHxfTD5OBc04lAB6Uo4fe0rIKagcrTmE4S4R
   7TQoKQU+Z0v5NFgGF7m0Znmn2CxCzqNatTGVooM4Oz+VCUuW/Q3cwbOss
   kzXZSuqK/Dg2Et9wLLBTmSD3KO6vAeG5ywNDn6cYIbMLtkERa1QJNoWRA
   nXy1KNqZIFtTmTAIhIPGM6QN/nUEPDde690QGU7dHhQ2NUTvwRjfs/nx3
   0HaGVDGOh5cyiJ9m7W/TFuXo6O1QDDKu9NzKiTF6nHrbKaPhdGJ96d7Jt
   MKZI9Zi0EGBykhj7691PAwYbSRmmSBcs78z8pFQIpeeValfjQ8XrkYhoA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284900588"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="284900588"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 18:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="920809463"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 18:04:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9cPm-000MhK-Tn;
        Fri, 08 Jul 2022 01:04:14 +0000
Date:   Fri, 8 Jul 2022 09:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 16/23]
 arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for
 'tdx_mmio_readq'
Message-ID: <202207080821.NvvSrMbA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   64a4c4e66ca9cce1ca55de6d801f32284fbf7c8e
commit: c3f81ff747739c9ee19408582ca418926af27188 [16/23] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207080821.NvvSrMbA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c3f81ff747739c9ee19408582ca418926af27188
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout c3f81ff747739c9ee19408582ca418926af27188
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/ arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     298 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~
>> arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for 'tdx_mmio_readq' [-Wmissing-prototypes]
     531 | unsigned long tdx_mmio_readq(void __iomem* addr)
         |               ^~~~~~~~~~~~~~


vim +/tdx_mmio_readq +531 arch/x86/coco/tdx/tdx.c

   530	
 > 531	unsigned long tdx_mmio_readq(void __iomem* addr)
   532	{
   533		unsigned long val;
   534	
   535		if (tdx_virt_mmio(8, false, (unsigned long)addr, &val))
   536			return 0xffffffffffffffff;
   537		return val;
   538	}
   539	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
