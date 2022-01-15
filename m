Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7F48F995
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiAOVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:41:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:64312 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233774AbiAOVlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642282905; x=1673818905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ptju6tR09L2pMAgvLdWWB4Uv5r7S29axNQQTEmGVtNk=;
  b=oHeqEkv02arEWt06XqvVyD/pt5xx+Jl5PmSG7dDj23edQBh98ghu3MWe
   sBwMS0pUB6ooEEgqgesfAeJdFTcvdU8yqtVrcaSOyt/r0Z2bgYt6r1Y50
   ANCcd/GY4lceoOIcZaAjcf0GWX/ePa5erI72YKwDR6YVUAmSmMczgjRA9
   /pNZsxRywpjpiVNp17Hponr/7i0tniOwvHEbG8GtbdJl3MdR2ByE6/o5q
   5HxDZv+8/DI+4pDoMQRV41Z0l+uZsKWsKtptUOJjeBXBafS3dJRO6jZ6N
   tC52LBaAN/YUoy09N+kOyWKU7l8ijTCkBD3pLNv+IoFFyiVCJII0dboW8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="330789238"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="330789238"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 13:41:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="476169482"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jan 2022 13:41:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8qnu-000AJ1-LH; Sat, 15 Jan 2022 21:41:42 +0000
Date:   Sun, 16 Jan 2022 05:41:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 13/56]
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:744:19: warning:
 incompatible integer to pointer conversion assigning to 'char *' from 'int'
Message-ID: <202201160519.bgz5nnMA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   f53503fb3489103cf72bc705b0e49e4853e5d485
commit: 53d54437e55ccd600a39e5dd5227d163b3ead000 [13/56] mlxsw: core_linecards: Add line card objects and implement provisioning
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220116/202201160519.bgz5nnMA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 650fc40b6d8d9a5869b4fca525d5f237b0ee2803)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/53d54437e55ccd600a39e5dd5227d163b3ead000
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 53d54437e55ccd600a39e5dd5227d163b3ead000
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/block/rnbd/ drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:425:26: warning: variable 'linecards' set but not used [-Wunused-but-set-variable]
           struct mlxsw_linecards *linecards;
                                   ^
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:744:21: error: implicit declaration of function 'vmalloc' [-Werror,-Wimplicit-function-declaration]
           types_info->data = vmalloc(types_info->data_size);
                              ^
>> drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:744:19: warning: incompatible integer to pointer conversion assigning to 'char *' from 'int' [-Wint-conversion]
           types_info->data = vmalloc(types_info->data_size);
                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:772:2: error: implicit declaration of function 'vfree' [-Werror,-Wimplicit-function-declaration]
           vfree(types_info->data);
           ^
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:783:2: error: implicit declaration of function 'vfree' [-Werror,-Wimplicit-function-declaration]
           vfree(types_info->data);
           ^
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:806:14: error: implicit declaration of function 'vzalloc' [-Werror,-Wimplicit-function-declaration]
           linecards = vzalloc(struct_size(linecards, linecards, slot_count));
                       ^
>> drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:806:12: warning: incompatible integer to pointer conversion assigning to 'struct mlxsw_linecards *' from 'int' [-Wint-conversion]
           linecards = vzalloc(struct_size(linecards, linecards, slot_count));
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:842:2: error: implicit declaration of function 'vfree' [-Werror,-Wimplicit-function-declaration]
           vfree(linecards);
           ^
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:860:2: error: implicit declaration of function 'vfree' [-Werror,-Wimplicit-function-declaration]
           vfree(linecards);
           ^
   3 warnings and 6 errors generated.


vim +744 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c

   717	
   718	static int mlxsw_linecard_types_init(struct mlxsw_core *mlxsw_core,
   719					     struct mlxsw_linecards *linecards)
   720	{
   721		struct mlxsw_linecard_types_info *types_info;
   722		const char *lc_ini_bundle_filename;
   723		const struct firmware *firmware;
   724		int err;
   725	
   726		lc_ini_bundle_filename = mlxsw_core_lc_ini_bundle_filename(mlxsw_core);
   727		if (!lc_ini_bundle_filename)
   728			return 0;
   729	
   730		err = request_firmware_direct(&firmware, lc_ini_bundle_filename,
   731					      linecards->bus_info->dev);
   732		if (err) {
   733			dev_warn(linecards->bus_info->dev, "Could not request linecards INI file \"%s\", provisioning will not be possible\n",
   734				 lc_ini_bundle_filename);
   735			return 0;
   736		}
   737	
   738		types_info = kzalloc(sizeof(*types_info), GFP_KERNEL);
   739		if (!types_info)
   740			return -ENOMEM;
   741		linecards->types_info = types_info;
   742	
   743		types_info->data_size = firmware->size;
 > 744		types_info->data = vmalloc(types_info->data_size);
   745		if (!types_info->data) {
   746			err = -ENOMEM;
   747			goto err_data_alloc;
   748		}
   749		memcpy(types_info->data, firmware->data, types_info->data_size);
   750		release_firmware(firmware);
   751	
   752		err = mlxsw_linecard_types_file_validate(linecards, types_info);
   753		if (err) {
   754			err = 0;
   755			goto err_type_file_file_validate;
   756		}
   757	
   758		types_info->ini_files = kmalloc_array(types_info->count,
   759						      sizeof(struct mlxsw_linecard_ini_file),
   760						      GFP_KERNEL);
   761		if (!types_info->ini_files) {
   762			err = -ENOMEM;
   763			goto err_ini_files_alloc;
   764		}
   765	
   766		mlxsw_linecard_types_file_parse(types_info);
   767	
   768		return 0;
   769	
   770	err_ini_files_alloc:
   771	err_type_file_file_validate:
 > 772		vfree(types_info->data);
   773	err_data_alloc:
   774		kfree(types_info);
   775		return err;
   776	}
   777	
   778	static void mlxsw_linecard_types_fini(struct mlxsw_linecards *linecards)
   779	{
   780		struct mlxsw_linecard_types_info *types_info = linecards->types_info;
   781	
   782		kfree(types_info->ini_files);
   783		vfree(types_info->data);
   784		kfree(types_info);
   785	}
   786	
   787	int mlxsw_linecards_init(struct mlxsw_core *mlxsw_core,
   788				 const struct mlxsw_bus_info *bus_info)
   789	{
   790		char mgpir_pl[MLXSW_REG_MGPIR_LEN];
   791		struct mlxsw_linecards *linecards;
   792		u8 slot_count;
   793		int err;
   794		int i;
   795	
   796		mlxsw_reg_mgpir_pack(mgpir_pl, 0);
   797		err = mlxsw_reg_query(mlxsw_core, MLXSW_REG(mgpir), mgpir_pl);
   798		if (err)
   799			return err;
   800	
   801		mlxsw_reg_mgpir_unpack(mgpir_pl, NULL, NULL, NULL,
   802				       NULL, &slot_count);
   803		if (!slot_count)
   804			return 0;
   805	
 > 806		linecards = vzalloc(struct_size(linecards, linecards, slot_count));
   807		if (!linecards)
   808			return -ENOMEM;
   809		linecards->count = slot_count;
   810		linecards->mlxsw_core = mlxsw_core;
   811		linecards->bus_info = bus_info;
   812	
   813		err = mlxsw_linecard_types_init(mlxsw_core, linecards);
   814		if (err)
   815			goto err_types_init;
   816	
   817		err = mlxsw_core_traps_register(mlxsw_core, mlxsw_linecard_listener,
   818						ARRAY_SIZE(mlxsw_linecard_listener),
   819						mlxsw_core);
   820		if (err)
   821			goto err_traps_register;
   822	
   823		mlxsw_core_linecards_set(mlxsw_core, linecards);
   824	
   825		for (i = 0; i < linecards->count; i++) {
   826			err = mlxsw_linecard_init(mlxsw_core, linecards, i + 1);
   827			if (err)
   828				goto err_linecard_init;
   829		}
   830	
   831		return 0;
   832	
   833	err_linecard_init:
   834		for (i--; i >= 0; i--)
   835			mlxsw_linecard_fini(mlxsw_core, linecards, i + 1);
   836		mlxsw_core_traps_unregister(mlxsw_core, mlxsw_linecard_listener,
   837					    ARRAY_SIZE(mlxsw_linecard_listener),
   838					    mlxsw_core);
   839	err_traps_register:
   840		mlxsw_linecard_types_fini(linecards);
   841	err_types_init:
   842		vfree(linecards);
   843	
   844		return err;
   845	}
   846	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
