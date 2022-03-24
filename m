Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524C34E5C90
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiCXBDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbiCXBCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:02:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5919559B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648083684; x=1679619684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OGtagVymZrYWDwutMu2wb1lQ4Vl3KkLc8yeJ5JYiQrs=;
  b=M3lV+od0UQtGgN3B2DamXbPTXtfeBrq75Qrq9ypDcsfWCYKUhZrPADLn
   +uU9niBRRwz9GutMseg/z1u1LWkq/1OC2euRGbsPkhqu0BH4JA2mHCd2p
   W6TRTtKRByz+Tv3eaz1+CbiQJXXl/D74rhjNdt+4gCpvrcH+m7ikyzG4S
   0cp+VATlZBR7/1n2HTnLN0/y7b5+H7jLs4xrftYaLdJRTG1dlfqocB80E
   VP1du63dlfkETnI+0o8kDGRmV7po7mkbInmVlrchdEZdCQNQBduRN8buv
   aMKj8LzwLChqmbWXH0scF0r0EGmCumgdIX6pMPRoFHaxutqWXm0UO/6JC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="240420438"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="240420438"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="519583294"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 18:01:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXBqs-000KX9-NG; Thu, 24 Mar 2022 01:01:22 +0000
Date:   Thu, 24 Mar 2022 09:00:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 14/27]
 drivers/net/netdevsim/dev.c:637:23: error: too many arguments to function
 '__nsim_dev_port_add'
Message-ID: <202203240845.YnY9Pd9I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   4a0e7275ecdf8f8cfd4c1a2e9acd45f93f04c0df
commit: a4347ad737edaf74ab771e14854e259ef224ab1c [14/27] netdevsim: allow port objects to be linked with line cards
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220324/202203240845.YnY9Pd9I-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/a4347ad737edaf74ab771e14854e259ef224ab1c
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout a4347ad737edaf74ab771e14854e259ef224ab1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the jpirko-mlxsw/jiri_devel_linecards HEAD 4a0e7275ecdf8f8cfd4c1a2e9acd45f93f04c0df builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/m68k/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:255,
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
   drivers/net/netdevsim/dev.c:638:43: note: in expansion of macro 'NULL'
     638 |                                           NULL, i);
         |                                           ^~~~
   drivers/net/netdevsim/dev.c:613:34: note: expected 'unsigned int' but argument is of type 'void *'
     613 |                     unsigned int port_index);
         |                     ~~~~~~~~~~~~~^~~~~~~~~~
>> drivers/net/netdevsim/dev.c:637:23: error: too many arguments to function '__nsim_dev_port_add'
     637 |                 err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: declared here
     612 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/dev.c:651:25: error: too many arguments to function '__nsim_dev_port_del'
     651 |                         __nsim_dev_port_del(nsim_dev_port, NULL, i);
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:614:13: note: declared here
     614 | static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c: At top level:
>> drivers/net/netdevsim/dev.c:1393:12: error: conflicting types for '__nsim_dev_port_add'; have 'int(struct nsim_dev *, enum nsim_dev_port_type,  struct nsim_dev_linecard *, unsigned int)'
    1393 | static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: previous declaration of '__nsim_dev_port_add' with type 'int(struct nsim_dev *, enum nsim_dev_port_type,  unsigned int)'
     612 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: warning: '__nsim_dev_port_add' used but never defined


vim +/__nsim_dev_port_add +637 drivers/net/netdevsim/dev.c

   629	
   630	static int nsim_esw_switchdev_enable(struct nsim_dev *nsim_dev,
   631					     struct netlink_ext_ack *extack)
   632	{
   633		struct nsim_dev_port *nsim_dev_port, *tmp;
   634		int i, err;
   635	
   636		for (i = 0; i < nsim_dev_get_vfs(nsim_dev); i++) {
 > 637			err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF,
   638						  NULL, i);
   639			if (err) {
   640				NL_SET_ERR_MSG_MOD(extack, "Failed to initialize VFs' netdevsim ports");
   641				pr_err("Failed to initialize VF id=%d. %d.\n", i, err);
   642				goto err_port_add_vfs;
   643			}
   644		}
   645		nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
   646		return 0;
   647	
   648	err_port_add_vfs:
   649		list_for_each_entry_safe(nsim_dev_port, tmp, &nsim_dev->port_list, list)
   650			if (nsim_dev_port_is_vf(nsim_dev_port))
 > 651				__nsim_dev_port_del(nsim_dev_port, NULL, i);
   652		return err;
   653	}
   654	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
