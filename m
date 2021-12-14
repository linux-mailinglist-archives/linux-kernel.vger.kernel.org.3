Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21834748CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhLNRER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:04:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:44043 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236281AbhLNREQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639501456; x=1671037456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kV60FJ4K67YN8INkEALp5r6OHU3m0yQix+ETn+H0hjc=;
  b=aFAEfGhupSgBbYp3MYzZzHOAnaCGOKv2TdgMT11Ne0S18Xm9+s+vNoA8
   M3H5UNid8JdRk/FJMMec7IIGMc7XQUPlrdS7o6dnjNj7CFgxsoGj/pQeo
   uxKHKB6UcUpo3yMdhU+KXeWpVk6X9sCFiPWP2pxqyUDg/Omet4UqhpAmY
   ijSRjOHG5aKQESUfMAhqJZH/HwJCHncKykBVUBwWkeYWxqF3sPKNWO/7N
   1jZnalRVaFeu7Fn9ZdADYhmhaS2xKkPKMYKJQdB323Qm6sbat6Wg3d7N4
   kJSrIx2JPbNtCRzWM1y9I/3rBFlehPoyhV4mCUC6gKCfrwrLeMsVI3gBN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236559037"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236559037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:04:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="482030681"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2021 09:04:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxBDq-0000Xs-2n; Tue, 14 Dec 2021 17:04:14 +0000
Date:   Wed, 15 Dec 2021 01:03:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Graf <graf@amazon.com>
Subject: ERROR: modpost: "boot_cpu_hartid" [arch/riscv/kvm/kvm.ko] undefined!
Message-ID: <202112150010.rOBJiaq8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: fd7bb4a251dfc1da3496bf59a4793937c13e8c1f RISC-V: KVM: Implement VMID allocator
date:   2 months ago
config: riscv-randconfig-r031-20211214 (https://download.01.org/0day-ci/archive/20211215/202112150010.rOBJiaq8-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd7bb4a251dfc1da3496bf59a4793937c13e8c1f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fd7bb4a251dfc1da3496bf59a4793937c13e8c1f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "boot_cpu_hartid" [arch/riscv/kvm/kvm.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
