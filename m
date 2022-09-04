Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB75AC513
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiIDPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:43:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C22E9F9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662306185; x=1693842185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=twPG6+TK0tWL/hZP2BeESv1Nji8Zi+UBlMEToiP0630=;
  b=OZncGVz9VoXcpYIlDQX8g/tv1EzDmbUie/45XrWxZeuA97d3s1YVlZ8H
   TEb9jkLQ9WyFnc3W/MOloAEF5QMV1WaTeFIVMyEvOtu1mK5+XAbv78So7
   oeaQMMgOxmWIC9CiKXUiczA1S2G2FJ+8tWwReS/hERdqcc+EL9HlstRRb
   EEzqZMNRuY/kr58ruKXnyM595mXo/1d4D3UMlPSXAKrnMW141UoWFoEcI
   r/EdJ/7jA3acjjLw6yk+viGPayjHd3AhG+FuP3H/oV1G1jJduXBiywDP2
   0L7bc6ZJ3+N4F2/DLMnceSb1gINLnOrYeeUxT6BdP+wC6hod8DniT3stJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="279265705"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="279265705"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 08:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="674974076"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2022 08:43:03 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUrm2-0003C0-2M;
        Sun, 04 Sep 2022 15:43:02 +0000
Date:   Sun, 4 Sep 2022 23:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [leon-rdma:xfrm-next 42/44]
 drivers/net/ethernet/mellanox/mlx5/core/eq.c:579:43: error:
 'MLX5_IPSEC_CAP_FULL_OFFLOAD' undeclared
Message-ID: <202209042336.6G07ozQ9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git xfrm-next
head:   0ed4792e3e488854df662617cf374ab96de8fc2a
commit: 5a11229976c3b581cbcff47c2312bb646f129e40 [42/44] net/mlx5e: Handle hardware IPsec events
config: parisc-randconfig-r023-20220904 (https://download.01.org/0day-ci/archive/20220904/202209042336.6G07ozQ9-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=5a11229976c3b581cbcff47c2312bb646f129e40
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma xfrm-next
        git checkout 5a11229976c3b581cbcff47c2312bb646f129e40
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function 'gather_async_events_mask':
>> drivers/net/ethernet/mellanox/mlx5/core/eq.c:579:43: error: 'MLX5_IPSEC_CAP_FULL_OFFLOAD' undeclared (first use in this function)
     579 |         if (mlx5_ipsec_device_caps(dev) & MLX5_IPSEC_CAP_FULL_OFFLOAD)
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/eq.c:579:43: note: each undeclared identifier is reported only once for each function it appears in


vim +/MLX5_IPSEC_CAP_FULL_OFFLOAD +579 drivers/net/ethernet/mellanox/mlx5/core/eq.c

   538	
   539	static void gather_async_events_mask(struct mlx5_core_dev *dev, u64 mask[4])
   540	{
   541		u64 async_event_mask = MLX5_ASYNC_EVENT_MASK;
   542	
   543		if (MLX5_VPORT_MANAGER(dev))
   544			async_event_mask |= (1ull << MLX5_EVENT_TYPE_NIC_VPORT_CHANGE);
   545	
   546		if (MLX5_CAP_GEN(dev, general_notification_event))
   547			async_event_mask |= (1ull << MLX5_EVENT_TYPE_GENERAL_EVENT);
   548	
   549		if (MLX5_CAP_GEN(dev, port_module_event))
   550			async_event_mask |= (1ull << MLX5_EVENT_TYPE_PORT_MODULE_EVENT);
   551		else
   552			mlx5_core_dbg(dev, "port_module_event is not set\n");
   553	
   554		if (MLX5_PPS_CAP(dev))
   555			async_event_mask |= (1ull << MLX5_EVENT_TYPE_PPS_EVENT);
   556	
   557		if (MLX5_CAP_GEN(dev, fpga))
   558			async_event_mask |= (1ull << MLX5_EVENT_TYPE_FPGA_ERROR) |
   559					    (1ull << MLX5_EVENT_TYPE_FPGA_QP_ERROR);
   560		if (MLX5_CAP_GEN_MAX(dev, dct))
   561			async_event_mask |= (1ull << MLX5_EVENT_TYPE_DCT_DRAINED);
   562	
   563		if (MLX5_CAP_GEN(dev, temp_warn_event))
   564			async_event_mask |= (1ull << MLX5_EVENT_TYPE_TEMP_WARN_EVENT);
   565	
   566		if (MLX5_CAP_MCAM_REG(dev, tracer_registers))
   567			async_event_mask |= (1ull << MLX5_EVENT_TYPE_DEVICE_TRACER);
   568	
   569		if (MLX5_CAP_GEN(dev, max_num_of_monitor_counters))
   570			async_event_mask |= (1ull << MLX5_EVENT_TYPE_MONITOR_COUNTER);
   571	
   572		if (mlx5_eswitch_is_funcs_handler(dev))
   573			async_event_mask |=
   574				(1ull << MLX5_EVENT_TYPE_ESW_FUNCTIONS_CHANGED);
   575	
   576		if (MLX5_CAP_GEN_MAX(dev, vhca_state))
   577			async_event_mask |= (1ull << MLX5_EVENT_TYPE_VHCA_STATE_CHANGE);
   578	
 > 579		if (mlx5_ipsec_device_caps(dev) & MLX5_IPSEC_CAP_FULL_OFFLOAD)
   580			async_event_mask |=
   581				(1ull << MLX5_EVENT_TYPE_OBJECT_CHANGE_EVENT);
   582	
   583		mask[0] = async_event_mask;
   584	
   585		if (MLX5_CAP_GEN(dev, event_cap))
   586			gather_user_async_events(dev, mask);
   587	}
   588	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
