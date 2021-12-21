Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB70447C5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhLUSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:03:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:3719 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232088AbhLUSD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640109836; x=1671645836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oi41HYlIbq01fjKNWy/Z7i7pvCOJnN47rmSuUs724Ps=;
  b=E9aCmc05yMGIZ1x/WTdAU/NMU+ggBFll+3FeR7r/V+PX6A2VZx5f3Hd4
   z52wXQBK36np5zQ6+dZ3I2C7J/k6SnAGR66OLSmlLVzTAD0NneNvG56MS
   4Q9Rn6VcR9BNVt6kN4+kqISfcqcPQcTAZzgcfOIzalcmbgmIb3ca3qosS
   J/gKefsRrIevcUGCvbE+5bamHpnd/tqXa0Y6vWH07RODddUE3X7SV13HJ
   rkxPelWv2vduVTEvuKglwvZ+IAkqrkYbUZ6Hh2fwJtZD1XcopQvtQTWmU
   JN70aegZjCME5zrlAYQkq+50wERF+v7KN2q+bBBn6++HAitujjT9ixEXq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="264647664"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="264647664"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 09:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="508158184"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2021 09:36:02 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzj3R-0009Fw-AZ; Tue, 21 Dec 2021 17:36:01 +0000
Date:   Wed, 22 Dec 2021 01:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>
Subject: [asahilinux:asahi-with-new-nvme 9/34]
 drivers/clk/clk-apple-nco.c:95:16: error: implicit declaration of function
 'FIELD_PREP'
Message-ID: <202112220119.mQPJa9jt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi-with-new-nvme
head:   675e4ce8d8355827d6ee1f2fadff9fd9598348c7
commit: 4c12a1771a86a4e324e793617cc40c498c054fb6 [9/34] clk: clk-apple-nco: Add driver for Apple NCO
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112220119.mQPJa9jt-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/4c12a1771a86a4e324e793617cc40c498c054fb6
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi-with-new-nvme
        git checkout 4c12a1771a86a4e324e793617cc40c498c054fb6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk-apple-nco.c: In function 'nco_div_translate':
>> drivers/clk/clk-apple-nco.c:95:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      95 |         return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
         |                ^~~~~~~~~~
   drivers/clk/clk-apple-nco.c: In function 'nco_div_translate_inv':
>> drivers/clk/clk-apple-nco.c:103:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     103 |         coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
         |                           ^~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_AMD_ACP_CONFIG
   Depends on SOUND && !UML && SND && SND_SOC && SND_SOC_ACPI
   Selected by
   - SND_SOC_SOF_AMD_COMMON && SOUND && !UML && SND && SND_SOC && SND_SOC_SOF_TOPLEVEL && SND_SOC_SOF_AMD_TOPLEVEL


vim +/FIELD_PREP +95 drivers/clk/clk-apple-nco.c

    87	
    88	static u32 nco_div_translate(struct nco_tables *tbl, int div)
    89	{
    90		int coarse = div / 4;
    91	
    92		if (WARN_ON(!nco_div_check(div)))
    93			return 0;
    94	
  > 95		return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
    96				FIELD_PREP(DIV_FINE, div % 4);
    97	}
    98	
    99	static int nco_div_translate_inv(struct nco_tables *tbl, int regval)
   100	{
   101		int coarse, fine;
   102	
 > 103		coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
   104		fine = FIELD_GET(DIV_FINE, regval);
   105	
   106		return coarse * 4 + fine;
   107	}
   108	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
