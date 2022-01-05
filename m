Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBB484E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiAEG3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:29:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:19805 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbiAEG3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641364171; x=1672900171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7en2HeB+Gm/Ko2tzwOTxWZX8wWZH8igixzBPuRqBy7I=;
  b=HPiKNBvERYDI3XiZDj6Ou6uhHXiNhxOOZkjsUVoWTdE7mqsnU14sLYcg
   EQtYScUAcZ2CEmcvuW7Ign+TA2K8amPhiamernE2RhmRxIBRKTsNk4Jpj
   pMhNVLJexP3ZElw/zPUqWgJlp933eEnhsiQF322txG+9OV6Z6InbRwLnp
   dvr8No/EXgr7GESEB+ve2Yzqn+3NVPOmG6ErMi8GZvxGw+hmyYV3tCw6+
   d4YlPdICP7ImPIlxwbyQ70+6qwnlzwJqZtr0FADnTJiK0WXjwg1Wgw1gw
   7V+MIyLVWdTw+NR2OrN5hs8Nz95vMnaz+PVtIUz911PhCusGAXz15V77e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266653577"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="266653577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 22:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="620934918"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2022 22:29:28 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4znb-000GKR-AY; Wed, 05 Jan 2022 06:29:27 +0000
Date:   Wed, 5 Jan 2022 14:29:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regulator: Add MAX20086-MAX20089 driver
Message-ID: <202201051456.soqOHo2E-lkp@intel.com>
References: <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on linux/master linus/master v5.16-rc8 next-20220104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Laurent-Pinchart/regulator-Add-driver-for-Maxim-MAX20086-MAX20089/20220103-051219
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: x86_64-randconfig-r014-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051456.soqOHo2E-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b6d12d70aa18c4aea48971443a7467c78e719147
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Laurent-Pinchart/regulator-Add-driver-for-Maxim-MAX20086-MAX20089/20220103-051219
        git checkout b6d12d70aa18c4aea48971443a7467c78e719147
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/regulator/max20086-regulator.c:99:2: error: initializer element is not a compile-time constant
           MAX20086_REGULATOR_DESC(0),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/max20086-regulator.c:79:10: note: expanded from macro 'MAX20086_REGULATOR_DESC'
           .name = max20086_output_names[n],       \
                   ^~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +99 drivers/regulator/max20086-regulator.c

    97	
    98	static const struct regulator_desc max20086_regulators[] = {
  > 99		MAX20086_REGULATOR_DESC(0),
   100		MAX20086_REGULATOR_DESC(1),
   101		MAX20086_REGULATOR_DESC(2),
   102		MAX20086_REGULATOR_DESC(3),
   103	};
   104	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
