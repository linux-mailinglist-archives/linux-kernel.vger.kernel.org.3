Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61448E36B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 05:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiANEv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 23:51:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:7728 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbiANEv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642135887; x=1673671887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ftiXt+A5FqoSllsgjd1y+CGKiwwHEZfFWIE2pVDmd+w=;
  b=Ubi2kVPr5oCcroQz3cnd45vfiPxhGAL/buMGn9J+IbrEiV1Ud9qIh1m2
   RFHFKIj/QWNlJU+VKLbpdXizAFkCoMaHZ0THnk04NdkruBSrW2LikYyHd
   iykcxVKGEK135o6Qlv8zqb1GjisVC8HhvdnNET4ttvYjyeEZy10uy/O4V
   T7Lc43uQtfWrUzorqvix0gTjSzZp/dODGTCyJso75eKfKnRkR8v1xEkcp
   UimnBx+cE5ECChJ8EoNOIAUyFAdcClIAY4HLYhmEBFsEyuT2gpEafUg/Y
   597FZ4Jwk8D835fd1/PYrv4vEjs4wVDh2ukgg9HvcqpR1W/w5L5lUqFrK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307526524"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="307526524"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 20:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="765768402"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2022 20:51:24 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8EYd-000876-PK; Fri, 14 Jan 2022 04:51:23 +0000
Date:   Fri, 14 Jan 2022 12:50:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k@lists.linux-m68k.org,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 3/4] clocksource/drivers: Add a goldfish-timer
 clocksource
Message-ID: <202201141238.HZZyqTBE-lkp@intel.com>
References: <20220113201920.3201760-4-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113201920.3201760-4-laurent@vivier.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on geert-m68k/for-next]
[also build test WARNING on linux/master v5.16]
[cannot apply to tip/timers/core linus/master next-20220113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20220114-042103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220114/202201141238.HZZyqTBE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7e887e6ec0d7193083a2f0020007688db2318c76
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20220114-042103
        git checkout 7e887e6ec0d7193083a2f0020007688db2318c76
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-goldfish.c: In function 'goldfish_timer_init':
   drivers/clocksource/timer-goldfish.c:94:20: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
      94 |         timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);
         |                    ^~~~~~~
         |                    vzalloc
>> drivers/clocksource/timer-goldfish.c:94:18: warning: assignment to 'struct goldfish_timer *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      94 |         timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);
         |                  ^
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for RTC_CLASS
   Depends on !S390
   Selected by
   - GOLDFISH_TIMER && GENERIC_CLOCKEVENTS
   WARNING: unmet direct dependencies detected for RTC_DRV_GOLDFISH
   Depends on RTC_CLASS && HAS_IOMEM
   Selected by
   - GOLDFISH_TIMER && GENERIC_CLOCKEVENTS


vim +94 drivers/clocksource/timer-goldfish.c

    88	
    89	void __init goldfish_timer_init(int irq, void __iomem *base)
    90	{
    91		struct goldfish_timer *timerdrv;
    92		int ret;
    93	
  > 94		timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
