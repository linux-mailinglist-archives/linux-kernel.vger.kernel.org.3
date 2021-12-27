Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D748026E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhL0Qsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:48:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:12236 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhL0Qs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640623706; x=1672159706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lhXOILtCWJmnuLxRGWD2jwij/PI2y8dpSEvOVVbwzok=;
  b=Rts5cDnWBuNvifno8gVfbVyP6lxK/WwJ/DNlC2rxaga+X5d/bF9hYnDV
   1XSc5tkiu0W0N2DM4tRKpXWk6fl4aDODooqHoHH58u03Msrre/FuNBPoz
   7BL8pkhPS6QXDXLm9PBgllrBmIFL9zqm6alYIeHtQ9TTYzkwJkqSM4hF8
   /Bms8lJYH5EMCN3m8W2+XHaNEZSsKKX/FvGksUeMulok5BCwNIZ3RrtM3
   dDdS6kXcL17B5V3wvfxM+rVmNGvnrsnm/gD2DeBAIXQnlyfDLjv8A0+Us
   oUfRZGqUEmN7HmlVrP55E8Qll/ehc5tyWj//39sNQ0yMGiWgr2w8FRYPr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="221235116"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="221235116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 08:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="686333906"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 08:47:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1t9l-0006aT-Ie; Mon, 27 Dec 2021 16:47:29 +0000
Date:   Tue, 28 Dec 2021 00:46:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: m68k-linux-ld: blake2s.c:undefined reference to `blake2s_compress'
Message-ID: <202112280019.orhQTotQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211227-214832/Jason-A-Donenfeld/lib-crypto-blake2s-include-as-built-in/20211223-221318
head:   a0100b394286ac0ea58b9bc14d48e1c6ca902edf
commit: c3ffa27999c0c1ba7d80b336e45a6bd2e20818b8 lib/crypto: blake2s: include as built-in
date:   3 hours ago
config: m68k-m5307c3_defconfig (https://download.01.org/0day-ci/archive/20211228/202112280019.orhQTotQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c3ffa27999c0c1ba7d80b336e45a6bd2e20818b8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211227-214832/Jason-A-Donenfeld/lib-crypto-blake2s-include-as-built-in/20211223-221318
        git checkout c3ffa27999c0c1ba7d80b336e45a6bd2e20818b8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: lib/crypto/blake2s.o: in function `blake2s_update':
   blake2s.c:(.text+0x50): undefined reference to `blake2s_compress'
>> m68k-linux-ld: blake2s.c:(.text+0x98): undefined reference to `blake2s_compress'
   m68k-linux-ld: lib/crypto/blake2s.o: in function `blake2s_final':
   blake2s.c:(.text+0xea): undefined reference to `blake2s_compress'
   m68k-linux-ld: lib/crypto/blake2s.o: in function `blake2s256_hmac':
   blake2s.c:(.text+0x1a4): undefined reference to `blake2s_compress'
   m68k-linux-ld: blake2s.c:(.text+0x4d4): undefined reference to `blake2s_compress'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
