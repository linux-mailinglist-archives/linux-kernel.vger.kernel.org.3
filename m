Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1BB490643
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiAQKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:51:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:4116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbiAQKvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642416714; x=1673952714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=36H2drjwpOY4IU2f8ScW/ajOBwnGkRxRYemk8d7v1T4=;
  b=hBlC6FHk1JtUQwx0MlghSwhlxAAQQFC5B25S8D5KhzCpbLd/ZY3K/OHF
   ALoudRo1EKdBIRPgsCxPiDF2IpyRa4Svmg6EG3jBNwag74LWH4qRQxpfc
   5vq2IRBL/qawFuYHM5Bp0iqapaCHuGFx/F/lBqGphjkRLIAbbI8kCCAmU
   dITOCrYowJcGni1KlPbvxzcAf85Y2EAr1KRo318+1NTpXKWebdF7vuPE6
   Ojtth4htkZdw/NXMIH4hZ+Px7/9fgdqN51JRPnPgH6IbXZlBy6nYdToCF
   8D5VHsoShcxY1+lReHadQuODy+2Ouk/dLesL55gZf39GZZIASVR3VGDjB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="231958928"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="231958928"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 02:51:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="693032267"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2022 02:51:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Pbm-000BUN-QQ; Mon, 17 Jan 2022 10:51:30 +0000
Date:   Mon, 17 Jan 2022 18:51:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: ERROR: modpost: "gpmc_omap_get_nand_ops"
 [drivers/mtd/nand/raw/omap2_nand.ko] undefined!
Message-ID: <202201171805.5HeoR4rS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c947b893d69231a9add855939da7c66237ab44f
commit: dbcb124acebd8148e9e858a231f1798956dd3ca6 mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
date:   4 weeks ago
config: arm64-randconfig-r001-20220117 (https://download.01.org/0day-ci/archive/20220117/202201171805.5HeoR4rS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dbcb124acebd8148e9e858a231f1798956dd3ca6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dbcb124acebd8148e9e858a231f1798956dd3ca6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "gpmc_omap_get_nand_ops" [drivers/mtd/nand/raw/omap2_nand.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP_GPMC
   Depends on MEMORY && OF_ADDRESS
   Selected by
   - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST && HAS_IOMEM && ARCH_K3

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
