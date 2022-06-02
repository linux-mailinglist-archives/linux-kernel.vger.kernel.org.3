Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB953C058
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiFBVX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFBVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:23:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2706A1A4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654205033; x=1685741033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o+l2zta686EFUb65MB32Cr2S/nlnv792fT0N5uZxSi8=;
  b=TRUI7QEcs8vnusStxw2yzFMP75sEYVOwPk92qLJmQY7czZ2UMPeMsWfY
   +5nC69+lKG8UXo9kMLi3LDFU4QmgFIhbhvDEfh6DI6esH068lDyXN9t00
   qesNBgmR6b70rwIljWlHSgQPUweVMjb6pGsJbMOLLR19Wp8hC5GAiyNkI
   u3p3tQliX6qssaGks0wt0+ehC/V5iBKpF4igr+sWcoDLDRmF814yR1aQl
   IfsNDxf9j+/rNl0lxVy6pSQXS+YmMruxIj6fZT48bFEQffdT5/ZPS/OHp
   D/Jy3l4bc0rkiD1/uc5yJwxyP7c2l6V4BOGLfquXYPbgmHTx7jCwNrfx5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="339130494"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="339130494"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 14:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="634236248"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2022 14:23:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwsII-0005SP-RM;
        Thu, 02 Jun 2022 21:23:50 +0000
Date:   Fri, 3 Jun 2022 05:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_lc_dev 4/5]
 drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c:67: undefined
 reference to `auxiliary_device_init'
Message-ID: <202206030514.RrhPomLx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_lc_dev
head:   ef34c1c33c0ae43a9ad3c0ed3708eb1880972de0
commit: 2d0852c5fa89a48c6fa1f860600b5e24e2faab4b [4/5] mlxsw: core_linecards: Introduce per line card auxiliary device
config: microblaze-randconfig-r011-20220531 (https://download.01.org/0day-ci/archive/20220603/202206030514.RrhPomLx-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/2d0852c5fa89a48c6fa1f860600b5e24e2faab4b
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_lc_dev
        git checkout 2d0852c5fa89a48c6fa1f860600b5e24e2faab4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.o: in function `mlxsw_linecard_dev_add':
>> drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c:67: undefined reference to `auxiliary_device_init'
>> microblaze-linux-ld: drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c:74: undefined reference to `__auxiliary_device_add'
   microblaze-linux-ld: drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.o: in function `mlxsw_linecard_driver_register':
>> drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c:138: undefined reference to `__auxiliary_driver_register'
   microblaze-linux-ld: drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.o: in function `mlxsw_linecard_driver_unregister':
>> drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c:143: undefined reference to `auxiliary_driver_unregister'


vim +67 drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c

    44	
    45	int mlxsw_linecard_dev_add(struct mlxsw_linecard *linecard)
    46	{
    47		struct mlxsw_linecard_dev *linecard_dev;
    48		int err;
    49		int id;
    50	
    51		id = mlxsw_linecard_dev_id_alloc();
    52		if (id < 0) {
    53			return id;
    54		}
    55	
    56		linecard_dev = kzalloc(sizeof(*linecard_dev), GFP_KERNEL);
    57		if (!linecard_dev) {
    58			mlxsw_linecard_dev_id_free(id);
    59			return -ENOMEM;
    60		}
    61		linecard_dev->adev.id = id;
    62		linecard_dev->adev.name = MLXSW_LINECARD_DEV_ID_NAME;
    63		linecard_dev->adev.dev.release = mlxsw_linecard_dev_release;
    64		linecard_dev->adev.dev.parent = linecard->linecards->bus_info->dev;
    65		linecard_dev->linecard = linecard;
    66	
  > 67		err = auxiliary_device_init(&linecard_dev->adev);
    68		if (err) {
    69			mlxsw_linecard_dev_id_free(id);
    70			kfree(linecard_dev);
    71			return err;
    72		}
    73	
  > 74		err = auxiliary_device_add(&linecard_dev->adev);
    75		if (err) {
    76			auxiliary_device_uninit(&linecard_dev->adev);
    77			return err;
    78		}
    79	
    80		linecard->dev = linecard_dev;
    81		return 0;
    82	}
    83	
    84	void mlxsw_linecard_dev_del(struct mlxsw_linecard *linecard)
    85	{
    86		struct mlxsw_linecard_dev *linecard_dev = linecard->dev;
    87	
    88		auxiliary_device_delete(&linecard_dev->adev);
    89		auxiliary_device_uninit(&linecard_dev->adev);
    90	}
    91	
    92	static const struct devlink_ops mlxsw_linecard_dev_devlink_ops = {
    93	
    94	};
    95	
    96	
    97	static int mlxsw_linecard_dev_probe(struct auxiliary_device *adev,
    98					    const struct auxiliary_device_id *id)
    99	{
   100		struct mlxsw_linecard_dev *linecard_dev = container_of(adev, struct mlxsw_linecard_dev, adev);
   101		struct devlink *devlink;
   102	
   103		devlink = devlink_alloc(&mlxsw_linecard_dev_devlink_ops, 0, &adev->dev);
   104		if (!devlink)
   105			return -ENOMEM;
   106	
   107		devlink_register(devlink);
   108		linecard_dev->devlink = devlink;
   109	
   110		return 0;
   111	}
   112	
   113	static void mlxsw_linecard_dev_remove(struct auxiliary_device *adev)
   114	{
   115		struct mlxsw_linecard_dev *linecard_dev = container_of(adev, struct mlxsw_linecard_dev, adev);
   116		struct devlink *devlink = linecard_dev->devlink;
   117	
   118		devlink_unregister(devlink);
   119		devlink_free(devlink);
   120	}
   121	
   122	static const struct auxiliary_device_id mlxsw_linecard_dev_id_table[] = {
   123		{ .name = KBUILD_MODNAME "." MLXSW_LINECARD_DEV_ID_NAME },
   124		{},
   125	};
   126	
   127	MODULE_DEVICE_TABLE(auxiliary, mlxsw_linecard_dev_id_table);
   128	
   129	static struct auxiliary_driver mlxsw_linecard_driver = {
   130		.name = MLXSW_LINECARD_DEV_ID_NAME,
   131		.probe = mlxsw_linecard_dev_probe,
   132		.remove = mlxsw_linecard_dev_remove,
   133		.id_table = mlxsw_linecard_dev_id_table,
   134	};
   135	
   136	int mlxsw_linecard_driver_register(void)
   137	{
 > 138		return auxiliary_driver_register(&mlxsw_linecard_driver);
   139	}
   140	
   141	void mlxsw_linecard_driver_unregister(void)
   142	{
 > 143		auxiliary_driver_unregister(&mlxsw_linecard_driver);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
