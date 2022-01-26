Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0459D49D475
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiAZV0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:26:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:21460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbiAZV0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643232382; x=1674768382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yh/tZymlE+Mu2oTh2CfURRIWv+Fup7UwHpHXOXfeH9Q=;
  b=mMur0l6QOxLqYDfpjhvDuI458F3luN0iao6HG/rMFLjgicdaxIBbN3Yz
   UObE3Grurim7pNWpvuceDnWETc7bJv5kVF6dmjwyboXpKiL2OHXzKqfPd
   MVNFL2wFHorA+b+12ZCs09IlvRWMhJQpQRP8HJaO5aYOnfSganBYwz08h
   c66DVVsmRTcYvraDmYboT8IiZZY+yVuGqOSRynO/FKwPXTeDEKyj4d3nd
   xpsKztBVqDnSxNM2iSv2mw6QOnxzIgMrkEG1iWic6kJ0pQjw0EFg4ip8L
   mQJ3VSMXAlWCkILMEynJxC/xrCJKytfbvEzIjKGsRx9CKy1TUS3RnmcPm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246433000"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246433000"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 13:26:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="563540899"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2022 13:26:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCpo1-000Lg3-Cc; Wed, 26 Jan 2022 21:26:17 +0000
Date:   Thu, 27 Jan 2022 05:25:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, john.stultz@linaro.org,
        tglx@linutronix.de
Cc:     kbuild-all@lists.01.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        boon.leong.ong@intel.com, mhiramat@kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] include: linux: Reorganize timekeeping and ktime headers
Message-ID: <202201270546.CQtmCsGw-lkp@intel.com>
References: <20220126200749.12090-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126200749.12090-1-carlos.bilbao@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on geert-m68k/for-next]
[also build test WARNING on tip/timers/core tip/x86/core linus/master v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20220127-041038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201270546.CQtmCsGw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3c432f5cbb3c550c1cef6747c4281b65a7d9d708
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20220127-041038
        git checkout 3c432f5cbb3c550c1cef6747c4281b65a7d9d708
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/m68k/kernel/time.c:67:6: warning: no previous prototype for 'read_persistent_clock64' [-Wmissing-prototypes]
      67 | void read_persistent_clock64(struct timespec64 *ts)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/kernel/time.c:145:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
     145 | void __init time_init(void)
         |             ^~~~~~~~~


vim +/read_persistent_clock64 +67 arch/m68k/kernel/time.c

fa7f9e7fade8457 Greg Ungerer  2012-01-23  64  
065f109f2506d6b Arnd Bergmann 2018-04-23  65  #ifdef CONFIG_M68KCLASSIC
065f109f2506d6b Arnd Bergmann 2018-04-23  66  #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
065f109f2506d6b Arnd Bergmann 2018-04-23 @67  void read_persistent_clock64(struct timespec64 *ts)
fa7f9e7fade8457 Greg Ungerer  2012-01-23  68  {
fa7f9e7fade8457 Greg Ungerer  2012-01-23  69  	struct rtc_time time;
b65769fc013edb7 Finn Thain    2018-04-23  70  
fa7f9e7fade8457 Greg Ungerer  2012-01-23  71  	ts->tv_sec = 0;
fa7f9e7fade8457 Greg Ungerer  2012-01-23  72  	ts->tv_nsec = 0;
fa7f9e7fade8457 Greg Ungerer  2012-01-23  73  
b65769fc013edb7 Finn Thain    2018-04-23  74  	if (!mach_hwclk)
b65769fc013edb7 Finn Thain    2018-04-23  75  		return;
b65769fc013edb7 Finn Thain    2018-04-23  76  
fa7f9e7fade8457 Greg Ungerer  2012-01-23  77  	mach_hwclk(0, &time);
fa7f9e7fade8457 Greg Ungerer  2012-01-23  78  
065f109f2506d6b Arnd Bergmann 2018-04-23  79  	ts->tv_sec = mktime64(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
fa7f9e7fade8457 Greg Ungerer  2012-01-23  80  			      time.tm_hour, time.tm_min, time.tm_sec);
fa7f9e7fade8457 Greg Ungerer  2012-01-23  81  }
065f109f2506d6b Arnd Bergmann 2018-04-23  82  #endif
fa7f9e7fade8457 Greg Ungerer  2012-01-23  83  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
