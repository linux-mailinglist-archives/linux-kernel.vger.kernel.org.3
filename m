Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309004BB258
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiBRGcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:32:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiBRGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:32:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E2369D3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645165938; x=1676701938;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QCSnJGsGA/3rLBnDEPq7JsVckny++B8iF6OISwIiGcc=;
  b=BRAiyCTNBu/wi/jO4T6alPPkHII2eWOHbGDEJ0USF3hLS1jaPXtRJk3a
   FP1qgx1JUUUhOaS5vbDdJZPsBOQswpGRfaNItEcGOOAGYD4jpLrflNZgM
   s4gF2Jts8ZV4HLLwMVw3vUvJ1UwAWdWQb6acrmo6PfzYA5yUShsKQz7AW
   ScUGNEN0mW1pZcHeUjF4Jql7RKoSp2XC6qS5dLA7Mp7MeqDoHt66oBDqx
   scMF2SwUGI79exHgvexUm2t5iFz8MMHWJ/GWL2AiJUTgV4LSKwbLSoxJi
   1g5wGZp1ygChiV/ZI3iJPWjmA3opZuduTNy9kiNc4eH4fLEf3y2mWHDf+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248658203"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="248658203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="637641755"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 22:32:15 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKwoR-00011m-6V; Fri, 18 Feb 2022 06:32:15 +0000
Date:   Fri, 18 Feb 2022 14:31:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     yipechai <YiPeng.Chai@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>
Subject: [agd5f:drm-next 73/91]
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2460:5: warning: no previous
 prototype for function 'amdgpu_ras_block_late_init_default'
Message-ID: <202202181417.bZQAVKEY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   7dfbe38cecadbaf6dd426855d8bf8f34a4ca2c30
commit: 418abce203fc2e936bf8c7632a9a429e861f6283 [73/91] drm/amdgpu: Remove redundant .ras_late_init initialization in some ras blocks
config: arm-randconfig-r036-20220217 (https://download.01.org/0day-ci/archive/20220218/202202181417.bZQAVKEY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 418abce203fc2e936bf8c7632a9a429e861f6283
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2416:3: warning: variable 'ras_obj' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (adev->in_suspend || amdgpu_in_reset(adev)) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2453:6: note: uninitialized use occurs here
           if (ras_obj->ras_cb)
               ^~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2416:3: note: remove the 'if' if its condition is always false
                   if (adev->in_suspend || amdgpu_in_reset(adev)) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2403:41: note: initialize the variable 'ras_obj' to silence this warning
           struct amdgpu_ras_block_object *ras_obj;
                                                  ^
                                                   = NULL
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2460:5: warning: no previous prototype for function 'amdgpu_ras_block_late_init_default' [-Wmissing-prototypes]
   int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
       ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2460:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
   ^
   static 
   2 warnings generated.


vim +/amdgpu_ras_block_late_init_default +2460 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c

  2459	
> 2460	int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
  2461				 struct ras_common_if *ras_block)
  2462	{
  2463		return amdgpu_ras_block_late_init(adev, ras_block);
  2464	}
  2465	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
