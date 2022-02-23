Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BD44C0A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiBWDS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiBWDSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:18:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9956289A7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645586307; x=1677122307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pMOybF75Y1QlUx30byGPwtyd2n2/N3cIhsbFeWxL8sM=;
  b=FM+cW7MIt4BZxs8025Q5OvgorEGj8nHD61mcYoh4EqSLf7zz7MkSJN7e
   +gL3nWUcYJIwyDBtNtF3+Yg2kC7DvCeHOIaQXrunYKB/ERds9JKa5TjtQ
   GR+2sF27VQywH4JnGFZXlnywX81+RDb73c0DgQ0qQ65ftSF4u6dC4FTgw
   wU+mtBpveZRU4aW0adQMV7Vuu2oWvMRNN3mK+2gg8sNp8Wwxel94tMXZO
   iNuh1WLtDrCjsrOjTVT3nakzfgrehlKpanRDjRwAlTbClAol5ajNaHDpN
   Hp5npw7NgZGLIYzrAnBhFIxirq5eJGsw0UGLBCqrn6utMkH1jVEmKhcxy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="235382950"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="235382950"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 19:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="508258109"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 19:18:13 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMiAP-0000vA-1P; Wed, 23 Feb 2022 03:18:13 +0000
Date:   Wed, 23 Feb 2022 11:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prike Liang <Prike.Liang@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [agd5f:drm-next 115/146]
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:526:5: warning: no previous
 prototype for function '__smu_get_enabled_features'
Message-ID: <202202231120.Noceeeac-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   b4779e5b8346b52e25e8be6b077d7db67f14644a
commit: f141e251474d673f75e8c16dbdabeb4da3939d7e [115/146] drm/amd/pm: validate SMU feature enable message for getting feature enabled mask
config: arm-randconfig-r035-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231120.Noceeeac-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout f141e251474d673f75e8c16dbdabeb4da3939d7e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/pm/swsmu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:526:5: warning: no previous prototype for function '__smu_get_enabled_features' [-Wmissing-prototypes]
   int __smu_get_enabled_features(struct smu_context *smu,
       ^
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:526:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __smu_get_enabled_features(struct smu_context *smu,
   ^
   static 
   1 warning generated.


vim +/__smu_get_enabled_features +526 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c

   525	
 > 526	int __smu_get_enabled_features(struct smu_context *smu,
   527				       uint64_t *enabled_features)
   528	{
   529		return smu_cmn_call_asic_func(get_enabled_mask, smu, enabled_features);
   530	}
   531	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
