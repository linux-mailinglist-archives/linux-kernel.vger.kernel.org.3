Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D844F463EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbhK3UE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:04:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:30222 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239950AbhK3UE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:04:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="297113376"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="297113376"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="459745256"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2021 12:01:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms9JK-000DiA-2h; Tue, 30 Nov 2021 20:01:06 +0000
Date:   Wed, 1 Dec 2021 04:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Deokgyu <secugyu@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.15.y 28/83] make[4]: *** No rule to make target
 'drivers/staging/fbtft/fb_hktft35.o', needed by
 'drivers/staging/fbtft/fb_hktft35.mod'.
Message-ID: <202112010357.0blfYsRD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

First bad commit (maybe != root cause):

tree:   https://github.com/tobetter/linux odroid-5.15.y
head:   31b3089969f700a8f6d8833b66ca89e104ba01ee
commit: da67b773b1fcd150b4fce3af576ca96813cbf334 [28/83] ODROID-XU4: drivers/fbtft: Add fb_hktft32 module for Hardkernel 3.2 inch TFT LCD
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211201/202112010357.0blfYsRD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/da67b773b1fcd150b4fce3af576ca96813cbf334
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.15.y
        git checkout da67b773b1fcd150b4fce3af576ca96813cbf334
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/staging/fbtft/fb_hktft35.o', needed by 'drivers/staging/fbtft/fb_hktft35.mod'.
   make[4]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
