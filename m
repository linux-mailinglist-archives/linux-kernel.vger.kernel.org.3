Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7214CA5A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbiCBNMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiCBNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:12:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A22DD71
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646226689; x=1677762689;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mYOrgzlN6n/mT3toec7HXRWdghg+WF25tI0TOlVE5yM=;
  b=TDT1egoUh3ejEOZtJC3K32mTd3Sn4mYBxl8AeP7qbiHM4iLC76Le9J8i
   Adw0+5D4DfOcwEZmenVzGL8ZNPhl/dkyhvmP7TMRmbaqVzz/uDL3kgJ60
   ewXdLhRgc9HIJkELEvGf5TWrdOU/xQXkeA8yDhQhsP1dQ6Mce0AekOWdG
   N/lRpw29ATn0p13MtsGkSFjw5mCsUqDYfLMXg1w26LRvZI4fk9QkGXr3d
   bj3L5X27FcckyIPsYH6b8cX4Lu38jt+R0OUZt9Mdqr4r2uulof7LPSQco
   zjtUvdiDkwvwWSB/AedmocFh1vVBGUkBMyQRq+rlgsOZ4SPt1jsRoMRo9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253320854"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253320854"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="493533189"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2022 05:11:02 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPOkw-0001Qo-0q; Wed, 02 Mar 2022 13:11:02 +0000
Date:   Wed, 2 Mar 2022 21:10:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Liu Yi L <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 25/31]
 drivers/vfio/vfio.c:1160:17: warning: incompatible integer to pointer
 conversion assigning to 'void *' from 'int'
Message-ID: <202203022116.URNbYC7D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   008e1a440da8ca4e1dae3dc1c210b46cb77ce01f
commit: 6a340611dcaacc984fb82a265f0a53a28aed80e0 [25/31] vfio: Add iommufd VFIO compat support to group_fd
config: hexagon-randconfig-r045-20220302 (https://download.01.org/0day-ci/archive/20220302/202203022116.URNbYC7D-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/6a340611dcaacc984fb82a265f0a53a28aed80e0
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 6a340611dcaacc984fb82a265f0a53a28aed80e0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vfio/vfio.c:1160:17: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           group->iommufd = vfio_group_set_iommufd(container_fd,
                          ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1160 drivers/vfio/vfio.c

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
  1161							&group->device_list);
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
