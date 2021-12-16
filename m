Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2B477838
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbhLPQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:19:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:44039 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233605AbhLPQTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639671553; x=1671207553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yuSLAgSHSRUNCw+AaQPs1VJEcJTHafCvnTkp5Ft8Sto=;
  b=BjHP/S8k6ZplOc3EUBU4A5T0NdExu0j1QNTax//w+8BsBffnn2/pl7sS
   bla7dVBGnx8iiWFO4i0Xrhxx1hQWV7PwjDeVGoT8k5avrElTa45BFmxW3
   0MnPNvSRSk3CUjnLDilg2YhoJqKz6jCD/b4wCzTqugb3EUumj27XmR9PK
   ct6rplnaRZ7fNMsHcNuslAlU8WwXrUwp6X15Ffj58SiNuDqj4MUwVfp29
   12BE0D9kB9NToyEYvP5+XG5zqJMcrwMxv5bfKLYhqBEShYzStio0HOwc8
   fE7ujBBVHW0m+G8IgBZkJM/fFFAQe8bhUj21fb0/+lmIchEAU+oWKs5Zt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238272483"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="238272483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 08:19:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="466125790"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 08:19:11 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxtTK-0003SC-FQ; Thu, 16 Dec 2021 16:19:10 +0000
Date:   Fri, 17 Dec 2021 00:18:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.16-rc3 15/25] ERROR: modpost:
 "vfio_platform_ops" [drivers/vfio/platform/vfio-platform.ko] undefined!
Message-ID: <202112170050.8LrWj0Aj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.16-rc3
head:   21c1bb93447d6cced2f486cdb68b92d11f2e664d
commit: efdbba2a0f53aec4a2774306cead86075b7351b4 [15/25] vifo_platform: Use vfio_alloc/put_device()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20211217/202112170050.8LrWj0Aj-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/efdbba2a0f53aec4a2774306cead86075b7351b4
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.16-rc3
        git checkout efdbba2a0f53aec4a2774306cead86075b7351b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vfio_platform_ops" [drivers/vfio/platform/vfio-platform.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
