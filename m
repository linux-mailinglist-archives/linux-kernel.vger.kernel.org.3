Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43702547A24
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiFLMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiFLMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:39:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750522A43C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655037549; x=1686573549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HpQNDuVbOnkLUQPeWilQh0raXkL3WdgqSTevyTYrtug=;
  b=NMV9x9cOcMqoSB3RbqGEr14lizs/dzjk1I7UGcDv7Fw/BPBP0z68q3MK
   SuI0TbCORjtVTYTrsGMJaMRn5Ebc8tx1f7R1hQ4oVJc91K91jBeph7AN1
   fMS+Lo0jFy1kM8Xi8qwx6aNXWV1vVh/TWDQCqA8pqYmvnlZF0aufrEwN6
   ofwaMMQjnqbfuiyimEN7yTQ5Bh3/RDZNiUlLncYMvskMhj6anrSLDlgzm
   Qq2R4/p/Lurk068+HS6ofJxFxEcKBwFN1Q+QaZ4/Pz3MsC1cs43ZfwLlo
   ielkJlNZfLYdprnavK0JdnKiBruU3UymoWPMfX75JlatntsawffEHpLo4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258479088"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="258479088"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 05:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="639172430"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2022 05:39:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0Mry-000Jun-My;
        Sun, 12 Jun 2022 12:39:06 +0000
Date:   Sun, 12 Jun 2022 20:38:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [drm-misc:for-linux-next 7/10]
 drivers/gpu/drm/bridge/tc358775.c:544:7: warning: variable 'dsi_lanes' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202206122022.NpZvuwCU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   d643daaf1694b7565fbe3982b630e1c7b95f1600
commit: 56426faa1492289ff794620c4ed8c1847a420d0a [7/10] drm/bridge: tc358775: Convert to drm_of_get_data_lanes_count_ep
config: hexagon-randconfig-r045-20220612 (https://download.01.org/0day-ci/archive/20220612/202206122022.NpZvuwCU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6466c9abf3674bade1f6ee859f24ebc7aaf9cd88)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout 56426faa1492289ff794620c4ed8c1847a420d0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/bridge/ drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/tc358775.c:544:7: warning: variable 'dsi_lanes' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (parent) {
                       ^~~~~~
   drivers/gpu/drm/bridge/tc358775.c:551:6: note: uninitialized use occurs here
           if (dsi_lanes < 0)
               ^~~~~~~~~
   drivers/gpu/drm/bridge/tc358775.c:544:3: note: remove the 'if' if its condition is always true
                   if (parent) {
                   ^~~~~~~~~~~~
   drivers/gpu/drm/bridge/tc358775.c:540:6: warning: variable 'dsi_lanes' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (endpoint) {
               ^~~~~~~~
   drivers/gpu/drm/bridge/tc358775.c:551:6: note: uninitialized use occurs here
           if (dsi_lanes < 0)
               ^~~~~~~~~
   drivers/gpu/drm/bridge/tc358775.c:540:2: note: remove the 'if' if its condition is always true
           if (endpoint) {
           ^~~~~~~~~~~~~~
   drivers/gpu/drm/bridge/tc358775.c:532:15: note: initialize the variable 'dsi_lanes' to silence this warning
           int dsi_lanes;
                        ^
                         = 0
   2 warnings generated.


vim +544 drivers/gpu/drm/bridge/tc358775.c

b26975593b17c2 Vinay Simha BN 2020-07-10  526  
b26975593b17c2 Vinay Simha BN 2020-07-10  527  static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
b26975593b17c2 Vinay Simha BN 2020-07-10  528  {
b26975593b17c2 Vinay Simha BN 2020-07-10  529  	struct device_node *endpoint;
b26975593b17c2 Vinay Simha BN 2020-07-10  530  	struct device_node *parent;
b26975593b17c2 Vinay Simha BN 2020-07-10  531  	struct device_node *remote;
56426faa149228 Marek Vasut    2022-05-24  532  	int dsi_lanes;
b26975593b17c2 Vinay Simha BN 2020-07-10  533  
b26975593b17c2 Vinay Simha BN 2020-07-10  534  	/*
b26975593b17c2 Vinay Simha BN 2020-07-10  535  	 * To get the data-lanes of dsi, we need to access the dsi0_out of port1
b26975593b17c2 Vinay Simha BN 2020-07-10  536  	 *  of dsi0 endpoint from bridge port0 of d2l_in
b26975593b17c2 Vinay Simha BN 2020-07-10  537  	 */
b26975593b17c2 Vinay Simha BN 2020-07-10  538  	endpoint = of_graph_get_endpoint_by_regs(tc->dev->of_node,
b26975593b17c2 Vinay Simha BN 2020-07-10  539  						 TC358775_DSI_IN, -1);
b26975593b17c2 Vinay Simha BN 2020-07-10  540  	if (endpoint) {
b26975593b17c2 Vinay Simha BN 2020-07-10  541  		/* dsi0_out node */
b26975593b17c2 Vinay Simha BN 2020-07-10  542  		parent = of_graph_get_remote_port_parent(endpoint);
b26975593b17c2 Vinay Simha BN 2020-07-10  543  		of_node_put(endpoint);
b26975593b17c2 Vinay Simha BN 2020-07-10 @544  		if (parent) {
b26975593b17c2 Vinay Simha BN 2020-07-10  545  			/* dsi0 port 1 */
56426faa149228 Marek Vasut    2022-05-24  546  			dsi_lanes = drm_of_get_data_lanes_count_ep(parent, 1, -1, 1, 4);
b26975593b17c2 Vinay Simha BN 2020-07-10  547  			of_node_put(parent);
b26975593b17c2 Vinay Simha BN 2020-07-10  548  		}
b26975593b17c2 Vinay Simha BN 2020-07-10  549  	}
b26975593b17c2 Vinay Simha BN 2020-07-10  550  
56426faa149228 Marek Vasut    2022-05-24  551  	if (dsi_lanes < 0)
56426faa149228 Marek Vasut    2022-05-24  552  		return dsi_lanes;
b26975593b17c2 Vinay Simha BN 2020-07-10  553  
56426faa149228 Marek Vasut    2022-05-24  554  	tc->num_dsi_lanes = dsi_lanes;
b26975593b17c2 Vinay Simha BN 2020-07-10  555  
b26975593b17c2 Vinay Simha BN 2020-07-10  556  	tc->host_node = of_graph_get_remote_node(np, 0, 0);
b26975593b17c2 Vinay Simha BN 2020-07-10  557  	if (!tc->host_node)
b26975593b17c2 Vinay Simha BN 2020-07-10  558  		return -ENODEV;
b26975593b17c2 Vinay Simha BN 2020-07-10  559  
b26975593b17c2 Vinay Simha BN 2020-07-10  560  	of_node_put(tc->host_node);
b26975593b17c2 Vinay Simha BN 2020-07-10  561  
b26975593b17c2 Vinay Simha BN 2020-07-10  562  	tc->lvds_link = SINGLE_LINK;
b26975593b17c2 Vinay Simha BN 2020-07-10  563  	endpoint = of_graph_get_endpoint_by_regs(tc->dev->of_node,
b26975593b17c2 Vinay Simha BN 2020-07-10  564  						 TC358775_LVDS_OUT1, -1);
b26975593b17c2 Vinay Simha BN 2020-07-10  565  	if (endpoint) {
b26975593b17c2 Vinay Simha BN 2020-07-10  566  		remote = of_graph_get_remote_port_parent(endpoint);
b26975593b17c2 Vinay Simha BN 2020-07-10  567  		of_node_put(endpoint);
b26975593b17c2 Vinay Simha BN 2020-07-10  568  
b26975593b17c2 Vinay Simha BN 2020-07-10  569  		if (remote) {
b26975593b17c2 Vinay Simha BN 2020-07-10  570  			if (of_device_is_available(remote))
b26975593b17c2 Vinay Simha BN 2020-07-10  571  				tc->lvds_link = DUAL_LINK;
b26975593b17c2 Vinay Simha BN 2020-07-10  572  			of_node_put(remote);
b26975593b17c2 Vinay Simha BN 2020-07-10  573  		}
b26975593b17c2 Vinay Simha BN 2020-07-10  574  	}
b26975593b17c2 Vinay Simha BN 2020-07-10  575  
b26975593b17c2 Vinay Simha BN 2020-07-10  576  	dev_dbg(tc->dev, "no.of dsi lanes: %d\n", tc->num_dsi_lanes);
b26975593b17c2 Vinay Simha BN 2020-07-10  577  	dev_dbg(tc->dev, "operating in %d-link mode\n",	tc->lvds_link);
b26975593b17c2 Vinay Simha BN 2020-07-10  578  
b26975593b17c2 Vinay Simha BN 2020-07-10  579  	return 0;
b26975593b17c2 Vinay Simha BN 2020-07-10  580  }
b26975593b17c2 Vinay Simha BN 2020-07-10  581  

:::::: The code at line 544 was first introduced by commit
:::::: b26975593b17c2c7188b96dba6fe9fff14480538 display/drm/bridge: TC358775 DSI/LVDS driver

:::::: TO: Vinay Simha BN <simhavcs@gmail.com>
:::::: CC: Sam Ravnborg <sam.ravnborg@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
