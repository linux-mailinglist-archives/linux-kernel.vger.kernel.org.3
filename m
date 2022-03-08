Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B964D2568
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiCIBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiCIBH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:07:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7BDEF0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646786938; x=1678322938;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wHOUq6oj52ftb6Lgge3jkOSIeqRGGllnLy57qfnO/iI=;
  b=SptU/ZWL9vF/+sIglnUdTHEFeVRF+5WauykEQih30z0jxPJbPCyrVr64
   MIensT65Tz4CQVeKFyUpR+7AXalMJf8TjWj8UVG0TLWfF4W2CH0P9JPbs
   mB8ewxE43rE0WZokJ2Di9+ZOZmywC/C7717bkVBRNqtGchCrYi6UtxGQD
   6EtLYKqhsRMErh0k9jdl0lkp7sOhUnlZ/mEViWwjyoj+CJI92T4e6IgVs
   f2Pysjiu2ZdeimpY3a7yOZD1x+BOteqC2TxU5uQF1euoZRSf8FrCKobWC
   +Jc+cFNtpB56V83v730UixtGctPAYZmLF3FxGbQ25hz25xL5sKGMfrPCE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318070544"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="318070544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 15:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="688103910"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2022 15:41:43 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRjSY-0002By-Rm; Tue, 08 Mar 2022 23:41:42 +0000
Date:   Wed, 9 Mar 2022 07:41:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [chanwoo:devfreq-testing 2/4] include/linux/devfreq.h:332:1:
 warning: no semicolon at end of struct or union
Message-ID: <202203090713.yqIkOA2s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   3439b6e7ff5704e4f812af746da9f06a6403d796
commit: ae763e5ef1bcfccbf95119180ee716637b7bb353 [2/4] PM / devfreq: Add cpu based scaling support to passive governor
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220309/202203090713.yqIkOA2s-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=ae763e5ef1bcfccbf95119180ee716637b7bb353
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout ae763e5ef1bcfccbf95119180ee716637b7bb353
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash drivers/devfreq/ drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/devfreq/governor_simpleondemand.c:10:
>> arch/um/include/asm/processor-generic.h:103:19: error: expected identifier or '(' before '&' token
     103 | #define cpu_data (&boot_cpu_data)
         |                   ^
   include/linux/devfreq.h:331:27: note: in expansion of macro 'cpu_data'
     331 |  struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                           ^~~~~~~~
   In file included from drivers/devfreq/governor_simpleondemand.c:11:
>> include/linux/devfreq.h:332:1: warning: no semicolon at end of struct or union
     332 | };
         | ^
--
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/devfreq/governor_passive.c:10:
>> arch/um/include/asm/processor-generic.h:103:19: error: expected identifier or '(' before '&' token
     103 | #define cpu_data (&boot_cpu_data)
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
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/devfreq/governor_passive.c:10:
   drivers/devfreq/governor_passive.c: In function 'get_target_freq_with_cpufreq':
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
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
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/devfreq/governor_passive.c:10:
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_notifier_call':
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:221:10: note: in expansion of macro 'cpu_data'
     221 |   !data->cpu_data[freqs->policy->cpu])
         |          ^~~~~~~~
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:224:26: note: in expansion of macro 'cpu_data'
     224 |  parent_cpu_data = data->cpu_data[freqs->policy->cpu];
         |                          ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_unregister_notifier':
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:258:29: note: in expansion of macro 'cpu_data'
     258 |   parent_cpu_data = p_data->cpu_data[cpu];
         |                             ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_register_notifier':
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:291:15: note: in expansion of macro 'cpu_data'
     291 |   if (p_data->cpu_data[cpu])
         |               ^~~~~~~~
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:331:11: note: in expansion of macro 'cpu_data'
     331 |   p_data->cpu_data[cpu] = parent_cpu_data;
         |           ^~~~~~~~


vim +332 include/linux/devfreq.h

ae763e5ef1bcfcc Saravana Kannan       2021-03-02  296  
996133119f57334 Chanwoo Choi          2016-03-22  297  /**
7a51320ecd39420 Mauro Carvalho Chehab 2020-03-17  298   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
996133119f57334 Chanwoo Choi          2016-03-22  299   *	and devfreq_add_device
996133119f57334 Chanwoo Choi          2016-03-22  300   * @parent:	the devfreq instance of parent device.
996133119f57334 Chanwoo Choi          2016-03-22  301   * @get_target_freq:	Optional callback, Returns desired operating frequency
996133119f57334 Chanwoo Choi          2016-03-22  302   *			for the device using passive governor. That is called
996133119f57334 Chanwoo Choi          2016-03-22  303   *			when passive governor should decide the next frequency
996133119f57334 Chanwoo Choi          2016-03-22  304   *			by using the new frequency of parent devfreq device
996133119f57334 Chanwoo Choi          2016-03-22  305   *			using governors except for passive governor.
996133119f57334 Chanwoo Choi          2016-03-22  306   *			If the devfreq device has the specific method to decide
996133119f57334 Chanwoo Choi          2016-03-22  307   *			the next frequency, should use this callback.
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  308   + * @parent_type	parent type of the device
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  309   + * @this:		the devfreq instance of own device.
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  310   + * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  311   + * @cpu_data:		the state min/max/current frequency of all online cpu's
996133119f57334 Chanwoo Choi          2016-03-22  312   *
996133119f57334 Chanwoo Choi          2016-03-22  313   * The devfreq_passive_data have to set the devfreq instance of parent
996133119f57334 Chanwoo Choi          2016-03-22  314   * device with governors except for the passive governor. But, don't need to
996133119f57334 Chanwoo Choi          2016-03-22  315   * initialize the 'this' and 'nb' field because the devfreq core will handle
996133119f57334 Chanwoo Choi          2016-03-22  316   * them.
996133119f57334 Chanwoo Choi          2016-03-22  317   */
996133119f57334 Chanwoo Choi          2016-03-22  318  struct devfreq_passive_data {
996133119f57334 Chanwoo Choi          2016-03-22  319  	/* Should set the devfreq instance of parent device */
996133119f57334 Chanwoo Choi          2016-03-22  320  	struct devfreq *parent;
996133119f57334 Chanwoo Choi          2016-03-22  321  
996133119f57334 Chanwoo Choi          2016-03-22  322  	/* Optional callback to decide the next frequency of passvice device */
996133119f57334 Chanwoo Choi          2016-03-22  323  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
996133119f57334 Chanwoo Choi          2016-03-22  324  
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  325  	/* Should set the type of parent device */
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  326  	enum devfreq_parent_dev_type parent_type;
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  327  
996133119f57334 Chanwoo Choi          2016-03-22  328  	/* For passive governor's internal use. Don't need to set them */
996133119f57334 Chanwoo Choi          2016-03-22  329  	struct devfreq *this;
996133119f57334 Chanwoo Choi          2016-03-22  330  	struct notifier_block nb;
ae763e5ef1bcfcc Saravana Kannan       2021-03-02  331  	struct devfreq_cpu_data *cpu_data[NR_CPUS];
996133119f57334 Chanwoo Choi          2016-03-22 @332  };
996133119f57334 Chanwoo Choi          2016-03-22  333  #endif
996133119f57334 Chanwoo Choi          2016-03-22  334  

:::::: The code at line 332 was first introduced by commit
:::::: 996133119f57334c38b020dbfaaac5b5eb127e29 PM / devfreq: Add new passive governor

:::::: TO: Chanwoo Choi <cw00.choi@samsung.com>
:::::: CC: MyungJoo Ham <myungjoo.ham@samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
