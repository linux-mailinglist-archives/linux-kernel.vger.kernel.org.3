Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A124C0B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiBWEjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBWEjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:39:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42768387BC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645591157; x=1677127157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OBAsJgAmXkoQH3w5up6qajOcwoEvBVR4pxFkXCd4nFU=;
  b=Ch/554q0opFzIG2eBQKoYynaBYJZMoeKbYGyQYTUFthUFQwkkjFpyMsL
   E/CcL15G6Wnk9l7FH/lBzVS+18kR4n/LTsRYNOqfCQkFXUP3cdYpoXHwA
   Ro+lcdYzICJ06W6RyBtETL8bzL0EiKppLNYaPqzAIBm3BJKVWyFCBjyTy
   ziYmcdUkYLMdehy0g1yKucSaC9dSndg6vY6Zz9YSnX4513h9G+J+cSN3b
   QRRG5aKwIxNr/r5femK8tchjpKdxlftxBeovPSJ04TqUX9MdKXZ4lmH6c
   /vGuwdczftmLunssqwME1m0kEMCZDg/BjjIITJwqdxA49cAHYGUkdsqvf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250708957"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="250708957"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 20:39:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="543190727"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2022 20:39:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMjQo-0000yu-Uh; Wed, 23 Feb 2022 04:39:14 +0000
Date:   Wed, 23 Feb 2022 12:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: [agd5f:drm-next 120/147]
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:202:7: warning: variable 'r'
 is uninitialized when used here
Message-ID: <202202231216.WfOj4nJp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   8bc1e581192e7ee9e808d1616b6d34b5da8f1206
commit: 9645c9c9fb153c149c7dffe8c7dc2bc8a6a7ce1a [120/147] drm/amdgpu: plumb error handling though amdgpu_benchmark()
config: arm-randconfig-r035-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231216.WfOj4nJp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 9645c9c9fb153c149c7dffe8c7dc2bc8a6a7ce1a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:202:7: warning: variable 'r' is uninitialized when used here [-Wuninitialized]
                   if (r)
                       ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:165:10: note: initialize the variable 'r' to silence this warning
           int i, r;
                   ^
                    = 0
   1 warning generated.


vim +/r +202 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c

   162	
   163	int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
   164	{
   165		int i, r;
   166		static const int common_modes[AMDGPU_BENCHMARK_COMMON_MODES_N] = {
   167			640 * 480 * 4,
   168			720 * 480 * 4,
   169			800 * 600 * 4,
   170			848 * 480 * 4,
   171			1024 * 768 * 4,
   172			1152 * 768 * 4,
   173			1280 * 720 * 4,
   174			1280 * 800 * 4,
   175			1280 * 854 * 4,
   176			1280 * 960 * 4,
   177			1280 * 1024 * 4,
   178			1440 * 900 * 4,
   179			1400 * 1050 * 4,
   180			1680 * 1050 * 4,
   181			1600 * 1200 * 4,
   182			1920 * 1080 * 4,
   183			1920 * 1200 * 4
   184		};
   185	
   186		switch (test_number) {
   187		case 1:
   188			/* simple test, VRAM to GTT and GTT to VRAM */
   189			r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
   190						  AMDGPU_GEM_DOMAIN_VRAM);
   191			if (r)
   192				return r;
   193			r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
   194						  AMDGPU_GEM_DOMAIN_GTT);
   195			if (r)
   196				return r;
   197			break;
   198		case 2:
   199			/* simple test, VRAM to VRAM */
   200			amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
   201					      AMDGPU_GEM_DOMAIN_VRAM);
 > 202			if (r)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
