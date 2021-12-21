Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBB547B6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhLUBCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:02:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:59454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhLUBCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640048561; x=1671584561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NLUzOH6tUpTQcEC5NCc1CX4TrkqfT1bnpm8U/JWESV0=;
  b=jcoEronuKGDEx1ueM2bb+eEqAKptpbLxihsHRRer2IHgRHsYVPJI+eZ/
   06jsmRMXB+z/ihVwqTAK7jkY8SFvlodGiGj1iWV0x06xcwYPMnof9hpy3
   fsmg2FJrVi20fspjl3ycwDnKQF+hB6axX4xQX93/Sz9A9ecfRJaIqOzDT
   C7uk65AOgEMaul3q8C/6gpWLEOPUDuXHI2/PrxTsTuJlNbCDc9CiYiPxb
   9tIAUoeclT+jvWlX1W8THHGNlHdDHUA6b1TNBVvCviJy8+O+AJNqD4oDu
   ke5Tg+ZjfEVEue6QlcqA+GKrTCI0EvvW3o9/i61LQ4bjNuqGTcjBvWv56
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="239043710"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="239043710"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 17:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="466127803"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2021 17:02:36 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzTY3-0008TZ-Vf; Tue, 21 Dec 2021 01:02:35 +0000
Date:   Tue, 21 Dec 2021 09:02:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Taniya Das <tdas@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>
Cc:     kbuild-all@lists.01.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 5/5] clk: qcom: lpass: Add support for LPASS clock
 controller for SC7280
Message-ID: <202112210805.wI87zJw0-lkp@intel.com>
References: <1640018638-19436-6-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640018638-19436-6-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next linus/master v5.16-rc6 next-20211220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Taniya-Das/Add-support-for-LPASS-Core-and-Audio-Clock-for-SC7280/20211221-004818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20211221/202112210805.wI87zJw0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fec640fab5ec498e79475ecd4b15bc95035a76b1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Taniya-Das/Add-support-for-LPASS-Core-and-Audio-Clock-for-SC7280/20211221-004818
        git checkout fec640fab5ec498e79475ecd4b15bc95035a76b1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/qcom/lpassaudiocc-sc7280.c:39:9: warning: this decimal constant is unsigned only in ISO C90
      39 |         { 595200000, 3600000000, 0 },
         |         ^
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/of.h:14,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/qcom/lpassaudiocc-sc7280.c:6:
   drivers/clk/qcom/lpassaudiocc-sc7280.c: In function 'lpass_audio_cc_sc7280_probe':
   include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/pm_clock.h:82:25: note: in expansion of macro 'NULL'
      82 | #define pm_clk_suspend  NULL
         |                         ^~~~
   drivers/clk/qcom/lpassaudiocc-sc7280.c:740:9: note: in expansion of macro 'pm_clk_suspend'
     740 |         pm_clk_suspend(&pdev->dev);
         |         ^~~~~~~~~~~~~~
   drivers/clk/qcom/lpassaudiocc-sc7280.c: In function 'lpass_aon_cc_sc7280_probe':
   include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/pm_clock.h:82:25: note: in expansion of macro 'NULL'
      82 | #define pm_clk_suspend  NULL
         |                         ^~~~
   drivers/clk/qcom/lpassaudiocc-sc7280.c:798:9: note: in expansion of macro 'pm_clk_suspend'
     798 |         pm_clk_suspend(&pdev->dev);
         |         ^~~~~~~~~~~~~~


vim +39 drivers/clk/qcom/lpassaudiocc-sc7280.c

    37	
    38	static const struct pll_vco zonda_vco[] = {
  > 39		{ 595200000, 3600000000, 0 },
    40	};
    41	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
