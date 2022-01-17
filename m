Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA584911AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiAQWTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:19:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:63018 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbiAQWTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642457992; x=1673993992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pcwn9sc6zy/5FPTqZEkOnm98mBAo/AMZfKVc4/nr3oM=;
  b=E02cHvLFryxdUsZBSkoRh1s3aNLN0Ob7Hz+5ZkGhvdDI95g0mkJ7yNJl
   QTGS73bUhMez/EpzsFQJD9HrWkSpYLSTYW/yy3Sz87OqMuyx24Y07k3NT
   0K66C5vL1yya19kEPLV3cY180MqdXJ1LPJMVK9QHY8emJsmpfei4QUruP
   y0mBU/ldmot/yW8LB+/fHM1EOp1MOobpaIuLjAVbt+bCL891ty/HfJ/0K
   sAmuaSOkV7TYf5Lan7LGDQSg6wr7JpnwEFDvVUwT9wGXEvV0df6EVVlzu
   bDQ73kc915o/VBZ/MPxlKnaMKFdzHM7SNuUCKtZYjb9cpFhhhs3gh5mI5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244657180"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244657180"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 14:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="693196191"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2022 14:19:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9aLt-000Bum-QF; Mon, 17 Jan 2022 22:19:49 +0000
Date:   Tue, 18 Jan 2022 06:18:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: arch/arc/kernel/smp.c:279:18: sparse: sparse: dereference of noderef
 expression
Message-ID: <202201180628.2dv8SAp3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c947b893d69231a9add855939da7c66237ab44f
commit: e188f3330a13df904d77003846eafd3edf99009d ARC: cmpxchg/xchg: rewrite as macros to make type safe
date:   5 months ago
config: arc-randconfig-s031-20220118 (https://download.01.org/0day-ci/archive/20220118/202201180628.2dv8SAp3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e188f3330a13df904d77003846eafd3edf99009d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e188f3330a13df904d77003846eafd3edf99009d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/kernel/

If you fix the issue, kindly add following tag as appropriate
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

41195d236e8445 Vineet Gupta    2013-01-18  261  
ddf84433f411b6 Vineet Gupta    2013-11-25  262  static void ipi_send_msg_one(int cpu, enum ipi_msg_type msg)
41195d236e8445 Vineet Gupta    2013-01-18  263  {
f2a4aa5646687f Vineet Gupta    2013-11-26  264  	unsigned long __percpu *ipi_data_ptr = per_cpu_ptr(&ipi_data, cpu);
d8e8c7dda11f5d Vineet Gupta    2013-11-28  265  	unsigned long old, new;
41195d236e8445 Vineet Gupta    2013-01-18  266  	unsigned long flags;
41195d236e8445 Vineet Gupta    2013-01-18  267  
f2a4aa5646687f Vineet Gupta    2013-11-26  268  	pr_debug("%d Sending msg [%d] to %d\n", smp_processor_id(), msg, cpu);
f2a4aa5646687f Vineet Gupta    2013-11-26  269  
41195d236e8445 Vineet Gupta    2013-01-18  270  	local_irq_save(flags);
41195d236e8445 Vineet Gupta    2013-01-18  271  
d8e8c7dda11f5d Vineet Gupta    2013-11-28  272  	/*
d8e8c7dda11f5d Vineet Gupta    2013-11-28  273  	 * Atomically write new msg bit (in case others are writing too),
d8e8c7dda11f5d Vineet Gupta    2013-11-28  274  	 * and read back old value
d8e8c7dda11f5d Vineet Gupta    2013-11-28  275  	 */
d8e8c7dda11f5d Vineet Gupta    2013-11-28  276  	do {
6aa7de059173a9 Mark Rutland    2017-10-23  277  		new = old = READ_ONCE(*ipi_data_ptr);
d8e8c7dda11f5d Vineet Gupta    2013-11-28  278  		new |= 1U << msg;
d8e8c7dda11f5d Vineet Gupta    2013-11-28 @279  	} while (cmpxchg(ipi_data_ptr, old, new) != old);
41195d236e8445 Vineet Gupta    2013-01-18  280  
d8e8c7dda11f5d Vineet Gupta    2013-11-28  281  	/*
d8e8c7dda11f5d Vineet Gupta    2013-11-28  282  	 * Call the platform specific IPI kick function, but avoid if possible:
d8e8c7dda11f5d Vineet Gupta    2013-11-28  283  	 * Only do so if there's no pending msg from other concurrent sender(s).
82a423053eb3cf Changcheng Deng 2021-08-14  284  	 * Otherwise, receiver will see this msg as well when it takes the
d8e8c7dda11f5d Vineet Gupta    2013-11-28  285  	 * IPI corresponding to that msg. This is true, even if it is already in
d8e8c7dda11f5d Vineet Gupta    2013-11-28  286  	 * IPI handler, because !@old means it has not yet dequeued the msg(s)
d8e8c7dda11f5d Vineet Gupta    2013-11-28  287  	 * so @new msg can be a free-loader
d8e8c7dda11f5d Vineet Gupta    2013-11-28  288  	 */
d8e8c7dda11f5d Vineet Gupta    2013-11-28  289  	if (plat_smp_ops.ipi_send && !old)
ddf84433f411b6 Vineet Gupta    2013-11-25  290  		plat_smp_ops.ipi_send(cpu);
41195d236e8445 Vineet Gupta    2013-01-18  291  
41195d236e8445 Vineet Gupta    2013-01-18  292  	local_irq_restore(flags);
41195d236e8445 Vineet Gupta    2013-01-18  293  }
41195d236e8445 Vineet Gupta    2013-01-18  294  

:::::: The code at line 279 was first introduced by commit
:::::: d8e8c7dda11f5d5cf90495f2e89d917a83509bc0 ARC: [SMP] optimize IPI send and receive

:::::: TO: Vineet Gupta <vgupta@synopsys.com>
:::::: CC: Vineet Gupta <vgupta@synopsys.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
