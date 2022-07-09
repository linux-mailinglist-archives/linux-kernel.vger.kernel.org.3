Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC056C7A2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGIHBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:01:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1F774AF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657350089; x=1688886089;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R59yKullgmUlb1ENR+m7wup6k3pblWwgkFFsAUZKWKw=;
  b=YMnNreIgToADEy3mMg7oArWHZsYu5Rq/lkBeF9LUjGs/WlAFmHEBLbVQ
   wmuyuv+Knu/VjgBYCY54+yXJ1u3OYiW1EAxynwO7sLkeQPr64iIUz+eUj
   6uhXpn1ea7/GjQ4pHSVL2b3LhRuXBIniQSqW3ulD0qX+FZgvTh6ono2is
   4AViP2VoVr/cgsAJ7OBBdwdZG6i6U/zfQGsTory6RUUVfpxEO67vXB9B/
   NNsNvkJVmD3/hzLDiyf+UGuEXphe52QjQupluhfs3HTJ/voMvWTm8Grc7
   1oPUsrdWosKCafhdL8Ner/44qENXwxI/wcTRbT5LIcimJKW/6Ehe+YSb6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="310005476"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="310005476"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 00:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="621489678"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 00:01:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA4T0-000OPq-Rl;
        Sat, 09 Jul 2022 07:01:26 +0000
Date:   Sat, 9 Jul 2022 15:00:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Xiao <Jack.Xiao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 409/419]
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1210:55: warning: implicit
 conversion from 'enum <anonymous>' to 'enum dma_resv_usage'
Message-ID: <202207091422.0Z9teg5Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e35cc9020f7b4540f5fbbff9fbe08808aab9addc
commit: 9a65294489b5b61b674f1497b6a54db4588024f9 [409/419] drm/amdgpu/mes: fix bo va unmap issue in mes
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220709/202207091422.0Z9teg5Y-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 9a65294489b5b61b674f1497b6a54db4588024f9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/display/dc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_ctx_alloc_meta_data':
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1079:13: warning: variable 'r' set but not used [-Wunused-but-set-variable]
    1079 |         int r;
         |             ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_ctx_unmap_meta_data':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1210:55: warning: implicit conversion from 'enum <anonymous>' to 'enum dma_resv_usage' [-Wenum-conversion]
    1210 |         r = dma_resv_get_singleton(bo->tbo.base.resv, false, &fence);
         |                                                       ^~~~~


vim +1210 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c

  1176	
  1177	int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
  1178					   struct amdgpu_mes_ctx_data *ctx_data)
  1179	{
  1180		struct amdgpu_bo_va *bo_va = ctx_data->meta_data_va;
  1181		struct amdgpu_bo *bo = ctx_data->meta_data_obj;
  1182		struct amdgpu_vm *vm = bo_va->base.vm;
  1183		struct amdgpu_bo_list_entry vm_pd;
  1184		struct list_head list, duplicates;
  1185		struct dma_fence *fence = NULL;
  1186		struct ttm_validate_buffer tv;
  1187		struct ww_acquire_ctx ticket;
  1188		long r = 0;
  1189	
  1190		INIT_LIST_HEAD(&list);
  1191		INIT_LIST_HEAD(&duplicates);
  1192	
  1193		tv.bo = &bo->tbo;
  1194		tv.num_shared = 2;
  1195		list_add(&tv.head, &list);
  1196	
  1197		amdgpu_vm_get_pd_bo(vm, &list, &vm_pd);
  1198	
  1199		r = ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
  1200		if (r) {
  1201			dev_err(adev->dev, "leaking bo va because "
  1202				"we fail to reserve bo (%ld)\n", r);
  1203			return r;
  1204		}
  1205	
  1206		amdgpu_vm_bo_del(adev, bo_va);
  1207		if (!amdgpu_vm_ready(vm))
  1208			goto out_unlock;
  1209	
> 1210		r = dma_resv_get_singleton(bo->tbo.base.resv, false, &fence);
  1211		if (r)
  1212			goto out_unlock;
  1213		if (fence) {
  1214			amdgpu_bo_fence(bo, fence, true);
  1215			fence = NULL;
  1216		}
  1217	
  1218		r = amdgpu_vm_clear_freed(adev, vm, &fence);
  1219		if (r || !fence)
  1220			goto out_unlock;
  1221	
  1222		dma_fence_wait(fence, false);
  1223		amdgpu_bo_fence(bo, fence, true);
  1224		dma_fence_put(fence);
  1225	
  1226	out_unlock:
  1227		if (unlikely(r < 0))
  1228			dev_err(adev->dev, "failed to clear page tables (%ld)\n", r);
  1229		ttm_eu_backoff_reservation(&ticket, &list);
  1230	
  1231		return r;
  1232	}
  1233	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
