Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D2488694
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 23:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiAHWKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 17:10:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:42899 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbiAHWKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641679813; x=1673215813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IWzuCSzB8TbQjtO1bt+7zE4UyMGIG27eDneCDPdj4xg=;
  b=U7rv0gV6pbKz0GP0Mib2Til6+UzLVslIUpmQEv0ViEBZHRnMJaAeOxef
   IHcIWCfj+iESf+1pLVcTBpCeYB5HfRTsmgJgZgR42soru832N8z63ksSX
   +tN8NcWbSi65wM5Es2a6Xlbmik1bsoBrTmoUA8yEtxoLkY8P2nxPfqQ11
   0jVLNdH9CPEEkruknaess2lsq61Eik0E9DgvtUOzbYteFt6B4HWZ/5qwk
   FkOe5TSPhCgpD628LlpQ5RRH2SGTtdhhXwKTAvJjcwO0t0aQRpRYgaUaZ
   VsJO4UiZYQXNn/2GEw1YE1wUHhsGhvooNy+EFYgAzTuJ9iX6MpYeMhTPc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="242993164"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="242993164"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 14:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="690167954"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2022 14:10:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6Jud-00016z-BM; Sat, 08 Jan 2022 22:10:11 +0000
Date:   Sun, 9 Jan 2022 06:10:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2296/2300] arch/mips/dec/platform.c:33:19: error:
 expected '=', ',', ';', 'asm' or '__attribute__' before 'dec_add_devices'
Message-ID: <202201090604.UYYPTJHx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4e348e961395297bb17f101cc63bc133d8a348e9
commit: 4d78e75186678c7853df35a422c167910b400856 [2296/2300] headers/deps: driver/core: Optimize <linux/device/driver.h> dependencies, remove <linux/module.h> inclusion
config: mips-decstation_defconfig (https://download.01.org/0day-ci/archive/20220109/202201090604.UYYPTJHx-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4d78e75186678c7853df35a422c167910b400856
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 4d78e75186678c7853df35a422c167910b400856
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/dec/platform.c:33:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dec_add_devices'
      33 | static int __init dec_add_devices(void)
         |                   ^~~~~~~~~~~~~~~
   arch/mips/dec/platform.c:40:1: warning: data definition has no type or storage class
      40 | device_initcall(dec_add_devices);
         | ^~~~~~~~~~~~~~~
>> arch/mips/dec/platform.c:40:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
   arch/mips/dec/platform.c:40:1: warning: parameter names (without types) in function declaration
   arch/mips/dec/platform.c:25:31: warning: 'dec_rtc_device' defined but not used [-Wunused-variable]
      25 | static struct platform_device dec_rtc_device = {
         |                               ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +33 arch/mips/dec/platform.c

fae67ad431146d2 Maciej W. Rozycki 2014-06-06  32  
fae67ad431146d2 Maciej W. Rozycki 2014-06-06 @33  static int __init dec_add_devices(void)
fae67ad431146d2 Maciej W. Rozycki 2014-06-06  34  {
fae67ad431146d2 Maciej W. Rozycki 2014-06-06  35  	dec_rtc_resources[0].start = RTC_PORT(0);
fae67ad431146d2 Maciej W. Rozycki 2014-06-06  36  	dec_rtc_resources[0].end = RTC_PORT(0) + dec_kn_slot_size - 1;
fae67ad431146d2 Maciej W. Rozycki 2014-06-06  37  	return platform_device_register(&dec_rtc_device);
fae67ad431146d2 Maciej W. Rozycki 2014-06-06  38  }
fae67ad431146d2 Maciej W. Rozycki 2014-06-06  39  
fae67ad431146d2 Maciej W. Rozycki 2014-06-06 @40  device_initcall(dec_add_devices);

:::::: The code at line 33 was first introduced by commit
:::::: fae67ad431146d2584dd813cbc198400a477aa53 arch/mips/dec: switch DECstation systems to rtc-cmos

:::::: TO: Maciej W. Rozycki <macro@linux-mips.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
