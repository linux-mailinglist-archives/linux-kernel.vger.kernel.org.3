Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369974A2FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbiA2OKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:10:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:31763 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234194AbiA2OKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643465416; x=1675001416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFcCHcnZzHGge7LC66GRjpuVC7vd/ne1/nu/vMIi1JY=;
  b=As8+9ej2p0Djm06Md9YqE+JE8Sbm7/usq3lcaKeSGgZhBH8uBjoxLmdF
   8jPJQt0Vcu890r5cXNmHP/+lKmjPOH4As0+rtNQRCt/fQ0teYLUHsDU7T
   30asKFjVYSEg5NKFsv4orz32N01cLRprP375dUDTGqs0E4/5OCM0H/K5r
   9AoWR7d+c1mFsRO1vRkoO0NbJre2cliOkFxdNEeGWUQ2WDLTPVOH+rmAC
   aP79ySq4D3c+a9BhqHuqMpDrqnPVeTBiJKn3AwMfz9JNjMewX2yVtGa8n
   FGhJo8VZiZjFUwT0EU+cmx3kievQgo3C1JnIlAYQynaGLGfj3imjCxMZ6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246111818"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="246111818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 06:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="675344441"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2022 06:10:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDoQe-000PHv-Tv; Sat, 29 Jan 2022 14:10:12 +0000
Date:   Sat, 29 Jan 2022 22:09:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>
Subject: Re: [PATCH v5 5/9] pinctrl: nuvoton: Add driver for WPCM450
Message-ID: <202201292234.NpSNe4TD-lkp@intel.com>
References: <20220129115228.2257310-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129115228.2257310-6-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Jonathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on robh/for-next linus/master v5.17-rc1 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20220129-195955
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220129/202201292234.NpSNe4TD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/3fd91ea1bad905592e89c8f987f6bd3740329b80
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20220129-195955
        git checkout 3fd91ea1bad905592e89c8f987f6bd3740329b80
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash drivers/pinctrl/nuvoton/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:908: warning: "DS" redefined
     908 | #define DS(lo, hi) (((lo) << DRIVE_STRENGTH_LO_SHIFT) | \
         | 
   In file included from arch/x86/um/shared/sysdep/ptrace.h:44,
                    from arch/um/include/asm/ptrace-generic.h:11,
                    from arch/x86/um/asm/ptrace.h:9,
                    from arch/um/include/asm/processor-generic.h:13,
                    from arch/x86/um/asm/processor.h:41,
                    from include/linux/rcupdate.h:30,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:5:
   arch/x86/um/shared/sysdep/ptrace_64.h:38: note: this is the location of the previous definition
      38 | #define DS (HOST_DS * sizeof(long))
         | 
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:5:
   drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c: In function 'npcm7xx_get_groups_count':
   drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:1564:21: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
    1564 |  dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: in definition of macro '__dynamic_func_call'
     134 |   func(&id, ##__VA_ARGS__);  \
         |               ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:2: note: in expansion of macro '_dynamic_func_call'
     166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:2: note: in expansion of macro 'dynamic_dev_dbg'
     155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:23: note: in expansion of macro 'dev_fmt'
     155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                       ^~~~~~~
   drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:1564:2: note: in expansion of macro 'dev_dbg'
    1564 |  dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
         |  ^~~~~~~
   drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:1564:35: note: format string is defined here
    1564 |  dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
         |                                  ~^
         |                                   |
         |                                   int
         |                                  %ld


vim +/DS +908 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c

3b588e43ee5c7ad Tomer Maimon 2018-08-08  907  
3b588e43ee5c7ad Tomer Maimon 2018-08-08 @908  #define DS(lo, hi)	(((lo) << DRIVE_STRENGTH_LO_SHIFT) | \
3b588e43ee5c7ad Tomer Maimon 2018-08-08  909  			 ((hi) << DRIVE_STRENGTH_HI_SHIFT))
3b588e43ee5c7ad Tomer Maimon 2018-08-08  910  #define DSLO(x)		(((x) >> DRIVE_STRENGTH_LO_SHIFT) & 0xF)
3b588e43ee5c7ad Tomer Maimon 2018-08-08  911  #define DSHI(x)		(((x) >> DRIVE_STRENGTH_HI_SHIFT) & 0xF)
3b588e43ee5c7ad Tomer Maimon 2018-08-08  912  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
