Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE949E6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiA0QEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:04:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:20274 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234522AbiA0QEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643299445; x=1674835445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U8jSoTl4ZPhwrYOK7YP3aGzzhgYSxSizByd3t+8mD7Y=;
  b=mOw/joDhUf0kno+R+F+RO+bBZcFeZYamPFP4kB+iYLkYHx5mkqhQjVFy
   +qOJDh34ioHsJGTtn94d1qRIZAq/Rc8U02krTFEqgSxBH2cvjQOGvbMPJ
   HCAfv/NT2zkEf/gMth4Sa1Y+OsOCHVx0IzPxMcbSqO3leYguiPrP3pX5w
   juudj4FlgVyfKMy6h57ywqN7UJaRFNvaZxQprKY4eBFEzP85KRBSOqpWZ
   710oF54YqAp+xVNY8cMKwCOr9+ZpMXSVgsbJI7TtLMaRJJxcE1ywZ1YZ+
   L7ZRGpRO4gBnyyrglW8ak9zFsIaG2wtg6DVNGPx9ppmGze5xuBd6Qlw0u
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230470578"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230470578"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="533154661"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2022 08:04:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD7Fh-000MlN-OZ; Thu, 27 Jan 2022 16:04:01 +0000
Date:   Fri, 28 Jan 2022 00:03:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: pcie.c:undefined reference to `pci_remap_iospace'
Message-ID: <202201272308.EHMur1Jl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: 6198461ef509356e7f0fe5b04e88009aa698a065 arm: ioremap: Replace pci_ioremap_io() usage by pci_remap_iospace()
date:   7 weeks ago
config: arm-randconfig-r033-20220127 (https://download.01.org/0day-ci/archive/20220127/202201272308.EHMur1Jl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6198461ef509356e7f0fe5b04e88009aa698a065
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6198461ef509356e7f0fe5b04e88009aa698a065
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mach-dove/pcie.o: in function `dove_pcie_setup':
>> pcie.c:(.init.text+0xd6): undefined reference to `pci_remap_iospace'
   arm-linux-gnueabi-ld: drivers/pci/pci.o: in function `devm_pci_remap_iospace':
   pci.c:(.text+0x1432): undefined reference to `pci_remap_iospace'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
