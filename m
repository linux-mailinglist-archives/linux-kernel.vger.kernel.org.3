Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239834897BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbiAJLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:43:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:47836 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244977AbiAJLlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641814905; x=1673350905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FmoJ3y7OcdqB18NHcTkTeuKKIfdDfKWzmCti7xacieg=;
  b=J5YOlX5FoBGlk2f4q6FOhwHstLln+woYgH+hSjE1HgpEl2zfjRZW2oSr
   gfwMgQNvCdZDsS2XvZMNBzbEBsU84GePZb2QZR+ej2sjlu/lGOQamGy+R
   NtUcC5SStWdRbaI/BKu5iI+CM2jGRm3O+PTY5X+Y/kj01bFlOYArbcuBL
   OvrTZGoqT7el2Jvy4OoDIYZZruN41qkLHYRTbOuDxj+pGqLuBtNrJEw1d
   xVBFTp3cvrnRzw8KxsywXkGnn3fF8+LqlnWSv0t6JUJyibWL63dq28/ed
   wNxF5PAWBcMtab1Y0HNN9WWOJ4fZncPUsp/N+KuMlBVOLvmBHRrBYUsN/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="306563048"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="306563048"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 03:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="690549113"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2022 03:41:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6t3T-00038Q-LQ; Mon, 10 Jan 2022 11:41:39 +0000
Date:   Mon, 10 Jan 2022 19:40:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li-hao Kuo <lhjeff911@gmail.com>, p.zabel@pengutronix.de,
        broonie@kernel.org, andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: Re: [PATCH v5 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <202201101911.hSqY5DkA-lkp@intel.com>
References: <761604f7aa4d4df16637103ba10d34674faf3d9b.1641797029.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761604f7aa4d4df16637103ba10d34674faf3d9b.1641797029.git.lhjeff911@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li-hao,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on pza/reset/next robh/for-next linus/master v5.16]
[cannot apply to next-20220110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Li-hao-Kuo/Add-SPI-control-driver-for-Sunplus-SP7021-SoC/20220110-144745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220110/202201101911.hSqY5DkA-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/53da1eda2d6e7a04e09dcb37a029ec3b384b7afb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Li-hao-Kuo/Add-SPI-control-driver-for-Sunplus-SP7021-SoC/20220110-144745
        git checkout 53da1eda2d6e7a04e09dcb37a029ec3b384b7afb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'drivers/spi/spi-sunplus-sp7021.o', needed by 'drivers/spi/built-in.a'.
   make[3]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
