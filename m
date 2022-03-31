Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712A04ED649
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiCaI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiCaI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:56:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292BEA345
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648716890; x=1680252890;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OVNRGTw7z8Qgh8ouyJiKkdQjQBRujL1UwH+DPrssMMY=;
  b=JCltQ6jY/6lAJMeNSRK3E5s2snxLS7jzlFbiJC7lF+VuPze4gNienwJo
   6cfokwM87CSxj0eu0aSXbmgo+tI/p+xCBCwNeAGVyuIpphItD87Ey6wtl
   ylpUKlH7+gzWRPLC2gYNQre/Veazmzmt4UuQClGOchyD7xz4zWuVQ7uXi
   /3PKEQVWinpAd1bO218BXezuC+RBnbwlvpNVCveehxpDloKhh/6A5tBby
   P3vwy5IatMHSs4YsQ1t+S8bTv28K70WyTUEtbRbfTRcpUEwiLMXqS+L8O
   X2c0bIpPEqpGjX1t7vVoyc8/v0Ba+L7v/XIVYS3L0iBYEdM4p+0KJj4SA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="284682348"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="284682348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="522253672"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2022 01:54:49 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZqZs-00006e-Mi;
        Thu, 31 Mar 2022 08:54:48 +0000
Date:   Thu, 31 Mar 2022 16:54:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_v5.18 16/25]
 drivers/vfio/pci/vfio_pci_zdev.c:112:5: warning: no previous prototype for
 'vfio_pci_info_zdev_add_caps'
Message-ID: <202203311635.aqHHbSIK-lkp@intel.com>
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

tree:   https://github.com/jgunthorpe/linux vfio_v5.18
head:   2af6f07c2b38e8b37c41347ff9bd2b2e8b32a8d6
commit: cbf96a0bc2aeb156e3bedee832c2c336953d8df2 [16/25] vfio/pci: Split linux/vfio_pci_core.h
config: s390-defconfig (https://download.01.org/0day-ci/archive/20220331/202203311635.aqHHbSIK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/cbf96a0bc2aeb156e3bedee832c2c336953d8df2
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_v5.18
        git checkout cbf96a0bc2aeb156e3bedee832c2c336953d8df2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/vfio/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vfio/pci/vfio_pci_zdev.c:112:5: warning: no previous prototype for 'vfio_pci_info_zdev_add_caps' [-Wmissing-prototypes]
     112 | int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/vfio_pci_info_zdev_add_caps +112 drivers/vfio/pci/vfio_pci_zdev.c

e6b817d4b8217a9 Matthew Rosato 2020-10-07  108  
e6b817d4b8217a9 Matthew Rosato 2020-10-07  109  /*
e6b817d4b8217a9 Matthew Rosato 2020-10-07  110   * Add all supported capabilities to the VFIO_DEVICE_GET_INFO capability chain.
e6b817d4b8217a9 Matthew Rosato 2020-10-07  111   */
536475109c82841 Max Gurtovoy   2021-08-26 @112  int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,

:::::: The code at line 112 was first introduced by commit
:::::: 536475109c82841126ca341ef0f138e7298880c1 vfio/pci: Rename vfio_pci_device to vfio_pci_core_device

:::::: TO: Max Gurtovoy <mgurtovoy@nvidia.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
