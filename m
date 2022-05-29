Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C2537148
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiE2ON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiE2ONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:13:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99741980
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653833634; x=1685369634;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v/ebwrVLFzJhynLx4/TGkQgVlAg48YwERRA1prVq7P4=;
  b=jLXriZltF1KnRPuJPPFGgtGrd2Xg5FkY7SUvki1zASwueuT7okn37MwT
   jSp2p9seoBvPxGVuu/HHZCnW/dwpMUF5yu/gbVqe5HOo2F/HBiLIAH8/a
   HlKto4baQ4vOT4mN2H8iCOIzwa2gljW73sZucT1fU2HOS0wQHx2SfpIb5
   mfS5FwYEbGBzlI8y0qiDRaAtpiZhUjausanG2+0E+orrbi8rb0FJBgh/x
   emw7PhSkwID9x+8pRgnM4wKq2GoRuYAY0QsUfwXRFTQ0MIyxLz+jXwScn
   FnvnQ9cYXVM+rm8ppKro4DtEt6hkbaik0FoXCyRdONepIX+qhipfJra0D
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="256866979"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="256866979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 07:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="550989252"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 May 2022 07:13:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvJfs-000148-55;
        Sun, 29 May 2022 14:13:44 +0000
Date:   Sun, 29 May 2022 22:13:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:413 amdgpu_get_xgmi_hive()
 warn: inconsistent indenting
Message-ID: <202205292210.BD83pOan-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   664a393a2663a0f62fc1b18157ccae33dcdbb8c8
commit: cfbb6b0047448e2d986160d9f30d60f604d9ad0f drm/amdgpu: Rework reset domain to be refcounted.
date:   4 months ago
config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220529/202205292210.BD83pOan-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
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
