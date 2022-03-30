Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7064EBDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiC3JjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244860AbiC3JjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:39:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB96393DB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648633040; x=1680169040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ecJxBpL/8jujjfLvyAxdtU96GhIZIvpCCUJvYqxNY3Y=;
  b=mqjkClGMUaYUH2cot32O3txgcXeoX64HjEHe/PUiuhJeeLCT8DRF+VY7
   1ppbQRqvHYmV1zuP0/vKyKHRBT3CgVD2F5FXN1ptmCQ4vRDMNoKblS9O0
   0oduZbboZYAnEby9U5IeRHcVnuqqRiXmjjl/EJkKVFVhpeKGNTQpyEop3
   /Tb2fTWfPxgJw3AbMIM3jnZVGrBlFkK+l3XGFFG3RkYBCSrvklVGmUhwF
   PJvDdvBkZzJtVSbUC2QlVCuoA8J2+fZ6aS6LUwVaFfCDW029rsxqm2LBH
   ZIN9yOr+0MuTQp9tP88sfyyv4gu5O9E25YtLPtpNe2hUDGheygdeI1XsI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345937152"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="345937152"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="719912394"
Received: from lkp-server02.sh.intel.com (HELO 7a008980c4ea) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2022 02:37:18 -0700
Received: from kbuild by 7a008980c4ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZUlR-0000F4-K9; Wed, 30 Mar 2022 09:37:17 +0000
Date:   Wed, 30 Mar 2022 17:36:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:413 amdgpu_get_xgmi_hive()
 warn: inconsistent indenting
Message-ID: <202203301722.eFgFpxPQ-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d888c83fcec75194a8a48ccd283953bdba7b2550
commit: cfbb6b0047448e2d986160d9f30d60f604d9ad0f drm/amdgpu: Rework reset domain to be refcounted.
date:   7 weeks ago
config: riscv-randconfig-m031-20220327 (https://download.01.org/0day-ci/archive/20220330/202203301722.eFgFpxPQ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:413 amdgpu_get_xgmi_hive() warn: inconsistent indenting

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:473 amdgpu_xgmi_set_pstate() warn: ignoring unreachable code.

vim +413 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c

   363	
   364	
   365	
   366	struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
   367	{
   368		struct amdgpu_hive_info *hive = NULL;
   369		int ret;
   370	
   371		if (!adev->gmc.xgmi.hive_id)
   372			return NULL;
   373	
   374		if (adev->hive) {
   375			kobject_get(&adev->hive->kobj);
   376			return adev->hive;
   377		}
   378	
   379		mutex_lock(&xgmi_mutex);
   380	
   381		list_for_each_entry(hive, &xgmi_hive_list, node)  {
   382			if (hive->hive_id == adev->gmc.xgmi.hive_id)
   383				goto pro_end;
   384		}
   385	
   386		hive = kzalloc(sizeof(*hive), GFP_KERNEL);
   387		if (!hive) {
   388			dev_err(adev->dev, "XGMI: allocation failed\n");
   389			hive = NULL;
   390			goto pro_end;
   391		}
   392	
   393		/* initialize new hive if not exist */
   394		ret = kobject_init_and_add(&hive->kobj,
   395				&amdgpu_xgmi_hive_type,
   396				&adev->dev->kobj,
   397				"%s", "xgmi_hive_info");
   398		if (ret) {
   399			dev_err(adev->dev, "XGMI: failed initializing kobject for xgmi hive\n");
   400			kobject_put(&hive->kobj);
   401			kfree(hive);
   402			hive = NULL;
   403			goto pro_end;
   404		}
   405	
   406		/**
   407		 * Avoid recreating reset domain when hive is reconstructed for the case
   408		 * of reset the devices in the XGMI hive during probe for SRIOV
   409		 * See https://www.spinics.net/lists/amd-gfx/msg58836.html
   410		 */
   411		if (adev->reset_domain->type != XGMI_HIVE) {
   412			hive->reset_domain = amdgpu_reset_create_reset_domain(XGMI_HIVE, "amdgpu-reset-hive");
 > 413				if (!hive->reset_domain) {
   414					dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
   415					ret = -ENOMEM;
   416					kobject_put(&hive->kobj);
   417					kfree(hive);
   418					hive = NULL;
   419					goto pro_end;
   420				}
   421		} else {
   422			amdgpu_reset_get_reset_domain(adev->reset_domain);
   423			hive->reset_domain = adev->reset_domain;
   424		}
   425	
   426		hive->hive_id = adev->gmc.xgmi.hive_id;
   427		INIT_LIST_HEAD(&hive->device_list);
   428		INIT_LIST_HEAD(&hive->node);
   429		mutex_init(&hive->hive_lock);
   430		atomic_set(&hive->number_devices, 0);
   431		task_barrier_init(&hive->tb);
   432		hive->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
   433		hive->hi_req_gpu = NULL;
   434	
   435		/*
   436		 * hive pstate on boot is high in vega20 so we have to go to low
   437		 * pstate on after boot.
   438		 */
   439		hive->hi_req_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
   440		list_add_tail(&hive->node, &xgmi_hive_list);
   441	
   442	pro_end:
   443		if (hive)
   444			kobject_get(&hive->kobj);
   445		mutex_unlock(&xgmi_mutex);
   446		return hive;
   447	}
   448	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
