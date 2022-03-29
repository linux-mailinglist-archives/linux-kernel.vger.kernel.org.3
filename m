Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC664EA493
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiC2B00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiC2B0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:26:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163665F5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648517083; x=1680053083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mu17qYsjkCHyz1+QOh7SLV+fK9EV9Jl13PPWrJf+Dmk=;
  b=c5CneQSLlHDWPYZD25jmiZKRrKlVvT2SFZkubN6RDpnkxFhuxI/NR+/c
   FH9PtB408Z+Dof/JA42PiaFeihmJ8SusdcQ8/56k5iApP+puibUqeGW6m
   hd/icPqfMGk5CiNLz8l4/U5+UapoVoUmtzEdxMRvlgYNp48Ymgx0f8/L6
   BRJpTnOspyVLGe4f3t0a0zKWlWRtXRcnUF0FZRKJYxTWpmJs4vV6WBOfG
   SouvtSzM/wYyIXTSCTADWIwb0xb/tE9VWAzQ79ZW9wK3hECa8W0lSbHai
   XxftdwVQkI2a2M77z98LQVSMAO6t6DeH/ykjCW/rdGoiBd6nrMbUuqtdZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345572294"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="345572294"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 18:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="546179180"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2022 18:24:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ0bA-0002UR-IL; Tue, 29 Mar 2022 01:24:40 +0000
Date:   Tue, 29 Mar 2022 09:24:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 84/97]
 drivers/net/netdevsim/dev.c:638:14: error: too many arguments to function
 call, expected 3, have 4
Message-ID: <202203290946.i4BOVfVX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   7acc15a4d5cd40bc4ab8bafe3f376adacd6f4bb2
commit: 9f172debd1c3d2de76650ee4e20aaa1bc31bb79e [84/97] netdevsim: allow port objects to be linked with line cards
config: i386-randconfig-a014-20220328 (https://download.01.org/0day-ci/archive/20220329/202203290946.i4BOVfVX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/9f172debd1c3d2de76650ee4e20aaa1bc31bb79e
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 9f172debd1c3d2de76650ee4e20aaa1bc31bb79e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/netdevsim/dev.c:638:14: error: too many arguments to function call, expected 3, have 4
                                             NULL, i);
                                                   ^
   drivers/net/netdevsim/dev.c:612:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
>> drivers/net/netdevsim/dev.c:651:39: error: too many arguments to function call, expected single argument 'nsim_dev_port', have 3 arguments
                           __nsim_dev_port_del(nsim_dev_port, NULL, i);
                           ~~~~~~~~~~~~~~~~~~~                ^~~~~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^
   drivers/net/netdevsim/dev.c:614:13: note: '__nsim_dev_port_del' declared here
   static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
               ^
>> drivers/net/netdevsim/dev.c:1393:12: error: conflicting types for '__nsim_dev_port_add'
   static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
              ^
   drivers/net/netdevsim/dev.c:612:1: note: previous declaration is here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   drivers/net/netdevsim/dev.c:1503:14: error: too many arguments to function call, expected 3, have 4
                                             NULL, i);
                                                   ^
   drivers/net/netdevsim/dev.c:612:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   drivers/net/netdevsim/dev.c:1839:27: error: too many arguments to function call, expected 3, have 4
                                             nsim_dev_linecard, port_index);
                                                                ^~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   5 errors generated.


vim +638 drivers/net/netdevsim/dev.c

   629	
   630	static int nsim_esw_switchdev_enable(struct nsim_dev *nsim_dev,
   631					     struct netlink_ext_ack *extack)
   632	{
   633		struct nsim_dev_port *nsim_dev_port, *tmp;
   634		int i, err;
   635	
   636		for (i = 0; i < nsim_dev_get_vfs(nsim_dev); i++) {
   637			err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF,
 > 638						  NULL, i);
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
