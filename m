Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED047598D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhLONWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:22:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:39860 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234617AbhLONWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639574563; x=1671110563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rUjJVZUVIvIFQr4MyBZlVi+Wln2PLmdQR/GPsbeKbcE=;
  b=O992ke/Gta0r2hb1wIKcHIZGQDEqjOxvrZ71vrgVPm0TsxQ+n1kaChuk
   LJ2Os+XYjwDBlAzJLck8MrkIRlO2lfaIukC5EzcsA+JYJvkyRflyG3yng
   gGmNOpJ2xTvKLc67X3MmH5nLTWnoW2DxJLhG5UmGGGyoNMtPSWkDN0rlR
   ZCh4nh2EMM5mtkN7evDQQyjCxPpfE1VHnoZQAi5vI4QuiFK/zGwEC1nU0
   LG7MHovkgX7o/jUdRH25+Q7QH2SkOgdaehCP/IaMGpEuLs3erekynppJi
   4oyUbM5fTj7slskBmCu2DB3U18ECfUtZ7cvSs8Y1vEiS1Ee3DbsIG/q1F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="237961886"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="237961886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="464260971"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2021 05:21:02 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxUDN-0001op-Op; Wed, 15 Dec 2021 13:21:01 +0000
Date:   Wed, 15 Dec 2021 21:20:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [linux-stable-rc:queue/4.19 9919/9999] ERROR: "usb_hid_driver"
 [drivers/hid/hid-asus.ko] undefined!
Message-ID: <202112152114.lpbAj4a1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.19
head:   9f411771d2924dfabe1071cc23e0d13d69ee8fb3
commit: b1efa723b986a84f84a95b6907cffe3a357338c9 [9919/9999] HID: add hid_is_usb() function to make it simpler for USB detection
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211215/202112152114.lpbAj4a1-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b1efa723b986a84f84a95b6907cffe3a357338c9
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.19
        git checkout b1efa723b986a84f84a95b6907cffe3a357338c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ERROR: "devm_ioremap_resource" [drivers/scsi/ufs/ufshcd-pltfrm.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/net/ethernet/aurora/nb8800.ko] undefined!
   ERROR: "devm_ioremap_nocache" [drivers/net/ethernet/altera/altera_tse.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/net/can/grcan.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/media/rc/ir-hix5hd2.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/input/touchscreen/imx6ul_tsc.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/input/serio/apbps2.ko] undefined!
>> ERROR: "usb_hid_driver" [drivers/hid/hid-asus.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/crypto/ccree/ccree.ko] undefined!
   ERROR: "debugfs_create_regset32" [drivers/crypto/ccree/ccree.ko] undefined!
   ERROR: "devm_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
