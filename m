Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9646AD02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358338AbhLFWu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:50:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:29746 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353633AbhLFWuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:50:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="236163289"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="236163289"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="563013969"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2021 14:47:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muMlV-000LpJ-6p; Mon, 06 Dec 2021 22:47:21 +0000
Date:   Tue, 7 Dec 2021 06:46:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: rockchip_i2s_tdm.c:undefined reference to `clk_set_parent'
Message-ID: <202112070621.TnLPiADU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f80ef9e49fdfbfbc4197711230098b90e6b05a7e
commit: 081068fd641403994f0505e6b91e021d3925f348 ASoC: rockchip: add support for i2s-tdm controller
date:   9 weeks ago
config: mips-randconfig-r031-20211206 (https://download.01.org/0day-ci/archive/20211207/202112070621.TnLPiADU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=081068fd641403994f0505e6b91e021d3925f348
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 081068fd641403994f0505e6b91e021d3925f348
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips-linux-ld: sound/soc/jz4740/jz4740-i2s.o: in function `jz4740_i2s_set_sysclk':
   jz4740-i2s.c:(.text+0x3ec): undefined reference to `clk_set_parent'
   mips-linux-ld: jz4740-i2s.c:(.text+0x44c): undefined reference to `clk_set_parent'
   mips-linux-ld: sound/soc/rockchip/rockchip_i2s_tdm.o: in function `rockchip_i2s_tdm_calibrate_mclk.isra.0':
>> rockchip_i2s_tdm.c:(.text+0x10d4): undefined reference to `clk_set_parent'
>> mips-linux-ld: rockchip_i2s_tdm.c:(.text+0x1180): undefined reference to `clk_set_parent'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
