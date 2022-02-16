Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1A54B8B13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiBPOJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:09:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiBPOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:08:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9311610EC5A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645020521; x=1676556521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bk/EYp4Hlzkayd5lOiirjY2brB/ZvPzle7F/dJVy3Qw=;
  b=ESilpi0al2oMCj1bjBtfCmBRXpKu9sJucSd3HAIu5zMgfOLIr6CE99p/
   hltozvMBllvSh3c0lMBm1cHtANy57GhX+dZV9ZjMMYSMNadM9mh3HRfUF
   dNRXLdR4vJuB+RM/cWsLbkQyIfh+Kj1aFqnmSI2RAE7T+1138A4V1QgrL
   2Lf0ScWq4VIHFn0ZAAlfF8bT7BZHMNNHxyC+IWA+Yanbjf3VWO3dEJ3kr
   xSrSonVOonsugp8E4T9zQ9ZFu5mbQuXp5uf+4MmC4eUAeKDCGjr/RoWKu
   +nzML+ib9rbuNs9UQvJMdS0sodQisBP1jZlHWlw767eRXWR5eFsfZwQx4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="248206670"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="248206670"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 06:08:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="487031921"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Feb 2022 06:08:39 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKKz0-000Aqk-Lb; Wed, 16 Feb 2022 14:08:38 +0000
Date:   Wed, 16 Feb 2022 22:08:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 19/43]
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:129:79: error: passing
 argument 3 of 'devlink_linecard_device_create' from incompatible pointer
 type
Message-ID: <202202162255.qkZEHFMQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   5cb021512c3be7e03591497caeab474ecccfcd21
commit: ddbc2cda5873d87ed1bf101a45620504bfc99a5a [19/43] devlink: allow driver to pass flash component name for line card device
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202162255.qkZEHFMQ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/ddbc2cda5873d87ed1bf101a45620504bfc99a5a
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout ddbc2cda5873d87ed1bf101a45620504bfc99a5a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the jpirko-mlxsw/jiri_devel_linecards HEAD 5cb021512c3be7e03591497caeab474ecccfcd21 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c: In function 'mlxsw_linecard_device_attach':
>> drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:129:79: error: passing argument 3 of 'devlink_linecard_device_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
     129 |                                                                 device_index, device);
         |                                                                               ^~~~~~
         |                                                                               |
         |                                                                               struct mlxsw_linecard_device *
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:15,
                    from drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:15:
   include/net/devlink.h:1579:44: note: expected 'const char *' but argument is of type 'struct mlxsw_linecard_device *'
    1579 |                                const char *flash_component, void *priv);
         |                                ~~~~~~~~~~~~^~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:128:34: error: too few arguments to function 'devlink_linecard_device_create'
     128 |         device->devlink_device = devlink_linecard_device_create(linecard->devlink_linecard,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:15,
                    from drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:15:
   include/net/devlink.h:1577:1: note: declared here
    1577 | devlink_linecard_device_create(struct devlink_linecard *linecard,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devlink_linecard_device_create +129 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c

c075259346e402e Jiri Pirko 2022-02-04   14  
c075259346e402e Jiri Pirko 2022-02-04  @15  #include "core.h"
c075259346e402e Jiri Pirko 2022-02-04   16  
c075259346e402e Jiri Pirko 2022-02-04   17  struct mlxsw_linecard_ini_file {
c075259346e402e Jiri Pirko 2022-02-04   18  	__le16 size;
c075259346e402e Jiri Pirko 2022-02-04   19  	union {
c075259346e402e Jiri Pirko 2022-02-04   20  		u8 data[0];
c075259346e402e Jiri Pirko 2022-02-04   21  		struct {
c075259346e402e Jiri Pirko 2022-02-04   22  			__be16 hw_revision;
c075259346e402e Jiri Pirko 2022-02-04   23  			__be16 ini_version;
c075259346e402e Jiri Pirko 2022-02-04   24  			u8 __dontcare[3];
c075259346e402e Jiri Pirko 2022-02-04   25  			u8 type;
c075259346e402e Jiri Pirko 2022-02-04   26  			u8 name[20];
c075259346e402e Jiri Pirko 2022-02-04   27  		} format;
c075259346e402e Jiri Pirko 2022-02-04   28  	};
c075259346e402e Jiri Pirko 2022-02-04   29  };
c075259346e402e Jiri Pirko 2022-02-04   30  
c075259346e402e Jiri Pirko 2022-02-04   31  struct mlxsw_linecard_types_info {
c075259346e402e Jiri Pirko 2022-02-04   32  	struct mlxsw_linecard_ini_file **ini_files;
c075259346e402e Jiri Pirko 2022-02-04   33  	unsigned int count;
c075259346e402e Jiri Pirko 2022-02-04   34  	size_t data_size;
c075259346e402e Jiri Pirko 2022-02-04   35  	char *data;
c075259346e402e Jiri Pirko 2022-02-04   36  };
c075259346e402e Jiri Pirko 2022-02-04   37  
c075259346e402e Jiri Pirko 2022-02-04   38  #define MLXSW_LINECARD_STATUS_EVENT_TO (10 * MSEC_PER_SEC)
c075259346e402e Jiri Pirko 2022-02-04   39  
c075259346e402e Jiri Pirko 2022-02-04   40  static void
c075259346e402e Jiri Pirko 2022-02-04   41  mlxsw_linecard_status_event_to_schedule(struct mlxsw_linecard *linecard,
c075259346e402e Jiri Pirko 2022-02-04   42  					enum mlxsw_linecard_status_event_type status_event_type)
c075259346e402e Jiri Pirko 2022-02-04   43  {
c075259346e402e Jiri Pirko 2022-02-04   44  	cancel_delayed_work_sync(&linecard->status_event_to_dw);
c075259346e402e Jiri Pirko 2022-02-04   45  	linecard->status_event_type_to = status_event_type;
c075259346e402e Jiri Pirko 2022-02-04   46  	mlxsw_core_schedule_dw(&linecard->status_event_to_dw,
c075259346e402e Jiri Pirko 2022-02-04   47  			       msecs_to_jiffies(MLXSW_LINECARD_STATUS_EVENT_TO));
c075259346e402e Jiri Pirko 2022-02-04   48  }
c075259346e402e Jiri Pirko 2022-02-04   49  
c075259346e402e Jiri Pirko 2022-02-04   50  static void
c075259346e402e Jiri Pirko 2022-02-04   51  mlxsw_linecard_status_event_done(struct mlxsw_linecard *linecard,
c075259346e402e Jiri Pirko 2022-02-04   52  				 enum mlxsw_linecard_status_event_type status_event_type)
c075259346e402e Jiri Pirko 2022-02-04   53  {
c075259346e402e Jiri Pirko 2022-02-04   54  	if (linecard->status_event_type_to == status_event_type)
c075259346e402e Jiri Pirko 2022-02-04   55  		cancel_delayed_work_sync(&linecard->status_event_to_dw);
c075259346e402e Jiri Pirko 2022-02-04   56  }
c075259346e402e Jiri Pirko 2022-02-04   57  
c075259346e402e Jiri Pirko 2022-02-04   58  static const char *
c075259346e402e Jiri Pirko 2022-02-04   59  mlxsw_linecard_types_lookup(struct mlxsw_linecards *linecards, u8 card_type)
c075259346e402e Jiri Pirko 2022-02-04   60  {
c075259346e402e Jiri Pirko 2022-02-04   61  	struct mlxsw_linecard_types_info *types_info;
c075259346e402e Jiri Pirko 2022-02-04   62  	struct mlxsw_linecard_ini_file *ini_file;
c075259346e402e Jiri Pirko 2022-02-04   63  	int i;
c075259346e402e Jiri Pirko 2022-02-04   64  
c075259346e402e Jiri Pirko 2022-02-04   65  	types_info = linecards->types_info;
c075259346e402e Jiri Pirko 2022-02-04   66  	if (!types_info)
c075259346e402e Jiri Pirko 2022-02-04   67  		return NULL;
c075259346e402e Jiri Pirko 2022-02-04   68  	for (i = 0; i < types_info->count; i++) {
c075259346e402e Jiri Pirko 2022-02-04   69  		ini_file = linecards->types_info->ini_files[i];
c075259346e402e Jiri Pirko 2022-02-04   70  		if (ini_file->format.type == card_type)
c075259346e402e Jiri Pirko 2022-02-04   71  			return ini_file->format.name;
c075259346e402e Jiri Pirko 2022-02-04   72  	}
c075259346e402e Jiri Pirko 2022-02-04   73  	return NULL;
c075259346e402e Jiri Pirko 2022-02-04   74  }
c075259346e402e Jiri Pirko 2022-02-04   75  
c075259346e402e Jiri Pirko 2022-02-04   76  static const char *mlxsw_linecard_type_name(struct mlxsw_linecard *linecard)
c075259346e402e Jiri Pirko 2022-02-04   77  {
c075259346e402e Jiri Pirko 2022-02-04   78  	struct mlxsw_core *mlxsw_core = linecard->linecards->mlxsw_core;
c075259346e402e Jiri Pirko 2022-02-04   79  	char mddq_pl[MLXSW_REG_MDDQ_LEN];
c075259346e402e Jiri Pirko 2022-02-04   80  	int err;
c075259346e402e Jiri Pirko 2022-02-04   81  
c075259346e402e Jiri Pirko 2022-02-04   82  	mlxsw_reg_mddq_slot_name_pack(mddq_pl, linecard->slot_index);
c075259346e402e Jiri Pirko 2022-02-04   83  	err = mlxsw_reg_query(mlxsw_core, MLXSW_REG(mddq), mddq_pl);
c075259346e402e Jiri Pirko 2022-02-04   84  	if (err)
c075259346e402e Jiri Pirko 2022-02-04   85  		return ERR_PTR(err);
c075259346e402e Jiri Pirko 2022-02-04   86  	mlxsw_reg_mddq_slot_name_unpack(mddq_pl, linecard->name);
c075259346e402e Jiri Pirko 2022-02-04   87  	return linecard->name;
c075259346e402e Jiri Pirko 2022-02-04   88  }
c075259346e402e Jiri Pirko 2022-02-04   89  
8978a4235a849b8 Jiri Pirko 2021-06-10   90  struct mlxsw_linecard_device_info {
8978a4235a849b8 Jiri Pirko 2021-06-10   91  	u16 fw_major;
8978a4235a849b8 Jiri Pirko 2021-06-10   92  	u16 fw_minor;
8978a4235a849b8 Jiri Pirko 2021-06-10   93  	u16 fw_sub_minor;
8978a4235a849b8 Jiri Pirko 2021-06-10   94  };
8978a4235a849b8 Jiri Pirko 2021-06-10   95  
d6c4ce1acc9e393 Jiri Pirko 2021-02-26   96  struct mlxsw_linecard_device {
d6c4ce1acc9e393 Jiri Pirko 2021-02-26   97  	struct list_head list;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26   98  	u8 index;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26   99  	struct mlxsw_linecard *linecard;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  100  	struct devlink_linecard_device *devlink_device;
8978a4235a849b8 Jiri Pirko 2021-06-10  101  	struct mlxsw_linecard_device_info info;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  102  };
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  103  
8978a4235a849b8 Jiri Pirko 2021-06-10  104  static struct mlxsw_linecard_device *
8978a4235a849b8 Jiri Pirko 2021-06-10  105  mlxsw_linecard_device_lookup(struct mlxsw_linecard *linecard, u8 index)
8978a4235a849b8 Jiri Pirko 2021-06-10  106  {
8978a4235a849b8 Jiri Pirko 2021-06-10  107  	struct mlxsw_linecard_device *device;
8978a4235a849b8 Jiri Pirko 2021-06-10  108  
8978a4235a849b8 Jiri Pirko 2021-06-10  109  	list_for_each_entry(device, &linecard->device_list, list)
8978a4235a849b8 Jiri Pirko 2021-06-10  110  		if (device->index == index)
8978a4235a849b8 Jiri Pirko 2021-06-10  111  			return device;
8978a4235a849b8 Jiri Pirko 2021-06-10  112  	return NULL;
8978a4235a849b8 Jiri Pirko 2021-06-10  113  }
8978a4235a849b8 Jiri Pirko 2021-06-10  114  
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  115  static int mlxsw_linecard_device_attach(struct mlxsw_core *mlxsw_core,
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  116  					struct mlxsw_linecard *linecard,
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  117  					u8 device_index, bool flash_owner)
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  118  {
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  119  	struct mlxsw_linecard_device *device;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  120  	int err;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  121  
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  122  	device = kzalloc(sizeof(*device), GFP_KERNEL);
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  123  	if (!device)
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  124  		return -ENOMEM;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  125  	device->index = device_index;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  126  	device->linecard = linecard;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  127  
d6c4ce1acc9e393 Jiri Pirko 2021-02-26 @128  	device->devlink_device = devlink_linecard_device_create(linecard->devlink_linecard,
8978a4235a849b8 Jiri Pirko 2021-06-10 @129  								device_index, device);
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  130  	if (IS_ERR(device->devlink_device)) {
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  131  		err = PTR_ERR(device->devlink_device);
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  132  		goto err_devlink_linecard_device_attach;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  133  	}
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  134  
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  135  	list_add_tail(&device->list, &linecard->device_list);
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  136  	return 0;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  137  
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  138  err_devlink_linecard_device_attach:
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  139  	kfree(device);
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  140  	return err;
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  141  }
d6c4ce1acc9e393 Jiri Pirko 2021-02-26  142  

:::::: The code at line 129 was first introduced by commit
:::::: 8978a4235a849b8e4afae8b58287fe199459128d mlxsw: core_linecards: Expose device FW version over device info

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
