Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215A953424A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbiEYRjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiEYRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:39:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A6CAFADA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500340; x=1685036340;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d8IVV6FH6JDhsADseOUxBqVpCfkI/N2LszUb6foim30=;
  b=kLjwlh7mLw9V/mYIToEsKcgxqxStqCPiqQhNypWlH7tyXCQuBUtrpe21
   xjpKUNMJFgowWYxHTJq2rGlRDvLV47ymi/wu0P3h/h2rTImuuM5Mr9Ayg
   yS5bcs0yN+MmmmpNqqf7d7paaqkfc+zWfO/ULhtQviTkFgzLJJOES7vfS
   J4wAetvuzXrAHw3p6KQQcwAbS+9B7SRdunFkjOn9xtqc6DXgP4lDth24z
   lD1QX28rlVU4KMzrX4Y7hnVhNqJUEU4Hv4ZQLsGIXtqbJwBBXDY0fGhQq
   gYRKb0a+TuWqts7TPdPON0fne5h2cOFOg7uc8Hf+DRTBM3emrJrMSFWgZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253754550"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253754550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="642458622"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2022 10:12:02 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntuYD-0003Ao-Ij;
        Wed, 25 May 2022 17:12:01 +0000
Date:   Thu, 26 May 2022 01:11:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 10/33] include/linux/pm_opp.h:459:16:
 warning: returning 'void *' from a function with return type 'int' makes
 integer from pointer without a cast
Message-ID: <202205260146.VYGeif1G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config
head:   d730dc101c586defb49eeafd8eea9b7bb0baa01b
commit: a23b86fb0614c769679169402c09ebcd07dbb22f [10/33] OPP: Add dev_pm_opp_set_config() and friends
config: m68k-randconfig-r033-20220524 (https://download.01.org/0day-ci/archive/20220526/202205260146.VYGeif1G-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=a23b86fb0614c769679169402c09ebcd07dbb22f
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout a23b86fb0614c769679169402c09ebcd07dbb22f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:19,
                    from kernel/sched/sched.h:30,
                    from kernel/sched/core.c:81:
   include/linux/pm_opp.h: In function 'devm_pm_opp_set_config':
>> include/linux/pm_opp.h:459:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     459 |         return ERR_PTR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:5235:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
    5235 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:9420:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
    9420 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
   kernel/sched/core.c:9448:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
    9448 | void __init sched_init(void)
         |             ^~~~~~~~~~
--
   In file included from include/linux/cpufreq.h:19,
                    from kernel/sched/sched.h:30,
                    from kernel/sched/fair.c:53:
   include/linux/pm_opp.h: In function 'devm_pm_opp_set_config':
>> include/linux/pm_opp.h:459:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     459 |         return ERR_PTR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:663:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     663 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpufreq.h:19,
                    from kernel/sched/sched.h:30,
                    from kernel/sched/build_policy.c:33:
   include/linux/pm_opp.h: In function 'devm_pm_opp_set_config':
>> include/linux/pm_opp.h:459:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     459 |         return ERR_PTR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_policy.c:43:
   kernel/sched/rt.c: At top level:
   kernel/sched/rt.c:666:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     666 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpufreq.h:19,
                    from kernel/sched/build_utility.c:21:
   include/linux/pm_opp.h: In function 'devm_pm_opp_set_config':
>> include/linux/pm_opp.h:459:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     459 |         return ERR_PTR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~


vim +459 include/linux/pm_opp.h

   456	
   457	static inline int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
   458	{
 > 459		return ERR_PTR(-EOPNOTSUPP);
   460	}
   461	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
