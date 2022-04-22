Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5950BD5E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449822AbiDVQrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449800AbiDVQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:46:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE53D5F8C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650645831; x=1682181831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iL7+aGwgJSlc39d1Ilbvm2KZhPW+6VwhKd3gr84pzSA=;
  b=ehTVYULEQBodQu4HBDmIwzcfR2L2k+ejl1hIbQ3yzg1O6gFR263/5S66
   h/M+XSkHbViIZYfNksd1gwtvJSHjyUXYqnHePbgil+3IbiG2c2mlL2u7w
   IpThUb5TxMDmEY0N3BBCCIJXJ1NAXQfeXvDM3IfYiyE7hK/Ot7xPaxKmm
   cScZydhtGQj7BAkANAqR4aJ3prNSl+DwtfRlzzssHLfxBgk/pxsIpSWKn
   7bVAQiqQkbXTg7KBgLPGt4NJmfUEWcmlUVX9a5aajDMloeSEOiSb6nSml
   Fsy7mhtiFqi49iTTnp1pfO3bW/+ulgcTlGY3EHhSUgM/zI33JCnf9K16h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289845481"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289845481"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="530926235"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2022 09:43:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhwNp-000ALg-8j;
        Fri, 22 Apr 2022 16:43:49 +0000
Date:   Sat, 23 Apr 2022 00:43:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2431/2579]
 include/asm-generic/percpu.h:147:9: error: implicit declaration of function
 'raw_local_irq_save'
Message-ID: <202204230044.O7aOPfOO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 518a4e5de1cbdbd028929db6ad968d6245b7e89a [2431/2579] headers/deps: rcu: Optimize <linux/rcupdate.h> dependencies
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220423/202204230044.O7aOPfOO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=518a4e5de1cbdbd028929db6ad968d6245b7e89a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 518a4e5de1cbdbd028929db6ad968d6245b7e89a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:393,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/preempt.h:10,
                    from include/linux/bottom_half.h:7,
                    from include/linux/rcupdate.h:26,
                    from include/linux/bpf.h:9,
                    from include/linux/bpf_verifier.h:7,
                    from net/ipv4/bpf_tcp_ca.c:6:
   include/linux/bpf.h: In function 'bpf_disable_instrumentation':
>> include/asm-generic/percpu.h:147:9: error: implicit declaration of function 'raw_local_irq_save' [-Werror=implicit-function-declaration]
     147 |         raw_local_irq_save(__flags);                                    \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:355:41: note: in expansion of macro 'this_cpu_generic_to_op'
     355 | #define this_cpu_add_8(pcp, val)        this_cpu_generic_to_op(pcp, val, +=)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:25: note: in expansion of macro 'this_cpu_add_8'
     380 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:509:41: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:41: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/linux/bpf.h:1446:9: note: in expansion of macro 'this_cpu_inc'
    1446 |         this_cpu_inc(bpf_prog_active);
         |         ^~~~~~~~~~~~
>> include/asm-generic/percpu.h:149:9: error: implicit declaration of function 'raw_local_irq_restore' [-Werror=implicit-function-declaration]
     149 |         raw_local_irq_restore(__flags);                                 \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:355:41: note: in expansion of macro 'this_cpu_generic_to_op'
     355 | #define this_cpu_add_8(pcp, val)        this_cpu_generic_to_op(pcp, val, +=)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:25: note: in expansion of macro 'this_cpu_add_8'
     380 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:509:41: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:41: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/linux/bpf.h:1446:9: note: in expansion of macro 'this_cpu_inc'
    1446 |         this_cpu_inc(bpf_prog_active);
         |         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/raw_local_irq_save +147 include/asm-generic/percpu.h

e88d62cd4b2f0b Mark Rutland    2017-09-26  143  
eba117889ac444 Tejun Heo       2014-06-17  144  #define this_cpu_generic_to_op(pcp, val, op)				\
9c28278a24c01c Tejun Heo       2014-06-17  145  do {									\
eba117889ac444 Tejun Heo       2014-06-17  146  	unsigned long __flags;						\
eba117889ac444 Tejun Heo       2014-06-17 @147  	raw_local_irq_save(__flags);					\
1b5ca12127427c Nicholas Piggin 2016-09-22  148  	raw_cpu_generic_to_op(pcp, val, op);				\
eba117889ac444 Tejun Heo       2014-06-17 @149  	raw_local_irq_restore(__flags);					\
9c28278a24c01c Tejun Heo       2014-06-17  150  } while (0)
9c28278a24c01c Tejun Heo       2014-06-17  151  
1b5ca12127427c Nicholas Piggin 2016-09-22  152  

:::::: The code at line 147 was first introduced by commit
:::::: eba117889ac444bea6e8270049cbaeed48169889 percpu: preffity percpu header files

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
