Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A955FFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiF2MUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiF2MUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:20:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B12B18A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656505199; x=1688041199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mrHipDU49psuWPBRRqhj53k0wes2BjmJ9RddHbseGRU=;
  b=hO2uIsvrMuGm5XDwAiUZEdMNIVWsYi5IV6d5F9ernZgQGHmiQY1FWmGk
   wIgMwjmG9s2CPDs1p+watB/VYx8JiJnttO/sOWMBmUSSztEJNcfBok0d2
   wM/76/kHyJR0faqe+UFVxRRtpHzxHCi/Koi/EIBkMd+pNg361jH5ctKr2
   jEOEY51N14BQeyyhzmYDhYLXWcPsoUzOBl/y2JHRKTfdkeK47VgUuynP8
   IZoDV6OZuxA/YyiGEA9ZnWB0MapDoXH8CAu5lRxhhagP0C44s5vd2EKle
   uReGxLu8Mtom2bghdze54VU1ZK63PKVNYtAHIUkNmnbUho47Srk1H5e7P
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="346007276"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="346007276"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 05:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="658534435"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2022 05:19:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Wfk-000BAo-PN;
        Wed, 29 Jun 2022 12:19:56 +0000
Date:   Wed, 29 Jun 2022 20:19:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: arch/arc/kernel/smp.c:279:18: sparse: sparse: dereference of noderef
 expression
Message-ID: <202206292022.SsCP1iGg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   941e3e7912696b9fbe3586083a7c2e102cee7a87
commit: e188f3330a13df904d77003846eafd3edf99009d ARC: cmpxchg/xchg: rewrite as macros to make type safe
date:   10 months ago
config: arc-randconfig-s031-20220629 (https://download.01.org/0day-ci/archive/20220629/202206292022.SsCP1iGg-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e188f3330a13df904d77003846eafd3edf99009d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e188f3330a13df904d77003846eafd3edf99009d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arc/kernel/smp.c:264:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __percpu *ipi_data_ptr @@     got unsigned long * @@
   arch/arc/kernel/smp.c:264:48: sparse:     expected unsigned long [noderef] __percpu *ipi_data_ptr
   arch/arc/kernel/smp.c:264:48: sparse:     got unsigned long *
   arch/arc/kernel/smp.c:279:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *v @@     got unsigned long [noderef] __percpu *__ai_ptr @@
   arch/arc/kernel/smp.c:279:18: sparse:     expected void const volatile *v
   arch/arc/kernel/smp.c:279:18: sparse:     got unsigned long [noderef] __percpu *__ai_ptr
   arch/arc/kernel/smp.c:277:29: sparse: sparse: cast removes address space '__percpu' of expression
   arch/arc/kernel/smp.c:413:72: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __percpu *percpu_dev_id @@     got int *dev @@
   arch/arc/kernel/smp.c:413:72: sparse:     expected void [noderef] __percpu *percpu_dev_id
   arch/arc/kernel/smp.c:413:72: sparse:     got int *dev
>> arch/arc/kernel/smp.c:279:18: sparse: sparse: dereference of noderef expression
>> arch/arc/kernel/smp.c:279:18: sparse: sparse: dereference of noderef expression

vim +279 arch/arc/kernel/smp.c

41195d236e84458 Vineet Gupta    2013-01-18  261  
ddf84433f411b61 Vineet Gupta    2013-11-25  262  static void ipi_send_msg_one(int cpu, enum ipi_msg_type msg)
41195d236e84458 Vineet Gupta    2013-01-18  263  {
f2a4aa5646687f9 Vineet Gupta    2013-11-26  264  	unsigned long __percpu *ipi_data_ptr = per_cpu_ptr(&ipi_data, cpu);
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  265  	unsigned long old, new;
41195d236e84458 Vineet Gupta    2013-01-18  266  	unsigned long flags;
41195d236e84458 Vineet Gupta    2013-01-18  267  
f2a4aa5646687f9 Vineet Gupta    2013-11-26  268  	pr_debug("%d Sending msg [%d] to %d\n", smp_processor_id(), msg, cpu);
f2a4aa5646687f9 Vineet Gupta    2013-11-26  269  
41195d236e84458 Vineet Gupta    2013-01-18  270  	local_irq_save(flags);
41195d236e84458 Vineet Gupta    2013-01-18  271  
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  272  	/*
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  273  	 * Atomically write new msg bit (in case others are writing too),
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  274  	 * and read back old value
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  275  	 */
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  276  	do {
6aa7de059173a98 Mark Rutland    2017-10-23  277  		new = old = READ_ONCE(*ipi_data_ptr);
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  278  		new |= 1U << msg;
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28 @279  	} while (cmpxchg(ipi_data_ptr, old, new) != old);
41195d236e84458 Vineet Gupta    2013-01-18  280  
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  281  	/*
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  282  	 * Call the platform specific IPI kick function, but avoid if possible:
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  283  	 * Only do so if there's no pending msg from other concurrent sender(s).
82a423053eb3cf2 Changcheng Deng 2021-08-14  284  	 * Otherwise, receiver will see this msg as well when it takes the
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  285  	 * IPI corresponding to that msg. This is true, even if it is already in
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  286  	 * IPI handler, because !@old means it has not yet dequeued the msg(s)
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  287  	 * so @new msg can be a free-loader
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  288  	 */
d8e8c7dda11f5d5 Vineet Gupta    2013-11-28  289  	if (plat_smp_ops.ipi_send && !old)
ddf84433f411b61 Vineet Gupta    2013-11-25  290  		plat_smp_ops.ipi_send(cpu);
41195d236e84458 Vineet Gupta    2013-01-18  291  
41195d236e84458 Vineet Gupta    2013-01-18  292  	local_irq_restore(flags);
41195d236e84458 Vineet Gupta    2013-01-18  293  }
41195d236e84458 Vineet Gupta    2013-01-18  294  

:::::: The code at line 279 was first introduced by commit
:::::: d8e8c7dda11f5d5cf90495f2e89d917a83509bc0 ARC: [SMP] optimize IPI send and receive

:::::: TO: Vineet Gupta <vgupta@synopsys.com>
:::::: CC: Vineet Gupta <vgupta@synopsys.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
