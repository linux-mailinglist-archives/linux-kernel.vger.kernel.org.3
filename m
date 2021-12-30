Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266D4817F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 01:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhL3A52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 19:57:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:38955 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233486AbhL3A52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 19:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640825848; x=1672361848;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yUAaGvj07WX09Kl9tz+Gl5gyV2UvBq6FTtkC+ImHrDY=;
  b=kKIHwqBVcfGWpfz26daOhqCsvfemfeprcej2SWyhljJX5UxH2QuwkNTn
   F5tbCbUtOI9OfHJba1tFHslUl7+8emhtpuTB9taylnsTN3yTsd+1fLQKB
   aLQkqHSHQrOstQ1abtpRnhlCGl5qBhjJhrWzOX3qibTZUalNlZ5l8k1D5
   z9/utE/TwIxe5WfxxOAbhI/H21vcTrMcMsmXj7y5I9+LY0EdJOn6o72Dj
   O6NWMjO6Mb5ZL0CoHun8p2IvDsBNMtzKXwc1YfqhYnrymdymEuI+yMB/c
   mPjc8QMy6A+CUDeBJHCTjKw2ZJdOLSiMtInAJQl3H1Hy36Hnb9Z3ejRTn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="239137504"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="239137504"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 16:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="468662675"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Dec 2021 16:57:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2jkz-0009Wl-3G; Thu, 30 Dec 2021 00:57:25 +0000
Date:   Thu, 30 Dec 2021 08:57:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Graf <graf@amazon.com>
Subject: ERROR: modpost: "boot_cpu_hartid" [arch/riscv/kvm/kvm.ko] undefined!
Message-ID: <202112300843.UUqHyQYw-lkp@intel.com>
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
head:   eec4df26e24e978e49ccf9bcf49ca0f2ccdaeffe
commit: fd7bb4a251dfc1da3496bf59a4793937c13e8c1f RISC-V: KVM: Implement VMID allocator
date:   3 months ago
config: riscv-randconfig-r035-20211230 (https://download.01.org/0day-ci/archive/20211230/202112300843.UUqHyQYw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd7bb4a251dfc1da3496bf59a4793937c13e8c1f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fd7bb4a251dfc1da3496bf59a4793937c13e8c1f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "boot_cpu_hartid" [arch/riscv/kvm/kvm.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
