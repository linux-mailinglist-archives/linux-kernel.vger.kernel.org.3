Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9C4BB109
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiBRFAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:00:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiBRFAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:00:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D7C2BAA03
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645160415; x=1676696415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+/4Ws4n5GO5MA4Lob8Av7zlFDSbbD9go+e2hEhCE6S8=;
  b=CPnR3kyDbfhCzD4Kz5VTmYB/8xlmRAXAyh578UqcY8b3fAC9ltlfrcpt
   DYJBs2tIw+n0sCQjkkXgaKHVUzzuNvdVTh8Ur6SVyzUxTjrYLvlKTjSvq
   dJl/k377ehDE3zdf31yFWMwAdoMXpGv5076vAKk/asWhbZv7/TH5KyeQC
   YAgRKL9g1amtwJ1TdGer0w/s7EgIr9fBLJoVMfgj++vTpU9clkr0mW8DN
   gVUT4VSppzeDds4LT/Xce335avjFNHtvX3UqwVAjYK5ACKniURyge/IoG
   KxwhIp7vxSHi/hqFR3+T2WqDiKtPSOtjXXQryRtxzBAuOrE5kQqzZqxOO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="337496543"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="337496543"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 21:00:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="530771170"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2022 21:00:13 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKvNM-0000y0-D9; Fri, 18 Feb 2022 05:00:12 +0000
Date:   Fri, 18 Feb 2022 12:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     yipechai <YiPeng.Chai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>
Subject: [agd5f:drm-next 73/91]
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2460:5: warning: no previous
 prototype for 'amdgpu_ras_block_late_init_default'
Message-ID: <202202181246.FqQEZVzy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   7dfbe38cecadbaf6dd426855d8bf8f34a4ca2c30
commit: 418abce203fc2e936bf8c7632a9a429e861f6283 [73/91] drm/amdgpu: Remove redundant .ras_late_init initialization in some ras blocks
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202181246.FqQEZVzy-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 418abce203fc2e936bf8c7632a9a429e861f6283
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2460:5: warning: no previous prototype for 'amdgpu_ras_block_late_init_default' [-Wmissing-prototypes]
    2460 | int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
