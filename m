Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA84FC8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiDKXxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiDKXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:53:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A37226ADF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649721045; x=1681257045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n7c3U06mbwi7inoRhYFyjiUmOGIY8XGz8bcBgDInUjU=;
  b=kwk1R+vEBNoWd5yKf4NTHKz1QCkSzoNLcszi2WWQQX/YpII2k4TO7f9X
   gPBtI1wR9TIJUxv55BOLKlk3WPHckqntDaLoq6NbS56AYWq9pCCvHEwq1
   X0URh7CWlqYrRFCEC1xhJoHHJule5GVaIJU9xCesUcLCygxkiIwmDHU1M
   kSi/82K8CSp7sDVCzTXLg0Qe2qmkuXPJuuVldyFx70Cn4PgyG5XJpx9OQ
   D6HNjOYe6uZpSLISDPtt6HHb8DRNGgZjnVlFhaTEMSkDXRYwkwhnaAApL
   c4OsjrMl/ru7aO9IuTtg1zuefFPl4iyj5CfGQvOBC25TOa+Ujla6iOqaS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322685165"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="322685165"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 16:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="611199379"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2022 16:50:43 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne3nv-0002LA-9B;
        Mon, 11 Apr 2022 23:50:43 +0000
Date:   Tue, 12 Apr 2022 07:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 79/93]
 drivers/net/netdevsim/dev.c:637:23: error: too many arguments to function
 '__nsim_dev_port_add'
Message-ID: <202204120745.1JTLjXK8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   e31049bc6a06f24c077e61e74b1bf1f137572726
commit: 5cfe0dc86bde79b21b5e0097a45355e3a5dbb1cb [79/93] netdevsim: allow port objects to be linked with line cards
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220412/202204120745.1JTLjXK8-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/5cfe0dc86bde79b21b5e0097a45355e3a5dbb1cb
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 5cfe0dc86bde79b21b5e0097a45355e3a5dbb1cb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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
