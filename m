Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1751A496C52
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiAVMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:22:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:19345 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbiAVMWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642854158; x=1674390158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XO8SDzCxTpL7LBkxnN3tUzgoOLw+b1v67YzdB6jhpkI=;
  b=Wf5KlUTpq1EtiVBRdI+g46k0RB7KhL2pvcvFp9OwN5KlOBHynoKg10im
   hgiEZTAIKtfuNB9yzWALkPSf0etC5H5EuNwHWs1pSIzZnB3mdMCp6H3Xn
   HNwBtvtX2CidzoTMVsX6QUnKvrRZmOoZ2OGcPY2wT1CkWKRdjFDkPVzDX
   fIQibJNVGdyGiKrvUr2mOvjusESQmA165ZgBSrgiVnDz/1LkLx2An12d1
   dnCLnPZTfxH8sr8b/t+uiFMO2SfFnzWx6sWAzSBTunZV/c2sKTz6WdW/M
   IgeTsZ1IKJ+uL+Jvk86s+gNbVhE9FWPMGGybYDhcnSW1+MX3TzzJ4NbOx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="309143479"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="309143479"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 04:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="596371908"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2022 04:22:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBFPg-000GNP-21; Sat, 22 Jan 2022 12:22:36 +0000
Date:   Sat, 22 Jan 2022 20:22:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] firmware: psci: Export a couple of suspend symbols
Message-ID: <202201221911.EEIlXDWO-lkp@intel.com>
References: <20220122035421.4086618-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122035421.4086618-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

I love your patch! Yet something to improve:

[auto build test ERROR on arm/for-next]
[also build test ERROR on soc/for-next arm64/for-next/core clk/clk-next linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/Broadcom-STB-PM-PSCI-extensions/20220122-115551
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
config: arm64-randconfig-r011-20220120 (https://download.01.org/0day-ci/archive/20220122/202201221911.EEIlXDWO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/488fbdb7de4d39409045b679db3e370600a774d4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Florian-Fainelli/Broadcom-STB-PM-PSCI-extensions/20220122-115551
        git checkout 488fbdb7de4d39409045b679db3e370600a774d4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: cpu_suspend
   >>> referenced by psci.c
   >>> firmware/psci/psci.o:(psci_system_suspend_enter) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: cpu_resume
   >>> referenced by psci.c
   >>> firmware/psci/psci.o:(psci_system_suspend) in archive drivers/built-in.a
   >>> referenced by psci.c
   >>> firmware/psci/psci.o:(psci_system_suspend) in archive drivers/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
