Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B651BE4C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354211AbiEELnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiEELnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:43:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58AC49922
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651750766; x=1683286766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AD2yT7DFP+hTGlKNWiI4lemreQHZJLeyzDnOs058URo=;
  b=CEnDzXoGLNfY6yvhGTd8JiNhh1uR0PiUseu6QTszpSEAK4ewXw+woxqU
   CpG6Drt9ez9mYNhS0Ga38NoZgJraZih6/iF6WrEoNjinbHhqDlMyuYZ0V
   2oapnRd0qGMBHYSoOBkYgPhOBBrmiDdrSJOK9RSaGUCFBeXHMKqGLXgR1
   mGp4SqCvHaLAHQCejo6ZG3vINcH7WHyv42SYnQlIqQhBXr+8MLj3xGT9Q
   jn4qEKAyZ04qUQR5p3HskMCPcXA8Nezkr9FRH0zrg1aK6M6obEcSl/E5A
   tAo3iSUUBXR7J7g8POd2Zvv8axLGrjYYR7MkPli2RMsDsScRSAcvrHBOm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="266922604"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="266922604"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 04:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="734857195"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2022 04:39:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmZpM-000CMB-7R;
        Thu, 05 May 2022 11:39:24 +0000
Date:   Thu, 5 May 2022 19:38:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_group_locking 24/28] drivers/vfio/vfio.c:1152:16:
 sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202205051928.3PBzM39q-lkp@intel.com>
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

tree:   https://github.com/jgunthorpe/linux vfio_group_locking
head:   0459b33a59543ac21e35b3c9c1ce106968109e6c
commit: bc90cf758ddd2ba50b99a407ec35b5f3c8218662 [24/28] vfio: Split up vfio_group_get_device_fd()
config: h8300-randconfig-s032-20220505 (https://download.01.org/0day-ci/archive/20220505/202205051928.3PBzM39q-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jgunthorpe/linux/commit/bc90cf758ddd2ba50b99a407ec35b5f3c8218662
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_group_locking
        git checkout bc90cf758ddd2ba50b99a407ec35b5f3c8218662
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/vfio/vfio.c:1152:16: sparse: sparse: Using plain integer as NULL pointer

vim +1152 drivers/vfio/vfio.c

  1106	
  1107	static struct file *vfio_device_open(struct vfio_device *device)
  1108	{
  1109		struct file *filep;
  1110		int ret;
  1111	
  1112		ret = vfio_device_assign_container(device);
  1113		if (ret)
  1114			return ERR_PTR(ret);
  1115	
  1116		if (!try_module_get(device->dev->driver->owner)) {
  1117			ret = -ENODEV;
  1118			goto err_unassign_container;
  1119		}
  1120	
  1121		mutex_lock(&device->dev_set->lock);
  1122		device->open_count++;
  1123		if (device->open_count == 1 && device->ops->open_device) {
  1124			ret = device->ops->open_device(device);
  1125			if (ret)
  1126				goto err_undo_count;
  1127		}
  1128		mutex_unlock(&device->dev_set->lock);
  1129	
  1130		/*
  1131		 * We can't use anon_inode_getfd() because we need to modify
  1132		 * the f_mode flags directly to allow more than just ioctls
  1133		 */
  1134		filep = anon_inode_getfile("[vfio-device]", &vfio_device_fops,
  1135					   device, O_RDWR);
  1136		if (IS_ERR(filep)) {
  1137			ret = PTR_ERR(filep);
  1138			goto err_close_device;
  1139		}
  1140	
  1141		/*
  1142		 * TODO: add an anon_inode interface to do this.
  1143		 * Appears to be missing by lack of need rather than
  1144		 * explicitly prevented.  Now there's need.
  1145		 */
  1146		filep->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
  1147	
  1148		/*
  1149		 * On success the ref of device is moved to the file and
  1150		 * put in vfio_device_fops_release()
  1151		 */
> 1152		return 0;
  1153	
  1154	err_close_device:
  1155		mutex_lock(&device->dev_set->lock);
  1156		if (device->open_count == 1 && device->ops->close_device)
  1157			device->ops->close_device(device);
  1158	err_undo_count:
  1159		device->open_count--;
  1160		mutex_unlock(&device->dev_set->lock);
  1161		module_put(device->dev->driver->owner);
  1162	err_unassign_container:
  1163		vfio_group_try_dissolve_container(device->group);
  1164		return ERR_PTR(ret);
  1165	}
  1166	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
