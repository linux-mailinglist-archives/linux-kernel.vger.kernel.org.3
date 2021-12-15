Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C999E476630
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhLOWs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:48:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:9615 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhLOWsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639608504; x=1671144504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JWFyo0Ydmtk47WVj8Zg8P0VPEZG3TTPE4W1aW0wI3zs=;
  b=UEJ8agBqa1GypRimAqkhH5F8jWqII66jkJW9x1vjieEbuYq4JQcLf4nI
   713n8j0wHDNIZRf1D2M+7FDSUPh3VfIy6xdDeWtQa6OSewFbLrEuPr7xx
   Rasxk0c2T/x64RUJNID/wVAf3DOC3GY2xJnJ3rl5nklrbWH4k/vq5HvmQ
   zvGRg/YsbYrcbVr4+gCahcdVvZ58m+ytClTwm+WYhpF28GipJACtqBTWb
   1ZEd9HRM30KzoyeZx5q9U4u8952s1zRXCwdQN++nUuCldgxrSM7jre4Kz
   GSs46JdhcGSYGaYst/U8KZU4QIOd8vFZfexboG++KrpyrWpcbVzqV/ygb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="302726834"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="302726834"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 14:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="545750614"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Dec 2021 14:48:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxd4O-0002Qm-Me; Wed, 15 Dec 2021 22:48:20 +0000
Date:   Thu, 16 Dec 2021 06:47:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org, jbx6244@gmail.com,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 3/4] phy: rockchip: add naneng combo phy for RK3568
Message-ID: <202112160605.2BqI0hlK-lkp@intel.com>
References: <20211215095657.13183-4-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215095657.13183-4-yifeng.zhao@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on robh/for-next lee-mfd/for-mfd-next v5.16-rc5 next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yifeng-Zhao/Add-Naneng-combo-PHY-support-for-RK3568/20211215-180610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211216/202112160605.2BqI0hlK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5e4ddb08d86d5232174d88483f29e96272a4b6c0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yifeng-Zhao/Add-Naneng-combo-PHY-support-for-RK3568/20211215-180610
        git checkout 5e4ddb08d86d5232174d88483f29e96272a4b6c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c: In function 'rk3568_combphy_cfg':
>> drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:22:47: error: 'HZ_PER_MHZ' undeclared (first use in this function)
      22 | #define REF_CLOCK_24MHz                 (24 * HZ_PER_MHZ)
         |                                               ^~~~~~~~~~
   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:490:14: note: in expansion of macro 'REF_CLOCK_24MHz'
     490 |         case REF_CLOCK_24MHz:
         |              ^~~~~~~~~~~~~~~
   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:22:47: note: each undeclared identifier is reported only once for each function it appears in
      22 | #define REF_CLOCK_24MHz                 (24 * HZ_PER_MHZ)
         |                                               ^~~~~~~~~~
   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:490:14: note: in expansion of macro 'REF_CLOCK_24MHz'
     490 |         case REF_CLOCK_24MHz:
         |              ^~~~~~~~~~~~~~~


vim +/HZ_PER_MHZ +22 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

    20	
    21	#define BIT_WRITEABLE_SHIFT		16
  > 22	#define REF_CLOCK_24MHz			(24 * HZ_PER_MHZ)
    23	#define REF_CLOCK_25MHz			(25 * HZ_PER_MHZ)
    24	#define REF_CLOCK_100MHz		(100 * HZ_PER_MHZ)
    25	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
