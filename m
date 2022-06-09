Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26E65448C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbiFIKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiFIKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:25:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB6C1EEC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654770331; x=1686306331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HmuegweNtbGftTETHYc9nj1zpXJZnEG+8UNyJgAbtVI=;
  b=HEk9g7IOHcrtM4TfTX21kxe/6MDovycke77DKBk9DDvwoXZEBo7KtT16
   2OBwu9YJsDc48KYvFSg0mCWiGe/kXxeyKB09+7fjUeePSdRNmrvBTYctj
   5ULDhT0Ciq0/RXwgEhvs+v2ro6RK4b1stnxZCMnocDEOWlgmW4GW1R741
   5q1AP2GWbMy30WD9UBzVz4EvdehzGFpRjgOn3YCOiLmg34799pqQoEBxd
   pjWBxxqhreJ55Q5uiBChsv13CY4hOiPbTlOte5kdG7uj4jgL1ivZHDRGa
   DpfvhYuhQ7iAgU5msS5/t4EJQYwc1e+vCrEydFOJRc1rp86RoTNgmnMWb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="341311633"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341311633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 03:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="649152134"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2022 03:25:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzFM1-000Fsn-74;
        Thu, 09 Jun 2022 10:25:29 +0000
Date:   Thu, 9 Jun 2022 18:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error:
 enumerator value for
 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer
 constant
Message-ID: <202206091828.eNkyL2EI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   5 weeks ago
config: arm-randconfig-r023-20220609 (https://download.01.org/0day-ci/archive/20220609/202206091828.eNkyL2EI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-orion5x/ drivers/cpufreq/ drivers/net/ethernet/intel/i40e/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/i40e/i40e_adminq.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e_type.h:10,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer constant
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_bb' is not an integer constant
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_configure_partition_bw_data' is not an integer constant
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:306:41: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
     306 | #define I40E_CHECK_CMD_LENGTH(X)        I40E_CHECK_STRUCT_LEN(16, X)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:23: error: enumerator value for 'i40e_static_assert_i40e_aqc_get_link_status' is not an integer constant
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:28: error: enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_data_feature' is not an integer constant
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:41,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:391:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:391:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:484:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:484:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:869:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:869:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:877:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:877:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^


vim +/i40e_static_assert_i40e_aqc_cloud_filters_element_data +1174 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h

56a62fc8689509 Jesse Brandeburg 2013-09-11  1173  
2c0015238f7d35 Amritha Nambiar  2017-10-27 @1174  I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
2c0015238f7d35 Amritha Nambiar  2017-10-27  1175  
2c0015238f7d35 Amritha Nambiar  2017-10-27  1176  /* i40e_aqc_cloud_filters_element_bb is used when
2c0015238f7d35 Amritha Nambiar  2017-10-27  1177   * I40E_AQC_CLOUD_CMD_BB flag is set.
2c0015238f7d35 Amritha Nambiar  2017-10-27  1178   */
2c0015238f7d35 Amritha Nambiar  2017-10-27  1179  struct i40e_aqc_cloud_filters_element_bb {
2c0015238f7d35 Amritha Nambiar  2017-10-27  1180  	struct i40e_aqc_cloud_filters_element_data element;
2c0015238f7d35 Amritha Nambiar  2017-10-27  1181  	u16     general_fields[32];
2c0015238f7d35 Amritha Nambiar  2017-10-27  1182  #define I40E_AQC_ADD_CLOUD_FV_FLU_0X16_WORD0	15
2c0015238f7d35 Amritha Nambiar  2017-10-27  1183  };
2c0015238f7d35 Amritha Nambiar  2017-10-27  1184  
2c0015238f7d35 Amritha Nambiar  2017-10-27 @1185  I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
2c0015238f7d35 Amritha Nambiar  2017-10-27  1186  

:::::: The code at line 1174 was first introduced by commit
:::::: 2c0015238f7d357f179249f101d6ed0327bc642a i40e: Admin queue definitions for cloud filters

:::::: TO: Amritha Nambiar <amritha.nambiar@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
