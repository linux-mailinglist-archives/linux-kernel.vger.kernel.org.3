Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7695855407B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355782AbiFVCWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352458AbiFVCW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:22:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7639831220
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655864547; x=1687400547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vb3kG9iEZ7Sf4x3S4wYGxtdbTfP0E+bf9smFI2x1lR4=;
  b=l+tD/b+M0u2TnWmZcgRvTdEZ+6+/K41vVMZYoMvYssR/KckY16vjecd+
   eo2juDe/6BWnZBrWumocAglfM41VQmLQBgmefOGvk4cfpxFLeKxp6hxhd
   55JQgiTF6xNfXTutd5PQuinCWfrSwA0kh9gSiARz0jsqQYJX0/p90F9Mm
   RgFMMVX2e6kccIo8MQfVEdNfyHT7+fzAZzn7uD7zOfauUV7Z70GyUPBBZ
   G/dXUme/W5NhaupWQQeHReC0IJgDNIt0c14BsW6RYDlThIMmHZXXdZ0pu
   M9w1vdA71SZ0gwUjqJAew7cyIEhfQj+lj1UrqBrY+F59sR+hFecCfdNdT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260722895"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="260722895"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 19:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="764693973"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2022 19:22:25 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3q0e-0000ib-JW;
        Wed, 22 Jun 2022 02:22:24 +0000
Date:   Wed, 22 Jun 2022 10:22:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: include/linux/percpu-defs.h:317:1: warning: initialization of
 'struct cpumask *' from 'int' makes pointer from integer without a cast
Message-ID: <202206221013.ygryuYit-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
head:   2059fff7a5a2b6016ef5843c673845283a00a646
commit: a4a1ec79913664ac49b72cda8c3756c4da7c16b4 sched/fair: Rename select_idle_mask to select_rq_mask
date:   17 hours ago
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220622/202206221013.ygryuYit-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a4a1ec79913664ac49b72cda8c3756c4da7c16b4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
        git checkout a4a1ec79913664ac49b72cda8c3756c4da7c16b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/x86/include/asm/percpu.h:390,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/energy_model.h:5,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c: In function 'find_idlest_group':
   kernel/sched/fair.c:9246:81: error: 'select_idle_mask' undeclared (first use in this function); did you mean 'select_idle_cpu'?
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/cpumask.h:742:41: note: in expansion of macro 'this_cpu_read'
     742 | #define this_cpu_cpumask_var_ptr(x)     this_cpu_read(x)
         |                                         ^~~~~~~~~~~~~
   kernel/sched/fair.c:9246:56: note: in expansion of macro 'this_cpu_cpumask_var_ptr'
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:9246:81: note: each undeclared identifier is reported only once for each function it appears in
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/cpumask.h:742:41: note: in expansion of macro 'this_cpu_read'
     742 | #define this_cpu_cpumask_var_ptr(x)     this_cpu_read(x)
         |                                         ^~~~~~~~~~~~~
   kernel/sched/fair.c:9246:56: note: in expansion of macro 'this_cpu_cpumask_var_ptr'
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:317:1: warning: initialization of 'struct cpumask *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     317 | ({                                                                      \
         | ^
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
     507 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:742:41: note: in expansion of macro 'this_cpu_read'
     742 | #define this_cpu_cpumask_var_ptr(x)     this_cpu_read(x)
         |                                         ^~~~~~~~~~~~~
   kernel/sched/fair.c:9246:56: note: in expansion of macro 'this_cpu_cpumask_var_ptr'
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~


vim +317 include/linux/percpu-defs.h

a32f8d8eda8bd49 Tejun Heo 2014-06-17  315  
a32f8d8eda8bd49 Tejun Heo 2014-06-17  316  #define __pcpu_size_call_return(stem, variable)				\
eba117889ac444b Tejun Heo 2014-06-17 @317  ({									\
eba117889ac444b Tejun Heo 2014-06-17  318  	typeof(variable) pscr_ret__;					\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  319  	__verify_pcpu_ptr(&(variable));					\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  320  	switch(sizeof(variable)) {					\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  321  	case 1: pscr_ret__ = stem##1(variable); break;			\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  322  	case 2: pscr_ret__ = stem##2(variable); break;			\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  323  	case 4: pscr_ret__ = stem##4(variable); break;			\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  324  	case 8: pscr_ret__ = stem##8(variable); break;			\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  325  	default:							\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  326  		__bad_size_call_parameter(); break;			\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  327  	}								\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  328  	pscr_ret__;							\
a32f8d8eda8bd49 Tejun Heo 2014-06-17  329  })
a32f8d8eda8bd49 Tejun Heo 2014-06-17  330  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
