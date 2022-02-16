Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AF4B8D83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiBPQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:11:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiBPQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:11:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309DA60041
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645027905; x=1676563905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QiEFimDzeKGWwLXx9r2Bgeshi0IgC4yuwUNyNN4cbws=;
  b=aasuoVh5IayuU8+Gq2ImQDSgEdbjtGQ3Pw3M3panBZNt0ax1L0IdM+DP
   RPZJKLQcLSCgESWLogLfTetSK+ajMEd9WZKRXT2nwMcVRt56E4e5bjoXh
   FbOScAwTh06J+nRTZoTLIZ5ixxdSrhtJW+FXcs/nBMECM+xb85hYJHM9u
   2bUhmyVYPR8A0TXGlDUBpqr2BccB+jrptQamYvP+cuyQDbRZttaI6yirJ
   q8Ze0URgS/bDchhqpBOXCgIKwNk5b7y4/1bPK3eM2GcjsGC+hURmo8FzY
   Og/UhBTW4/rnLcHpCrgtkNT2lQU7D2RSWwihoRjKd/wtri791KBaFCX7x
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231281805"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="231281805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 08:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="571354112"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2022 08:11:42 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKMu6-000Avw-Ah; Wed, 16 Feb 2022 16:11:42 +0000
Date:   Thu, 17 Feb 2022 00:10:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Pasternak <vadimp@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@nvidia.com>
Subject: [jpirko-mlxsw:jiri_devel_linecards 29/43]
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c:898:23: error:
 initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka
 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from
 incompatible pointer type 'void (*)(struct ml...
Message-ID: <202202170026.mb9LyVVk-lkp@intel.com>
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
commit: 0733fff985b276239955edfc5a42e929eced7437 [29/43] mlxsw: core_hwmon: Add interfaces for line card initialization and de-initialization
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220217/202202170026.mb9LyVVk-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/0733fff985b276239955edfc5a42e929eced7437
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 0733fff985b276239955edfc5a42e929eced7437
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c:898:23: error: initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from incompatible pointer type 'void (*)(struct mlxsw_core *, u8,  const struct mlxsw_linecard *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  const struct mlxsw_linecard *, void *)'} [-Werror=incompatible-pointer-types]
     898 |         .got_active = mlxsw_hwmon_got_active,
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c:898:23: note: (near initialization for 'mlxsw_hwmon_event_ops.got_active')
   drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c:899:25: error: initialization of 'void (*)(struct mlxsw_core *, u8,  void *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  void *, void *)'} from incompatible pointer type 'void (*)(struct mlxsw_core *, u8,  const struct mlxsw_linecard *, void *)' {aka 'void (*)(struct mlxsw_core *, unsigned char,  const struct mlxsw_linecard *, void *)'} [-Werror=incompatible-pointer-types]
     899 |         .got_inactive = mlxsw_hwmon_got_inactive,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c:899:25: note: (near initialization for 'mlxsw_hwmon_event_ops.got_inactive')
   cc1: some warnings being treated as errors


vim +898 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c

   896	
   897	static struct mlxsw_linecards_event_ops mlxsw_hwmon_event_ops = {
 > 898		.got_active = mlxsw_hwmon_got_active,
   899		.got_inactive = mlxsw_hwmon_got_inactive,
   900	};
   901	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
