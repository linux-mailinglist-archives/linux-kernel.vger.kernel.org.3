Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039E44A6922
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbiBBARW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:17:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:34886 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243178AbiBBARV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643761041; x=1675297041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AcqrJTov8DeKhBB4HDvm7SyZlS3Ngs/SVJk64zjhbF4=;
  b=PuF8FSyT4dsQpoPia4WlS0Ww3yT4XAf4HDHW9sNVSxfZF5fYivOBbBMF
   nRL/YNb7Qs/80iEB3SLnNb9P6Y1aBAjxa7GFMf40tANb/FE0wmhlfiWDQ
   teLVdlxaoj0wYxqs9O09Sj7g8eoGd8fQR82cKs7bUjAlWt1z6i6Sr3U9y
   vCzuJ0Cu3L2Z9MG8GtWPYWPXWZ2t3tC02VVVbAQtQDyaWkv8niVaGDJkh
   XIkcB3dyJ1klt598RDpRo/zFzIetufjQIEpFFmPtNHUFfmu5euiXoL88W
   XcntXpuYDD+mDIDfkc3agseElA+ChHQB3ndRiurO0hfwEBEZfPIK8QLM/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="245418984"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="245418984"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 16:17:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="497566044"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2022 16:17:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF3Ko-000Trj-SV; Wed, 02 Feb 2022 00:17:18 +0000
Date:   Wed, 2 Feb 2022 08:16:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [csky-linux:riscv_compat_v5 20/21] riscv64-linux-ld:
 arch/riscv/kernel/compat_syscall_table.o:undefined reference to
 `compat_sys_fadvise64_64'
Message-ID: <202202020825.z4o2smGO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v5
head:   471721ad5e81a434eb4c5d84187312fedaf6cf72
commit: a43cb0b9c0aaa0888a758b2155ef7554a3328aec [20/21] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-m031-20220131 (https://download.01.org/0day-ci/archive/20220202/202202020825.z4o2smGO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/a43cb0b9c0aaa0888a758b2155ef7554a3328aec
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v5
        git checkout a43cb0b9c0aaa0888a758b2155ef7554a3328aec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8): undefined reference to `compat_sys_fadvise64_64'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
