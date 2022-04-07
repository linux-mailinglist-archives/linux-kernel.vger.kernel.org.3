Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334554F7C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiDGKJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244113AbiDGKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:08:50 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C082BC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649326008; x=1680862008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=unfnYCPSgpycrdJhJBi5EhSSRpRKJ7qA2UrLAxLqJfo=;
  b=eNwrR3P36ol97Itqi8u1of6wn6biXoAiYbmlGdg0yjcmP71ueXshyQWI
   A5DnfFf52e5zACNAyc0pmsdBnlpzgnFy31ZtKsvx7XnqwkxgE+MZPAjuI
   hPINn1lGYy3kyrV0GQtUEt/x+MWireFf8zVxV0sua3pUoaFL/Bq0Lo60P
   oOyfmn3R7D5SMa2CXXb7ymtWc3tzFQ/yVgUaodBwCgBbSengs0pyM7LGt
   WC0Z1jK6bYB6Zut38QUOS363BA580OjWN+14zY/h0eocVpTOe9aePhtju
   nubtDDVwWrvAts9uRlbXf3fvKz96A/aq2P4l/cv07eCZw89ftqfhX0sDu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321974173"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="321974173"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 03:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="549980531"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2022 03:06:39 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncP2E-0005Ja-RR;
        Thu, 07 Apr 2022 10:06:38 +0000
Date:   Thu, 7 Apr 2022 18:06:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [chanwoo:devfreq-testing 2/4] include/linux/devfreq.h:332:1:
 warning: no semicolon at end of struct or union
Message-ID: <202204071831.uDO7FR9U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   e8222a8ce34258ab3033cae96c0153a55414da4d
commit: 95f7ed4a4161892825bb0ba124579c93280ad462 [2/4] PM / devfreq: Add cpu based scaling support to passive governor
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220407/202204071831.uDO7FR9U-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=95f7ed4a4161892825bb0ba124579c93280ad462
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout 95f7ed4a4161892825bb0ba124579c93280ad462
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from drivers/devfreq/devfreq.c:11:
>> arch/um/include/asm/processor-generic.h:103:19: error: expected identifier or '(' before '&' token
     103 | #define cpu_data (&boot_cpu_data)
         |                   ^
   include/linux/devfreq.h:331:34: note: in expansion of macro 'cpu_data'
     331 |         struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                                  ^~~~~~~~
   In file included from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
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
   include/linux/devfreq.h:331:34: note: in expansion of macro 'cpu_data'
     331 |         struct devfreq_cpu_data *cpu_data[NR_CPUS];
         |                                  ^~~~~~~~
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
   drivers/devfreq/governor_passive.c:58:43: note: in expansion of macro 'cpu_data'
      58 |                 parent_cpu_data = p_data->cpu_data[cpu];
         |                                           ^~~~~~~~
>> drivers/devfreq/governor_passive.c:50:38: warning: variable 'p_data' set but not used [-Wunused-but-set-variable]
      50 |         struct devfreq_passive_data *p_data =
         |                                      ^~~~~~
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
   drivers/devfreq/governor_passive.c:221:24: note: in expansion of macro 'cpu_data'
     221 |                 !data->cpu_data[freqs->policy->cpu])
         |                        ^~~~~~~~
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:224:33: note: in expansion of macro 'cpu_data'
     224 |         parent_cpu_data = data->cpu_data[freqs->policy->cpu];
         |                                 ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_unregister_notifier':
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:258:43: note: in expansion of macro 'cpu_data'
     258 |                 parent_cpu_data = p_data->cpu_data[cpu];
         |                                           ^~~~~~~~
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_register_notifier':
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:291:29: note: in expansion of macro 'cpu_data'
     291 |                 if (p_data->cpu_data[cpu])
         |                             ^~~~~~~~
>> arch/um/include/asm/processor-generic.h:103:18: error: expected identifier before '(' token
     103 | #define cpu_data (&boot_cpu_data)
         |                  ^
   drivers/devfreq/governor_passive.c:331:25: note: in expansion of macro 'cpu_data'
     331 |                 p_data->cpu_data[cpu] = parent_cpu_data;
         |                         ^~~~~~~~


vim +332 include/linux/devfreq.h

95f7ed4a416189 Saravana Kannan       2021-03-02  296  
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
95f7ed4a416189 Saravana Kannan       2021-03-02  308   + * @parent_type	parent type of the device
95f7ed4a416189 Saravana Kannan       2021-03-02  309   + * @this:		the devfreq instance of own device.
95f7ed4a416189 Saravana Kannan       2021-03-02  310   + * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
95f7ed4a416189 Saravana Kannan       2021-03-02  311   + * @cpu_data:		the state min/max/current frequency of all online cpu's
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
95f7ed4a416189 Saravana Kannan       2021-03-02  325  	/* Should set the type of parent device */
95f7ed4a416189 Saravana Kannan       2021-03-02  326  	enum devfreq_parent_dev_type parent_type;
95f7ed4a416189 Saravana Kannan       2021-03-02  327  
996133119f5733 Chanwoo Choi          2016-03-22  328  	/* For passive governor's internal use. Don't need to set them */
996133119f5733 Chanwoo Choi          2016-03-22  329  	struct devfreq *this;
996133119f5733 Chanwoo Choi          2016-03-22  330  	struct notifier_block nb;
95f7ed4a416189 Saravana Kannan       2021-03-02  331  	struct devfreq_cpu_data *cpu_data[NR_CPUS];
996133119f5733 Chanwoo Choi          2016-03-22 @332  };
996133119f5733 Chanwoo Choi          2016-03-22  333  #endif
996133119f5733 Chanwoo Choi          2016-03-22  334  

:::::: The code at line 332 was first introduced by commit
:::::: 996133119f57334c38b020dbfaaac5b5eb127e29 PM / devfreq: Add new passive governor

:::::: TO: Chanwoo Choi <cw00.choi@samsung.com>
:::::: CC: MyungJoo Ham <myungjoo.ham@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
