Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2B4748D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhLNRE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:04:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:41092 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236275AbhLNRES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639501458; x=1671037458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q12ALn7cBLnaYmmzNIs5wIxKBLaZLakPjYPHrOnzFAY=;
  b=Cf2KzK3BkrkS5ipi3UucfOdVz6QKZlyoiE6bm8St6rX4keH+lKQDRPPe
   SYHn3r7hmlVVy26OmDe/pRQ3kykGIIzj8WX5oe+JXyZKOv2idRj0orSzJ
   610siTq7IbKwD5Pc6onIaZC107xxm7RUVRtybh7VoSo4bOqoSUQ/iwQpS
   j79SlQMhLNhXdClE9xcIkPU0vln8Bryrjuig0YZBosEMc0mmnqN2X+23s
   1RDdyjZTuNITkXR1bruDPWIoahS8ZHzSEHea5PopaxvIlHFbK/qFPA8VB
   3z4OeljuQmPiwMmi8Dj9uVnIUdk1CojVqJdOJAle1iO+43jTJ7GutbRwM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225883790"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225883790"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="682132569"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2021 09:04:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxBDp-0000Xk-Ui; Tue, 14 Dec 2021 17:04:13 +0000
Date:   Wed, 15 Dec 2021 01:03:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Travkin <nikita@trvn.ru>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     kbuild-all@lists.01.org, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: Add clock based PWM output driver
Message-ID: <202112150018.zRKkwUhX-lkp@intel.com>
References: <20211213150335.51888-3-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213150335.51888-3-nikita@trvn.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on thierry-reding-pwm/for-next]
[also build test ERROR on v5.16-rc5 next-20211213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nikita-Travkin/Clock-based-PWM-output-driver/20211213-230628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: riscv-randconfig-c024-20211214 (https://download.01.org/0day-ci/archive/20211215/202112150018.zRKkwUhX-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/454624747f4637529777274ae1b5ab7af33fd130
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nikita-Travkin/Clock-based-PWM-output-driver/20211213-230628
        git checkout 454624747f4637529777274ae1b5ab7af33fd130
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv32-linux-ld: drivers/pwm/pwm-clk.o: in function `.L18':
>> pwm-clk.c:(.text+0x86): undefined reference to `__udivdi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
