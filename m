Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5F4B8B38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiBPOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:19:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiBPOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:19:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF41B6506
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645021180; x=1676557180;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I9b5584pasqFyUNl2GI+JwJAx5NhvBxbRBeYif4Iq0U=;
  b=CwOz8dh8p+Hy42kiDoB0BTJNG0JySfKEA5S28g5hdsZzlyx5gtWDPTDI
   RDkRcW81b7x88H/hhrKlHY1AEDQ+WKdLYMkCPq12UqDdmtFESHGQiVB+Z
   78XKFdJbgjZJ7TB7nFCTyBYB//vzlhjxYr0fl/IHlCVM0Oh99VKSH144W
   MTJpMxmCc54Icl12qoQMgH5HZMqCZDJkkF8GItxSLZQttFRpL6bg6gm+l
   qmfm4kLF70t3/PbAwu0SL1sgqesZiEwu8l1cjgHj8T/nUYtiUaelnVIXM
   U2RFs/G6ckTfJkYXu5JYPNdMqOLcQ34n8mOnaHpsKPW0BhRUvhMRAYvi7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231236669"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="231236669"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 06:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="774062379"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 06:19:39 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKL9e-000ArI-Sv; Wed, 16 Feb 2022 14:19:38 +0000
Date:   Wed, 16 Feb 2022 22:18:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Pasternak <vadimp@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@nvidia.com>
Subject: [jpirko-mlxsw:jiri_devel_linecards 27/43]
 drivers/net/ethernet/mellanox/mlxsw/core_env.c:1249:23: error:
 initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka
 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from
 incompatible pointer type 'void (*)(struct mlx...
Message-ID: <202202162243.YGWLhWv3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   5cb021512c3be7e03591497caeab474ecccfcd21
commit: 08ac493598146680137ed7a81dc108b837018125 [27/43] mlxsw: core: Add interfaces for line card initialization and de-initialization
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202162243.YGWLhWv3-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/08ac493598146680137ed7a81dc108b837018125
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 08ac493598146680137ed7a81dc108b837018125
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/core_env.c:1249:23: error: initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from incompatible pointer type 'void (*)(struct mlxsw_core *, u8,  const struct mlxsw_linecard *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  const struct mlxsw_linecard *, void *)'} [-Werror=incompatible-pointer-types]
    1249 |         .got_active = mlxsw_env_got_active,
         |                       ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_env.c:1249:23: note: (near initialization for 'mlxsw_env_event_ops.got_active')
   drivers/net/ethernet/mellanox/mlxsw/core_env.c:1250:25: error: initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from incompatible pointer type 'void (*)(struct mlxsw_core *, u8,  const struct mlxsw_linecard *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  const struct mlxsw_linecard *, void *)'} [-Werror=incompatible-pointer-types]
    1250 |         .got_inactive = mlxsw_env_got_inactive,
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_env.c:1250:25: note: (near initialization for 'mlxsw_env_event_ops.got_inactive')
   cc1: some warnings being treated as errors


vim +1249 drivers/net/ethernet/mellanox/mlxsw/core_env.c

  1247	
  1248	static struct mlxsw_linecards_event_ops mlxsw_env_event_ops = {
> 1249		.got_active = mlxsw_env_got_active,
  1250		.got_inactive = mlxsw_env_got_inactive,
  1251	};
  1252	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
