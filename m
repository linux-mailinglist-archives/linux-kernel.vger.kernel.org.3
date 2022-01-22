Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E3496A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiAVHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:10:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:47911 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbiAVHKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642835430; x=1674371430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f7faM8+Ihwp2zYBbHZ9/W4SYTYEw7bFEIZKV5anVTyc=;
  b=ZlQ5sWVgShoGrp6HBmMEnCW2fdRiRIje/9vwfTEBo8flYn7rBk/Vxb/X
   eZqz2Zm4qTYpSs/wHEqKSfj137MwpzWPbhADgFu37Ii910eHCiJUWOdVN
   F01srSgZsW8C964FxS65oY67o/F3kay5ioTV6/rtB1bT1Vj2osuZV0sZw
   UcS2T+SL5pZU5oL2y1FrfCvdTUb50HQPPKkz4xHYYnCSkeiFXKQp698C/
   +xy78H3bt7KV8XJMio4AdMVEUA4ftABkSohoOI1kPs1x6J4OeAj1UsRcm
   0kpY9FA6zHDJ0qJDRSJ2F9mEygAen0vKqBNLea7eehGHaThzl+3saw36M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="246016780"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="246016780"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 23:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="579831490"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2022 23:10:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBAXY-000G9B-43; Sat, 22 Jan 2022 07:10:24 +0000
Date:   Sat, 22 Jan 2022 15:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] soc: bcm: brcmstb: Added support for PSCI system
 suspend operations
Message-ID: <202201221439.RaZlgS8d-lkp@intel.com>
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
config: arm-multi_v7_defconfig (https://download.01.org/0day-ci/archive/20220122/202201221439.RaZlgS8d-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/30bf64821ad5d3cbbc91770b3927905d10d3bdf3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Florian-Fainelli/Broadcom-STB-PM-PSCI-extensions/20220122-115551
        git checkout 30bf64821ad5d3cbbc91770b3927905d10d3bdf3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/bcm/brcmstb/pm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/bcm/brcmstb/pm/pm-psci.c:95:6: warning: no previous prototype for 'brcmstb_psci_sys_poweroff' [-Wmissing-prototypes]
      95 | void brcmstb_psci_sys_poweroff(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


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
