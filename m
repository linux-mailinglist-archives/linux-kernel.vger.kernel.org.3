Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE68753425B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbiEYRov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbiEYRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:44:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACB79E9E3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500687; x=1685036687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S15J8qiMe78oyZ75jSB0YG8t0U9DMdTYTd2h31lUDPg=;
  b=lTVYjOe/ZSGnn5Y4eeTmOxw79OiNAfML8eEVh+IAGE5eYLzN7N9+uiY7
   Z5bltcUWTSRH5GwgbvL2kFHPsyrtI5c0UTJ5UbSIBFC1RcYDPoW2C3+Mk
   7hYWSmgxTDlzLB13uze2cIFYNrB8YUyUB4KL4Xo4qxZPWQ2eaoOxCnz6Y
   z3/wlPhIBoFw3/ykqZ7JdYB+lKymrTEs4kgxnZeK0Gfy5JCLrakUmLdxV
   7AoF7RGsosZdXxFkWkFOXjrmcL5UiI0cbQeEicg4Ev3vmgyt/5d9XYz25
   qpjZo6nt2xGRLSIMjUVTptVSgtcppzELvRUavNEsjme6EMbyEP2DNxJZK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="299219929"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="299219929"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="609292606"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2022 10:23:03 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntuis-0003Bd-F4;
        Wed, 25 May 2022 17:23:02 +0000
Date:   Thu, 26 May 2022 01:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 10/33] include/linux/pm_opp.h:459:9: warning:
 incompatible pointer to integer conversion returning 'void *' from a
 function with result type 'int'
Message-ID: <202205260150.ezjPkAEK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config
head:   d730dc101c586defb49eeafd8eea9b7bb0baa01b
commit: a23b86fb0614c769679169402c09ebcd07dbb22f [10/33] OPP: Add dev_pm_opp_set_config() and friends
config: mips-randconfig-r014-20220524 (https://download.01.org/0day-ci/archive/20220526/202205260150.ezjPkAEK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=a23b86fb0614c769679169402c09ebcd07dbb22f
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout a23b86fb0614c769679169402c09ebcd07dbb22f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:81:
   In file included from kernel/sched/sched.h:30:
   In file included from include/linux/cpufreq.h:19:
>> include/linux/pm_opp.h:459:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EOPNOTSUPP);
                  ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:5235:20: warning: no previous prototype for function 'task_sched_runtime' [-Wmissing-prototypes]
   unsigned long long task_sched_runtime(struct task_struct *p)
                      ^
   kernel/sched/core.c:5235:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long long task_sched_runtime(struct task_struct *p)
   ^
   static 
   kernel/sched/core.c:6487:35: warning: no previous prototype for function 'schedule_user' [-Wmissing-prototypes]
   asmlinkage __visible void __sched schedule_user(void)
                                     ^
   kernel/sched/core.c:6487:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage __visible void __sched schedule_user(void)
                        ^
                        static 
   kernel/sched/core.c:9420:13: warning: no previous prototype for function 'sched_init_smp' [-Wmissing-prototypes]
   void __init sched_init_smp(void)
               ^
   kernel/sched/core.c:9420:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init sched_init_smp(void)
   ^
   static 
   kernel/sched/core.c:9448:13: warning: no previous prototype for function 'sched_init' [-Wmissing-prototypes]
   void __init sched_init(void)
               ^
   kernel/sched/core.c:9448:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init sched_init(void)
   ^
   static 
   kernel/sched/core.c:3574:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
   static inline bool rq_has_pinned_tasks(struct rq *rq)
                      ^
   kernel/sched/core.c:5502:20: warning: unused function 'sched_tick_start' [-Wunused-function]
   static inline void sched_tick_start(int cpu) { }
                      ^
   kernel/sched/core.c:5503:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
   static inline void sched_tick_stop(int cpu) { }
                      ^
   kernel/sched/core.c:6191:20: warning: unused function 'sched_core_cpu_starting' [-Wunused-function]
   static inline void sched_core_cpu_starting(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:6192:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
   static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:6193:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
   static inline void sched_core_cpu_dying(unsigned int cpu) {}
                      ^
   11 warnings generated.
--
   In file included from kernel/sched/fair.c:53:
   In file included from kernel/sched/sched.h:30:
   In file included from include/linux/cpufreq.h:19:
>> include/linux/pm_opp.h:459:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EOPNOTSUPP);
                  ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:663:5: warning: no previous prototype for function 'sched_update_scaling' [-Wmissing-prototypes]
   int sched_update_scaling(void)
       ^
   kernel/sched/fair.c:663:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_update_scaling(void)
   ^
   static 
   kernel/sched/fair.c:2979:20: warning: unused function 'account_numa_enqueue' [-Wunused-function]
   static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
                      ^
   kernel/sched/fair.c:2983:20: warning: unused function 'account_numa_dequeue' [-Wunused-function]
   static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p)
                      ^
   kernel/sched/fair.c:2987:20: warning: unused function 'update_scan_period' [-Wunused-function]
   static inline void update_scan_period(struct task_struct *p, int new_cpu)
                      ^
   kernel/sched/fair.c:4189:20: warning: unused function 'cfs_rq_is_decayed' [-Wunused-function]
   static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
                      ^
   kernel/sched/fair.c:5524:19: warning: unused function 'throttled_lb_pair' [-Wunused-function]
   static inline int throttled_lb_pair(struct task_group *tg,
                     ^
   kernel/sched/fair.c:5541:20: warning: unused function 'update_runtime_enabled' [-Wunused-function]
   static inline void update_runtime_enabled(struct rq *rq) {}
                      ^
   kernel/sched/fair.c:5542:20: warning: unused function 'unthrottle_offline_cfs_rqs' [-Wunused-function]
   static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
                      ^
   9 warnings generated.
--
   In file included from kernel/sched/build_policy.c:33:
   In file included from kernel/sched/sched.h:30:
   In file included from include/linux/cpufreq.h:19:
>> include/linux/pm_opp.h:459:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EOPNOTSUPP);
                  ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_policy.c:43:
   kernel/sched/rt.c:666:6: warning: no previous prototype for function 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
        ^
   kernel/sched/rt.c:666:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
   ^
   static 
   2 warnings generated.
--
   In file included from kernel/sched/build_utility.c:21:
   In file included from include/linux/cpufreq.h:19:
>> include/linux/pm_opp.h:459:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EOPNOTSUPP);
                  ^~~~~~~~~~~~~~~~~~~~
   1 warning generated.


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
