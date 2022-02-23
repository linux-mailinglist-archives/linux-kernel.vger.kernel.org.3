Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963A64C07AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiBWCPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiBWCPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:15:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2063B55B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 18:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645582515; x=1677118515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WsXISW5aKhQZoR0LtotIOTwHcOMd2YUdAGevCyk3IHI=;
  b=hFtTjyPI/Yz5YGqaldrepxwmo+ki6c9DI3k25HrMoD29vdnv6vv3jDQr
   grRpMpkUYpo7BLJngvaxrp0xfMXngQB7CPRK0cFdc9bFvErAE80ya/dJ9
   Gd8h4SfRLQkmSlxGBIrCbrpnAA4okZrjE/tqhVEEtg9EcF1LjTGtMyR0N
   mbO02B94N77EHOokBnYVkIm0GxR/wJZlliXHTU6v6wCFXb7D4EjN9NeOJ
   b/R20W7MlqrY6LtpjiGrrxdJ8fG/MRhuK+MyS/1j7EZZyndb5KJ6VjTF2
   8DYuiYW3Ucb7n0h7TTdCm92LRZn+2hX8RnNgeMc1pRtNPUGP1n0DnlTLr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338300576"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="338300576"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 18:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="508243424"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 18:15:12 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMhBP-0000rm-LW; Wed, 23 Feb 2022 02:15:11 +0000
Date:   Wed, 23 Feb 2022 10:14:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prike Liang <Prike.Liang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [agd5f:drm-next 115/146]
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:526:5: warning: no previous
 prototype for '__smu_get_enabled_features'
Message-ID: <202202231018.26Vt4vfh-lkp@intel.com>
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
head:   b4779e5b8346b52e25e8be6b077d7db67f14644a
commit: f141e251474d673f75e8c16dbdabeb4da3939d7e [115/146] drm/amd/pm: validate SMU feature enable message for getting feature enabled mask
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202231018.26Vt4vfh-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout f141e251474d673f75e8c16dbdabeb4da3939d7e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:526:5: warning: no previous prototype for '__smu_get_enabled_features' [-Wmissing-prototypes]
     526 | int __smu_get_enabled_features(struct smu_context *smu,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


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
