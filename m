Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDCB4C9797
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiCAVPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiCAVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:15:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D125C347
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646169272; x=1677705272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WRbNCLlAB9hSATwWO4r0Bsd4Q26nHNiL+p3iTmhVtDA=;
  b=VtBMNa9N+dnwURKrcJUDJSG5Huxw6ouZ3LUVXlR9XNoBIMlhiVfvsqAg
   z6XY+FAVTHInXxsSMLFw8GiKlhaTPHIBk4pjG5NDh91TDRYrnsJx62pVa
   mU2NPgy/DTOmMq5Vol/NNCzRZhrnUkZFLUwYZ8xFclBNI7plP8YCPw9iD
   q13KJcpHBLoJOEofgErIq8xH0nvvXpJ6sV3iRk3jJClaf9ohNf1Is0Yhg
   n9PipL1mSFPYBnClpM8Rt0ctMnsQofTrFTMQwLJOpUHpRSKxKCLwEffS5
   P/R+9DdiBekZv2EFEHpmmcvGyw4R5Mj6XYn/Nthk7XYOW3L4LelAEyaOU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253434803"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253434803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 13:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="709223456"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2022 13:14:30 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP9pF-00012X-O8; Tue, 01 Mar 2022 21:14:29 +0000
Date:   Wed, 2 Mar 2022 05:13:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 38/39]
 drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of
 'devlink_linecard_device_create' from incompatible pointer type
Message-ID: <202203020522.M9GYd0HL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   fcef7b383481be9b69822d4d795df70f382f78f1
commit: 6db26604520f23b4189cb7979bfceea51678df22 [38/39] TMP: devlink device type
config: arc-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020522.M9GYd0HL-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/6db26604520f23b4189cb7979bfceea51678df22
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 6db26604520f23b4189cb7979bfceea51678df22
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/netdevsim/dev.c: In function 'nsim_dev_linecard_devices_create':
>> drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of 'devlink_linecard_device_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
     119 |                                                         nsim_dev_linecard);
         |                                                         ^~~~~~~~~~~~~~~~~
         |                                                         |
         |                                                         struct nsim_dev_linecard *
   In file included from drivers/net/netdevsim/dev.c:29:
   include/net/devlink.h:1580:44: note: expected 'const char *' but argument is of type 'struct nsim_dev_linecard *'
    1580 |                                const char *type, void *priv);
         |                                ~~~~~~~~~~~~^~~~
>> drivers/net/netdevsim/dev.c:117:26: error: too few arguments to function 'devlink_linecard_device_create'
     117 |                 device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/netdevsim/dev.c:29:
   include/net/devlink.h:1577:1: note: declared here
    1577 | devlink_linecard_device_create(struct devlink_linecard *linecard,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devlink_linecard_device_create +119 drivers/net/netdevsim/dev.c

d75afab460832e Jiri Pirko 2021-05-05  100  
d75afab460832e Jiri Pirko 2021-05-05  101  static int
d75afab460832e Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
d75afab460832e Jiri Pirko 2021-05-05  103  {
d75afab460832e Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
d75afab460832e Jiri Pirko 2021-05-05  105  	char *component_name;
d75afab460832e Jiri Pirko 2021-05-05  106  	int err;
d75afab460832e Jiri Pirko 2021-05-05  107  	int i;
d75afab460832e Jiri Pirko 2021-05-05  108  
d75afab460832e Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
d75afab460832e Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
d75afab460832e Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
d75afab460832e Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
d75afab460832e Jiri Pirko 2021-05-05  113  
d75afab460832e Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
d75afab460832e Jiri Pirko 2021-05-05  115  		if (i > 0)
d75afab460832e Jiri Pirko 2021-05-05  116  			component_name = NULL;
d75afab460832e Jiri Pirko 2021-05-05 @117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
d75afab460832e Jiri Pirko 2021-05-05  118  							i, component_name,
d75afab460832e Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
d75afab460832e Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
d75afab460832e Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
d75afab460832e Jiri Pirko 2021-05-05  122  			goto rollback;
d75afab460832e Jiri Pirko 2021-05-05  123  		}
d75afab460832e Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
d75afab460832e Jiri Pirko 2021-05-05  125  	}
d75afab460832e Jiri Pirko 2021-05-05  126  	return 0;
d75afab460832e Jiri Pirko 2021-05-05  127  
d75afab460832e Jiri Pirko 2021-05-05  128  rollback:
d75afab460832e Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
d75afab460832e Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
d75afab460832e Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
d75afab460832e Jiri Pirko 2021-05-05  132  						device);
d75afab460832e Jiri Pirko 2021-05-05  133  	}
d75afab460832e Jiri Pirko 2021-05-05  134  	return err;
d75afab460832e Jiri Pirko 2021-05-05  135  }
d75afab460832e Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: d75afab460832ea5abcbfe1d3e7107a44e648046 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
