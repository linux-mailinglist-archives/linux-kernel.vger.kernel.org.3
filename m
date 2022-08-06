Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF758B56C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiHFMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiHFMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:25:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464152613
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659788757; x=1691324757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g7psvbIbxejckfZseovXpRiOXtpRWvckpSLypWUTg7M=;
  b=Gd6OaO8X+d4dHPhEeO+X2nR2g1UfLJq/I5C0Jpb3nHPhqew8ra0aSzcs
   i1uc+5WZj4LHXwIdi2FcJKC8k97qBpjkMZKkDGXdg5Ans5tV4E47qf42f
   RRNFUUFGJ8J1RuvUHHf6oGNzLzD+bR4QRT8ZW7qGilx7xJubGGZniwTNZ
   ET4R6KjAFXw0GyczSppEb5o8upFmgkBHKzmOnjyms2SQyYkf0z3NKRPpI
   0KVp/sqUl7HZsNWsXq+P24XeaCCpWYUiDPnpnw9rTbA0z3On3mguKh0bU
   S5AXIqwulKKLsiZI75ZgQBbCMRg+JMPuR49O9g2BZYy/co7pRmnrDIhVi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="376658333"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="376658333"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636786267"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2022 05:25:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKIsN-000KLx-0P;
        Sat, 06 Aug 2022 12:25:55 +0000
Date:   Sat, 6 Aug 2022 20:25:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 16/23]
 arch/x86/coco/tdx/tdx.c:531:15: warning: no previous prototype for
 'tdx_mmio_readq'
Message-ID: <202208062038.xHmGD2TI-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   c170462888e1dab8e3e80c1c6e3708dd473ad1ed
commit: 733588efac52121a59664e2dbd04edfdd9fdb580 [16/23] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220806/202208062038.xHmGD2TI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/733588efac52121a59664e2dbd04edfdd9fdb580
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 733588efac52121a59664e2dbd04edfdd9fdb580
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

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
