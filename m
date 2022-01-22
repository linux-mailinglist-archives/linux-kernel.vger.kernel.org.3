Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08562496A63
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 07:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiAVGJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 01:09:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:58926 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233130AbiAVGJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 01:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642831763; x=1674367763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6urHQV109JrsxIHRd0xz2vSMZ5CUJSiuumgsKimJBSo=;
  b=NShGoZVGtO5meV3j/jG9EvuYKvX4lFjyFmuiKNlVBzutIU9P7R3Nfezs
   xoD64J5bHIgTuyowJxf4ZuTdGxoOMexuY5N9yw4TQ8fItsQvmKb5NefsT
   +KVW17HgeRr3hWOgXUX7rXsUAzKTN3ZMbwbXbWWP2oQ+njK6JkCKYVqiK
   RkX0J1pV4YABfzttImIfU+Qo1qoVwBgGC368mizC9x7L4TTqtH5L0Husq
   Vafyk0cjwS7qEV193n1vocFMMly3D3fTPHv2j5sKtlBMMd/DmmTtvDkln
   TS+2/KVBCUlBRAkfMAiln3+qP43ge2tFqh6n6WgigNeuA8482XsOoEHHP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="243390691"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="243390691"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 22:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="694869233"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 22:09:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB9aS-000G6O-En; Sat, 22 Jan 2022 06:09:20 +0000
Date:   Sat, 22 Jan 2022 14:09:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] soc: bcm: brcmstb: Added support for PSCI system
 suspend operations
Message-ID: <202201221442.7bCTuqul-lkp@intel.com>
References: <20220122035421.4086618-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122035421.4086618-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on arm/for-next]
[also build test WARNING on soc/for-next arm64/for-next/core clk/clk-next linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/Broadcom-STB-PM-PSCI-extensions/20220122-115551
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
config: arm64-randconfig-r011-20220120 (https://download.01.org/0day-ci/archive/20220122/202201221442.7bCTuqul-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/30bf64821ad5d3cbbc91770b3927905d10d3bdf3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Florian-Fainelli/Broadcom-STB-PM-PSCI-extensions/20220122-115551
        git checkout 30bf64821ad5d3cbbc91770b3927905d10d3bdf3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/bcm/brcmstb/pm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/bcm/brcmstb/pm/pm-psci.c:95:6: warning: no previous prototype for function 'brcmstb_psci_sys_poweroff' [-Wmissing-prototypes]
   void brcmstb_psci_sys_poweroff(void)
        ^
   drivers/soc/bcm/brcmstb/pm/pm-psci.c:95:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void brcmstb_psci_sys_poweroff(void)
   ^
   static 
   1 warning generated.


vim +/brcmstb_psci_sys_poweroff +95 drivers/soc/bcm/brcmstb/pm/pm-psci.c

    94	
  > 95	void brcmstb_psci_sys_poweroff(void)
    96	{
    97		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
    98	}
    99	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
