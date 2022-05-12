Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF137524206
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiELBaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiELBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:30:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321E154B3F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652319000; x=1683855000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yBicI1ozOS+8JBXjAVPpem5ndTeksvMr59sNnu5jwNs=;
  b=X0XUOzKFr7zQq5ekpnptSmOSFseroBHlHnS3Nq3S7DSGGHfdv+5dfoNU
   r40zbOAfANoZHeddztUZ5tr8yH0yV9gpa0AlX+LQ4X7W396KsKjGMXnkh
   /I8Qvu5v7T6NZtgEyjGWzy/66MaX7WNPJwp8yzcsFlkE8kQi8pAvbF702
   vYqi3ILFJ4dDgLo3VcXCnoAW9GI7ow/f1B8/+JMOVxvx8AdoWuh7KSVvI
   XkfaUFmfs7mhMpRTmhqZk5f5pyf1FgxtNzqCKqJo00mz6GFX670IeX7Vy
   1Z08j7J4IE4fyTNYqWQaeaUZnTqg+Axjo+vhdVaPjvno7rMP6QFHjhv2R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295103650"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295103650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 18:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="658397468"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2022 18:29:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noxeQ-000Jmn-3Z;
        Thu, 12 May 2022 01:29:58 +0000
Date:   Thu, 12 May 2022 09:29:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [pdx86-platform-drivers-x86:review-hans 46/59]
 kernel/stop_machine.c:638:35: error: call to undeclared function
 'cpu_smt_mask'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202205120904.Gr9HEY5E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   57709a27d9744f5af4bbeec3ba3105c6aa1075eb
commit: 104355bf96bb985c40f8f8da43f70b935d59fb61 [46/59] stop_machine: Add stop_core_cpuslocked() for per-core operations
config: hexagon-randconfig-r045-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120904.Gr9HEY5E-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=104355bf96bb985c40f8f8da43f70b935d59fb61
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 104355bf96bb985c40f8f8da43f70b935d59fb61
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/stop_machine.c:638:35: error: call to undeclared function 'cpu_smt_mask'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           const struct cpumask *smt_mask = cpu_smt_mask(cpu);
                                            ^
   kernel/stop_machine.c:638:35: note: did you mean 'cpu_cpu_mask'?
   include/linux/topology.h:250:37: note: 'cpu_cpu_mask' declared here
   static inline const struct cpumask *cpu_cpu_mask(int cpu)
                                       ^
>> kernel/stop_machine.c:638:24: warning: incompatible integer to pointer conversion initializing 'const struct cpumask *' with an expression of type 'int' [-Wint-conversion]
           const struct cpumask *smt_mask = cpu_smt_mask(cpu);
                                 ^          ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/cpu_smt_mask +638 kernel/stop_machine.c

   635	
   636	int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
   637	{
 > 638		const struct cpumask *smt_mask = cpu_smt_mask(cpu);
   639	
   640		struct multi_stop_data msdata = {
   641			.fn = fn,
   642			.data = data,
   643			.num_threads = cpumask_weight(smt_mask),
   644			.active_cpus = smt_mask,
   645		};
   646	
   647		lockdep_assert_cpus_held();
   648	
   649		/* Set the initial state and stop all online cpus. */
   650		set_state(&msdata, MULTI_STOP_PREPARE);
   651		return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
   652	}
   653	EXPORT_SYMBOL_GPL(stop_core_cpuslocked);
   654	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
