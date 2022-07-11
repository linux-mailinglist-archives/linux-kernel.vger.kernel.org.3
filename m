Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAA56F96D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiGKI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiGKI6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:58:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01F22503
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657529907; x=1689065907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wGJDzEFR+Tk3jcvAhFJBDfKoe8dSvdR+9ahbECtp+YI=;
  b=MZnmD/rddLegmqlzc2jUOP4mUdfCAnpaipxz2y+A9tKNVPyjQfAyaHgR
   pC47INdT0FFJTf3nAn1i3Cb7VxOTLKD4KNqKuvGfA03PRZFANK0vfg8BY
   gCHKyyo7PHUA+px06UtCpOBqa+7t4fT8bNGDW5/IuVVe39Cyj7jnsSilY
   b2VLH3x68lycf9r2BsQRDv44boXXpVC7n94SeoEAND2uPwhyuvC9IPXn9
   OtaexyhQ59DTQu5nAuCKix96XhTtIXmw2cVr8CEOXbMObeRhjRG0RR2SQ
   uXlMLnuV2EimaT7x5JjNQAMZE0Of0LupokfAS6e9+BHphl7IpNEm9HCrg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="285740556"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="285740556"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="921705367"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 01:58:22 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oApFG-0000dl-85;
        Mon, 11 Jul 2022 08:58:22 +0000
Date:   Mon, 11 Jul 2022 16:57:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bluetooth-wip 8/8]
 drivers/bluetooth/hci_bcm43xx.c:1088:23: warning: unused variable 'bcm43xx'
Message-ID: <202207111654.rRuKu0Ms-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bluetooth-wip
head:   988727c92ef6a0ae2c476c6f06676b63665c6059
commit: 988727c92ef6a0ae2c476c6f06676b63665c6059 [8/8] Bluetooth: hci_bcm43xx: Add new driver for BCM43XX PCI boards
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220711/202207111654.rRuKu0Ms-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6ce63e267aab79ca87bf63453d34dd3909ab978d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/988727c92ef6a0ae2c476c6f06676b63665c6059
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bluetooth-wip
        git checkout 988727c92ef6a0ae2c476c6f06676b63665c6059
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/ drivers/hid/ drivers/md/ drivers/net/ethernet/mellanox/mlx5/core/ drivers/vfio/pci/mlx5/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/hci_bcm43xx.c:1088:23: warning: unused variable 'bcm43xx' [-Wunused-variable]
           struct bcm43xx_data *bcm43xx = hci_get_drvdata(hdev);
                                ^
   drivers/bluetooth/hci_bcm43xx.c:1280:8: error: incompatible pointer types passing '__le64 *' (aka 'unsigned long long *') to parameter of type 'dma_addr_t *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
                               &bcm43xx->ctx->per_info_addr, GFP_KERNEL);
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:550:15: note: passing argument to parameter 'dma_handle' here
                   dma_addr_t *dma_handle, gfp_t gfp)
                               ^
   1 warning and 1 error generated.


vim +/bcm43xx +1088 drivers/bluetooth/hci_bcm43xx.c

  1085	
  1086	static int bcm43xx_hci_close(struct hci_dev *hdev)
  1087	{
> 1088		struct bcm43xx_data *bcm43xx = hci_get_drvdata(hdev);
  1089	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
