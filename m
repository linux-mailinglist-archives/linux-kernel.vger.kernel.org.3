Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0594647159E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhLKTUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:20:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:8198 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhLKTUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639250452; x=1670786452;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wbPAXxRfmSv/H1gpRO2PkJEkV0z5tGfQ661rEptXzqQ=;
  b=Ch7ov2TV90jjmyzj9+KePbpJphHYAWq+tZHWnJ7hoSDAhWP+EHyWuRTn
   9ZrvN31igNfcG6ma5BUfr3dFAhGyHiJtW4gSQ25LnbTvNDrVOKSS+mDgw
   DeAry3l5rCzY5Xe7MS3eD+NwMH485hmZCHMrL+92OLJccUCHKxDQh4Tsr
   VKcZ23LX9RFLwuT06NtBrdYGAUiwI2dImPrBJMwb0C4cQg2YCQ7jtQrOp
   EP3EVxq8biPiyVVCvdhulvWwThVSYn9wwZtCQ/uJZvancjLwVGm2LfYAM
   ELoKKFpNClSbsI66+erDtOKv4rkC4RWHX6s75oo6F0HHsDgXZAzNS8viW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="299341084"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="299341084"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 11:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="681135778"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2021 11:20:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw7vN-000503-KJ; Sat, 11 Dec 2021 19:20:49 +0000
Date:   Sun, 12 Dec 2021 03:20:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [chanwoo:devfreq-testing 2/4]
 arch/um/include/asm/processor-generic.h:104:19: error: expected identifier
 or '(' before '&' token
Message-ID: <202112120322.6KDmAB1p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   5857e3d1820d85e10321ec180ed88e780fd0ec3e
commit: d678890dcdf858c25d2789793a35a81c4311e972 [2/4] PM / devfreq: Add cpu based scaling support to passive governor
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20211212/202112120322.6KDmAB1p-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=d678890dcdf858c25d2789793a35a81c4311e972
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout d678890dcdf858c25d2789793a35a81c4311e972
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/rcupdate.h:30,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/base/power/main.c:21:
>> arch/um/include/asm/processor-generic.h:104:19: error: expected identifier or '(' before '&' token
     104 | #define cpu_data (&boot_cpu_data)
         |                   ^
   include/linux/devfreq.h:331:27: note: in expansion of macro 'cpu_data'
     331 |  struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                           ^~~~~~~~
   In file included from drivers/base/power/main.c:35:
   include/linux/devfreq.h:332:1: warning: no semicolon at end of struct or union
     332 | };
         | ^
--
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/mm_types.h:9,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/devfreq/governor_passive.c:10:
>> arch/um/include/asm/processor-generic.h:104:19: error: expected identifier or '(' before '&' token
     104 | #define cpu_data (&boot_cpu_data)
         |                   ^
   include/linux/devfreq.h:331:27: note: in expansion of macro 'cpu_data'
     331 |  struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                           ^~~~~~~~
   In file included from drivers/devfreq/governor_passive.c:16:
   include/linux/devfreq.h:332:1: warning: no semicolon at end of struct or union
     332 | };
         | ^
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/mm_types.h:9,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/devfreq/governor_passive.c:10:
   drivers/devfreq/governor_passive.c: In function 'get_target_freq_with_cpufreq':
>> arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:58:29: note: in expansion of macro 'cpu_data'
      58 |   parent_cpu_data = p_data->cpu_data[cpu];
         |                             ^~~~~~~~
   drivers/devfreq/governor_passive.c:50:31: warning: variable 'p_data' set but not used [-Wunused-but-set-variable]
      50 |  struct devfreq_passive_data *p_data =
         |                               ^~~~~~
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/mm_types.h:9,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/devfreq/governor_passive.c:10:
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_notifier_call':
>> arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:221:10: note: in expansion of macro 'cpu_data'
     221 |   !data->cpu_data[freqs->policy->cpu])
         |          ^~~~~~~~
>> arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:224:26: note: in expansion of macro 'cpu_data'
     224 |  parent_cpu_data = data->cpu_data[freqs->policy->cpu];
         |                          ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_unregister_notifier':
>> arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:258:29: note: in expansion of macro 'cpu_data'
     258 |   parent_cpu_data = p_data->cpu_data[cpu];
         |                             ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_register_notifier':
>> arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:291:15: note: in expansion of macro 'cpu_data'
     291 |   if (p_data->cpu_data[cpu])
         |               ^~~~~~~~
>> arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:331:11: note: in expansion of macro 'cpu_data'
     331 |   p_data->cpu_data[cpu] = parent_cpu_data;
         |           ^~~~~~~~


vim +104 arch/um/include/asm/processor-generic.h

^1da177e4c3f41 include/asm-um/processor-generic.h      Linus Torvalds 2005-04-16  103  
^1da177e4c3f41 include/asm-um/processor-generic.h      Linus Torvalds 2005-04-16 @104  #define cpu_data (&boot_cpu_data)
^1da177e4c3f41 include/asm-um/processor-generic.h      Linus Torvalds 2005-04-16  105  #define current_cpu_data boot_cpu_data
d8fb32f4790f2a arch/um/include/asm/processor-generic.h Anton Ivanov   2021-03-12  106  #define cache_line_size()	(boot_cpu_data.cache_alignment)
^1da177e4c3f41 include/asm-um/processor-generic.h      Linus Torvalds 2005-04-16  107  

:::::: The code at line 104 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
