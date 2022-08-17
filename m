Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590855968B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiHQFkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiHQFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:40:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B144F191
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660714814; x=1692250814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fr2ccTBrMAyNFRTXIjEexaycVessIvgURcYbkU8aAZk=;
  b=PREgkAZS5Jcr0dEiGXbsTKo7YKsvPWwyzYF4qazbO7BK5Xc24eb9S6QR
   2nGGzYgBDkYczQUS4MVuAt1anu6xTKbE900EQr0U95yzy2hUYHQIXRDrR
   R4RSwhhPUeIYw12jbUe3LcKpklbEELPNoN1Tw0Euj/07afk558PUyRDhZ
   W5DbzDc4Az26xt6jI3AnsUm7/5/evCcLmwR6T4444AZ0EKelDIo9qIC37
   ZNjRdVgDRodybxZ4ipCHon54/kVWN85QD7iNOT0Lf1yJISdZo0Azm/+TV
   pmtWaNkpAJdg0+nUqfogsaENOCwoFMACLOcuFWZnjkL/6kxhYA+ka+0RU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378697832"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378697832"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="557983828"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2022 22:40:12 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOBml-0000cm-1w;
        Wed, 17 Aug 2022 05:40:11 +0000
Date:   Wed, 17 Aug 2022 13:39:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_dma_buf 1/18]
 drivers/vfio/pci/vfio_pci_zdev.c:116:5: warning: no previous prototype for
 'vfio_pci_info_zdev_add_caps'
Message-ID: <202208171357.kX3EBdtG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_dma_buf
head:   f5c3d9a2ccc263572e3fc0f87a338679af57184a
commit: 25ad961c532a633fa112c551f8ec63cd17fda180 [1/18] vfio/pci: Split linux/vfio_pci_core.h
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220817/202208171357.kX3EBdtG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/25ad961c532a633fa112c551f8ec63cd17fda180
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_dma_buf
        git checkout 25ad961c532a633fa112c551f8ec63cd17fda180
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/vfio/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vfio/pci/vfio_pci_zdev.c:116:5: warning: no previous prototype for 'vfio_pci_info_zdev_add_caps' [-Wmissing-prototypes]
     116 | int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/vfio/pci/vfio_pci_zdev.c:144:5: warning: no previous prototype for 'vfio_pci_zdev_open_device' [-Wmissing-prototypes]
     144 | int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/vfio/pci/vfio_pci_zdev.c:157:6: warning: no previous prototype for 'vfio_pci_zdev_close_device' [-Wmissing-prototypes]
     157 | void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/vfio_pci_info_zdev_add_caps +116 drivers/vfio/pci/vfio_pci_zdev.c

e6b817d4b8217a Matthew Rosato 2020-10-07  112  
e6b817d4b8217a Matthew Rosato 2020-10-07  113  /*
e6b817d4b8217a Matthew Rosato 2020-10-07  114   * Add all supported capabilities to the VFIO_DEVICE_GET_INFO capability chain.
e6b817d4b8217a Matthew Rosato 2020-10-07  115   */
536475109c8284 Max Gurtovoy   2021-08-26 @116  int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
e6b817d4b8217a Matthew Rosato 2020-10-07  117  				struct vfio_info_cap *caps)
e6b817d4b8217a Matthew Rosato 2020-10-07  118  {
e6b817d4b8217a Matthew Rosato 2020-10-07  119  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
e6b817d4b8217a Matthew Rosato 2020-10-07  120  	int ret;
e6b817d4b8217a Matthew Rosato 2020-10-07  121  
e6b817d4b8217a Matthew Rosato 2020-10-07  122  	if (!zdev)
e6b817d4b8217a Matthew Rosato 2020-10-07  123  		return -ENODEV;
e6b817d4b8217a Matthew Rosato 2020-10-07  124  
46c47466609444 Max Gurtovoy   2021-02-01  125  	ret = zpci_base_cap(zdev, caps);
e6b817d4b8217a Matthew Rosato 2020-10-07  126  	if (ret)
e6b817d4b8217a Matthew Rosato 2020-10-07  127  		return ret;
e6b817d4b8217a Matthew Rosato 2020-10-07  128  
46c47466609444 Max Gurtovoy   2021-02-01  129  	ret = zpci_group_cap(zdev, caps);
e6b817d4b8217a Matthew Rosato 2020-10-07  130  	if (ret)
e6b817d4b8217a Matthew Rosato 2020-10-07  131  		return ret;
e6b817d4b8217a Matthew Rosato 2020-10-07  132  
e6b817d4b8217a Matthew Rosato 2020-10-07  133  	if (zdev->util_str_avail) {
46c47466609444 Max Gurtovoy   2021-02-01  134  		ret = zpci_util_cap(zdev, caps);
e6b817d4b8217a Matthew Rosato 2020-10-07  135  		if (ret)
e6b817d4b8217a Matthew Rosato 2020-10-07  136  			return ret;
e6b817d4b8217a Matthew Rosato 2020-10-07  137  	}
e6b817d4b8217a Matthew Rosato 2020-10-07  138  
46c47466609444 Max Gurtovoy   2021-02-01  139  	ret = zpci_pfip_cap(zdev, caps);
e6b817d4b8217a Matthew Rosato 2020-10-07  140  
e6b817d4b8217a Matthew Rosato 2020-10-07  141  	return ret;
e6b817d4b8217a Matthew Rosato 2020-10-07  142  }
8061d1c31f1a01 Matthew Rosato 2022-06-06  143  
8061d1c31f1a01 Matthew Rosato 2022-06-06 @144  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
8061d1c31f1a01 Matthew Rosato 2022-06-06  145  {
8061d1c31f1a01 Matthew Rosato 2022-06-06  146  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
8061d1c31f1a01 Matthew Rosato 2022-06-06  147  
8061d1c31f1a01 Matthew Rosato 2022-06-06  148  	if (!zdev)
8061d1c31f1a01 Matthew Rosato 2022-06-06  149  		return -ENODEV;
8061d1c31f1a01 Matthew Rosato 2022-06-06  150  
8061d1c31f1a01 Matthew Rosato 2022-06-06  151  	if (!vdev->vdev.kvm)
8061d1c31f1a01 Matthew Rosato 2022-06-06  152  		return 0;
8061d1c31f1a01 Matthew Rosato 2022-06-06  153  
8061d1c31f1a01 Matthew Rosato 2022-06-06  154  	return kvm_s390_pci_register_kvm(zdev, vdev->vdev.kvm);
8061d1c31f1a01 Matthew Rosato 2022-06-06  155  }
8061d1c31f1a01 Matthew Rosato 2022-06-06  156  
8061d1c31f1a01 Matthew Rosato 2022-06-06 @157  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)

:::::: The code at line 116 was first introduced by commit
:::::: 536475109c82841126ca341ef0f138e7298880c1 vfio/pci: Rename vfio_pci_device to vfio_pci_core_device

:::::: TO: Max Gurtovoy <mgurtovoy@nvidia.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
