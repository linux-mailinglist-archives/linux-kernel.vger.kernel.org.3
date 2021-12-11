Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F24A47112F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 04:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbhLKDcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 22:32:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:24475 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235552AbhLKDcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639193310; x=1670729310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ostjL02oknf+yf9nJaaR23+focXQ5kntXrlPoEf/X5Q=;
  b=e0ETYpZZEz90I5oRBiuWfa4y4oJsR6JOYfYQ7a3ahSdSZVIclxx54ZWZ
   cCPSvhLQeTqPglu5+izYKzXrGoRrXqlEGJkgutjJi0zKMHPtED4Fhq4lJ
   OljSKXwqpk0loXs6QeNk0bX4Zb80mUpwUZ0sTDuhWHC62v1lAyEkURrwZ
   0YPS4dpaNdhBC2MJRb53x4iXVWrjt4QqwutYMrQm6IADyiTB5NbtpknTP
   Z8jfCJsIqMJyxCqM31WfbxzBNSaZ9V1B4ksrQLGv87xIme9TJv3mSFPt+
   feiOBSjR+FCs5cDC9XTVZxMnSASAZyWXo7OI6lY/BWics58Q/fgDdvF+7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="324769516"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="324769516"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 19:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="462765161"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2021 19:28:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvt3j-00042z-0E; Sat, 11 Dec 2021 03:28:27 +0000
Date:   Sat, 11 Dec 2021 11:27:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [chanwoo:devfreq-testing 2/4] include/linux/devfreq.h:332:1:
 warning: no semicolon at end of struct or union
Message-ID: <202112111116.n71rjgZH-lkp@intel.com>
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
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20211211/202112111116.n71rjgZH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=d678890dcdf858c25d2789793a35a81c4311e972
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout d678890dcdf858c25d2789793a35a81c4311e972
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash drivers/devfreq/ drivers/memory/samsung/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from drivers/devfreq/devfreq.c:11:
   arch/um/include/asm/processor-generic.h:104:19: error: expected identifier or '(' before '&' token
     104 | #define cpu_data (&boot_cpu_data)
         |                   ^
   include/linux/devfreq.h:331:27: note: in expansion of macro 'cpu_data'
     331 |  struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                           ^~~~~~~~
   In file included from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
>> include/linux/devfreq.h:332:1: warning: no semicolon at end of struct or union
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
   arch/um/include/asm/processor-generic.h:104:19: error: expected identifier or '(' before '&' token
     104 | #define cpu_data (&boot_cpu_data)
         |                   ^
   include/linux/devfreq.h:331:27: note: in expansion of macro 'cpu_data'
     331 |  struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                           ^~~~~~~~
   In file included from drivers/devfreq/governor_passive.c:16:
>> include/linux/devfreq.h:332:1: warning: no semicolon at end of struct or union
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
   arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:58:29: note: in expansion of macro 'cpu_data'
      58 |   parent_cpu_data = p_data->cpu_data[cpu];
         |                             ^~~~~~~~
>> drivers/devfreq/governor_passive.c:50:31: warning: variable 'p_data' set but not used [-Wunused-but-set-variable]
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
   arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:221:10: note: in expansion of macro 'cpu_data'
     221 |   !data->cpu_data[freqs->policy->cpu])
         |          ^~~~~~~~
   arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:224:26: note: in expansion of macro 'cpu_data'
     224 |  parent_cpu_data = data->cpu_data[freqs->policy->cpu];
         |                          ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_unregister_notifier':
   arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:258:29: note: in expansion of macro 'cpu_data'
     258 |   parent_cpu_data = p_data->cpu_data[cpu];
         |                             ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_register_notifier':
   arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:291:15: note: in expansion of macro 'cpu_data'
     291 |   if (p_data->cpu_data[cpu])
         |               ^~~~~~~~
   arch/um/include/asm/processor-generic.h:104:18: error: expected identifier before '(' token
     104 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:331:11: note: in expansion of macro 'cpu_data'
     331 |   p_data->cpu_data[cpu] = parent_cpu_data;
         |           ^~~~~~~~


vim +332 include/linux/devfreq.h

d678890dcdf858 Saravana Kannan       2021-03-02  296  
996133119f5733 Chanwoo Choi          2016-03-22  297  /**
7a51320ecd3942 Mauro Carvalho Chehab 2020-03-17  298   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
996133119f5733 Chanwoo Choi          2016-03-22  299   *	and devfreq_add_device
996133119f5733 Chanwoo Choi          2016-03-22  300   * @parent:	the devfreq instance of parent device.
996133119f5733 Chanwoo Choi          2016-03-22  301   * @get_target_freq:	Optional callback, Returns desired operating frequency
996133119f5733 Chanwoo Choi          2016-03-22  302   *			for the device using passive governor. That is called
996133119f5733 Chanwoo Choi          2016-03-22  303   *			when passive governor should decide the next frequency
996133119f5733 Chanwoo Choi          2016-03-22  304   *			by using the new frequency of parent devfreq device
996133119f5733 Chanwoo Choi          2016-03-22  305   *			using governors except for passive governor.
996133119f5733 Chanwoo Choi          2016-03-22  306   *			If the devfreq device has the specific method to decide
996133119f5733 Chanwoo Choi          2016-03-22  307   *			the next frequency, should use this callback.
d678890dcdf858 Saravana Kannan       2021-03-02  308   + * @parent_type	parent type of the device
d678890dcdf858 Saravana Kannan       2021-03-02  309   + * @this:		the devfreq instance of own device.
d678890dcdf858 Saravana Kannan       2021-03-02  310   + * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
d678890dcdf858 Saravana Kannan       2021-03-02  311   + * @cpu_data:		the state min/max/current frequency of all online cpu's
996133119f5733 Chanwoo Choi          2016-03-22  312   *
996133119f5733 Chanwoo Choi          2016-03-22  313   * The devfreq_passive_data have to set the devfreq instance of parent
996133119f5733 Chanwoo Choi          2016-03-22  314   * device with governors except for the passive governor. But, don't need to
996133119f5733 Chanwoo Choi          2016-03-22  315   * initialize the 'this' and 'nb' field because the devfreq core will handle
996133119f5733 Chanwoo Choi          2016-03-22  316   * them.
996133119f5733 Chanwoo Choi          2016-03-22  317   */
996133119f5733 Chanwoo Choi          2016-03-22  318  struct devfreq_passive_data {
996133119f5733 Chanwoo Choi          2016-03-22  319  	/* Should set the devfreq instance of parent device */
996133119f5733 Chanwoo Choi          2016-03-22  320  	struct devfreq *parent;
996133119f5733 Chanwoo Choi          2016-03-22  321  
996133119f5733 Chanwoo Choi          2016-03-22  322  	/* Optional callback to decide the next frequency of passvice device */
996133119f5733 Chanwoo Choi          2016-03-22  323  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
996133119f5733 Chanwoo Choi          2016-03-22  324  
d678890dcdf858 Saravana Kannan       2021-03-02  325  	/* Should set the type of parent device */
d678890dcdf858 Saravana Kannan       2021-03-02  326  	enum devfreq_parent_dev_type parent_type;
d678890dcdf858 Saravana Kannan       2021-03-02  327  
996133119f5733 Chanwoo Choi          2016-03-22  328  	/* For passive governor's internal use. Don't need to set them */
996133119f5733 Chanwoo Choi          2016-03-22  329  	struct devfreq *this;
996133119f5733 Chanwoo Choi          2016-03-22  330  	struct notifier_block nb;
d678890dcdf858 Saravana Kannan       2021-03-02  331  	struct devfreq_cpu_data *cpu_data[NR_CPUS];
996133119f5733 Chanwoo Choi          2016-03-22 @332  };
996133119f5733 Chanwoo Choi          2016-03-22  333  #endif
996133119f5733 Chanwoo Choi          2016-03-22  334  

:::::: The code at line 332 was first introduced by commit
:::::: 996133119f57334c38b020dbfaaac5b5eb127e29 PM / devfreq: Add new passive governor

:::::: TO: Chanwoo Choi <cw00.choi@samsung.com>
:::::: CC: MyungJoo Ham <myungjoo.ham@samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
