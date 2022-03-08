Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6654D1A02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347331AbiCHOI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiCHOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:08:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAAC1B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646748447; x=1678284447;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4+oHbdDk7RVU8mFBrgvhwsbKXJLPjk9gTrZfPKc5C3s=;
  b=ZzbQPWIVDPfHb93F1toMEBieUU86DZVD17RZaPGWyhyB6kVm6me26fUI
   6zE5Q5WH3R9IXJcTuT5v5pQ4Tjc5+W3prV9jNyZCfaNDSfUyAuPdZGEOm
   qN5YJXyzrga68BtZ5sa7WYB6BbLZJ2Md0awMj1UAsUWbNE6lfptMFIltK
   zdpLpL4i+SCqB40s+UN2pwWLqyea5Vd063JuOpR1xQ0FMz5zgunMBZK8X
   9l9h/XkBxjFcsDe2xmmELYr+NPgykmFe5+9lZUIJyv+L0nQONjB2ZLRlp
   DRCUfG0Riv1VhBV6c0V/wOueQzV/J5EOs6mp+QNh/4Lfz0nZqZgWP48xr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317917227"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="317917227"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 06:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643664725"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 06:07:25 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRaUn-0001Vl-42; Tue, 08 Mar 2022 14:07:25 +0000
Date:   Tue, 8 Mar 2022 22:07:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 39/40]
 drivers/net/netdevsim/dev.c:119:25: error: too few arguments to function
 call, expected 5, have 4
Message-ID: <202203082101.aGtvJRgf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   00a5d1d90798fb011d849a45bcaadd546af72602
commit: 2e58b589b7c7b2ab1355721db5122b8f415410f6 [39/40] TMP: devlink device type
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220308/202203082101.aGtvJRgf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/2e58b589b7c7b2ab1355721db5122b8f415410f6
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 2e58b589b7c7b2ab1355721db5122b8f415410f6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/netdevsim/dev.c:119:25: error: too few arguments to function call, expected 5, have 4
                                                           nsim_dev_linecard);
                                                                            ^
   include/net/devlink.h:1577:1: note: 'devlink_linecard_device_create' declared here
   devlink_linecard_device_create(struct devlink_linecard *linecard,
   ^
   1 error generated.


vim +119 drivers/net/netdevsim/dev.c

dcf92710cf8eb9 Jiri Pirko 2021-05-05  100  
dcf92710cf8eb9 Jiri Pirko 2021-05-05  101  static int
dcf92710cf8eb9 Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
dcf92710cf8eb9 Jiri Pirko 2021-05-05  103  {
dcf92710cf8eb9 Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  105  	char *component_name;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  106  	int err;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  107  	int i;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  108  
dcf92710cf8eb9 Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
dcf92710cf8eb9 Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
dcf92710cf8eb9 Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
dcf92710cf8eb9 Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  113  
dcf92710cf8eb9 Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
dcf92710cf8eb9 Jiri Pirko 2021-05-05  115  		if (i > 0)
dcf92710cf8eb9 Jiri Pirko 2021-05-05  116  			component_name = NULL;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
dcf92710cf8eb9 Jiri Pirko 2021-05-05  118  							i, component_name,
dcf92710cf8eb9 Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
dcf92710cf8eb9 Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
dcf92710cf8eb9 Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
dcf92710cf8eb9 Jiri Pirko 2021-05-05  122  			goto rollback;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  123  		}
dcf92710cf8eb9 Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  125  	}
dcf92710cf8eb9 Jiri Pirko 2021-05-05  126  	return 0;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  127  
dcf92710cf8eb9 Jiri Pirko 2021-05-05  128  rollback:
dcf92710cf8eb9 Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
dcf92710cf8eb9 Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
dcf92710cf8eb9 Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
dcf92710cf8eb9 Jiri Pirko 2021-05-05  132  						device);
dcf92710cf8eb9 Jiri Pirko 2021-05-05  133  	}
dcf92710cf8eb9 Jiri Pirko 2021-05-05  134  	return err;
dcf92710cf8eb9 Jiri Pirko 2021-05-05  135  }
dcf92710cf8eb9 Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: dcf92710cf8eb910bb40f1ce722ec40a4e39d199 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
