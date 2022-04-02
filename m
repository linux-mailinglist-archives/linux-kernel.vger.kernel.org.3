Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92494F05F4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbiDBTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiDBTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:46:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882A21837
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648928705; x=1680464705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x4DPq9dY05g2mfooonPHQqJf1rYJgFV3UH94ojfxpg0=;
  b=e3/tJWosKn1wHEzynJJsMqgvKgGsZCBDm/rJtOY4O38lcG++4U3D/2kc
   KekkLsysKtDH6FSDfQaxq+w1kWh3bd7IDZW3Fy8kckZ62Sw9NmY2ELUe4
   4Zc7bzRvULcstIHXLGq7UfGEZMN5aHrHa2J7fYj6MW3F47Hu58PqJCzVk
   WDTZHpaUgZPipo6td0iM3xTndMC+rra+igKzNY+azNbTBovm6Sd27gsCu
   qhQWWZvJLx95uiUuLy/XJVh1YUnuu1o082Em4LOOnfwIk0YGy+ePYgVNG
   xV2EPXdEsvQQKfh5Am4DED3Nx/NNhBBjNHg9v15MZS3VFyGcSAKEToy7v
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="285274973"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="285274973"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 12:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="548197292"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Apr 2022 12:45:03 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1najgE-0000NH-7y;
        Sat, 02 Apr 2022 19:45:02 +0000
Date:   Sun, 3 Apr 2022 03:44:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 29/29] drivers/ufs/host/ufs-hisi.c:561:34:
 warning: unused variable 'ufs_hisi_of_match'
Message-ID: <202204030304.ueflBFlz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

First bad commit (maybe != root cause):

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   0b5d222740b4462f5e306b363f0684b902ac1298
commit: 0b5d222740b4462f5e306b363f0684b902ac1298 [29/29] scsi: ufs: Split the drivers/scsi/ufs directory
config: hexagon-randconfig-r045-20220403 (https://download.01.org/0day-ci/archive/20220403/202204030304.ueflBFlz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/0b5d222740b4462f5e306b363f0684b902ac1298
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout 0b5d222740b4462f5e306b363f0684b902ac1298
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/ufs/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ufs/host/ufs-hisi.c:561:34: warning: unused variable 'ufs_hisi_of_match' [-Wunused-const-variable]
   static const struct of_device_id ufs_hisi_of_match[] = {
                                    ^
   1 warning generated.


vim +/ufs_hisi_of_match +561 drivers/ufs/host/ufs-hisi.c

653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  560  
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05 @561  static const struct of_device_id ufs_hisi_of_match[] = {
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  562  	{ .compatible = "hisilicon,hi3660-ufs", .data = &ufs_hba_hi3660_vops },
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  563  	{ .compatible = "hisilicon,hi3670-ufs", .data = &ufs_hba_hi3670_vops },
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  564  	{},
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  565  };
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  566  

:::::: The code at line 561 was first introduced by commit
:::::: 653fcb07d95eda58b72a5e715230b582c4d6d69e scsi: ufs: Add HI3670 SoC UFS driver support

:::::: TO: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
