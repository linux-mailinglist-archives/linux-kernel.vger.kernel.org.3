Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C840148C717
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354567AbiALPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:20:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:44802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354583AbiALPUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642000824; x=1673536824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f/5nsh6nLoBINONVdBqki4aXxEoQYraMQMisuojf5D8=;
  b=T1TT8b0vD6ro3zaHqbuI/cR2Zsu+7JwzrmnfuxQc7Pvn1VvZ4Qwd1Zdi
   nhG2GRoNdA2DgLwNx0qfG/Xu3k+cZ6833iuLo2QyJGnF6g6eKIw+hjq+z
   3JKbwc3mFpaRJD2yc9BU2ZGEMbLkA1Ug5zSQmUROJg3b8gylrPJX2+eGO
   RBtD2u3HkujCLQKmSdQ7EloHEx4kcVs1nH5QtabpD+MExL8HnkIUlXIIf
   L2JuDmnmxbDf2o8+A9UudetF49y3SB4l7na6/BKDlREdFSQsZbCaySAA/
   oMOwGmqW5uStqW2utrTfq0ldw3A4IbWmcZlUHKU992FiNitx+sR24v9iw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="268101876"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="268101876"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 07:19:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="528673697"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2022 07:19:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7fPm-00060L-S7; Wed, 12 Jan 2022 15:19:54 +0000
Date:   Wed, 12 Jan 2022 23:19:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: pci.c:undefined reference to `pci_remap_iospace'
Message-ID: <202201122304.s9fOLkUx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   daadb3bd0e8d3e317e36bc2c1542e86c528665e5
commit: 09d97da660ff77df20984496aa0abcd6b88819f2 MIPS: Only define pci_remap_iospace() for Ralink
date:   5 weeks ago
config: mips-randconfig-r021-20220112 (https://download.01.org/0day-ci/archive/20220112/202201122304.s9fOLkUx-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09d97da660ff77df20984496aa0abcd6b88819f2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09d97da660ff77df20984496aa0abcd6b88819f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: drivers/pci/pci.o: in function `devm_pci_remap_iospace':
>> pci.c:(.text+0x708c): undefined reference to `pci_remap_iospace'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
