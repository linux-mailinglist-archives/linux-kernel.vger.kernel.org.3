Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93C49AB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S254806AbiAYEqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:46:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:14177 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1326941AbiAYDnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643082216; x=1674618216;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ftj6jgx8RwpkP0vXmNcC3D4q/G2CggJO85GIv+Ix1nQ=;
  b=cGhlpeBYFDNti2Osz+phK5tcfR7mfSj06CkZuxBrZYkqYQ7e9/X4NPVA
   3wZ+bJeHYHui8jmMrg952BhlJ3vOpJYDf8yK4eXymfAz1KuhcU4o4l1k5
   xZXkI+0LphL/9MXsoMoGg3zwzzrSsRIx1ld+knnGco2T1R6JwsyNks7jW
   E9fs4FWPy39ROXB6t0Z5UbFJ9FsLhglSxohc+/lQKNn+4ybCAxs3Vc+0g
   eSbHxcV8BCbsmYipjd7C+Cwt3Xg71j6WGoNaTjQ+P3t/8olDYXeHG0bG1
   7WnJH/oyDxR/93BX3gICgi8VKiUz1eqosERyM++fzHUqpQrA0AxTdccO6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309529285"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="309529285"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="627753001"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 19:38:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCCey-000JIb-P4; Tue, 25 Jan 2022 03:38:20 +0000
Date:   Tue, 25 Jan 2022 11:37:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 8/165] drivers/gpu/drm/xe/xe_pci.c:1230:39: error:
 'adl_p_info' defined but not used
Message-ID: <202201251102.C8Uyp5F7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 6fc3424d304d6766e3abe371a586b83fc10d625f [8/165] drm/xe: Initial commit
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201251102.C8Uyp5F7-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 6fc3424d304d6766e3abe371a586b83fc10d625f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/xe/xe_pci.c:1373:5: error: no previous prototype for 'i915_register_pci_driver' [-Werror=missing-prototypes]
    1373 | int i915_register_pci_driver(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:1378:6: error: no previous prototype for 'i915_unregister_pci_driver' [-Werror=missing-prototypes]
    1378 | void i915_unregister_pci_driver(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1230:39: error: 'adl_p_info' defined but not used [-Werror=unused-const-variable=]
    1230 | static const struct intel_device_info adl_p_info = {
         |                                       ^~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1175:39: error: 'adl_s_info' defined but not used [-Werror=unused-const-variable=]
    1175 | static const struct intel_device_info adl_s_info = {
         |                                       ^~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1142:39: error: 'rkl_info' defined but not used [-Werror=unused-const-variable=]
    1142 | static const struct intel_device_info rkl_info = {
         |                                       ^~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:1134:39: error: 'tgl_info' defined but not used [-Werror=unused-const-variable=]
    1134 | static const struct intel_device_info tgl_info = {
         |                                       ^~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1099:39: error: 'jsl_info' defined but not used [-Werror=unused-const-variable=]
    1099 | static const struct intel_device_info jsl_info = {
         |                                       ^~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1092:39: error: 'ehl_info' defined but not used [-Werror=unused-const-variable=]
    1092 | static const struct intel_device_info ehl_info = {
         |                                       ^~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1085:39: error: 'icl_info' defined but not used [-Werror=unused-const-variable=]
    1085 | static const struct intel_device_info icl_info = {
         |                                       ^~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1045:39: error: 'cnl_info' defined but not used [-Werror=unused-const-variable=]
    1045 | static const struct intel_device_info cnl_info = {
         |                                       ^~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1032:39: error: 'cml_gt2_info' defined but not used [-Werror=unused-const-variable=]
    1032 | static const struct intel_device_info cml_gt2_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1027:39: error: 'cml_gt1_info' defined but not used [-Werror=unused-const-variable=]
    1027 | static const struct intel_device_info cml_gt1_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1016:39: error: 'cfl_gt3_info' defined but not used [-Werror=unused-const-variable=]
    1016 | static const struct intel_device_info cfl_gt3_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1011:39: error: 'cfl_gt2_info' defined but not used [-Werror=unused-const-variable=]
    1011 | static const struct intel_device_info cfl_gt2_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:1006:39: error: 'cfl_gt1_info' defined but not used [-Werror=unused-const-variable=]
    1006 | static const struct intel_device_info cfl_gt1_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:995:39: error: 'kbl_gt3_info' defined but not used [-Werror=unused-const-variable=]
     995 | static const struct intel_device_info kbl_gt3_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:990:39: error: 'kbl_gt2_info' defined but not used [-Werror=unused-const-variable=]
     990 | static const struct intel_device_info kbl_gt2_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:985:39: error: 'kbl_gt1_info' defined but not used [-Werror=unused-const-variable=]
     985 | static const struct intel_device_info kbl_gt1_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:973:39: error: 'glk_info' defined but not used [-Werror=unused-const-variable=]
     973 | static const struct intel_device_info glk_info = {
         |                                       ^~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:967:39: error: 'bxt_info' defined but not used [-Werror=unused-const-variable=]
     967 | static const struct intel_device_info bxt_info = {
         |                                       ^~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:925:39: error: 'skl_gt4_info' defined but not used [-Werror=unused-const-variable=]
     925 | static const struct intel_device_info skl_gt4_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:920:39: error: 'skl_gt3_info' defined but not used [-Werror=unused-const-variable=]
     920 | static const struct intel_device_info skl_gt3_info = {
         |                                       ^~~~~~~~~~~~
>> drivers/gpu/drm/xe/xe_pci.c:909:39: error: 'skl_gt2_info' defined but not used [-Werror=unused-const-variable=]
     909 | static const struct intel_device_info skl_gt2_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:904:39: error: 'skl_gt1_info' defined but not used [-Werror=unused-const-variable=]
     904 | static const struct intel_device_info skl_gt1_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:857:39: error: 'chv_info' defined but not used [-Werror=unused-const-variable=]
     857 | static const struct intel_device_info chv_info = {
         |                                       ^~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:850:39: error: 'bdw_gt3_info' defined but not used [-Werror=unused-const-variable=]
     850 | static const struct intel_device_info bdw_gt3_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:842:39: error: 'bdw_rsvd_info' defined but not used [-Werror=unused-const-variable=]
     842 | static const struct intel_device_info bdw_rsvd_info = {
         |                                       ^~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:837:39: error: 'bdw_gt2_info' defined but not used [-Werror=unused-const-variable=]
     837 | static const struct intel_device_info bdw_gt2_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:832:39: error: 'bdw_gt1_info' defined but not used [-Werror=unused-const-variable=]
     832 | static const struct intel_device_info bdw_gt1_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:814:39: error: 'hsw_gt3_info' defined but not used [-Werror=unused-const-variable=]
     814 | static const struct intel_device_info hsw_gt3_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:809:39: error: 'hsw_gt2_info' defined but not used [-Werror=unused-const-variable=]
     809 | static const struct intel_device_info hsw_gt2_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:804:39: error: 'hsw_gt1_info' defined but not used [-Werror=unused-const-variable=]
     804 | static const struct intel_device_info hsw_gt1_info = {
         |                                       ^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:759:39: error: 'vlv_info' defined but not used [-Werror=unused-const-variable=]
     759 | static const struct intel_device_info vlv_info = {
         |                                       ^~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:750:39: error: 'ivb_q_info' defined but not used [-Werror=unused-const-variable=]
     750 | static const struct intel_device_info ivb_q_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:745:39: error: 'ivb_m_gt2_info' defined but not used [-Werror=unused-const-variable=]
     745 | static const struct intel_device_info ivb_m_gt2_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:740:39: error: 'ivb_m_gt1_info' defined but not used [-Werror=unused-const-variable=]
     740 | static const struct intel_device_info ivb_m_gt1_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:729:39: error: 'ivb_d_gt2_info' defined but not used [-Werror=unused-const-variable=]
     729 | static const struct intel_device_info ivb_d_gt2_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:724:39: error: 'ivb_d_gt1_info' defined but not used [-Werror=unused-const-variable=]
     724 | static const struct intel_device_info ivb_d_gt1_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:692:39: error: 'snb_m_gt2_info' defined but not used [-Werror=unused-const-variable=]
     692 | static const struct intel_device_info snb_m_gt2_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:687:39: error: 'snb_m_gt1_info' defined but not used [-Werror=unused-const-variable=]
     687 | static const struct intel_device_info snb_m_gt1_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:676:39: error: 'snb_d_gt2_info' defined but not used [-Werror=unused-const-variable=]
     676 | static const struct intel_device_info snb_d_gt2_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:671:39: error: 'snb_d_gt1_info' defined but not used [-Werror=unused-const-variable=]
     671 | static const struct intel_device_info snb_d_gt1_info = {
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:638:39: error: 'ilk_m_info' defined but not used [-Werror=unused-const-variable=]
     638 | static const struct intel_device_info ilk_m_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:633:39: error: 'ilk_d_info' defined but not used [-Werror=unused-const-variable=]
     633 | static const struct intel_device_info ilk_d_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:606:39: error: 'gm45_info' defined but not used [-Werror=unused-const-variable=]
     606 | static const struct intel_device_info gm45_info = {
         |                                       ^~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:599:39: error: 'g45_info' defined but not used [-Werror=unused-const-variable=]
     599 | static const struct intel_device_info g45_info = {
         |                                       ^~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:588:39: error: 'i965gm_info' defined but not used [-Werror=unused-const-variable=]
     588 | static const struct intel_device_info i965gm_info = {
         |                                       ^~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:580:39: error: 'i965g_info' defined but not used [-Werror=unused-const-variable=]
     580 | static const struct intel_device_info i965g_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:554:39: error: 'pnv_m_info' defined but not used [-Werror=unused-const-variable=]
     554 | static const struct intel_device_info pnv_m_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:546:39: error: 'pnv_g_info' defined but not used [-Werror=unused-const-variable=]
     546 | static const struct intel_device_info pnv_g_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:538:39: error: 'g33_info' defined but not used [-Werror=unused-const-variable=]
     538 | static const struct intel_device_info g33_info = {
         |                                       ^~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:524:39: error: 'i945gm_info' defined but not used [-Werror=unused-const-variable=]
     524 | static const struct intel_device_info i945gm_info = {
         |                                       ^~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:513:39: error: 'i945g_info' defined but not used [-Werror=unused-const-variable=]
     513 | static const struct intel_device_info i945g_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:500:39: error: 'i915gm_info' defined but not used [-Werror=unused-const-variable=]
     500 | static const struct intel_device_info i915gm_info = {
         |                                       ^~~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:489:39: error: 'i915g_info' defined but not used [-Werror=unused-const-variable=]
     489 | static const struct intel_device_info i915g_info = {
         |                                       ^~~~~~~~~~
   drivers/gpu/drm/xe/xe_pci.c:467:39: error: 'i865g_info' defined but not used [-Werror=unused-const-variable=]
     467 | static const struct intel_device_info i865g_info = {


vim +/adl_p_info +1230 drivers/gpu/drm/xe/xe_pci.c

  1031	
> 1032	static const struct intel_device_info cml_gt2_info = {
  1033		CML_PLATFORM,
  1034		.gt = 2,
  1035	};
  1036	
  1037	#define GEN10_FEATURES \
  1038		GEN9_FEATURES, \
  1039		GEN(10), \
  1040		.dbuf.size = 1024 - 4, /* 4 blocks for bypass path allocation */ \
  1041		.display.has_dsc = 1, \
  1042		.has_coherent_ggtt = false, \
  1043		GLK_COLORS
  1044	
> 1045	static const struct intel_device_info cnl_info = {
  1046		GEN10_FEATURES,
  1047		PLATFORM(INTEL_CANNONLAKE),
  1048		.gt = 2,
  1049	};
  1050	
  1051	#define GEN11_DEFAULT_PAGE_SIZES \
  1052		.page_sizes = I915_GTT_PAGE_SIZE_4K | \
  1053			      I915_GTT_PAGE_SIZE_64K | \
  1054			      I915_GTT_PAGE_SIZE_2M
  1055	
  1056	#define GEN11_FEATURES \
  1057		GEN10_FEATURES, \
  1058		GEN11_DEFAULT_PAGE_SIZES, \
  1059		.abox_mask = BIT(0), \
  1060		.cpu_transcoder_mask = BIT(TRANSCODER_A) | BIT(TRANSCODER_B) | \
  1061			BIT(TRANSCODER_C) | BIT(TRANSCODER_EDP) | \
  1062			BIT(TRANSCODER_DSI_0) | BIT(TRANSCODER_DSI_1), \
  1063		.pipe_offsets = { \
  1064			[TRANSCODER_A] = PIPE_A_OFFSET, \
  1065			[TRANSCODER_B] = PIPE_B_OFFSET, \
  1066			[TRANSCODER_C] = PIPE_C_OFFSET, \
  1067			[TRANSCODER_EDP] = PIPE_EDP_OFFSET, \
  1068			[TRANSCODER_DSI_0] = PIPE_DSI0_OFFSET, \
  1069			[TRANSCODER_DSI_1] = PIPE_DSI1_OFFSET, \
  1070		}, \
  1071		.trans_offsets = { \
  1072			[TRANSCODER_A] = TRANSCODER_A_OFFSET, \
  1073			[TRANSCODER_B] = TRANSCODER_B_OFFSET, \
  1074			[TRANSCODER_C] = TRANSCODER_C_OFFSET, \
  1075			[TRANSCODER_EDP] = TRANSCODER_EDP_OFFSET, \
  1076			[TRANSCODER_DSI_0] = TRANSCODER_DSI0_OFFSET, \
  1077			[TRANSCODER_DSI_1] = TRANSCODER_DSI1_OFFSET, \
  1078		}, \
  1079		GEN(11), \
  1080		.dbuf.size = 2048, \
  1081		.dbuf.slice_mask = BIT(DBUF_S1) | BIT(DBUF_S2), \
  1082		.has_logical_ring_elsq = 1, \
  1083		.color = { .degamma_lut_size = 33, .gamma_lut_size = 262145 }
  1084	
> 1085	static const struct intel_device_info icl_info = {
  1086		GEN11_FEATURES,
  1087		PLATFORM(INTEL_ICELAKE),
  1088		.platform_engine_mask =
  1089			BIT(RCS0) | BIT(BCS0) | BIT(VECS0) | BIT(VCS0) | BIT(VCS2),
  1090	};
  1091	
> 1092	static const struct intel_device_info ehl_info = {
  1093		GEN11_FEATURES,
  1094		PLATFORM(INTEL_ELKHARTLAKE),
  1095		.platform_engine_mask = BIT(RCS0) | BIT(BCS0) | BIT(VCS0) | BIT(VECS0),
  1096		.ppgtt_size = 36,
  1097	};
  1098	
> 1099	static const struct intel_device_info jsl_info = {
  1100		GEN11_FEATURES,
  1101		PLATFORM(INTEL_JASPERLAKE),
  1102		.platform_engine_mask = BIT(RCS0) | BIT(BCS0) | BIT(VCS0) | BIT(VECS0),
  1103		.ppgtt_size = 36,
  1104	};
  1105	
  1106	#define GEN12_FEATURES \
  1107		GEN11_FEATURES, \
  1108		GEN(12), \
  1109		.abox_mask = GENMASK(2, 1), \
  1110		.pipe_mask = BIT(PIPE_A) | BIT(PIPE_B) | BIT(PIPE_C) | BIT(PIPE_D), \
  1111		.cpu_transcoder_mask = BIT(TRANSCODER_A) | BIT(TRANSCODER_B) | \
  1112			BIT(TRANSCODER_C) | BIT(TRANSCODER_D) | \
  1113			BIT(TRANSCODER_DSI_0) | BIT(TRANSCODER_DSI_1), \
  1114		.pipe_offsets = { \
  1115			[TRANSCODER_A] = PIPE_A_OFFSET, \
  1116			[TRANSCODER_B] = PIPE_B_OFFSET, \
  1117			[TRANSCODER_C] = PIPE_C_OFFSET, \
  1118			[TRANSCODER_D] = PIPE_D_OFFSET, \
  1119			[TRANSCODER_DSI_0] = PIPE_DSI0_OFFSET, \
  1120			[TRANSCODER_DSI_1] = PIPE_DSI1_OFFSET, \
  1121		}, \
  1122		.trans_offsets = { \
  1123			[TRANSCODER_A] = TRANSCODER_A_OFFSET, \
  1124			[TRANSCODER_B] = TRANSCODER_B_OFFSET, \
  1125			[TRANSCODER_C] = TRANSCODER_C_OFFSET, \
  1126			[TRANSCODER_D] = TRANSCODER_D_OFFSET, \
  1127			[TRANSCODER_DSI_0] = TRANSCODER_DSI0_OFFSET, \
  1128			[TRANSCODER_DSI_1] = TRANSCODER_DSI1_OFFSET, \
  1129		}, \
  1130		TGL_CURSOR_OFFSETS, \
  1131		.has_global_mocs = 1, \
  1132		.display.has_dsb = 1
  1133	
  1134	static const struct intel_device_info tgl_info = {
  1135		GEN12_FEATURES,
  1136		PLATFORM(INTEL_TIGERLAKE),
  1137		.display.has_modular_fia = 1,
  1138		.platform_engine_mask =
  1139			BIT(RCS0) | BIT(BCS0) | BIT(VECS0) | BIT(VCS0) | BIT(VCS2),
  1140	};
  1141	
> 1142	static const struct intel_device_info rkl_info = {
  1143		GEN12_FEATURES,
  1144		PLATFORM(INTEL_ROCKETLAKE),
  1145		.abox_mask = BIT(0),
  1146		.pipe_mask = BIT(PIPE_A) | BIT(PIPE_B) | BIT(PIPE_C),
  1147		.cpu_transcoder_mask = BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |
  1148			BIT(TRANSCODER_C),
  1149		.display.has_hti = 1,
  1150		.display.has_psr_hw_tracking = 0,
  1151		.platform_engine_mask =
  1152			BIT(RCS0) | BIT(BCS0) | BIT(VECS0) | BIT(VCS0),
  1153	};
  1154	
  1155	#define DGFX_FEATURES \
  1156		.memory_regions = REGION_SMEM | REGION_LMEM | REGION_STOLEN_LMEM, \
  1157		.has_llc = 0, \
  1158		.has_snoop = 1, \
  1159		.is_dgfx = 1
  1160	
  1161	static const struct intel_device_info dg1_info __maybe_unused = {
  1162		GEN12_FEATURES,
  1163		DGFX_FEATURES,
  1164		.graphics_rel = 10,
  1165		PLATFORM(INTEL_DG1),
  1166		.pipe_mask = BIT(PIPE_A) | BIT(PIPE_B) | BIT(PIPE_C) | BIT(PIPE_D),
  1167		.require_force_probe = 1,
  1168		.platform_engine_mask =
  1169			BIT(RCS0) | BIT(BCS0) | BIT(VECS0) |
  1170			BIT(VCS0) | BIT(VCS2),
  1171		/* Wa_16011227922 */
  1172		.ppgtt_size = 47,
  1173	};
  1174	
> 1175	static const struct intel_device_info adl_s_info = {
  1176		GEN12_FEATURES,
  1177		PLATFORM(INTEL_ALDERLAKE_S),
  1178		.pipe_mask = BIT(PIPE_A) | BIT(PIPE_B) | BIT(PIPE_C) | BIT(PIPE_D),
  1179		.require_force_probe = 1,
  1180		.display.has_hti = 1,
  1181		.display.has_psr_hw_tracking = 0,
  1182		.platform_engine_mask =
  1183			BIT(RCS0) | BIT(BCS0) | BIT(VECS0) | BIT(VCS0) | BIT(VCS2),
  1184		.dma_mask_size = 39,
  1185	};
  1186	
  1187	#define XE_LPD_CURSOR_OFFSETS \
  1188		.cursor_offsets = { \
  1189			[PIPE_A] = CURSOR_A_OFFSET, \
  1190			[PIPE_B] = IVB_CURSOR_B_OFFSET, \
  1191			[PIPE_C] = IVB_CURSOR_C_OFFSET, \
  1192			[PIPE_D] = TGL_CURSOR_D_OFFSET, \
  1193		}
  1194	
  1195	#define XE_LPD_FEATURES \
  1196		.abox_mask = GENMASK(1, 0),						\
  1197		.color = { .degamma_lut_size = 0, .gamma_lut_size = 0 },		\
  1198		.cpu_transcoder_mask = BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |		\
  1199			BIT(TRANSCODER_C) | BIT(TRANSCODER_D),				\
  1200		.dbuf.size = 4096,							\
  1201		.dbuf.slice_mask = BIT(DBUF_S1) | BIT(DBUF_S2) | BIT(DBUF_S3) |		\
  1202			BIT(DBUF_S4),							\
  1203		.display.has_ddi = 1,							\
  1204		.display.has_dmc = 1,							\
  1205		.display.has_dp_mst = 1,						\
  1206		.display.has_dsb = 1,							\
  1207		.display.has_dsc = 1,							\
  1208		.display.has_fbc = 1,							\
  1209		.display.has_fpga_dbg = 1,						\
  1210		.display.has_hdcp = 1,							\
  1211		.display.has_hotplug = 1,						\
  1212		.display.has_ipc = 1,							\
  1213		.display.has_psr = 1,							\
  1214		.display.ver = 13,							\
  1215		.pipe_mask = BIT(PIPE_A) | BIT(PIPE_B) | BIT(PIPE_C) | BIT(PIPE_D),	\
  1216		.pipe_offsets = {							\
  1217			[TRANSCODER_A] = PIPE_A_OFFSET,					\
  1218			[TRANSCODER_B] = PIPE_B_OFFSET,					\
  1219			[TRANSCODER_C] = PIPE_C_OFFSET,					\
  1220			[TRANSCODER_D] = PIPE_D_OFFSET,					\
  1221		},									\
  1222		.trans_offsets = {							\
  1223			[TRANSCODER_A] = TRANSCODER_A_OFFSET,				\
  1224			[TRANSCODER_B] = TRANSCODER_B_OFFSET,				\
  1225			[TRANSCODER_C] = TRANSCODER_C_OFFSET,				\
  1226			[TRANSCODER_D] = TRANSCODER_D_OFFSET,				\
  1227		},									\
  1228		XE_LPD_CURSOR_OFFSETS
  1229	
> 1230	static const struct intel_device_info adl_p_info = {
  1231		GEN12_FEATURES,
  1232		XE_LPD_FEATURES,
  1233		PLATFORM(INTEL_ALDERLAKE_P),
  1234		.require_force_probe = 1,
  1235		.display.has_cdclk_crawl = 1,
  1236		.display.has_modular_fia = 1,
  1237		.display.has_psr_hw_tracking = 0,
  1238		.platform_engine_mask =
  1239			BIT(RCS0) | BIT(BCS0) | BIT(VECS0) | BIT(VCS0) | BIT(VCS2),
  1240		.ppgtt_size = 48,
  1241		.dma_mask_size = 39,
  1242	};
  1243	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
