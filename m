Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B2F496E22
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 22:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiAVVxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 16:53:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:25391 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbiAVVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 16:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642888386; x=1674424386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SNWEoAgFCx9s6kVPn4ZZXLiy0rbXBcZO3eNvmYmXlMY=;
  b=YH4YhlE6lWeupin0siI615rQDDjfZQ+BlbpuP+sA0FjNYACqwS9qaaFb
   XDtbCCKODJpHtvbZ4iJU4XlK/Cr+/3Se2zQToMmjnax+MDa0duJyBv4It
   MAlBxfibhuB3GXjaT23eMwA438/UvNCmm5Uy94MY6DOWYgwTi+OkQz2My
   hzc2H+DuxxIiGxcycOYxFBPdszjHA8o/FKLU+4BZ+OTvB8NaN2kiN+NOQ
   3DOdsR9PkOedv3EdKUeUQ62jrs5eo+QKKyw5F0TgvLGFb+HUdw78tzT2i
   NR6+hKku8h+skOQ3qcmi2mhbO9kthpqPXlPnwDZtMu642LiYanaOB5tmW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10235"; a="309174978"
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="309174978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 13:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="478622976"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2022 13:53:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBOJk-000Gmi-9x; Sat, 22 Jan 2022 21:53:04 +0000
Date:   Sun, 23 Jan 2022 05:52:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: ld.lld: error: undefined symbol: cpus_booted_once_mask
Message-ID: <202201230454.RAEWzGlV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c52283265a462a100ae63ddf58b4e5884acde86
commit: 835f442fdbce33a47a6bde356643fd7e3ef7ec1b irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime
date:   5 weeks ago
config: arm-randconfig-r035-20220122 (https://download.01.org/0day-ci/archive/20220123/202201230454.RAEWzGlV-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=835f442fdbce33a47a6bde356643fd7e3ef7ec1b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 835f442fdbce33a47a6bde356643fd7e3ef7ec1b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: cpus_booted_once_mask
   >>> referenced by irq-gic-v3-its.c
   >>>               irqchip/irq-gic-v3-its.o:(its_cpu_memreserve_lpi) in archive drivers/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
