Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4914E7FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiCZIXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiCZIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:23:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D82013E8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648282890; x=1679818890;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fKP51Hr9tTThF36GJpjm8KGyUOWXgbSRjqfQB448bOI=;
  b=SAXD+uQmv0NjffNlgnyC2jU31AOUJyiP8ZGdPVBVl6iwqgnktkcHA5nt
   MTe4kJ9wlJQ0aDY3e6ozpEYSQaK6waTuKQiYxRoEMJN6DHjTBeCylp4JO
   vkXsGOLVLo++1PR0XrM9e2X8wyhrW+NYPYV1MNxSOm0H8jgJd5F585z/V
   gpOFiGJP3IbrdppoV0cR3gmaNEaFuKN9NdkAEHENkmt7bnG6tX9l/uMYI
   2jp2LYaDV7B7FWzNGScUpaAOaDehx9LwVsxbhCTMxJyYJzpzPkYGAZCeY
   +qGhAjJtGowygNjSAQqZMTOFSNXAeCAPyU9ceG5AWCT3yYiK944cYP8Yx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283648734"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="283648734"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 01:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="516777196"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2022 01:21:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY1fr-000NBo-Hp; Sat, 26 Mar 2022 08:21:27 +0000
Date:   Sat, 26 Mar 2022 16:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next-2022-03-25 32/32]
 drivers/scsi/ufs-drivers/ufs-hisi.c:560:34: warning: unused variable
 'ufs_hisi_of_match'
Message-ID: <202203261643.I7AyxLDj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

tree:   https://github.com/bvanassche/linux ufs-for-next-2022-03-25
head:   976ba17fe820846e56fb154b1ae35f5d90be192b
commit: 976ba17fe820846e56fb154b1ae35f5d90be192b [32/32] scsi: ufs: Split the drivers/scsi/ufs directory
config: hexagon-randconfig-r005-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261643.I7AyxLDj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/976ba17fe820846e56fb154b1ae35f5d90be192b
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next-2022-03-25
        git checkout 976ba17fe820846e56fb154b1ae35f5d90be192b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/scsi/ufs-drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/ufs-drivers/ufs-hisi.c:560:34: warning: unused variable 'ufs_hisi_of_match' [-Wunused-const-variable]
   static const struct of_device_id ufs_hisi_of_match[] = {
                                    ^
   1 warning generated.


vim +/ufs_hisi_of_match +560 drivers/scsi/ufs-drivers/ufs-hisi.c

653fcb07d95eda5 drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  559  
653fcb07d95eda5 drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05 @560  static const struct of_device_id ufs_hisi_of_match[] = {
653fcb07d95eda5 drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  561  	{ .compatible = "hisilicon,hi3660-ufs", .data = &ufs_hba_hi3660_vops },
653fcb07d95eda5 drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  562  	{ .compatible = "hisilicon,hi3670-ufs", .data = &ufs_hba_hi3670_vops },
653fcb07d95eda5 drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  563  	{},
653fcb07d95eda5 drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  564  };
653fcb07d95eda5 drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  565  

:::::: The code at line 560 was first introduced by commit
:::::: 653fcb07d95eda58b72a5e715230b582c4d6d69e scsi: ufs: Add HI3670 SoC UFS driver support

:::::: TO: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
