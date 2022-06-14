Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA69E54BDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354104AbiFNWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiFNWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:42:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77588527DB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655246531; x=1686782531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NKciAO4qHgp24jfXYG+V+9J+3rZXQ+d+hg2Z4/u0bpc=;
  b=JkvvVQtlIFhIqT1BUEUyhBqhRxPGLZN7V7Ouxy/FmjqWB/dSIdjIh4rU
   Cd9h+RX8/YMnIbwwvtNGnEJ8NGMYD91IbaJ/WOgLGa7U2D68hA4DuBjiN
   W7InrD9dfgBKBZlh503H9fasCgp0Ohr0jSurasrCCuOrC1NDJISze6gOp
   fnJGFeHikQc3F5YLXHCtFXIptEt8tygxyvoxMerqCEXFEc9pfJz4PqyW+
   KBYAuUihZqeKlJnIn1Bs6alfDb2vJdqRnQhpxzKZf6JpxYlkfcXY1beQu
   zDhk/eh+9CnZo1+7pfTTUoRUpyWKluqYWLd9epxEnrJY6BWhyc6TBO/R9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261790569"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261790569"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 15:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="612450643"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2022 15:41:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1FEP-000MML-0F;
        Tue, 14 Jun 2022 22:41:53 +0000
Date:   Wed, 15 Jun 2022 06:41:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Erico Nunes <nunes.erico@gmail.com>,
        Eric Anholt <eric@anholt.net>
Subject: [anholt:5.17-for-mesa-ci 2375/2390]
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1115:4: error: implicit declaration of
 function 'writeq'
Message-ID: <202206150657.egHDOJhU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/anholt/linux 5.17-for-mesa-ci
head:   bc830a9e22faa411feb4b2ef4b25f7e6d04d36fe
commit: 07aeca39b9491d3455451da0923b19dc0c480e41 [2375/2390] drm/msm/a6xx: make GPUs SMMU context bank available in it's aperture.
config: hexagon-randconfig-r045-20220613 (https://download.01.org/0day-ci/archive/20220615/202206150657.egHDOJhU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/anholt/linux/commit/07aeca39b9491d3455451da0923b19dc0c480e41
        git remote add anholt https://github.com/anholt/linux
        git fetch --no-tags anholt 5.17-for-mesa-ci
        git checkout 07aeca39b9491d3455451da0923b19dc0c480e41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1115:4: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
                           writeq(0x48000, reg); /* offset of cb0 from gpu's base */
                           ^
   1 error generated.


vim +/writeq +1115 drivers/gpu/drm/msm/adreno/a6xx_gpu.c

   872	
   873	#define A6XX_INT_MASK (A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR | \
   874		  A6XX_RBBM_INT_0_MASK_RBBM_ATB_ASYNCFIFO_OVERFLOW | \
   875		  A6XX_RBBM_INT_0_MASK_CP_HW_ERROR | \
   876		  A6XX_RBBM_INT_0_MASK_CP_IB2 | \
   877		  A6XX_RBBM_INT_0_MASK_CP_IB1 | \
   878		  A6XX_RBBM_INT_0_MASK_CP_RB | \
   879		  A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS | \
   880		  A6XX_RBBM_INT_0_MASK_RBBM_ATB_BUS_OVERFLOW | \
   881		  A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT | \
   882		  A6XX_RBBM_INT_0_MASK_UCHE_OOB_ACCESS | \
   883		  A6XX_RBBM_INT_0_MASK_UCHE_TRAP_INTR)
   884	
   885	static int hw_init(struct msm_gpu *gpu)
   886	{
   887		struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
   888		struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
   889		int ret;
   890	
   891		/* Make sure the GMU keeps the GPU on while we set it up */
   892		a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
   893	
   894		gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
   895	
   896		/*
   897		 * Disable the trusted memory range - we don't actually supported secure
   898		 * memory rendering at this point in time and we don't want to block off
   899		 * part of the virtual memory space.
   900		 */
   901		gpu_write64(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE_LO,
   902			REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE_HI, 0x00000000);
   903		gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000);
   904	
   905		/* Turn on 64 bit addressing for all blocks */
   906		gpu_write(gpu, REG_A6XX_CP_ADDR_MODE_CNTL, 0x1);
   907		gpu_write(gpu, REG_A6XX_VSC_ADDR_MODE_CNTL, 0x1);
   908		gpu_write(gpu, REG_A6XX_GRAS_ADDR_MODE_CNTL, 0x1);
   909		gpu_write(gpu, REG_A6XX_RB_ADDR_MODE_CNTL, 0x1);
   910		gpu_write(gpu, REG_A6XX_PC_ADDR_MODE_CNTL, 0x1);
   911		gpu_write(gpu, REG_A6XX_HLSQ_ADDR_MODE_CNTL, 0x1);
   912		gpu_write(gpu, REG_A6XX_VFD_ADDR_MODE_CNTL, 0x1);
   913		gpu_write(gpu, REG_A6XX_VPC_ADDR_MODE_CNTL, 0x1);
   914		gpu_write(gpu, REG_A6XX_UCHE_ADDR_MODE_CNTL, 0x1);
   915		gpu_write(gpu, REG_A6XX_SP_ADDR_MODE_CNTL, 0x1);
   916		gpu_write(gpu, REG_A6XX_TPL1_ADDR_MODE_CNTL, 0x1);
   917		gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_ADDR_MODE_CNTL, 0x1);
   918	
   919		/* enable hardware clockgating */
   920		a6xx_set_hwcg(gpu, true);
   921	
   922		/* VBIF/GBIF start*/
   923		if (adreno_is_a640_family(adreno_gpu) ||
   924		    adreno_is_a650_family(adreno_gpu)) {
   925			gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
   926			gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
   927			gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
   928			gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
   929			gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
   930			gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
   931		} else {
   932			gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
   933		}
   934	
   935		if (adreno_is_a630(adreno_gpu))
   936			gpu_write(gpu, REG_A6XX_VBIF_GATE_OFF_WRREQ_EN, 0x00000009);
   937	
   938		/* Make all blocks contribute to the GPU BUSY perf counter */
   939		gpu_write(gpu, REG_A6XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff);
   940	
   941		/* Disable L2 bypass in the UCHE */
   942		gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0xffffffc0);
   943		gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_HI, 0x0001ffff);
   944		gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0xfffff000);
   945		gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_HI, 0x0001ffff);
   946		gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0xfffff000);
   947		gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_HI, 0x0001ffff);
   948	
   949		if (!adreno_is_a650_family(adreno_gpu)) {
   950			/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
   951			gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN_LO,
   952				REG_A6XX_UCHE_GMEM_RANGE_MIN_HI, 0x00100000);
   953	
   954			gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MAX_LO,
   955				REG_A6XX_UCHE_GMEM_RANGE_MAX_HI,
   956				0x00100000 + adreno_gpu->gmem - 1);
   957		}
   958	
   959		gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
   960		gpu_write(gpu, REG_A6XX_UCHE_CACHE_WAYS, 0x4);
   961	
   962		if (adreno_is_a640_family(adreno_gpu) ||
   963		    adreno_is_a650_family(adreno_gpu))
   964			gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
   965		else
   966			gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
   967		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
   968	
   969		if (adreno_is_a660_family(adreno_gpu))
   970			gpu_write(gpu, REG_A6XX_CP_LPAC_PROG_FIFO_SIZE, 0x00000020);
   971	
   972		/* Setting the mem pool size */
   973		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
   974	
   975		/* Setting the primFifo thresholds default values,
   976		 * and vccCacheSkipDis=1 bit (0x200) for A640 and newer
   977		*/
   978		if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
   979			gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
   980		else if (adreno_is_a640_family(adreno_gpu) || adreno_is_7c3(adreno_gpu))
   981			gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
   982		else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
   983			gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
   984		else
   985			gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00180000);
   986	
   987		/* Set the AHB default slave response to "ERROR" */
   988		gpu_write(gpu, REG_A6XX_CP_AHB_CNTL, 0x1);
   989	
   990		/* Turn on performance counters */
   991		gpu_write(gpu, REG_A6XX_RBBM_PERFCTR_CNTL, 0x1);
   992	
   993		/* Select CP0 to always count cycles */
   994		gpu_write(gpu, REG_A6XX_CP_PERFCTR_CP_SEL(0), PERF_CP_ALWAYS_COUNT);
   995	
   996		a6xx_set_ubwc_config(gpu);
   997	
   998		/* Enable fault detection */
   999		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL,
  1000			(1 << 30) | 0x1fffff);
  1001	
  1002		gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, 1);
  1003	
  1004		/* Set weights for bicubic filtering */
  1005		if (adreno_is_a650_family(adreno_gpu)) {
  1006			gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0, 0);
  1007			gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
  1008				0x3fe05ff4);
  1009			gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_2,
  1010				0x3fa0ebee);
  1011			gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_3,
  1012				0x3f5193ed);
  1013			gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_4,
  1014				0x3f0243f0);
  1015		}
  1016	
  1017		/* Protect registers from the CP */
  1018		a6xx_set_cp_protect(gpu);
  1019	
  1020		if (adreno_is_a660_family(adreno_gpu)) {
  1021			gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x1);
  1022			gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x0);
  1023		}
  1024	
  1025		/* Set dualQ + disable afull for A660 GPU */
  1026		if (adreno_is_a660(adreno_gpu))
  1027			gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x66906);
  1028	
  1029		/* Enable expanded apriv for targets that support it */
  1030		if (gpu->hw_apriv) {
  1031			gpu_write(gpu, REG_A6XX_CP_APRIV_CNTL,
  1032				(1 << 6) | (1 << 5) | (1 << 3) | (1 << 2) | (1 << 1));
  1033		}
  1034	
  1035		/* Enable interrupts */
  1036		gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_INT_MASK);
  1037	
  1038		ret = adreno_hw_init(gpu);
  1039		if (ret)
  1040			goto out;
  1041	
  1042		ret = a6xx_ucode_init(gpu);
  1043		if (ret)
  1044			goto out;
  1045	
  1046		/* Set the ringbuffer address */
  1047		gpu_write64(gpu, REG_A6XX_CP_RB_BASE, REG_A6XX_CP_RB_BASE_HI,
  1048			gpu->rb[0]->iova);
  1049	
  1050		/* Targets that support extended APRIV can use the RPTR shadow from
  1051		 * hardware but all the other ones need to disable the feature. Targets
  1052		 * that support the WHERE_AM_I opcode can use that instead
  1053		 */
  1054		if (adreno_gpu->base.hw_apriv)
  1055			gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
  1056		else
  1057			gpu_write(gpu, REG_A6XX_CP_RB_CNTL,
  1058				MSM_GPU_RB_CNTL_DEFAULT | AXXX_CP_RB_CNTL_NO_UPDATE);
  1059	
  1060		/*
  1061		 * Expanded APRIV and targets that support WHERE_AM_I both need a
  1062		 * privileged buffer to store the RPTR shadow
  1063		 */
  1064	
  1065		if (adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami) {
  1066			if (!a6xx_gpu->shadow_bo) {
  1067				a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
  1068					sizeof(u32) * gpu->nr_rings,
  1069					MSM_BO_WC | MSM_BO_MAP_PRIV,
  1070					gpu->aspace, &a6xx_gpu->shadow_bo,
  1071					&a6xx_gpu->shadow_iova);
  1072	
  1073				if (IS_ERR(a6xx_gpu->shadow))
  1074					return PTR_ERR(a6xx_gpu->shadow);
  1075	
  1076				msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
  1077			}
  1078	
  1079			gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR_LO,
  1080				REG_A6XX_CP_RB_RPTR_ADDR_HI,
  1081				shadowptr(a6xx_gpu, gpu->rb[0]));
  1082		}
  1083	
  1084		/* Always come up on rb 0 */
  1085		a6xx_gpu->cur_ring = gpu->rb[0];
  1086	
  1087		gpu->cur_ctx_seqno = 0;
  1088	
  1089		/* Enable the SQE_to start the CP engine */
  1090		gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
  1091	
  1092		ret = a6xx_cp_init(gpu);
  1093		if (ret)
  1094			goto out;
  1095	
  1096		/*
  1097		 * Try to load a zap shader into the secure world. If successful
  1098		 * we can use the CP to switch out of secure mode. If not then we
  1099		 * have no resource but to try to switch ourselves out manually. If we
  1100		 * guessed wrong then access to the RBBM_SECVID_TRUST_CNTL register will
  1101		 * be blocked and a permissions violation will soon follow.
  1102		 */
  1103		ret = a6xx_zap_shader_init(gpu);
  1104		if (!ret) {
  1105			OUT_PKT7(gpu->rb[0], CP_SET_SECURE_MODE, 1);
  1106			OUT_RING(gpu->rb[0], 0x00000000);
  1107	
  1108			a6xx_flush(gpu, gpu->rb[0]);
  1109			if (!a6xx_idle(gpu, gpu->rb[0]))
  1110				return -EINVAL;
  1111		} else if (ret == -ENODEV) {
  1112			static bool first = true;
  1113			if (first) {
  1114				void __iomem *reg = ioremap(0x05060000, 0x1000);
> 1115				writeq(0x48000, reg); /* offset of cb0 from gpu's base */
  1116				iounmap(reg);
  1117			}
  1118			/*
  1119			 * This device does not use zap shader (but print a warning
  1120			 * just in case someone got their dt wrong.. hopefully they
  1121			 * have a debug UART to realize the error of their ways...
  1122			 * if you mess this up you are about to crash horribly)
  1123			 */
  1124			dev_warn_once(gpu->dev->dev,
  1125				"Zap shader not enabled - using SECVID_TRUST_CNTL instead\n");
  1126			gpu_write(gpu, REG_A6XX_RBBM_SECVID_TRUST_CNTL, 0x0);
  1127			ret = 0;
  1128		} else {
  1129			return ret;
  1130		}
  1131	
  1132	out:
  1133		/*
  1134		 * Tell the GMU that we are done touching the GPU and it can start power
  1135		 * management
  1136		 */
  1137		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
  1138	
  1139		if (a6xx_gpu->gmu.legacy) {
  1140			/* Take the GMU out of its special boot mode */
  1141			a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
  1142		}
  1143	
  1144		return ret;
  1145	}
  1146	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
