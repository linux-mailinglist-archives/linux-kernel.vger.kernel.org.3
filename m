Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C9498190
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiAXN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:59:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:59221 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237643AbiAXN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643032785; x=1674568785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yRAUJR/xhVfI7sy4u6pDQ9bbgdxxxk9stbD2Mn1dH70=;
  b=hGo8hAvRvOzQpPOkPVBPLiwrnjcgRUWDTRukdEx6HIiEHUdplDs8r6bu
   BAGPH9P7Lyc+AZ5+WBAmQKKUm/bAQkGXHFpgfBISN0W3jIocdCJpufFts
   pZ5g+dpdSIdwk24OIiQDRZ5q6VDuwnthIijndFAejyEYbVn5ezvkyw+Yf
   dCSirG+cPr0CdQt3/61PHVTchZQsdTQ4phpg7kEJsb6Ty5obzs6Jxfrzo
   OIDI6yqNEL9Z8wqOP41zzme/RveeKcMCvq91R9JyJm2NU9VX1wKZ8bVg2
   PiILnFfAiLkZm8AR3JnJwAQSteOKYyvMw4JRnlBfcV9jszd0zCo+bP7Kw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270482785"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270482785"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673631251"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2022 05:59:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBzsk-000IQ5-Ja; Mon, 24 Jan 2022 13:59:42 +0000
Date:   Mon, 24 Jan 2022 21:59:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2355/2384] arch/mips/dec/platform.c:33:19:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 'dec_add_devices'
Message-ID: <202201242143.d1yXnKnX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: a8084e440c4391f574018f45590e8666b4ddda5f [2355/2384] headers/deps: driver/core: Optimize <linux/device/driver.h> dependencies, remove <linux/module.h> inclusion
config: mips-randconfig-r023-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242143.d1yXnKnX-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a8084e440c4391f574018f45590e8666b4ddda5f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout a8084e440c4391f574018f45590e8666b4ddda5f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/dec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/mips/dec/platform.c:33:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dec_add_devices'
      33 | static int __init dec_add_devices(void)
         |                   ^~~~~~~~~~~~~~~
>> arch/mips/dec/platform.c:40:1: warning: data definition has no type or storage class
      40 | device_initcall(dec_add_devices);
         | ^~~~~~~~~~~~~~~
>> arch/mips/dec/platform.c:40:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
>> arch/mips/dec/platform.c:40:1: warning: parameter names (without types) in function declaration
   arch/mips/dec/platform.c:25:31: warning: 'dec_rtc_device' defined but not used [-Wunused-variable]
      25 | static struct platform_device dec_rtc_device = {
         |                               ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +33 arch/mips/dec/platform.c

fae67ad431146d Maciej W. Rozycki 2014-06-06  32  
fae67ad431146d Maciej W. Rozycki 2014-06-06 @33  static int __init dec_add_devices(void)
fae67ad431146d Maciej W. Rozycki 2014-06-06  34  {
fae67ad431146d Maciej W. Rozycki 2014-06-06  35  	dec_rtc_resources[0].start = RTC_PORT(0);
fae67ad431146d Maciej W. Rozycki 2014-06-06  36  	dec_rtc_resources[0].end = RTC_PORT(0) + dec_kn_slot_size - 1;
fae67ad431146d Maciej W. Rozycki 2014-06-06  37  	return platform_device_register(&dec_rtc_device);
fae67ad431146d Maciej W. Rozycki 2014-06-06  38  }
fae67ad431146d Maciej W. Rozycki 2014-06-06  39  
fae67ad431146d Maciej W. Rozycki 2014-06-06 @40  device_initcall(dec_add_devices);

:::::: The code at line 33 was first introduced by commit
:::::: fae67ad431146d2584dd813cbc198400a477aa53 arch/mips/dec: switch DECstation systems to rtc-cmos

:::::: TO: Maciej W. Rozycki <macro@linux-mips.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
