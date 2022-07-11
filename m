Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF5564A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiGCXIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGCXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:08:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692432AD2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656889719; x=1688425719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AN+uYUAeRXG5Qw5P6ZCCXYGvFyjv5RiaHLKCZSSoxfs=;
  b=dDOrVcKqdpsH2Jb8GEUfC0fB2+mBZ7gYugJlu4FTYSKNjCZiuieJtKZx
   xlsTIeJXbO1c+3rN4ajezlTYDnmSoMrOs+S4I3U8Wi4QWKCHxdhQLoull
   sGlmAu6L0Ne+TPdezmF6qYET/F4Gszjl++DweEyucnrjZX+a+t6W1Jvcl
   CaFHme2eHT9szt/tnXpWY+VfO3jOsWCltnIGaKGbl4v6iSgJP8cisd+YM
   a797Pv5UpqncoLnyqniMF6yWc3PvMJ5Yup4/I7ckADgve3dItX611odBn
   /xa6/z9/UHuPHUEpcDwJM3n6qAgbD0EXZv1QcxZ76E0ui0Bak5EBNkSZq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283021962"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283021962"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 16:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="589884986"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2022 16:08:37 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o88hg-000H6x-IZ;
        Sun, 03 Jul 2022 23:08:36 +0000
Date:   Mon, 4 Jul 2022 07:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1078:12: warning: stack frame
 size (1040) exceeds limit (1024) in 'vcn_v3_0_start'
Message-ID: <202207040616.wrFXupIJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b8d5109f50969ead9d49c3e8bd78ec1f82e548e3
commit: 123db17ddff007080d464e785689fb14f94cbc7a Merge tag 'amd-drm-next-5.18-2022-02-11-1' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
date:   5 months ago
config: mips-randconfig-r013-20220703 (https://download.01.org/0day-ci/archive/20220704/202207040616.wrFXupIJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5d787689b14574fe58ba9798563f4a6df6059fbf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=123db17ddff007080d464e785689fb14f94cbc7a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 123db17ddff007080d464e785689fb14f94cbc7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1078:12: warning: stack frame size (1040) exceeds limit (1024) in 'vcn_v3_0_start' [-Wframe-larger-than]
   static int vcn_v3_0_start(struct amdgpu_device *adev)
              ^
   1 warning generated.


vim +/vcn_v3_0_start +1078 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c

ec2d0577b466c2 Boyuan Zhang                2020-03-27  1077  
cf14826cdfb5c9 Leo Liu                     2019-11-15 @1078  static int vcn_v3_0_start(struct amdgpu_device *adev)
cf14826cdfb5c9 Leo Liu                     2019-11-15  1079  {
e42dd87e70e66a Sonny Jiang                 2020-11-27  1080  	volatile struct amdgpu_fw_shared *fw_shared;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1081  	struct amdgpu_ring *ring;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1082  	uint32_t rb_bufsz, tmp;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1083  	int i, j, k, r;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1084  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1085  	if (adev->pm.dpm_enabled)
cf14826cdfb5c9 Leo Liu                     2019-11-15  1086  		amdgpu_dpm_enable_uvd(adev, true);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1087  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1088  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
cf14826cdfb5c9 Leo Liu                     2019-11-15  1089  		if (adev->vcn.harvest_config & (1 << i))
cf14826cdfb5c9 Leo Liu                     2019-11-15  1090  			continue;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1091  
ec2d0577b466c2 Boyuan Zhang                2020-03-27  1092  		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG){
ec2d0577b466c2 Boyuan Zhang                2020-03-27  1093  			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
ec2d0577b466c2 Boyuan Zhang                2020-03-27  1094  			continue;
ec2d0577b466c2 Boyuan Zhang                2020-03-27  1095  		}
ec2d0577b466c2 Boyuan Zhang                2020-03-27  1096  
fedac0155a1c28 Leo Liu                     2019-11-27  1097  		/* disable VCN power gating */
fedac0155a1c28 Leo Liu                     2019-11-27  1098  		vcn_v3_0_disable_static_power_gating(adev, i);
fedac0155a1c28 Leo Liu                     2019-11-27  1099  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1100  		/* set VCN status busy */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1101  		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1102  		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1103  
fedac0155a1c28 Leo Liu                     2019-11-27  1104  		/*SW clock gating */
fedac0155a1c28 Leo Liu                     2019-11-27  1105  		vcn_v3_0_disable_clock_gating(adev, i);
fedac0155a1c28 Leo Liu                     2019-11-27  1106  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1107  		/* enable VCPU clock */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1108  		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
cf14826cdfb5c9 Leo Liu                     2019-11-15  1109  			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1110  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1111  		/* disable master interrupt */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1112  		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1113  			~UVD_MASTINT_EN__VCPU_EN_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1114  
d6b0185b8dc738 Leo Liu                     2020-01-28  1115  		/* enable LMI MC and UMC channels */
d6b0185b8dc738 Leo Liu                     2020-01-28  1116  		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
d6b0185b8dc738 Leo Liu                     2020-01-28  1117  			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
d6b0185b8dc738 Leo Liu                     2020-01-28  1118  
d6b0185b8dc738 Leo Liu                     2020-01-28  1119  		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
d6b0185b8dc738 Leo Liu                     2020-01-28  1120  		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
d6b0185b8dc738 Leo Liu                     2020-01-28  1121  		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
d6b0185b8dc738 Leo Liu                     2020-01-28  1122  		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
d6b0185b8dc738 Leo Liu                     2020-01-28  1123  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1124  		/* setup mmUVD_LMI_CTRL */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1125  		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1126  		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1127  			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
cf14826cdfb5c9 Leo Liu                     2019-11-15  1128  			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1129  			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1130  			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1131  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1132  		/* setup mmUVD_MPC_CNTL */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1133  		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1134  		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1135  		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1136  		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1137  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1138  		/* setup UVD_MPC_SET_MUXA0 */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1139  		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1140  			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1141  			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1142  			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1143  			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1144  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1145  		/* setup UVD_MPC_SET_MUXB0 */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1146  		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1147  			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1148  			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1149  			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1150  			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1151  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1152  		/* setup mmUVD_MPC_SET_MUX */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1153  		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1154  			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1155  			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
cf14826cdfb5c9 Leo Liu                     2019-11-15  1156  			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1157  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1158  		vcn_v3_0_mc_resume(adev, i);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1159  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1160  		/* VCN global tiling registers */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1161  		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1162  			adev->gfx.config.gb_addr_config);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1163  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1164  		/* unblock VCPU register access */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1165  		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1166  			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1167  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1168  		/* release VCPU reset to boot */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1169  		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1170  			~UVD_VCPU_CNTL__BLK_RST_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1171  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1172  		for (j = 0; j < 10; ++j) {
cf14826cdfb5c9 Leo Liu                     2019-11-15  1173  			uint32_t status;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1174  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1175  			for (k = 0; k < 100; ++k) {
cf14826cdfb5c9 Leo Liu                     2019-11-15  1176  				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1177  				if (status & 2)
cf14826cdfb5c9 Leo Liu                     2019-11-15  1178  					break;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1179  				mdelay(10);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1180  			}
cf14826cdfb5c9 Leo Liu                     2019-11-15  1181  			r = 0;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1182  			if (status & 2)
cf14826cdfb5c9 Leo Liu                     2019-11-15  1183  				break;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1184  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1185  			DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1186  			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
cf14826cdfb5c9 Leo Liu                     2019-11-15  1187  				UVD_VCPU_CNTL__BLK_RST_MASK,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1188  				~UVD_VCPU_CNTL__BLK_RST_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1189  			mdelay(10);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1190  			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1191  				~UVD_VCPU_CNTL__BLK_RST_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1192  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1193  			mdelay(10);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1194  			r = -1;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1195  		}
cf14826cdfb5c9 Leo Liu                     2019-11-15  1196  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1197  		if (r) {
cf14826cdfb5c9 Leo Liu                     2019-11-15  1198  			DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1199  			return r;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1200  		}
cf14826cdfb5c9 Leo Liu                     2019-11-15  1201  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1202  		/* enable master interrupt */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1203  		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
cf14826cdfb5c9 Leo Liu                     2019-11-15  1204  			UVD_MASTINT_EN__VCPU_EN_MASK,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1205  			~UVD_MASTINT_EN__VCPU_EN_MASK);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1206  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1207  		/* clear the busy bit of VCN_STATUS */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1208  		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1209  			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1210  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1211  		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1212  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1213  		ring = &adev->vcn.inst[i].ring_dec;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1214  		/* force RBC into idle state */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1215  		rb_bufsz = order_base_2(ring->ring_size);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1216  		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1217  		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1218  		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1219  		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1220  		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1221  		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1222  
e42dd87e70e66a Sonny Jiang                 2020-11-27  1223  		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
e42dd87e70e66a Sonny Jiang                 2020-11-27  1224  		fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
e42dd87e70e66a Sonny Jiang                 2020-11-27  1225  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1226  		/* programm the RB_BASE for ring buffer */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1227  		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1228  			lower_32_bits(ring->gpu_addr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1229  		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1230  			upper_32_bits(ring->gpu_addr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1231  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1232  		/* Initialize the ring buffer's read and write pointers */
cf14826cdfb5c9 Leo Liu                     2019-11-15  1233  		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1234  
b2576c3bf4ce9b Sonny Jiang                 2021-01-31  1235  		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1236  		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1237  		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
cf14826cdfb5c9 Leo Liu                     2019-11-15  1238  			lower_32_bits(ring->wptr));
b2576c3bf4ce9b Sonny Jiang                 2021-01-31  1239  		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
e42dd87e70e66a Sonny Jiang                 2020-11-27  1240  		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
e42dd87e70e66a Sonny Jiang                 2020-11-27  1241  
1d789535a03679 Alex Deucher                2021-10-04  1242  		if (adev->ip_versions[UVD_HWIP][0] != IP_VERSION(3, 0, 33)) {
e42dd87e70e66a Sonny Jiang                 2020-11-27  1243  			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1244  			ring = &adev->vcn.inst[i].ring_enc[0];
cf14826cdfb5c9 Leo Liu                     2019-11-15  1245  			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1246  			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1247  			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1248  			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1249  			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
e42dd87e70e66a Sonny Jiang                 2020-11-27  1250  			fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1251  
e42dd87e70e66a Sonny Jiang                 2020-11-27  1252  			fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1253  			ring = &adev->vcn.inst[i].ring_enc[1];
cf14826cdfb5c9 Leo Liu                     2019-11-15  1254  			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1255  			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1256  			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1257  			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
cf14826cdfb5c9 Leo Liu                     2019-11-15  1258  			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
e42dd87e70e66a Sonny Jiang                 2020-11-27  1259  			fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
cf14826cdfb5c9 Leo Liu                     2019-11-15  1260  		}
f703d4b6f20688 Veerabadhran Gopalakrishnan 2021-03-11  1261  	}
cf14826cdfb5c9 Leo Liu                     2019-11-15  1262  
cf14826cdfb5c9 Leo Liu                     2019-11-15  1263  	return 0;
cf14826cdfb5c9 Leo Liu                     2019-11-15  1264  }
cf14826cdfb5c9 Leo Liu                     2019-11-15  1265  

:::::: The code at line 1078 was first introduced by commit
:::::: cf14826cdfb5c9fe10f98210d040b9d7486c381d drm/amdgpu: add VCN3.0 support for Sienna_Cichlid

:::::: TO: Leo Liu <leo.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
