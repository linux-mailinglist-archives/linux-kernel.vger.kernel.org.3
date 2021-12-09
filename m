Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5B46EC0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhLIPsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:48:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:16836 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbhLIPsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639064702; x=1670600702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oKF69hlaGcANR15fx9O9vsPeGWXDimG35n9e4fb3vPo=;
  b=DWHx+vcUg0zh3SXcjvFg2kDjA0MgIWSj1/urTS3g/CJMZyTLvoNPjV5E
   lPxaR1Dy9AGDIYXNArJ2uYP9cyQeDNIDxqHwtV/W8tw8KV+reEhNMiXXi
   1wSe7xuigGSNoQU9bjClWuPU/FUU8BVLvrKS+Gz8Hwmn0ebXMTZ1P5UMi
   3WL7cK6pSL/S8j+piQTe6mGHqmnb8jRUlN4Cy8G+xaMqM7IcJdL0KEfsZ
   Ap84HKaxvO4ee8uHahlrk4rTr9t9Tyj6SHiMKbUg717UCC/u3nEGL9bNs
   kSHNA+owwa9NV0LYE0viHE8MtsuFUDWADzLsldx0Li3ipZ88pXa2DqOaa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218817038"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="218817038"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 07:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="503534234"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2021 07:43:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvLZy-00026q-Jq; Thu, 09 Dec 2021 15:43:30 +0000
Date:   Thu, 9 Dec 2021 23:43:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Deokgyu <secugyu@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.16.y 27/75] make[4]: *** No rule to make target
 'drivers/staging/fbtft/fb_hktft35.o', needed by
 'drivers/staging/fbtft/built-in.a'.
Message-ID: <202112092356.m5mgi8FD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

First bad commit (maybe != root cause):

tree:   https://github.com/tobetter/linux odroid-5.16.y
head:   04f296b5f991198f16f76ba15a23e9e00e30aac4
commit: 9619de99010a64c0bc671f656f9913565b92e307 [27/75] ODROID-XU4: drivers/fbtft: Add fb_hktft32 module for Hardkernel 3.2 inch TFT LCD
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20211209/202112092356.m5mgi8FD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/9619de99010a64c0bc671f656f9913565b92e307
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.16.y
        git checkout 9619de99010a64c0bc671f656f9913565b92e307
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/staging/fbtft/fb_hktft35.o', needed by 'drivers/staging/fbtft/built-in.a'.
   make[4]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
