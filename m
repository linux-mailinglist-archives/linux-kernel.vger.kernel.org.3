Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF849D5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiAZWs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:48:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:50336 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbiAZWs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643237307; x=1674773307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UGllFUd3Rc9OCUZtzzbY3S9kUs08qaKuyK4fPoadjD4=;
  b=JiVZ0WhsVP6CjtsTDBGRDjLMk9cE7KWDEAuPk374oFacnXzofO7i1xgl
   ftaEG9dQdZP2phIBF8+DuVoOoyuWDHARRlNrptXz8UZcHjS3dlJ69z5V2
   kwm3Dh+018eAbba99DvZ1nvdOd7KIVMsTq42rtXTNzkvpK6EzCSDPpRr8
   Q/ZtMQG6VqBoNVjxlc7pp/1FflKC40jFXnaqt0NiS8fI6xqzM7wXrOR6k
   8RqIIxIqPfbYH7PvZ+TnxmCcQRvN/CdyhqOb91DFT/dhAbinMPW/wSROc
   NtlDUxndLsMQAwx6HON9eSCdBgWYujmqJ962vxJlrXpnlwmPycIINCEfU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246619504"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246619504"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 14:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="767280511"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jan 2022 14:48:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCr5S-000Ljo-Lj; Wed, 26 Jan 2022 22:48:22 +0000
Date:   Thu, 27 Jan 2022 06:47:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, john.stultz@linaro.org,
        tglx@linutronix.de
Cc:     kbuild-all@lists.01.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        boon.leong.ong@intel.com, mhiramat@kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] include: linux: Reorganize timekeeping and ktime headers
Message-ID: <202201270622.w96GBqWO-lkp@intel.com>
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220127/202201270622.w96GBqWO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/3c432f5cbb3c550c1cef6747c4281b65a7d9d708
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20220127-041038
        git checkout 3c432f5cbb3c550c1cef6747c4281b65a7d9d708
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/um/kernel/time.c:763:6: warning: no previous prototype for 'read_persistent_clock64' [-Wmissing-prototypes]
     763 | void read_persistent_clock64(struct timespec64 *ts)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   arch/um/kernel/time.c:778:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
     778 | void __init time_init(void)
         |             ^~~~~~~~~


vim +/read_persistent_clock64 +763 arch/um/kernel/time.c

aceb343464a136e arch/um/kernel/time_kern.c Jeff Dike       2006-07-10  762  
288fb3d5683f508 arch/um/kernel/time.c      Arnd Bergmann   2017-11-02 @763  void read_persistent_clock64(struct timespec64 *ts)
9f31f5774961a73 arch/um/kernel/time.c      John Stultz     2010-07-13  764  {
065038706f77a56 arch/um/kernel/time.c      Johannes Berg   2019-05-27  765  	long long nsecs;
065038706f77a56 arch/um/kernel/time.c      Johannes Berg   2019-05-27  766  
7f3414226b58b0d arch/um/kernel/time.c      Johannes Berg   2021-01-15  767  	time_travel_set_start();
7f3414226b58b0d arch/um/kernel/time.c      Johannes Berg   2021-01-15  768  
2701c1bd91dda81 arch/um/kernel/time.c      Johannes Berg   2020-12-02  769  	if (time_travel_mode != TT_MODE_OFF)
065038706f77a56 arch/um/kernel/time.c      Johannes Berg   2019-05-27  770  		nsecs = time_travel_start + time_travel_time;
065038706f77a56 arch/um/kernel/time.c      Johannes Berg   2019-05-27  771  	else
065038706f77a56 arch/um/kernel/time.c      Johannes Berg   2019-05-27  772  		nsecs = os_persistent_clock_emulation();
b29230769e3482b arch/um/kernel/time.c      Thomas Gleixner 2010-08-03  773  
288fb3d5683f508 arch/um/kernel/time.c      Arnd Bergmann   2017-11-02  774  	set_normalized_timespec64(ts, nsecs / NSEC_PER_SEC,
9f31f5774961a73 arch/um/kernel/time.c      John Stultz     2010-07-13  775  				  nsecs % NSEC_PER_SEC);
9f31f5774961a73 arch/um/kernel/time.c      John Stultz     2010-07-13  776  }
9f31f5774961a73 arch/um/kernel/time.c      John Stultz     2010-07-13  777  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
