Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0471B4E9CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiC1Qwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiC1Qwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:52:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014CA45AD8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648486251; x=1680022251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uggnpUWy5i36x9NAJpsVOkgq+ajINhriqPkhsivY5LQ=;
  b=NzLsBNv84nCM6RmT7ZGxjcMbETaCxe10hctxUjjLqKNEfnQsJbcSaKIr
   hqk2ERunGcBbvqix1i0tn1MORrL7U3yR9EWnDrSeolbDqjewYGDFFhDui
   +8P5tvsR26PDLz7RjWy3EW7NA6gzOohHPBHwk+MfUySbq7bP7Vxo3RJHQ
   I2wrDyp00DWL1aes5E3KN7zeci/8bZWTJz6mw6Z33WSvTznG42Epb4+4j
   0PG6MPCnk70aPSPt6M/VvZy0MAzBishdlDLKtKY15lYiJtYd+vjfuS0nS
   LowSfnc+kP7fNlgwhC1WQY2zgZgSfuZdBQ2pgNBngxSNyNlGxd9yIxBsj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258764817"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="258764817"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 09:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="518255950"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2022 09:50:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYsZs-0002Al-7c; Mon, 28 Mar 2022 16:50:48 +0000
Date:   Tue, 29 Mar 2022 00:50:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:for-next 11/14] kernel/irq/cpuhotplug.c:155:6:
 warning: no previous prototype for 'irq_migrate_all_off_this_cpu'
Message-ID: <202203290038.b6TKcGbv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
head:   d2d1f1e2e989e1f0369d6c991fec7cd3843979a3
commit: 1d02434051997d499ed9b4fe29fb2992f93f5345 [11/14] parisc: Implement __cpu_die() and __cpu_disable() for CPU hotplugging
config: parisc-randconfig-r004-20220327 (https://download.01.org/0day-ci/archive/20220329/202203290038.b6TKcGbv-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=1d02434051997d499ed9b4fe29fb2992f93f5345
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next
        git checkout 1d02434051997d499ed9b4fe29fb2992f93f5345
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc64 SHELL=/bin/bash kernel/irq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/irq/cpuhotplug.c:155:6: warning: no previous prototype for 'irq_migrate_all_off_this_cpu' [-Wmissing-prototypes]
     155 | void irq_migrate_all_off_this_cpu(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/limits.h:6,
                    from include/linux/kernel.h:16,
                    from include/linux/interrupt.h:6,
                    from kernel/irq/cpuhotplug.c:12:
>> include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
       8 | #define NULL ((void *)0)
         |                ^~~~
   include/linux/irq.h:620:41: note: in expansion of macro 'NULL'
     620 | # define irq_affinity_online_cpu        NULL
         |                                         ^~~~
   kernel/irq/cpuhotplug.c:218:5: note: in expansion of macro 'irq_affinity_online_cpu'
     218 | int irq_affinity_online_cpu(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:8:23: error: expected ')' before numeric constant
       8 | #define NULL ((void *)0)
         |                       ^
   include/linux/irq.h:620:41: note: in expansion of macro 'NULL'
     620 | # define irq_affinity_online_cpu        NULL
         |                                         ^~~~
   kernel/irq/cpuhotplug.c:218:5: note: in expansion of macro 'irq_affinity_online_cpu'
     218 | int irq_affinity_online_cpu(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/cpuhotplug.c:189:13: warning: 'irq_restore_affinity_of_irq' defined but not used [-Wunused-function]
     189 | static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/irq_migrate_all_off_this_cpu +155 kernel/irq/cpuhotplug.c

f1e0bb0ad473a3 Yang Yingliang  2015-09-24  144  
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  145  /**
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  146   * irq_migrate_all_off_this_cpu - Migrate irqs away from offline cpu
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  147   *
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  148   * The current CPU has been marked offline.  Migrate IRQs off this CPU.
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  149   * If the affinity settings do not allow other CPUs, force them onto any
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  150   * available CPU.
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  151   *
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  152   * Note: we must iterate over all IRQs, whether they have an attached
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  153   * action structure or not, as we need to get chained interrupts too.
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  154   */
f1e0bb0ad473a3 Yang Yingliang  2015-09-24 @155  void irq_migrate_all_off_this_cpu(void)
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  156  {
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  157  	struct irq_desc *desc;
0dd945ff4647a1 Thomas Gleixner 2017-06-20  158  	unsigned int irq;
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  159  
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  160  	for_each_active_irq(irq) {
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  161  		bool affinity_broken;
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  162  
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  163  		desc = irq_to_desc(irq);
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  164  		raw_spin_lock(&desc->lock);
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  165  		affinity_broken = migrate_one_irq(desc);
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  166  		raw_spin_unlock(&desc->lock);
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  167  
0dd945ff4647a1 Thomas Gleixner 2017-06-20  168  		if (affinity_broken) {
88ffe2d0a55a16 Lee Jones       2021-08-16  169  			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  170  					    irq, smp_processor_id());
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  171  		}
0dd945ff4647a1 Thomas Gleixner 2017-06-20  172  	}
f1e0bb0ad473a3 Yang Yingliang  2015-09-24  173  }
c5cb83bb337c25 Thomas Gleixner 2017-06-20  174  

:::::: The code at line 155 was first introduced by commit
:::::: f1e0bb0ad473a32d1b7e6d285ae9f7e47710bb5e genirq: Introduce generic irq migration for cpu hotunplug

:::::: TO: Yang Yingliang <yangyingliang@huawei.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
