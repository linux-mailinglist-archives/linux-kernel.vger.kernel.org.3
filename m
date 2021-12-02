Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE284662BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357412AbhLBLw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:52:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:45728 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357341AbhLBLw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:52:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="234201197"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="234201197"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="541203627"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Dec 2021 03:49:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mskaf-000GH2-Lc; Thu, 02 Dec 2021 11:49:29 +0000
Date:   Thu, 2 Dec 2021 19:48:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brett Creeley <brett.creeley@intel.com>
Cc:     kbuild-all@lists.01.org,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Dan Nowlin <dan.nowlin@intel.com>
Subject: [tnguy-next-queue:dev-queue 108/111]
 drivers/net/ethernet/intel/ice/ice_vlan_mode.c:96:31: error: 'ICE_DBG_AQ'
 undeclared; did you mean 'ICE_DBG_LAN'?
Message-ID: <202112021957.1KmfBjqc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   99b52d8ae980f329a6b1c3f2cb76eb31c800a684
commit: 3f419c30541088b1a1b8a7a7197d82c21ba3898c [108/111] ice: Support configuring the device to Double VLAN Mode
config: m68k-randconfig-r014-20211202 (https://download.01.org/0day-ci/archive/20211202/202112021957.1KmfBjqc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=3f419c30541088b1a1b8a7a7197d82c21ba3898c
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 3f419c30541088b1a1b8a7a7197d82c21ba3898c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/ice/ice_type.h:11,
                    from drivers/net/ethernet/intel/ice/ice.h:58,
                    from drivers/net/ethernet/intel/ice/ice_common.h:7,
                    from drivers/net/ethernet/intel/ice/ice_vlan_mode.c:4:
   drivers/net/ethernet/intel/ice/ice_vlan_mode.c: In function 'ice_aq_is_dvm_ena':
>> drivers/net/ethernet/intel/ice/ice_vlan_mode.c:96:31: error: 'ICE_DBG_AQ' undeclared (first use in this function); did you mean 'ICE_DBG_LAN'?
      96 |                 ice_debug(hw, ICE_DBG_AQ, "Failed to get VLAN mode, status %d\n",
         |                               ^~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_osdep.h:42:14: note: in definition of macro 'ice_debug'
      42 |         if ((type) & (hw)->debug_mask)                          \
         |              ^~~~
   drivers/net/ethernet/intel/ice/ice_vlan_mode.c:96:31: note: each undeclared identifier is reported only once for each function it appears in
      96 |                 ice_debug(hw, ICE_DBG_AQ, "Failed to get VLAN mode, status %d\n",
         |                               ^~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_osdep.h:42:14: note: in definition of macro 'ice_debug'
      42 |         if ((type) & (hw)->debug_mask)                          \
         |              ^~~~


vim +96 drivers/net/ethernet/intel/ice/ice_vlan_mode.c

     3	
   > 4	#include "ice_common.h"
     5	
     6	/**
     7	 * ice_pkg_get_supported_vlan_mode - determine if DDP supports Double VLAN mode
     8	 * @hw: pointer to the HW struct
     9	 * @dvm: output variable to determine if DDP supports DVM(true) or SVM(false)
    10	 */
    11	static int
    12	ice_pkg_get_supported_vlan_mode(struct ice_hw *hw, bool *dvm)
    13	{
    14		u16 meta_init_size = sizeof(struct ice_meta_init_section);
    15		struct ice_meta_init_section *sect;
    16		struct ice_buf_build *bld;
    17		int status;
    18	
    19		/* if anything fails, we assume there is no DVM support */
    20		*dvm = false;
    21	
    22		bld = ice_pkg_buf_alloc_single_section(hw,
    23						       ICE_SID_RXPARSER_METADATA_INIT,
    24						       meta_init_size, (void **)&sect);
    25		if (!bld)
    26			return -ENOMEM;
    27	
    28		/* only need to read a single section */
    29		sect->count = cpu_to_le16(1);
    30		sect->offset = cpu_to_le16(ICE_META_VLAN_MODE_ENTRY);
    31	
    32		status = ice_aq_upload_section(hw,
    33					       (struct ice_buf_hdr *)ice_pkg_buf(bld),
    34					       ICE_PKG_BUF_SIZE, NULL);
    35		if (!status) {
    36			DECLARE_BITMAP(entry, ICE_META_INIT_BITS);
    37			u32 arr[ICE_META_INIT_DW_CNT];
    38			u16 i;
    39	
    40			/* convert to host bitmap format */
    41			for (i = 0; i < ICE_META_INIT_DW_CNT; i++)
    42				arr[i] = le32_to_cpu(sect->entry.bm[i]);
    43	
    44			bitmap_from_arr32(entry, arr, (u16)ICE_META_INIT_BITS);
    45	
    46			/* check if DVM is supported */
    47			*dvm = test_bit(ICE_META_VLAN_MODE_BIT, entry);
    48		}
    49	
    50		ice_pkg_buf_free(hw, bld);
    51	
    52		return status;
    53	}
    54	
    55	/**
    56	 * ice_aq_get_vlan_mode - get the VLAN mode of the device
    57	 * @hw: pointer to the HW structure
    58	 * @get_params: structure FW fills in based on the current VLAN mode config
    59	 *
    60	 * Get VLAN Mode Parameters (0x020D)
    61	 */
    62	static int
    63	ice_aq_get_vlan_mode(struct ice_hw *hw,
    64			     struct ice_aqc_get_vlan_mode *get_params)
    65	{
    66		struct ice_aq_desc desc;
    67	
    68		if (!get_params)
    69			return -EINVAL;
    70	
    71		ice_fill_dflt_direct_cmd_desc(&desc,
    72					      ice_aqc_opc_get_vlan_mode_parameters);
    73	
    74		return ice_aq_send_cmd(hw, &desc, get_params, sizeof(*get_params),
    75				       NULL);
    76	}
    77	
    78	/**
    79	 * ice_aq_is_dvm_ena - query FW to check if double VLAN mode is enabled
    80	 * @hw: pointer to the HW structure
    81	 *
    82	 * Returns true if the hardware/firmware is configured in double VLAN mode,
    83	 * else return false signaling that the hardware/firmware is configured in
    84	 * single VLAN mode.
    85	 *
    86	 * Also, return false if this call fails for any reason (i.e. firmware doesn't
    87	 * support this AQ call).
    88	 */
    89	static bool ice_aq_is_dvm_ena(struct ice_hw *hw)
    90	{
    91		struct ice_aqc_get_vlan_mode get_params = { 0 };
    92		int status;
    93	
    94		status = ice_aq_get_vlan_mode(hw, &get_params);
    95		if (status) {
  > 96			ice_debug(hw, ICE_DBG_AQ, "Failed to get VLAN mode, status %d\n",
    97				  status);
    98			return false;
    99		}
   100	
   101		return (get_params.vlan_mode & ICE_AQ_VLAN_MODE_DVM_ENA);
   102	}
   103	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
