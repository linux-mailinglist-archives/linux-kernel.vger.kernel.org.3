Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B667C58B4C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiHFJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHFJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:39:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F67715828
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659778793; x=1691314793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TPkR6NzIe+XfK9FccMcl0Kt71lLg/XkRXHtNCLFwx5o=;
  b=oFwbxAbVCAVeQxdMZlU0FNngIB+bUYh13GrSUZzozFryxk9YYbXOiywu
   klmBxA5bGjBS2aupBSkEKviEJ7zNHJ2YFSmxgB02W8qSG8UFQDsZLdeaE
   BjKdHQf0gl53p+rs5z/o3qXQRqcOlTs3mrv5bHiQ3gwJqJ4OB9Ymg5a3p
   6OcrxsyZxLHlHBEXYFJE0RNsRTsKdASLKVoWgTdRIAzql3ODC0kht47QI
   FYDcWNJuS3KZpw81aBhoL1mzogXn7Nj8iRpPAxKdNgIOJxpNpyMRbn9sl
   thfmB99kd72WR5k8TjlbMfHvIJSrf5duEqsfN6mCaZaXw7qgimnCgmYCS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287918952"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="287918952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 02:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="746110359"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2022 02:39:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKGHf-000KF7-2F;
        Sat, 06 Aug 2022 09:39:51 +0000
Date:   Sat, 6 Aug 2022 17:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 16/23]
 arch/x86/coco/tdx/tdx.c:531:15: sparse: sparse: symbol 'tdx_mmio_readq' was
 not declared. Should it be static?
Message-ID: <202208061701.gECNmfr2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220806/202208061701.gECNmfr2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/733588efac52121a59664e2dbd04edfdd9fdb580
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 733588efac52121a59664e2dbd04edfdd9fdb580
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/x86/coco/tdx/tdx.c:298:14: sparse: sparse: symbol 'tdx_write_msr' was not declared. Should it be static?
>> arch/x86/coco/tdx/tdx.c:531:15: sparse: sparse: symbol 'tdx_mmio_readq' was not declared. Should it be static?

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
