Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E309B48084F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhL1KQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:16:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:32396 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhL1KQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640686561; x=1672222561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5r60XSQuJMjWFGTZHNRaKFro/hYRDAXK45F4ZCGAlc4=;
  b=DGdEizzLgYyuZh4tG/z9/POjRy4TZpt663K5wMPgFz00aqXVZXwWLeke
   bgQJkNhJ2wHR+/M5LFptVu+ECRTGeRrrh0zCsD9jdxm8tmLbupgM1zkJ5
   2f5/4XCUMSllloCuNikFeczSRU34nwb8tMhOwC4rgSDugDhNQ/Jk4DMKC
   g+Qc65lRhO6KhgIDXKJvSMRn1QLOipuZhVVec9e+aGI/YtHeFOe44E70/
   I1ao45h0pAjYUG2U7lJl6EHIZNCTr0uissXf8ED7QFn62r3yF2EEiNi1z
   5m3CP7PuevoqDFGEnfK8/I2kZYLFDxeNCTvAvqeZnl9xoQYs9h0i6/XTS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="228651049"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="228651049"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 02:16:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="686553081"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2021 02:15:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n29WQ-0007Td-S2; Tue, 28 Dec 2021 10:15:58 +0000
Date:   Tue, 28 Dec 2021 18:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v2 2/17] error:
 include/uapi/asm-generic/fcntl.h: leak CONFIG_COMPAT to user-space
Message-ID: <202112281817.hJFO6Vw8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2
head:   ea94b57a9abaf61f0d0fb41516fab3df16c62c9e
commit: da4662b00ccfe39feabcfef759497af3c071d8ad [2/17] asm-generic: fcntl: compat: Remove duplicate definitions
config: csky-buildonly-randconfig-r001-20211228 (https://download.01.org/0day-ci/archive/20211228/202112281817.hJFO6Vw8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/da4662b00ccfe39feabcfef759497af3c071d8ad
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2
        git checkout da4662b00ccfe39feabcfef759497af3c071d8ad
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/asm-generic/fcntl.h: leak CONFIG_COMPAT to user-space
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm-generic/fcntl.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1283: headers] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
