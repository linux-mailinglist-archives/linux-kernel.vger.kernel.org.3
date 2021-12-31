Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2B482438
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhLaNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:36:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:18348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhLaNg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640957816; x=1672493816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ziiIZDW4FuCQoGjGsFab8WdZj2erKAoSEUkndTEE768=;
  b=G/R1fBgW5tuDtQML1YOmn6BddE9qnAw3WMmUDxI1z16hkiYhKWdkhRoF
   XpB19EpmMI8WMxubYYRyjXrBVjMvsE6pyZIMWgn5eAQID6L1ngUXVsWg9
   jLR0vqqTTFXKIPJDonH9wFONE4ddCChMHqZdwOXB5te7zhSao2UwuuQ04
   O5taEaAU2Cm34FLKEDPAdUyN937j/cdo8l3NVI9riEpCjBOnxmAZA5nFL
   mgB70MiiaGuUGnpzjJMV6iwW0BQ7asiwHGRpII55AS/rtap6BafiGJIeq
   fy0b/rqYeLnoJoCZSPQJDYUTLZ2jE5bcVOYKpGbbKbBVEWEZNTgpfs1vW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328145542"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="328145542"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 05:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="470948797"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2021 05:36:54 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3I5W-000BId-6R; Fri, 31 Dec 2021 13:36:54 +0000
Date:   Fri, 31 Dec 2021 21:36:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Graf <graf@amazon.com>
Subject: ERROR: modpost: "boot_cpu_hartid" [arch/riscv/kvm/kvm.ko] undefined!
Message-ID: <202112312103.ocXHa7GE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f3d93c6eaff6b84e43b63e0d7a119c5920e1020
commit: fd7bb4a251dfc1da3496bf59a4793937c13e8c1f RISC-V: KVM: Implement VMID allocator
date:   3 months ago
config: riscv-randconfig-r005-20211231 (https://download.01.org/0day-ci/archive/20211231/202112312103.ocXHa7GE-lkp@intel.com/config)
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
