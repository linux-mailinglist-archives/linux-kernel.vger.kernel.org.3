Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED852216C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347522AbiEJQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347518AbiEJQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:42:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5155C64A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652200697; x=1683736697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9QWyfcw1CMut7JXAtG+goqqFdsSUhSb0SnAONXDHiow=;
  b=UWbdTO3H9qXclVshK+1oY2IjiuPw3acXWEZmnw50DoM1O2LtVRVBPPDc
   gBwXsbyWxncwtwDppUb74bkG4DIe4nMHOP4U4bTqR3a4j2OHWI79yjkgg
   4hmIlJYtjbjwl4LqL83md5PuFcOvIaSOS0zcQFxjdu1j/MdGP9Mhf2oDu
   h+vYP3AjMBKmht8dgULsL0V/DR7ksfEn9jS8axN7zf/FMypZ/p/AHSfzu
   YXyL3UFnRguNywv3x+w2uzNjk7TTG1VbCL5M50z2+hap6GJx0AlXuujAo
   5+04nYwc/4lO5aPt9L+DY9OVE622xq1o+0KgBwajt6T5T4+hqo3Mvxvvg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249961864"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="249961864"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 09:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="602546828"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2022 09:38:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noSsI-000I8Q-KM;
        Tue, 10 May 2022 16:38:14 +0000
Date:   Wed, 11 May 2022 00:37:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: [yu-chen-surf:sis 1/1] kernel/sched/fair.c:9317:12: warning:
 comparison of distinct pointer types ('typeof (0) *' (aka 'int *') and
 'typeof ((nr_llc * y) / (1L << 10)) *' (aka 'long *'))
Message-ID: <202205110033.NNmqSG7c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/yu-chen-surf/linux.git sis
head:   e99eab1b5fbda9474ad4fe9074983f2d2169923b
commit: e99eab1b5fbda9474ad4fe9074983f2d2169923b [1/1] sched/fair: Introduce SIS_UTIL to search idle CPU based on sum of util_avg
config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20220511/202205110033.NNmqSG7c-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/yu-chen-surf/linux/commit/e99eab1b5fbda9474ad4fe9074983f2d2169923b
        git remote add yu-chen-surf https://github.com/yu-chen-surf/linux.git
        git fetch --no-tags yu-chen-surf sis
        git checkout e99eab1b5fbda9474ad4fe9074983f2d2169923b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c:5530:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
        ^
   kernel/sched/fair.c:5530:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
   ^
   static 
>> kernel/sched/fair.c:9317:12: warning: comparison of distinct pointer types ('typeof (0) *' (aka 'int *') and 'typeof ((nr_llc * y) / (1L << 10)) *' (aka 'long *')) [-Wcompare-distinct-pointer-types]
           nr_scan = max(0, (nr_llc * y) / SCHED_CAPACITY_SCALE);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   kernel/sched/fair.c:10704:6: warning: no previous prototype for function 'nohz_balance_enter_idle' [-Wmissing-prototypes]
   void nohz_balance_enter_idle(int cpu)
        ^
   kernel/sched/fair.c:10704:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void nohz_balance_enter_idle(int cpu)
   ^
   static 
   kernel/sched/fair.c:11826:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11826:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11828:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:11828:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:11833:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11833:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11835:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11835:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:507:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
   static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
                      ^
   kernel/sched/fair.c:528:19: warning: unused function 'tg_is_idle' [-Wunused-function]
   static inline int tg_is_idle(struct task_group *tg)
                     ^
   kernel/sched/fair.c:5511:20: warning: unused function 'sync_throttle' [-Wunused-function]
   static inline void sync_throttle(struct task_group *tg, int cpu) {}
                      ^
   kernel/sched/fair.c:5536:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
   static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
                                       ^
   kernel/sched/fair.c:5540:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
   static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
                      ^
   12 warnings generated.


vim +9317 kernel/sched/fair.c

  9267	
  9268	static inline void update_idle_cpu_scan(struct lb_env *env,
  9269						unsigned long sum_util)
  9270	{
  9271		struct sched_domain_shared *sd_share;
  9272		int nr_scan, nr_llc, x, y;
  9273	
  9274		if (!sched_feat(SIS_UTIL))
  9275			return;
  9276		/*
  9277		 * Update the number of CPUs to scan in LLC domain, which could
  9278		 * be used as a hint in select_idle_cpu(). The update of this hint
  9279		 * occurs during periodic load balancing, rather than frequent
  9280		 * newidle balance.
  9281		 */
  9282		nr_llc = per_cpu(sd_llc_size, env->dst_cpu);
  9283		if (env->idle == CPU_NEWLY_IDLE ||
  9284		    env->sd->span_weight != nr_llc)
  9285			return;
  9286	
  9287		sd_share = rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
  9288		if (!sd_share)
  9289			return;
  9290	
  9291		/*
  9292		 * The number of CPUs to search drops as sum_util increases, when
  9293		 * sum_util hits 85% or above, the scan stops.
  9294		 * The reason to choose 85% as the threshold is because this is the
  9295		 * imbalance_pct(117) when a LLC sched group is overloaded.
  9296		 *
  9297		 * let y = 1 - (x/0.85)^2                                         [1]
  9298		 *
  9299		 * y is the ratio of CPUs to be scanned in the LLC
  9300		 * domain, x is the ratio of sum_util compared to the
  9301		 * CPU capacity:
  9302		 *
  9303		 * x = sum_util / (nr_llc * SCHED_CAPACITY_SCALE)                 [2]
  9304		 *
  9305		 * Scale x by SCHED_CAPACITY_SCALE and [2] becomes:
  9306		 *
  9307		 * x = sum_util / nr_llc                                          [3]
  9308		 *
  9309		 * and [1] becomes:
  9310		 *
  9311		 * y = (SCHED_CAPACITY_SCALE - (x*x)/740) / SCHED_CAPACITY_SCALE  [4]
  9312		 *
  9313		 * then the number of CPUs to scan is nr_scan = nr_llc * y
  9314		 */
  9315		x = sum_util / nr_llc;
  9316		y = SCHED_CAPACITY_SCALE - (x * x) / 740;
> 9317		nr_scan = max(0, (nr_llc * y) / SCHED_CAPACITY_SCALE);
  9318		WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
  9319	}
  9320	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
