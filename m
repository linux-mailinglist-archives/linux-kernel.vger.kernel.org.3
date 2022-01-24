Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A977A497C92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiAXKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:00:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:1834 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbiAXKAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643018435; x=1674554435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I9ASTMkJBZh1dnZeeM7ClIkGGamrhZ4TzmARTN6rzk4=;
  b=iwTGTipd2ieKLH6tBDufWhV7W4WpEMIQwI/8Hyoaj2gqnCBPdixCVelp
   W7tP6SfStWlg0WehTAzgJt1+nNAJLtcqi2eKsioV+oFyd6J3xlHWxC+h0
   tXEQ8lrE9w0quWcBVG6viNxLvcheA+JBZ4Fm3VSMfpIYwZBqNrt7oJ6MW
   JamCTVKNAzME4NInV+iHWuJadg40/qzD2MizAY4jtTjeo0cAmpLF4YzCU
   wLzlc5wwS/OZC/EOWzt59VbB7uoBxMClb61/p9udJRD2slIghB3Oq3Ad0
   GYFD0F6qKWlThtBaEnkrn2dz9YFRMXXokBn4eOvF3tLjijiVcCLxKdIhK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306726405"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306726405"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 01:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695369016"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 01:59:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBw8G-000I9K-R5; Mon, 24 Jan 2022 09:59:28 +0000
Date:   Mon, 24 Jan 2022 17:58:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/pci/controller/pcie-mt7621.c:549:34: warning: unused
 variable 'mt7621_pcie_ids'
Message-ID: <202201241754.igtHzgHv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55 Merge branch 'pci/driver-cleanup'
date:   11 days ago
config: mips-randconfig-r031-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241754.igtHzgHv-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pci/controller/pcie-mt7621.c:112:20: warning: unused function 'pcie_rmw' [-Wunused-function]
   static inline void pcie_rmw(struct mt7621_pcie *pcie, u32 reg, u32 clr, u32 set)
                      ^
>> drivers/pci/controller/pcie-mt7621.c:549:34: warning: unused variable 'mt7621_pcie_ids' [-Wunused-const-variable]
   static const struct of_device_id mt7621_pcie_ids[] = {
                                    ^
   2 warnings generated.


vim +/mt7621_pcie_ids +549 drivers/pci/controller/pcie-mt7621.c

03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin  2018-03-15  548  
4793895f597d42e drivers/pci/controller/pcie-mt7621.c    Bjorn Helgaas 2021-12-22 @549  static const struct of_device_id mt7621_pcie_ids[] = {
03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin  2018-03-15  550  	{ .compatible = "mediatek,mt7621-pci" },
03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin  2018-03-15  551  	{},
03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin  2018-03-15  552  };
4793895f597d42e drivers/pci/controller/pcie-mt7621.c    Bjorn Helgaas 2021-12-22  553  MODULE_DEVICE_TABLE(of, mt7621_pcie_ids);
03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin  2018-03-15  554  

:::::: The code at line 549 was first introduced by commit
:::::: 4793895f597d42eb54a0f54711b61263b6a8dd03 PCI: mt7621: Rename mt7621_pci_ to mt7621_pcie_

:::::: TO: Bjorn Helgaas <bhelgaas@google.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
