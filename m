Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4524684A3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354819AbhLDMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:07:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:61627 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354342AbhLDMHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:07:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217138630"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="217138630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 04:03:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="656537334"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2021 04:03:49 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtTlc-000Iy4-OA; Sat, 04 Dec 2021 12:03:48 +0000
Date:   Sat, 4 Dec 2021 20:03:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:linkage/alias-rework 3/5] string.c:(.text+0x9b0): multiple
 definition of `strchr'; arch/arm64/lib/strchr.o:(.text+0x0): first defined
 here
Message-ID: <202112041951.birTgnqD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
head:   237447148f41ca99a7b980037060b7a6f3afe535
commit: 5b1a122bc457e6f09d2bf79a8902d859447e105f [3/5] WIP: arm64: remove SYM_FUNC_*_PI()
config: arm64-randconfig-r036-20211203 (https://download.01.org/0day-ci/archive/20211204/202112041951.birTgnqD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=5b1a122bc457e6f09d2bf79a8902d859447e105f
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark linkage/alias-rework
        git checkout 5b1a122bc457e6f09d2bf79a8902d859447e105f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: lib/string.o: in function `strchr':
>> string.c:(.text+0x9b0): multiple definition of `strchr'; arch/arm64/lib/strchr.o:(.text+0x0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
