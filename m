Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E287A5A36D7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiH0KFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiH0KE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:04:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED81104
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661594696; x=1693130696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E5dDamjBugMbc4PfhB81x6he75H2JHpePc58gD6oet8=;
  b=ehYUCiLpbLDdpban73A3FqlptwnHKCnflF6IoOFRqGTRKiaDlKkUPF80
   WEmV9nB8HoJkGMkvRwt4M08Ct7PXeqCNxNbmkcEyEzlDVvn/T7gmKwelM
   NqKWPGk9g1c93X/HV7cj2yvLZPCXUt2ncImv5bhxAymklIUZrUf+2Uykx
   SyApSF5eTxkdaeLHdcX7b6nyqMu4mLw1GOfQ4hpex7DmPmtgbTdTlXYUe
   q9G/hWfvYrxJLkj3YPhC4HJIyH3gTf+MBNWwExa6H2kD0d/1wGMa+K7M5
   3+UvJLn0PVSQ6dfd/gQYfG4KtGVg+Ahoj7izNd2WM/rx46CRS9tm+IpO6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="320764493"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="320764493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 03:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="561705134"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2022 03:04:54 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRsgQ-00004L-08;
        Sat, 27 Aug 2022 10:04:54 +0000
Date:   Sat, 27 Aug 2022 18:04:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 11/36]
 arch/x86/coco/tdx/tdx.c:298:14: sparse: sparse: symbol 'tdx_write_msr' was
 not declared. Should it be static?
Message-ID: <202208271745.SPAzpPNc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: a9189da9f0413f85d9072894ccb973cf785d2c0d [11/36] x86/tdx: Use direct paravirt call for wrmsrl
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220827/202208271745.SPAzpPNc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/a9189da9f0413f85d9072894ccb973cf785d2c0d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout a9189da9f0413f85d9072894ccb973cf785d2c0d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/coco/tdx/tdx.c:298:14: sparse: sparse: symbol 'tdx_write_msr' was not declared. Should it be static?

vim +/tdx_write_msr +298 arch/x86/coco/tdx/tdx.c

   297	
 > 298	void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   299	{
   300		struct tdx_hypercall_args args = {
   301			.r10 = TDX_HYPERCALL_STANDARD,
   302			.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
   303			.r12 = msr,
   304			.r13 = (u64)high << 32 | low,
   305		};
   306	
   307		if (tdx_fast_tdcall_path_msr(msr))
   308			__tdx_hypercall(&args, 0);
   309		else
   310			native_write_msr(msr, low, high);
   311	}
   312	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
