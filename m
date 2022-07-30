Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1172585A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiG3KsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 06:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiG3KsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 06:48:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE0175B1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659178083; x=1690714083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0uByVVpR9BzdDWk8k2H2AaNl2DyQGlvcRdmOANw+V7c=;
  b=l147bQGzgRqo1TZS4LfNq76P4YOawqqxuTTl3KevkQK8F2CX3m9vB4ax
   LoZMzXs9kf78CoDqv6/PGl+DAVY9UrdpVvlWHs51Bguu1rWdGlk8XGTES
   wPKOrmBgYifp/K1OiO26n7xj4izyJgvCmV+bSNMB0susdIGTIftIUoDa0
   YlveZ1/5H+/N0KLZj85pIr9scj6lwHDlJz7iStooua1LOb27bmLs/n4kW
   hK0vTYh4KFkOA9KmlGlyzS7mQns1rkPvtVaU2LltzitUCAmz+xDJEVwI1
   cGMsfzTZdanAnTARUgX0KwCL+bcAcZKSofV3LlEADIyr5JILivafrOPLd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="350613256"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="350613256"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 03:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="629670761"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2022 03:48:01 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHk0n-000CkN-0I;
        Sat, 30 Jul 2022 10:48:01 +0000
Date:   Sat, 30 Jul 2022 18:47:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Gui <Jack.Gui@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:amd-staging-drm-next 1247/1278]
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:23: error: implicit declaration
 of function 'vmalloc'; did you mean 'kvmalloc'?
Message-ID: <202207301805.lGuXicPm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next
head:   2305916dca043ed69bd464f74a886b0216780aa6
commit: 8d1669d0090d25da9faf3d72c30ad57056bd3888 [1247/1278] drm/amd/amdgpu: add memory training support for PSP_V13
config: alpha-buildonly-randconfig-r001-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301805.lGuXicPm-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f amd-staging-drm-next
        git checkout 8d1669d0090d25da9faf3d72c30ad57056bd3888
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c: In function 'psp_v13_0_memory_training':
>> drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:23: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     534 |                 buf = vmalloc(sz);
         |                       ^~~~~~~
         |                       kvmalloc
>> drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:21: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     534 |                 buf = vmalloc(sz);
         |                     ^
>> drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:545:33: error: implicit declaration of function 'vfree'; did you mean 'kfree'? [-Werror=implicit-function-declaration]
     545 |                                 vfree(buf);
         |                                 ^~~~~
         |                                 kfree
   cc1: some warnings being treated as errors


vim +534 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c

   457	
   458	
   459	static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
   460	{
   461		struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
   462		uint32_t *pcache = (uint32_t *)ctx->sys_cache;
   463		struct amdgpu_device *adev = psp->adev;
   464		uint32_t p2c_header[4];
   465		uint32_t sz;
   466		void *buf;
   467		int ret, idx;
   468	
   469		if (ctx->init == PSP_MEM_TRAIN_NOT_SUPPORT) {
   470			dev_dbg(adev->dev, "Memory training is not supported.\n");
   471			return 0;
   472		} else if (ctx->init != PSP_MEM_TRAIN_INIT_SUCCESS) {
   473			dev_err(adev->dev, "Memory training initialization failure.\n");
   474			return -EINVAL;
   475		}
   476	
   477		if (psp_v13_0_is_sos_alive(psp)) {
   478			dev_dbg(adev->dev, "SOS is alive, skip memory training.\n");
   479			return 0;
   480		}
   481	
   482		amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
   483		dev_dbg(adev->dev,"sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x,%08x]\n",
   484			  pcache[0], pcache[1], pcache[2], pcache[3],
   485			  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3]);
   486	
   487		if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
   488			dev_dbg(adev->dev, "Short training depends on restore.\n");
   489			ops |= PSP_MEM_TRAIN_RESTORE;
   490		}
   491	
   492		if ((ops & PSP_MEM_TRAIN_RESTORE) &&
   493		    pcache[0] != MEM_TRAIN_SYSTEM_SIGNATURE) {
   494			dev_dbg(adev->dev, "sys_cache[0] is invalid, restore depends on save.\n");
   495			ops |= PSP_MEM_TRAIN_SAVE;
   496		}
   497	
   498		if (p2c_header[0] == MEM_TRAIN_SYSTEM_SIGNATURE &&
   499		    !(pcache[0] == MEM_TRAIN_SYSTEM_SIGNATURE &&
   500		      pcache[3] == p2c_header[3])) {
   501			dev_dbg(adev->dev, "sys_cache is invalid or out-of-date, need save training data to sys_cache.\n");
   502			ops |= PSP_MEM_TRAIN_SAVE;
   503		}
   504	
   505		if ((ops & PSP_MEM_TRAIN_SAVE) &&
   506		    p2c_header[0] != MEM_TRAIN_SYSTEM_SIGNATURE) {
   507			dev_dbg(adev->dev, "p2c_header[0] is invalid, save depends on long training.\n");
   508			ops |= PSP_MEM_TRAIN_SEND_LONG_MSG;
   509		}
   510	
   511		if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
   512			ops &= ~PSP_MEM_TRAIN_SEND_SHORT_MSG;
   513			ops |= PSP_MEM_TRAIN_SAVE;
   514		}
   515	
   516		dev_dbg(adev->dev, "Memory training ops:%x.\n", ops);
   517	
   518		if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
   519			/*
   520			 * Long training will encroach a certain amount on the bottom of VRAM;
   521			 * save the content from the bottom of VRAM to system memory
   522			 * before training, and restore it after training to avoid
   523			 * VRAM corruption.
   524			 */
   525			sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
   526	
   527			if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
   528				dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
   529					  adev->gmc.visible_vram_size,
   530					  adev->mman.aper_base_kaddr);
   531				return -EINVAL;
   532			}
   533	
 > 534			buf = vmalloc(sz);
   535			if (!buf) {
   536				dev_err(adev->dev, "failed to allocate system memory.\n");
   537				return -ENOMEM;
   538			}
   539	
   540			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
   541				memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
   542				ret = psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
   543				if (ret) {
   544					DRM_ERROR("Send long training msg failed.\n");
 > 545					vfree(buf);
   546					drm_dev_exit(idx);
   547					return ret;
   548				}
   549	
   550				memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
   551				adev->hdp.funcs->flush_hdp(adev, NULL);
   552				vfree(buf);
   553				drm_dev_exit(idx);
   554			} else {
   555				vfree(buf);
   556				return -ENODEV;
   557			}
   558		}
   559	
   560		if (ops & PSP_MEM_TRAIN_SAVE) {
   561			amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, ctx->sys_cache, ctx->train_data_size, false);
   562		}
   563	
   564		if (ops & PSP_MEM_TRAIN_RESTORE) {
   565			amdgpu_device_vram_access(psp->adev, ctx->c2p_train_data_offset, ctx->sys_cache, ctx->train_data_size, true);
   566		}
   567	
   568		if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
   569			ret = psp_v13_0_memory_training_send_msg(psp, (amdgpu_force_long_training > 0) ?
   570								 PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
   571			if (ret) {
   572				dev_err(adev->dev, "send training msg failed.\n");
   573				return ret;
   574			}
   575		}
   576		ctx->training_cnt++;
   577		return 0;
   578	}
   579	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
