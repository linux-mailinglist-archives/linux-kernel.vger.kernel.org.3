Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E535214BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiEJMFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiEJMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:05:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5113A71A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652184094; x=1683720094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=801YV3eY0WKMKVYdlx0DViaW1WOmS+py+igyAxz2olY=;
  b=FuEm8BTtlXZDNNhfzNtbMwFuEbEtqDms3b4wApkE1YhLziwAxmDzpnjd
   UM8/+Uvan5ZSmTJ2Dgp462G8V+s/CGa1VXXGcLuH6M15zY+U8x9ua/vCn
   kVvj7FJTYp8VVF26hV6wnB4vCeG6lz8b6t8KGEr3BF1vVIyX65JrfnKtW
   jHVa8aK7UcuQFpawmAOYyX4Ixh3pE8re5NCi2ud6cB7KZuDg+QLcQ/7ck
   s2NdLH3KE7gbWlSal+B3D4ixoWohzdWRsSbuX/PNhoJe7TMpaeQH/1MhA
   Cx+K65JXY9uwoe4P6oA7/JmfTAvyA6kTTRgs0vJsc2NHhulvpkQ4d41jY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269286022"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269286022"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 05:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="635913710"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2022 05:01:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noOYV-000Hqk-LT;
        Tue, 10 May 2022 12:01:31 +0000
Date:   Tue, 10 May 2022 20:00:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     kbuild-all@lists.01.org, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [yu-chen-surf:sis 1/1] kernel/sched/fair.c:9317:19: sparse: sparse:
 incompatible types in comparison expression (different type sizes):
Message-ID: <202205101914.mxQiTOkX-lkp@intel.com>
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
head:   e59a4ccc3962b54c5488c142b073dcf9b85b5843
commit: e59a4ccc3962b54c5488c142b073dcf9b85b5843 [1/1] sched/fair: Introduce SIS_UTIL to search idle CPU based on sum of util_avg
config: arc-randconfig-s031-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101914.mxQiTOkX-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/yu-chen-surf/linux/commit/e59a4ccc3962b54c5488c142b073dcf9b85b5843
        git remote add yu-chen-surf https://github.com/yu-chen-surf/linux.git
        git fetch --no-tags yu-chen-surf sis
        git checkout e59a4ccc3962b54c5488c142b073dcf9b85b5843
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c:918:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:918:34: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:918:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:11027:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11027:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11027:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:5053:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5053:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:5053:22: sparse:    struct task_struct *
   kernel/sched/fair.c:5834:1: sparse: sparse: symbol '__pcpu_scope_load_balance_mask' was not declared. Should it be static?
   kernel/sched/fair.c:5835:1: sparse: sparse: symbol '__pcpu_scope_select_idle_mask' was not declared. Should it be static?
   kernel/sched/fair.c:6817:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6817:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:6817:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6951:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6951:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:6951:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7149:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7149:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7149:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7447:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7447:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7447:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8432:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:8432:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:8432:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:8976:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:8976:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:8976:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10302:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10302:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10302:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:9962:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:9962:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:9962:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:10398:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10398:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10398:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:4693:31: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2169:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2169:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2169:9: sparse:    struct task_struct *
>> kernel/sched/fair.c:9317:19: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> kernel/sched/fair.c:9317:19: sparse:    int *
>> kernel/sched/fair.c:9317:19: sparse:    long *
   kernel/sched/sched.h:2011:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2011:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2011:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2011:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2011:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2011:25: sparse:    struct task_struct *

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
> 9317		nr_scan = max(0, nr_llc * y  / SCHED_CAPACITY_SCALE);
  9318		WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
  9319	}
  9320	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
