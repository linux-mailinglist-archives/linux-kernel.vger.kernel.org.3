Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E2B5909EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiHLBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHLBfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:35:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813713FB0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660268119; x=1691804119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ytP1fNDC6EFMXGJmHYfQRY+7duePc76O+JRGgj6YKLA=;
  b=LD8yicG/19qQFD6beVP4rdppxdgWVm/llyC3MkAY1wV6h2ZEgx03wjyi
   EhXJ2KoGU5i0EOEUTzq0Vgbdju4VDuUBaeusx/j1cU+ZdnSub1KTszzhN
   cs5gw2RuuBQ8+stc/ynCV7oWyfAVKtdlesU2IY6KqUFbodaryXnioig3l
   XK5Uc9Yys9c1CSFMX/OZ35k+ckVkiEw8Mfu07jz6P7ch9aHSPo8ybrLrv
   NtoKAAF5sMme4FOSO2MgzmSUKIMfgUgGT8Kw0B25aIjAt/kWd7/XxUpMx
   3DW1VZlMm5hildi3wT5oYZE3Zc9/42wh9nsRnVsFLnUVSLbxK1aHdvUJt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="317466112"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="317466112"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 18:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556354718"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2022 18:35:17 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMJa0-0000vb-2g;
        Fri, 12 Aug 2022 01:35:16 +0000
Date:   Fri, 12 Aug 2022 09:34:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: drivers/vfio/pci/vfio_pci_zdev.c:151: undefined reference to
 `kvm_s390_pci_register_kvm'
Message-ID: <202208120916.loN3Qrx7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ebfc85e2cd7b08f518b526173e9a33b56b3913b
commit: 8061d1c31f1a018281bc9877ecce44bfc779e21d vfio-pci/zdev: add open/close device hooks
date:   5 weeks ago
config: s390-randconfig-s042-20220811 (https://download.01.org/0day-ci/archive/20220812/202208120916.loN3Qrx7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8061d1c31f1a018281bc9877ecce44bfc779e21d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8061d1c31f1a018281bc9877ecce44bfc779e21d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/vfio/pci/vfio_pci_zdev.o: in function `vfio_pci_zdev_open_device':
>> drivers/vfio/pci/vfio_pci_zdev.c:151: undefined reference to `kvm_s390_pci_register_kvm'
   s390-linux-ld: drivers/vfio/pci/vfio_pci_zdev.o: in function `vfio_pci_zdev_close_device':
>> drivers/vfio/pci/vfio_pci_zdev.c:161: undefined reference to `kvm_s390_pci_unregister_kvm'


vim +151 drivers/vfio/pci/vfio_pci_zdev.c

   140	
   141	int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
   142	{
   143		struct zpci_dev *zdev = to_zpci(vdev->pdev);
   144	
   145		if (!zdev)
   146			return -ENODEV;
   147	
   148		if (!vdev->vdev.kvm)
   149			return 0;
   150	
 > 151		return kvm_s390_pci_register_kvm(zdev, vdev->vdev.kvm);
   152	}
   153	
   154	void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
   155	{
   156		struct zpci_dev *zdev = to_zpci(vdev->pdev);
   157	
   158		if (!zdev || !vdev->vdev.kvm)
   159			return;
   160	
 > 161		kvm_s390_pci_unregister_kvm(zdev);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
