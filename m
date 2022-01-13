Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE348D5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiAMKll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:41:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:24103 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbiAMKlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642070500; x=1673606500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TPBu1IxTu2hZ+dRj8vstJdFYEiXBAWhWrJeYPuKeWZU=;
  b=XoRoC7R2XzopG211F2Jn8zNZKSmoGPd7vLDYzlzeVRgVV8ivsmSxKHTE
   oWXYNiv1OkSlvhf7+ppIvf8ks+g39c1f1aCeh7MKFPLilf1PbzQ7rlleS
   V980bbAI7nJiG5hrRcUPNmsTHwGKgJaRBMY3ILVPpMz2eiTW3EKbXP7um
   gCzgjHh7fvarGEGZQ02nGo+o7+5cnEZT4ibRYz5Zw09QCNF03xNCJ6x91
   XoFnPK/slZj69I+3URR4lf9ImgLTaIO43Zzwl+5lz8wo/TWYr6cY+4Q0u
   sltV0WhMLpGWsV5GyUpSF1DSUsaRqiMB0/Hn4cBlwWU1LPelpPomb0omY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307328199"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307328199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475263020"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 02:41:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7xY2-00075x-HZ; Thu, 13 Jan 2022 10:41:38 +0000
Date:   Thu, 13 Jan 2022 18:41:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 50/57] ERROR: modpost: "ipaq_micro_tx_msg"
 [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!
Message-ID: <202201131843.cJPeRhCD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   7c5e0e177553f8a9ef3424e59fb3ef69c6b71689
commit: e0903a11cbed3fcc17d26af1d2a9d7f842e60ac7 [50/57] ARM: sa1100/h3xxx: sleeve support
config: arm-pleb_defconfig (https://download.01.org/0day-ci/archive/20220113/202201131843.cJPeRhCD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout e0903a11cbed3fcc17d26af1d2a9d7f842e60ac7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ipaq_micro_tx_msg" [arch/arm/mach-sa1100/h3xxx-sleeve.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
