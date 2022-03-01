Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5384C8E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiCAOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiCAOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:55:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3ADA1BCB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646146488; x=1677682488;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1mL06sq+XidRIYwKGym3YToUsju7gBaFDlMGneYFcno=;
  b=fi3qJlEoyrBWBzEjiaI7fptDJmPwBrgxQ5pvxS7q1SSH3yD+MAWuJ9ZP
   l+uC6W+Y42g71CyHb0z2aaA3UWutRGncBkUD069iwidntNEDsqjdErGMG
   70xzOlrqCw4XEfKWPR0uZidKcrQQjbB7luyWgrsVQJc9es62S1Sjx/S4e
   OY+UAjlJeGzDuM81JQzQNYbnkBbLr4HlgwBCn5awLPA17JcVl0WPpi/dZ
   DfkSiu/hei7PEf/FtztG38d7Mt0FDoArvxZ/yhim+FinpA3VJ4nY5CU6/
   vYuRmPMZtU1TrV/q1yd/ExGsdet9DESbRmVSMigABBox7a2LMxx3uI3WD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236653267"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="236653267"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493131752"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2022 06:54:46 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP3tm-0000aW-4A; Tue, 01 Mar 2022 14:54:46 +0000
Date:   Tue, 1 Mar 2022 22:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 25/30]
 drivers/vfio/vfio.c:1084:17: error: too many arguments to function
 'vfio_group_unset_iommufd'
Message-ID: <202203012220.94kbaYHY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   2bca5fa75dad57f41002a93861a950d35d55e568
commit: 4bc299c908a9e789a2514db95519046d795d1303 [25/30] vfio: Add iommufd VFIO compat support to group_fd
config: mips-randconfig-r015-20220301 (https://download.01.org/0day-ci/archive/20220301/202203012220.94kbaYHY-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/4bc299c908a9e789a2514db95519046d795d1303
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 4bc299c908a9e789a2514db95519046d795d1303
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/vfio/vfio.c: In function '__vfio_group_unset_container':
>> drivers/vfio/vfio.c:1084:17: error: too many arguments to function 'vfio_group_unset_iommufd'
    1084 |                 vfio_group_unset_iommufd(group->iommufd, &group->device_list);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/vfio/vfio.c:35:
   include/linux/iommufd.h:56:20: note: declared here
      56 | static inline void vfio_group_unset_iommufd(void *iommufd)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c: In function 'vfio_group_set_container':
>> drivers/vfio/vfio.c:1161:49: error: passing argument 2 of 'vfio_group_set_iommufd' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1161 |                                                 &group->device_list);
         |                                                 ^~~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 struct list_head *
   In file included from drivers/vfio/vfio.c:35:
   include/linux/iommufd.h:50:70: note: expected 'struct iommu_group *' but argument is of type 'struct list_head *'
      50 | static inline int vfio_group_set_iommufd(int fd, struct iommu_group *group,
         |                                                  ~~~~~~~~~~~~~~~~~~~~^~~~~
>> drivers/vfio/vfio.c:1160:26: error: too few arguments to function 'vfio_group_set_iommufd'
    1160 |         group->iommufd = vfio_group_set_iommufd(container_fd,
         |                          ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/vfio/vfio.c:35:
   include/linux/iommufd.h:50:19: note: declared here
      50 | static inline int vfio_group_set_iommufd(int fd, struct iommu_group *group,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/vfio_group_unset_iommufd +1084 drivers/vfio/vfio.c

  1074	
  1075	/*
  1076	 * VFIO Group fd, /dev/vfio/$GROUP
  1077	 */
  1078	static void __vfio_group_unset_container(struct vfio_group *group)
  1079	{
  1080		struct vfio_container *container = group->container;
  1081		struct vfio_iommu_driver *driver;
  1082	
  1083		if (group->iommufd) {
> 1084			vfio_group_unset_iommufd(group->iommufd, &group->device_list);
  1085			group->iommufd = NULL;
  1086			return;
  1087		}
  1088	
  1089		down_write(&container->group_lock);
  1090	
  1091		driver = container->iommu_driver;
  1092		if (driver)
  1093			driver->ops->detach_group(container->iommu_data,
  1094						  group->iommu_group);
  1095	
  1096		iommu_group_release_dma_owner(group->iommu_group);
  1097	
  1098		group->container = NULL;
  1099		wake_up(&group->container_q);
  1100		list_del(&group->container_next);
  1101	
  1102		/* Detaching the last group deprivileges a container, remove iommu */
  1103		if (driver && list_empty(&container->group_list)) {
  1104			driver->ops->release(container->iommu_data);
  1105			module_put(driver->ops->owner);
  1106			container->iommu_driver = NULL;
  1107			container->iommu_data = NULL;
  1108		}
  1109	
  1110		up_write(&container->group_lock);
  1111	
  1112		vfio_container_put(container);
  1113	}
  1114	
  1115	/*
  1116	 * VFIO_GROUP_UNSET_CONTAINER should fail if there are other users or
  1117	 * if there was no container to unset.  Since the ioctl is called on
  1118	 * the group, we know that still exists, therefore the only valid
  1119	 * transition here is 1->0.
  1120	 */
  1121	static int vfio_group_unset_container(struct vfio_group *group)
  1122	{
  1123		int users = atomic_cmpxchg(&group->container_users, 1, 0);
  1124	
  1125		if (!users)
  1126			return -EINVAL;
  1127		if (users != 1)
  1128			return -EBUSY;
  1129	
  1130		__vfio_group_unset_container(group);
  1131	
  1132		return 0;
  1133	}
  1134	
  1135	/*
  1136	 * When removing container users, anything that removes the last user
  1137	 * implicitly removes the group from the container.  That is, if the
  1138	 * group file descriptor is closed, as well as any device file descriptors,
  1139	 * the group is free.
  1140	 */
  1141	static void vfio_group_try_dissolve_container(struct vfio_group *group)
  1142	{
  1143		if (0 == atomic_dec_if_positive(&group->container_users))
  1144			__vfio_group_unset_container(group);
  1145	}
  1146	
  1147	static int vfio_group_set_container(struct vfio_group *group, int container_fd)
  1148	{
  1149		struct fd f;
  1150		struct vfio_container *container;
  1151		struct vfio_iommu_driver *driver;
  1152		int ret = 0;
  1153	
  1154		if (atomic_read(&group->container_users))
  1155			return -EINVAL;
  1156	
  1157		if (group->type == VFIO_NO_IOMMU && !capable(CAP_SYS_RAWIO))
  1158			return -EPERM;
  1159	
> 1160		group->iommufd = vfio_group_set_iommufd(container_fd,
> 1161							&group->device_list);
  1162		if (group->iommufd) {
  1163			atomic_inc(&group->container_users);
  1164			return ret;
  1165		}
  1166	
  1167		f = fdget(container_fd);
  1168		if (!f.file)
  1169			return -EBADF;
  1170	
  1171		/* Sanity check, is this really our fd? */
  1172		if (f.file->f_op != &vfio_fops) {
  1173			fdput(f);
  1174			return -EINVAL;
  1175		}
  1176	
  1177		container = f.file->private_data;
  1178		WARN_ON(!container); /* fget ensures we don't race vfio_release */
  1179	
  1180		down_write(&container->group_lock);
  1181	
  1182		/* Real groups and fake groups cannot mix */
  1183		if (!list_empty(&container->group_list) &&
  1184		    container->noiommu != (group->type == VFIO_NO_IOMMU)) {
  1185			ret = -EPERM;
  1186			goto unlock_out;
  1187		}
  1188	
  1189		ret = iommu_group_claim_dma_owner(group->iommu_group, f.file);
  1190		if (ret)
  1191			goto unlock_out;
  1192	
  1193		driver = container->iommu_driver;
  1194		if (driver) {
  1195			ret = driver->ops->attach_group(container->iommu_data,
  1196							group->iommu_group,
  1197							group->type);
  1198			if (ret) {
  1199				iommu_group_release_dma_owner(group->iommu_group);
  1200				goto unlock_out;
  1201			}
  1202		}
  1203	
  1204		group->container = container;
  1205		container->noiommu = (group->type == VFIO_NO_IOMMU);
  1206		list_add(&group->container_next, &container->group_list);
  1207	
  1208		/* Get a reference on the container and mark a user within the group */
  1209		vfio_container_get(container);
  1210		atomic_inc(&group->container_users);
  1211	
  1212	unlock_out:
  1213		up_write(&container->group_lock);
  1214		fdput(f);
  1215		return ret;
  1216	}
  1217	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
