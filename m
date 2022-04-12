Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676CA4FC95C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 02:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiDLAnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 20:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiDLAnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:43:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6260CAE66
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649724076; x=1681260076;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NVIl9aheGBGH4Yb5cPFMiyNZl855rP0pfHbJJc7xNsQ=;
  b=btjU6Lh7RSgzdpYmdKFwp6AcOQDbQLS2zw7LFwvvIIADjzOpBnK3dAbM
   zvo2Wrb3TihdXbxKaSlGivqWXP2RD9bWOkCmVHrzR73DM+8f0HO9+l3IE
   driRgJS7WCSFfcuyHjutH4Y6QG6XnPw735CP1p2AUntlfkwrSR23aUVu3
   m0cZs3D7DDQNvLhI6wGX8A9zlh1gI0ojY/O4IdnD3g1dukfpgarx7gmCb
   oLMcfGibGVAzegu8xnhSAS7d/JFI7ExAYFKrC9SaSbBGvF5+TKxCgRuiO
   YId3xKOBWoBu2u/Joifgz+XfKEFKxi4OtTOS0m2AgA40x1By6Htbl7DK9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262426918"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="262426918"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="526222961"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 17:41:14 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne4an-0002NG-KW;
        Tue, 12 Apr 2022 00:41:13 +0000
Date:   Tue, 12 Apr 2022 08:41:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 91/93]
 drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of
 'devlink_linecard_device_create' from incompatible pointer type
Message-ID: <202204120800.yyqLXueA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   e31049bc6a06f24c077e61e74b1bf1f137572726
commit: ac7fd66c0d376eb5bfe801b1a2226598705a6b6d [91/93] TMP: devlink device type
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220412/202204120800.yyqLXueA-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/ac7fd66c0d376eb5bfe801b1a2226598705a6b6d
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout ac7fd66c0d376eb5bfe801b1a2226598705a6b6d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/netdevsim/

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
   include/net/devlink.h:1610:44: note: expected 'const char *' but argument is of type 'struct nsim_dev_linecard *'
    1610 |                                const char *type, void *priv);
         |                                ~~~~~~~~~~~~^~~~
>> drivers/net/netdevsim/dev.c:117:26: error: too few arguments to function 'devlink_linecard_device_create'
     117 |                 device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/netdevsim/dev.c:29:
   include/net/devlink.h:1607:1: note: declared here
    1607 | devlink_linecard_device_create(struct devlink_linecard *linecard,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/net/netdevsim/dev.c:18:
   drivers/net/netdevsim/dev.c: In function 'nsim_esw_switchdev_enable':
   include/linux/stddef.h:8:14: warning: passing argument 3 of '__nsim_dev_port_add' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/net/netdevsim/dev.c:870:43: note: in expansion of macro 'NULL'
     870 |                                           NULL, i);
         |                                           ^~~~
   drivers/net/netdevsim/dev.c:845:34: note: expected 'unsigned int' but argument is of type 'void *'
     845 |                     unsigned int port_index);
         |                     ~~~~~~~~~~~~~^~~~~~~~~~
   drivers/net/netdevsim/dev.c:869:23: error: too many arguments to function '__nsim_dev_port_add'
     869 |                 err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:844:1: note: declared here
     844 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:883:25: error: too many arguments to function '__nsim_dev_port_del'
     883 |                         __nsim_dev_port_del(nsim_dev_port, NULL, i);
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:846:13: note: declared here
     846 | static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c: At top level:
   drivers/net/netdevsim/dev.c:1625:12: error: conflicting types for '__nsim_dev_port_add'; have 'int(struct nsim_dev *, enum nsim_dev_port_type,  struct nsim_dev_linecard *, unsigned int)'
    1625 | static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:844:1: note: previous declaration of '__nsim_dev_port_add' with type 'int(struct nsim_dev *, enum nsim_dev_port_type,  unsigned int)'
     844 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:844:1: warning: '__nsim_dev_port_add' used but never defined
   cc1: some warnings being treated as errors


vim +/devlink_linecard_device_create +119 drivers/net/netdevsim/dev.c

18c8e54cc09123 Jiri Pirko 2021-05-05  100  
18c8e54cc09123 Jiri Pirko 2021-05-05  101  static int
18c8e54cc09123 Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
18c8e54cc09123 Jiri Pirko 2021-05-05  103  {
18c8e54cc09123 Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
18c8e54cc09123 Jiri Pirko 2021-05-05  105  	char *component_name;
18c8e54cc09123 Jiri Pirko 2021-05-05  106  	int err;
18c8e54cc09123 Jiri Pirko 2021-05-05  107  	int i;
18c8e54cc09123 Jiri Pirko 2021-05-05  108  
18c8e54cc09123 Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
18c8e54cc09123 Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
18c8e54cc09123 Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
18c8e54cc09123 Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
18c8e54cc09123 Jiri Pirko 2021-05-05  113  
18c8e54cc09123 Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
18c8e54cc09123 Jiri Pirko 2021-05-05  115  		if (i > 0)
18c8e54cc09123 Jiri Pirko 2021-05-05  116  			component_name = NULL;
18c8e54cc09123 Jiri Pirko 2021-05-05 @117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
18c8e54cc09123 Jiri Pirko 2021-05-05  118  							i, component_name,
18c8e54cc09123 Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
18c8e54cc09123 Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
18c8e54cc09123 Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
18c8e54cc09123 Jiri Pirko 2021-05-05  122  			goto rollback;
18c8e54cc09123 Jiri Pirko 2021-05-05  123  		}
18c8e54cc09123 Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
18c8e54cc09123 Jiri Pirko 2021-05-05  125  	}
18c8e54cc09123 Jiri Pirko 2021-05-05  126  	return 0;
18c8e54cc09123 Jiri Pirko 2021-05-05  127  
18c8e54cc09123 Jiri Pirko 2021-05-05  128  rollback:
18c8e54cc09123 Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
18c8e54cc09123 Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
18c8e54cc09123 Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
18c8e54cc09123 Jiri Pirko 2021-05-05  132  						device);
18c8e54cc09123 Jiri Pirko 2021-05-05  133  	}
18c8e54cc09123 Jiri Pirko 2021-05-05  134  	return err;
18c8e54cc09123 Jiri Pirko 2021-05-05  135  }
18c8e54cc09123 Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: 18c8e54cc09123e6810b00d12879e2428dc9fbb9 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
