Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4587D4B8FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiBPRxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:53:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbiBPRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:53:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC53C17C124
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645033967; x=1676569967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c/MuB3Mup/CLGmN40NIuicGQzGSxEz7jP2XRVcgPy2U=;
  b=GalMCzDWqeVBIJLiPszCKJTW9/Tjo3+t5DF9yGH7iN3s5bkpomBtUR9G
   JAUzJN1hJh9IKvEewdOFTosBOujuephUi9O6jp0sMsBJ8EBW+b4gLNHOw
   d9EpnyHrU3tl/Jpk316GJ5xokv3BzGAmOYwLXYFP9oMLJPZsYC8Vkdzxi
   tdBPvEPR1XULX82onrCvmhPKZ49NW1BJKIId0BKctx8ylAEsiLdWJuqeB
   Ut8Bhfzmv3H2hi3+kAviMJ0gwo2VQ5n37zCErRrW0JcsEm4LOLpgwpHPz
   pdKwqoP10FL8sr8ntxRWLg0RU94JLLkMaiborHa/ZPo3iwL/dSkluvgoh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249515648"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="249515648"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 09:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="681612264"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2022 09:52:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKOTt-000B0e-JI; Wed, 16 Feb 2022 17:52:45 +0000
Date:   Thu, 17 Feb 2022 01:52:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Pasternak <vadimp@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: [jpirko-mlxsw:jiri_devel_linecards 27/43]
 drivers/net/ethernet/mellanox/mlxsw/core_env.c:1249:16: error: incompatible
 function pointer types initializing 'void (*)(struct mlxsw_core *, u8, void
 *, void *)' (aka 'void (*)(struct mlxsw_core *, unsigned char, void *, void
 *)') with an expression of ...
Message-ID: <202202170101.p6TIUxNw-lkp@intel.com>
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
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220217/202202170101.p6TIUxNw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/08ac493598146680137ed7a81dc108b837018125
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 08ac493598146680137ed7a81dc108b837018125
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/core_env.c:1249:16: error: incompatible function pointer types initializing 'void (*)(struct mlxsw_core *, u8, void *, void *)' (aka 'void (*)(struct mlxsw_core *, unsigned char, void *, void *)') with an expression of type 'void (struct mlxsw_core *, u8, const struct mlxsw_linecard *, void *)' (aka 'void (struct mlxsw_core *, unsigned char, const struct mlxsw_linecard *, void *)') [-Werror,-Wincompatible-function-pointer-types]
           .got_active = mlxsw_env_got_active,
                         ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_env.c:1250:18: error: incompatible function pointer types initializing 'void (*)(struct mlxsw_core *, u8, void *, void *)' (aka 'void (*)(struct mlxsw_core *, unsigned char, void *, void *)') with an expression of type 'void (struct mlxsw_core *, u8, const struct mlxsw_linecard *, void *)' (aka 'void (struct mlxsw_core *, unsigned char, const struct mlxsw_linecard *, void *)') [-Werror,-Wincompatible-function-pointer-types]
           .got_inactive = mlxsw_env_got_inactive,
                           ^~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


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
