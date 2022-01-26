Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDC49C80D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbiAZKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:52:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:51786 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240330AbiAZKwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643194370; x=1674730370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=99XIoflJfVvEWt32oDXv5e98RYwNF7ZbngfWc3mKumg=;
  b=IOt9bkcgPtV1NPsP+dFLqPf7fuGLF09qAnt/ggSWOCAbP6z1gjuSGG+n
   HuUxF8iymBxiBgLJL9lrsT70un46zuqXVbFG8jPmh04BydaQNZxKN1+Ae
   jrP1MK5Bf2LPmQwOZT0Dtqi1DSk5Sxdyxql5hKa5bPO6KVgOQgoLJ56j4
   qr0NeyLCFCuqLmSid1lk0H5ES3r3j3KEeNFcFrFsRRdwnSUQG/liOJYeo
   GWvWRllMiHvdWWzt+uOqTUiBhDsX9fucqZ1xM2LG41Mm0AieW2TX3nwix
   7EicWCuuvsG+IwG7Ujfy5GYboc1TJ+pHEh6uh0T6DECZjxu6l/ghi+fob
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227197745"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="227197745"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 02:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="495322483"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2022 02:52:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCfux-000L69-6f; Wed, 26 Jan 2022 10:52:47 +0000
Date:   Wed, 26 Jan 2022 18:52:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>
Subject: [agd5f:drm-next 150/190]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:213:6:
 warning: no previous prototype for function
 'retrieve_downstream_port_device'
Message-ID: <202201261822.GyXGxsid-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   63e583c8843f305a3e334a96d5de00435f4d38a2
commit: 09db246ceef70bc6bd9c3e0d02b3c855f8fc25fb [150/190] drm/amd/display: Retrieve MST Downstream Port Status
config: i386-randconfig-a013-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261822.GyXGxsid-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 09db246ceef70bc6bd9c3e0d02b3c855f8fc25fb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:43:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2918:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
                   uint64_t temp;
                            ^
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:213:6: warning: no previous prototype for function 'retrieve_downstream_port_device' [-Wmissing-prototypes]
   bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:213:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
   ^
   static 
   2 warnings generated.


vim +/retrieve_downstream_port_device +213 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c

    41	
    42	#include "i2caux_interface.h"
  > 43	#include "dmub_cmd.h"
    44	#if defined(CONFIG_DEBUG_FS)
    45	#include "amdgpu_dm_debugfs.h"
    46	#endif
    47	
    48	#if defined(CONFIG_DRM_AMD_DC_DCN)
    49	#include "dc/dcn20/dcn20_resource.h"
    50	#endif
    51	
    52	static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
    53					  struct drm_dp_aux_msg *msg)
    54	{
    55		ssize_t result = 0;
    56		struct aux_payload payload;
    57		enum aux_return_code_type operation_result;
    58	
    59		if (WARN_ON(msg->size > 16))
    60			return -E2BIG;
    61	
    62		payload.address = msg->address;
    63		payload.data = msg->buffer;
    64		payload.length = msg->size;
    65		payload.reply = &msg->reply;
    66		payload.i2c_over_aux = (msg->request & DP_AUX_NATIVE_WRITE) == 0;
    67		payload.write = (msg->request & DP_AUX_I2C_READ) == 0;
    68		payload.mot = (msg->request & DP_AUX_I2C_MOT) != 0;
    69		payload.write_status_update =
    70				(msg->request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
    71		payload.defer_delay = 0;
    72	
    73		result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
    74					      &operation_result);
    75	
    76		if (payload.write && result >= 0)
    77			result = msg->size;
    78	
    79		if (result < 0)
    80			switch (operation_result) {
    81			case AUX_RET_SUCCESS:
    82				break;
    83			case AUX_RET_ERROR_HPD_DISCON:
    84			case AUX_RET_ERROR_UNKNOWN:
    85			case AUX_RET_ERROR_INVALID_OPERATION:
    86			case AUX_RET_ERROR_PROTOCOL_ERROR:
    87				result = -EIO;
    88				break;
    89			case AUX_RET_ERROR_INVALID_REPLY:
    90			case AUX_RET_ERROR_ENGINE_ACQUIRE:
    91				result = -EBUSY;
    92				break;
    93			case AUX_RET_ERROR_TIMEOUT:
    94				result = -ETIMEDOUT;
    95				break;
    96			}
    97	
    98		return result;
    99	}
   100	
   101	static void
   102	dm_dp_mst_connector_destroy(struct drm_connector *connector)
   103	{
   104		struct amdgpu_dm_connector *aconnector =
   105			to_amdgpu_dm_connector(connector);
   106	
   107		if (aconnector->dc_sink) {
   108			dc_link_remove_remote_sink(aconnector->dc_link,
   109						   aconnector->dc_sink);
   110			dc_sink_release(aconnector->dc_sink);
   111		}
   112	
   113		kfree(aconnector->edid);
   114	
   115		drm_connector_cleanup(connector);
   116		drm_dp_mst_put_port_malloc(aconnector->port);
   117		kfree(aconnector);
   118	}
   119	
   120	static int
   121	amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
   122	{
   123		struct amdgpu_dm_connector *amdgpu_dm_connector =
   124			to_amdgpu_dm_connector(connector);
   125		int r;
   126	
   127		r = drm_dp_mst_connector_late_register(connector,
   128						       amdgpu_dm_connector->port);
   129		if (r < 0)
   130			return r;
   131	
   132	#if defined(CONFIG_DEBUG_FS)
   133		connector_debugfs_init(amdgpu_dm_connector);
   134	#endif
   135	
   136		return 0;
   137	}
   138	
   139	static void
   140	amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
   141	{
   142		struct amdgpu_dm_connector *amdgpu_dm_connector =
   143			to_amdgpu_dm_connector(connector);
   144		struct drm_dp_mst_port *port = amdgpu_dm_connector->port;
   145	
   146		drm_dp_mst_connector_early_unregister(connector, port);
   147	}
   148	
   149	static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
   150		.fill_modes = drm_helper_probe_single_connector_modes,
   151		.destroy = dm_dp_mst_connector_destroy,
   152		.reset = amdgpu_dm_connector_funcs_reset,
   153		.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
   154		.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
   155		.atomic_set_property = amdgpu_dm_connector_atomic_set_property,
   156		.atomic_get_property = amdgpu_dm_connector_atomic_get_property,
   157		.late_register = amdgpu_dm_mst_connector_late_register,
   158		.early_unregister = amdgpu_dm_mst_connector_early_unregister,
   159	};
   160	
   161	#if defined(CONFIG_DRM_AMD_DC_DCN)
   162	bool needs_dsc_aux_workaround(struct dc_link *link)
   163	{
   164		if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
   165		    (link->dpcd_caps.dpcd_rev.raw == DPCD_REV_14 || link->dpcd_caps.dpcd_rev.raw == DPCD_REV_12) &&
   166		    link->dpcd_caps.sink_count.bits.SINK_COUNT >= 2)
   167			return true;
   168	
   169		return false;
   170	}
   171	
   172	static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
   173	{
   174		struct dc_sink *dc_sink = aconnector->dc_sink;
   175		struct drm_dp_mst_port *port = aconnector->port;
   176		u8 dsc_caps[16] = { 0 };
   177		u8 dsc_branch_dec_caps_raw[3] = { 0 };	// DSC branch decoder caps 0xA0 ~ 0xA2
   178		u8 *dsc_branch_dec_caps = NULL;
   179	
   180		aconnector->dsc_aux = drm_dp_mst_dsc_aux_for_port(port);
   181	
   182		/*
   183		 * drm_dp_mst_dsc_aux_for_port() will return NULL for certain configs
   184		 * because it only check the dsc/fec caps of the "port variable" and not the dock
   185		 *
   186		 * This case will return NULL: DSC capabe MST dock connected to a non fec/dsc capable display
   187		 *
   188		 * Workaround: explicitly check the use case above and use the mst dock's aux as dsc_aux
   189		 *
   190		 */
   191		if (!aconnector->dsc_aux && !port->parent->port_parent &&
   192		    needs_dsc_aux_workaround(aconnector->dc_link))
   193			aconnector->dsc_aux = &aconnector->mst_port->dm_dp_aux.aux;
   194	
   195		if (!aconnector->dsc_aux)
   196			return false;
   197	
   198		if (drm_dp_dpcd_read(aconnector->dsc_aux, DP_DSC_SUPPORT, dsc_caps, 16) < 0)
   199			return false;
   200	
   201		if (drm_dp_dpcd_read(aconnector->dsc_aux,
   202				DP_DSC_BRANCH_OVERALL_THROUGHPUT_0, dsc_branch_dec_caps_raw, 3) == 3)
   203			dsc_branch_dec_caps = dsc_branch_dec_caps_raw;
   204	
   205		if (!dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
   206					  dsc_caps, dsc_branch_dec_caps,
   207					  &dc_sink->dsc_caps.dsc_dec_caps))
   208			return false;
   209	
   210		return true;
   211	}
   212	
 > 213	bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
   214	{
   215		union dp_downstream_port_present ds_port_present;
   216	
   217		if (!aconnector->dsc_aux)
   218			return false;
   219	
   220		if (drm_dp_dpcd_read(aconnector->dsc_aux, DP_DOWNSTREAMPORT_PRESENT, &ds_port_present, 1) < 0) {
   221			DRM_INFO("Failed to read downstream_port_present 0x05 from DFP of branch device\n");
   222			return false;
   223		}
   224	
   225		aconnector->mst_downstream_port_present = ds_port_present;
   226		DRM_INFO("Downstream port present %d, type %d\n",
   227				ds_port_present.fields.PORT_PRESENT, ds_port_present.fields.PORT_TYPE);
   228	
   229		return true;
   230	}
   231	#endif
   232	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
