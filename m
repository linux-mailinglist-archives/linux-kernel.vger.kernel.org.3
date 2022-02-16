Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E274B8C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiBPPK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:10:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiBPPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:10:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB042A64DD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645024242; x=1676560242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LG4idFbzqEHVgQ4j1CpjWPu8xIDklGnCfWS0dLUcgKY=;
  b=cQsBSnBLfIwZ4td7u1yV+PDJPYsA+53u58zErJKmz6g1/PbBYu6l1tKf
   9ndo/sidJyf80K4Ma7FS0LyAlKeDl1vZXHzFR8G1BmYMAhLJQKN1o6n8A
   gJKRHrc8uhQoZkm/7uWFK9CBZ1G4yLmLF147IodeaXb/62z2OdZCENYc2
   6IvnQozB30QXOVAyytEwZ7r0KESB1k6//VXuj4A7FeKlmMIvgiiLmR62r
   XFPAA1xOH9KGuxcf8OnCw6G4oYmI8czG8df/QGit9XxNm0Tb+ra9ZCoQc
   MftngwDFdd1RsFV7SjrXKP680Sjb3HX9nkc15sh3O2U90XSeMtuEAMhOO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231248574"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="231248574"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 07:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="503058862"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2022 07:10:40 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKLx2-000Atl-79; Wed, 16 Feb 2022 15:10:40 +0000
Date:   Wed, 16 Feb 2022 23:09:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Pasternak <vadimp@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@nvidia.com>
Subject: [jpirko-mlxsw:jiri_devel_linecards 28/43]
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:1023:23: error:
 initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka
 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from
 incompatible pointer type 'void (*)(struct...
Message-ID: <202202162311.zXdLiZmj-lkp@intel.com>
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
commit: 37b9b28d9ef1e71cb5a449450fbc2ca9e9d6d667 [28/43] mlxsw: core_thermal: Add interfaces for line card initialization and de-initialization
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202162311.zXdLiZmj-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/37b9b28d9ef1e71cb5a449450fbc2ca9e9d6d667
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 37b9b28d9ef1e71cb5a449450fbc2ca9e9d6d667
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:1023:23: error: initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from incompatible pointer type 'void (*)(struct mlxsw_core *, u8,  const struct mlxsw_linecard *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  const struct mlxsw_linecard *, void *)'} [-Werror=incompatible-pointer-types]
    1023 |         .got_active = mlxsw_thermal_got_active,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:1023:23: note: (near initialization for 'mlxsw_thermal_event_ops.got_active')
   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:1024:25: error: initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from incompatible pointer type 'void (*)(struct mlxsw_core *, u8,  const struct mlxsw_linecard *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  const struct mlxsw_linecard *, void *)'} [-Werror=incompatible-pointer-types]
    1024 |         .got_inactive = mlxsw_thermal_got_inactive,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:1024:25: note: (near initialization for 'mlxsw_thermal_event_ops.got_inactive')
   cc1: some warnings being treated as errors


vim +1023 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c

  1021	
  1022	static struct mlxsw_linecards_event_ops mlxsw_thermal_event_ops = {
> 1023		.got_active = mlxsw_thermal_got_active,
  1024		.got_inactive = mlxsw_thermal_got_inactive,
  1025	};
  1026	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
