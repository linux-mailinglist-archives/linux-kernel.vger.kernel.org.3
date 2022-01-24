Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4594980E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbiAXNSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:18:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:15028 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243090AbiAXNSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643030323; x=1674566323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FGPICUAdjAgk3jQL3q6fAeYsf5yGyOmW5ZIi5TU/TQY=;
  b=PbiVPLgiVAZnj9w3SThDPVucpZ4ra0jDK/qeEf390/i/7k+kUdhWh19u
   iqs5rLRO676P2rtQ2bsZNdv/I+5ocUZNlWWbEbTaH7GkhOIKm9/bgAj36
   Ydzto56c8k+tEhLC2qVru7isacA3LXfuHevx8BED4Oa/hVNrnlauP+udi
   1331KgrHim/qeB48FB33Dd9o3agB5wD/DC3ZgWd4eddqAjvJr/8mgkJlw
   uoqCLminERKqwu+w2DyX6DYLN+TjFOAcgfY4PafGG/XB1MFfph66dvZx2
   3KfWBM/GszFNwX3ffMJNjd939aIhyV2faQ3EkbzcXoihpDgWVC4kV7MYu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306756542"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306756542"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596785596"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 05:18:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBzF3-000IMw-2e; Mon, 24 Jan 2022 13:18:41 +0000
Date:   Mon, 24 Jan 2022 21:18:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chenjieqin <Jessica.Chen@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 36/63] microblaze-linux-ld: undefined reference to
 `__udivdi3'
Message-ID: <202201242153.mzML1Ixz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   fdbe623707a8f3f9b9d2cb3c4c240299a12b8302
commit: d8f87b24049876b29ade8ed4e49f975d32eeec79 [36/63] drivers/pwm: Add SiFive PWM PTC driver
config: microblaze-randconfig-r015-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242153.mzML1Ixz-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/d8f87b24049876b29ade8ed4e49f975d32eeec79
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout d8f87b24049876b29ade8ed4e49f975d32eeec79
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/pwm/pwm-sifive-ptc.o: in function `sifive_pwm_ptc_apply':
   (.text+0x68): undefined reference to `__udivdi3'
>> microblaze-linux-ld: (.text+0x8c): undefined reference to `__udivdi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
