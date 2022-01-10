Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07011489A39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiAJNoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:44:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:13332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbiAJNoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641822241; x=1673358241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ynoYZyK0TpFLkgNw8QEmZ5Yrt0U51SATxebbB80K5sw=;
  b=nAkXsdm3wrDRjYj+C8gt4CLC+DhWh+LORxR1ANKTAWpMJULc1buHuHJA
   ljWOhVUlaZ1bMKjZlYX6XFfY8BtdqHPCOKCkCqxvnYF4AsZWYPeGC7o70
   9+hOglr8q6RiNxD76s0HeFTpp1xpscHkJoF8zC4UXWSCjjroiL+VnTVPH
   PKw0IR249/C5WatA6uvGmvt1W0AxrHJbOxerFnjPI6JwBJOsbQRoxPVxC
   opGRPeqfcGKYv1w6oMfkxIlb4ks3XOZR3rDKb7q27+AqLGtY+zxFIJkBd
   2gfq0TWAHG/V8zCu5xlycxDRgiZT9l+w2US6lvk+QoQjCS+juRS4AmRLw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="240776835"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="240776835"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 05:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="474131630"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Jan 2022 05:43:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6uxq-0003YV-3g; Mon, 10 Jan 2022 13:43:58 +0000
Date:   Mon, 10 Jan 2022 21:43:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2055/2375] arch/mips/sibyte/sb1250/irq.c:76:29:
 error: invalid use of undefined type 'struct irq_data'
Message-ID: <202201102119.iZr8M5Ui-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   391ce485ced0e47bf8d2ce8bc32bb87887e16656
commit: 78e95e8ad607924f6b933eedfb11d434e964e7d7 [2055/2375] headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/hardirq.h>
config: mips-randconfig-r015-20220109 (https://download.01.org/0day-ci/archive/20220110/202201102119.iZr8M5Ui-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=78e95e8ad607924f6b933eedfb11d434e964e7d7
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 78e95e8ad607924f6b933eedfb11d434e964e7d7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/sibyte/sb1250/irq.c:72:39: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
      72 | static int sb1250_set_affinity(struct irq_data *d, const struct cpumask *mask,
         |                                       ^~~~~~~~
   arch/mips/sibyte/sb1250/irq.c: In function 'sb1250_set_affinity':
>> arch/mips/sibyte/sb1250/irq.c:76:29: error: invalid use of undefined type 'struct irq_data'
      76 |         unsigned int irq = d->irq;
         |                             ^~
   arch/mips/sibyte/sb1250/irq.c: At top level:
   arch/mips/sibyte/sb1250/irq.c:114:39: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
     114 | static void disable_sb1250_irq(struct irq_data *d)
         |                                       ^~~~~~~~
   arch/mips/sibyte/sb1250/irq.c: In function 'disable_sb1250_irq':
   arch/mips/sibyte/sb1250/irq.c:116:29: error: invalid use of undefined type 'struct irq_data'
     116 |         unsigned int irq = d->irq;
         |                             ^~
   arch/mips/sibyte/sb1250/irq.c: At top level:
   arch/mips/sibyte/sb1250/irq.c:121:38: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
     121 | static void enable_sb1250_irq(struct irq_data *d)
         |                                      ^~~~~~~~
   arch/mips/sibyte/sb1250/irq.c: In function 'enable_sb1250_irq':
   arch/mips/sibyte/sb1250/irq.c:123:29: error: invalid use of undefined type 'struct irq_data'
     123 |         unsigned int irq = d->irq;
         |                             ^~
   arch/mips/sibyte/sb1250/irq.c: At top level:
   arch/mips/sibyte/sb1250/irq.c:129:35: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
     129 | static void ack_sb1250_irq(struct irq_data *d)
         |                                   ^~~~~~~~
   arch/mips/sibyte/sb1250/irq.c: In function 'ack_sb1250_irq':
   arch/mips/sibyte/sb1250/irq.c:131:29: error: invalid use of undefined type 'struct irq_data'
     131 |         unsigned int irq = d->irq;
         |                             ^~
   arch/mips/sibyte/sb1250/irq.c: At top level:
>> arch/mips/sibyte/sb1250/irq.c:174:15: error: variable 'sb1250_irq_type' has initializer but incomplete type
     174 | static struct irq_chip sb1250_irq_type = {
         |               ^~~~~~~~
>> arch/mips/sibyte/sb1250/irq.c:175:10: error: 'struct irq_chip' has no member named 'name'
     175 |         .name = "SB1250-IMR",
         |          ^~~~
   arch/mips/sibyte/sb1250/irq.c:175:17: warning: excess elements in struct initializer
     175 |         .name = "SB1250-IMR",
         |                 ^~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:175:17: note: (near initialization for 'sb1250_irq_type')
>> arch/mips/sibyte/sb1250/irq.c:176:10: error: 'struct irq_chip' has no member named 'irq_mask_ack'
     176 |         .irq_mask_ack = ack_sb1250_irq,
         |          ^~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:176:25: warning: excess elements in struct initializer
     176 |         .irq_mask_ack = ack_sb1250_irq,
         |                         ^~~~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:176:25: note: (near initialization for 'sb1250_irq_type')
>> arch/mips/sibyte/sb1250/irq.c:177:10: error: 'struct irq_chip' has no member named 'irq_unmask'
     177 |         .irq_unmask = enable_sb1250_irq,
         |          ^~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:177:23: warning: excess elements in struct initializer
     177 |         .irq_unmask = enable_sb1250_irq,
         |                       ^~~~~~~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:177:23: note: (near initialization for 'sb1250_irq_type')
>> arch/mips/sibyte/sb1250/irq.c:178:10: error: 'struct irq_chip' has no member named 'irq_mask'
     178 |         .irq_mask = disable_sb1250_irq,
         |          ^~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:178:21: warning: excess elements in struct initializer
     178 |         .irq_mask = disable_sb1250_irq,
         |                     ^~~~~~~~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:178:21: note: (near initialization for 'sb1250_irq_type')
>> arch/mips/sibyte/sb1250/irq.c:180:10: error: 'struct irq_chip' has no member named 'irq_set_affinity'
     180 |         .irq_set_affinity = sb1250_set_affinity
         |          ^~~~~~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:180:29: warning: excess elements in struct initializer
     180 |         .irq_set_affinity = sb1250_set_affinity
         |                             ^~~~~~~~~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:180:29: note: (near initialization for 'sb1250_irq_type')
   arch/mips/sibyte/sb1250/irq.c:184:13: warning: no previous prototype for 'init_sb1250_irqs' [-Wmissing-prototypes]
     184 | void __init init_sb1250_irqs(void)
         |             ^~~~~~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c: In function 'init_sb1250_irqs':
>> arch/mips/sibyte/sb1250/irq.c:189:17: error: implicit declaration of function 'irq_set_chip_and_handler' [-Werror=implicit-function-declaration]
     189 |                 irq_set_chip_and_handler(i, &sb1250_irq_type,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/sibyte/sb1250/irq.c:190:42: error: 'handle_level_irq' undeclared (first use in this function)
     190 |                                          handle_level_irq);
         |                                          ^~~~~~~~~~~~~~~~
   arch/mips/sibyte/sb1250/irq.c:190:42: note: each undeclared identifier is reported only once for each function it appears in
   arch/mips/sibyte/sb1250/irq.c: At top level:
>> arch/mips/sibyte/sb1250/irq.c:174:24: error: storage size of 'sb1250_irq_type' isn't known
     174 | static struct irq_chip sb1250_irq_type = {
         |                        ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +76 arch/mips/sibyte/sb1250/irq.c

^1da177e4c3f41 Linus Torvalds    2005-04-16   70  
^1da177e4c3f41 Linus Torvalds    2005-04-16   71  #ifdef CONFIG_SMP
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23   72  static int sb1250_set_affinity(struct irq_data *d, const struct cpumask *mask,
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23   73  			       bool force)
^1da177e4c3f41 Linus Torvalds    2005-04-16   74  {
^1da177e4c3f41 Linus Torvalds    2005-04-16   75  	int i = 0, old_cpu, cpu, int_on;
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  @76  	unsigned int irq = d->irq;
^1da177e4c3f41 Linus Torvalds    2005-04-16   77  	u64 cur_ints;
^1da177e4c3f41 Linus Torvalds    2005-04-16   78  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds    2005-04-16   79  
421d1563c66204 Thomas Gleixner   2014-03-04   80  	i = cpumask_first_and(mask, cpu_online_mask);
^1da177e4c3f41 Linus Torvalds    2005-04-16   81  
^1da177e4c3f41 Linus Torvalds    2005-04-16   82  	/* Convert logical CPU to physical CPU */
^1da177e4c3f41 Linus Torvalds    2005-04-16   83  	cpu = cpu_logical_map(i);
^1da177e4c3f41 Linus Torvalds    2005-04-16   84  
^1da177e4c3f41 Linus Torvalds    2005-04-16   85  	/* Protect against other affinity changers and IMR manipulation */
5772f6deb6214a Ralf Baechle      2010-02-27   86  	raw_spin_lock_irqsave(&sb1250_imr_lock, flags);
^1da177e4c3f41 Linus Torvalds    2005-04-16   87  
^1da177e4c3f41 Linus Torvalds    2005-04-16   88  	/* Swizzle each CPU's IMR (but leave the IP selection alone) */
^1da177e4c3f41 Linus Torvalds    2005-04-16   89  	old_cpu = sb1250_irq_owner[irq];
65bda1a95d395c Maciej W. Rozycki 2005-02-22   90  	cur_ints = ____raw_readq(IOADDR(A_IMR_MAPPER(old_cpu) +
^1da177e4c3f41 Linus Torvalds    2005-04-16   91  					R_IMR_INTERRUPT_MASK));
^1da177e4c3f41 Linus Torvalds    2005-04-16   92  	int_on = !(cur_ints & (((u64) 1) << irq));
^1da177e4c3f41 Linus Torvalds    2005-04-16   93  	if (int_on) {
^1da177e4c3f41 Linus Torvalds    2005-04-16   94  		/* If it was on, mask it */
^1da177e4c3f41 Linus Torvalds    2005-04-16   95  		cur_ints |= (((u64) 1) << irq);
65bda1a95d395c Maciej W. Rozycki 2005-02-22   96  		____raw_writeq(cur_ints, IOADDR(A_IMR_MAPPER(old_cpu) +
^1da177e4c3f41 Linus Torvalds    2005-04-16   97  					R_IMR_INTERRUPT_MASK));
^1da177e4c3f41 Linus Torvalds    2005-04-16   98  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16   99  	sb1250_irq_owner[irq] = cpu;
^1da177e4c3f41 Linus Torvalds    2005-04-16  100  	if (int_on) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  101  		/* unmask for the new CPU */
65bda1a95d395c Maciej W. Rozycki 2005-02-22  102  		cur_ints = ____raw_readq(IOADDR(A_IMR_MAPPER(cpu) +
^1da177e4c3f41 Linus Torvalds    2005-04-16  103  					R_IMR_INTERRUPT_MASK));
^1da177e4c3f41 Linus Torvalds    2005-04-16  104  		cur_ints &= ~(((u64) 1) << irq);
65bda1a95d395c Maciej W. Rozycki 2005-02-22  105  		____raw_writeq(cur_ints, IOADDR(A_IMR_MAPPER(cpu) +
^1da177e4c3f41 Linus Torvalds    2005-04-16  106  					R_IMR_INTERRUPT_MASK));
^1da177e4c3f41 Linus Torvalds    2005-04-16  107  	}
5772f6deb6214a Ralf Baechle      2010-02-27  108  	raw_spin_unlock_irqrestore(&sb1250_imr_lock, flags);
d5dedd4507d307 Yinghai Lu        2009-04-27  109  
d5dedd4507d307 Yinghai Lu        2009-04-27  110  	return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  111  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  112  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  113  
1544129da2de9f Thomas Gleixner   2011-06-06  114  static void disable_sb1250_irq(struct irq_data *d)
1544129da2de9f Thomas Gleixner   2011-06-06  115  {
1544129da2de9f Thomas Gleixner   2011-06-06  116  	unsigned int irq = d->irq;
1544129da2de9f Thomas Gleixner   2011-06-06  117  
1544129da2de9f Thomas Gleixner   2011-06-06  118  	sb1250_mask_irq(sb1250_irq_owner[irq], irq);
1544129da2de9f Thomas Gleixner   2011-06-06  119  }
1544129da2de9f Thomas Gleixner   2011-06-06  120  
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  121  static void enable_sb1250_irq(struct irq_data *d)
^1da177e4c3f41 Linus Torvalds    2005-04-16  122  {
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  123  	unsigned int irq = d->irq;
^1da177e4c3f41 Linus Torvalds    2005-04-16  124  
^1da177e4c3f41 Linus Torvalds    2005-04-16  125  	sb1250_unmask_irq(sb1250_irq_owner[irq], irq);
^1da177e4c3f41 Linus Torvalds    2005-04-16  126  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  127  
^1da177e4c3f41 Linus Torvalds    2005-04-16  128  
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  129  static void ack_sb1250_irq(struct irq_data *d)
^1da177e4c3f41 Linus Torvalds    2005-04-16  130  {
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  131  	unsigned int irq = d->irq;
^1da177e4c3f41 Linus Torvalds    2005-04-16  132  #ifdef CONFIG_SIBYTE_HAS_LDT
^1da177e4c3f41 Linus Torvalds    2005-04-16  133  	u64 pending;
^1da177e4c3f41 Linus Torvalds    2005-04-16  134  
^1da177e4c3f41 Linus Torvalds    2005-04-16  135  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  136  	 * If the interrupt was an HT interrupt, now is the time to
^1da177e4c3f41 Linus Torvalds    2005-04-16  137  	 * clear it.  NOTE: we assume the HT bridge was set up to
^1da177e4c3f41 Linus Torvalds    2005-04-16  138  	 * deliver the interrupts to all CPUs (which makes affinity
^1da177e4c3f41 Linus Torvalds    2005-04-16  139  	 * changing easier for us)
^1da177e4c3f41 Linus Torvalds    2005-04-16  140  	 */
65bda1a95d395c Maciej W. Rozycki 2005-02-22  141  	pending = __raw_readq(IOADDR(A_IMR_REGISTER(sb1250_irq_owner[irq],
^1da177e4c3f41 Linus Torvalds    2005-04-16  142  						    R_IMR_LDT_INTERRUPT)));
^1da177e4c3f41 Linus Torvalds    2005-04-16  143  	pending &= ((u64)1 << (irq));
^1da177e4c3f41 Linus Torvalds    2005-04-16  144  	if (pending) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  145  		int i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  146  		for (i=0; i<NR_CPUS; i++) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  147  			int cpu;
^1da177e4c3f41 Linus Torvalds    2005-04-16  148  #ifdef CONFIG_SMP
^1da177e4c3f41 Linus Torvalds    2005-04-16  149  			cpu = cpu_logical_map(i);
^1da177e4c3f41 Linus Torvalds    2005-04-16  150  #else
^1da177e4c3f41 Linus Torvalds    2005-04-16  151  			cpu = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  152  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  153  			/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  154  			 * Clear for all CPUs so an affinity switch
^1da177e4c3f41 Linus Torvalds    2005-04-16  155  			 * doesn't find an old status
^1da177e4c3f41 Linus Torvalds    2005-04-16  156  			 */
65bda1a95d395c Maciej W. Rozycki 2005-02-22  157  			__raw_writeq(pending,
^1da177e4c3f41 Linus Torvalds    2005-04-16  158  				     IOADDR(A_IMR_REGISTER(cpu,
^1da177e4c3f41 Linus Torvalds    2005-04-16  159  						R_IMR_LDT_INTERRUPT_CLR)));
^1da177e4c3f41 Linus Torvalds    2005-04-16  160  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  161  
^1da177e4c3f41 Linus Torvalds    2005-04-16  162  		/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  163  		 * Generate EOI.  For Pass 1 parts, EOI is a nop.  For
^1da177e4c3f41 Linus Torvalds    2005-04-16  164  		 * Pass 2, the LDT world may be edge-triggered, but
^1da177e4c3f41 Linus Torvalds    2005-04-16  165  		 * this EOI shouldn't hurt.  If they are
^1da177e4c3f41 Linus Torvalds    2005-04-16  166  		 * level-sensitive, the EOI is required.
^1da177e4c3f41 Linus Torvalds    2005-04-16  167  		 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  168  		*(uint32_t *)(ldt_eoi_space+(irq<<16)+(7<<2)) = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  169  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  170  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  171  	sb1250_mask_irq(sb1250_irq_owner[irq], irq);
^1da177e4c3f41 Linus Torvalds    2005-04-16  172  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  173  
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23 @174  static struct irq_chip sb1250_irq_type = {
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23 @175  	.name = "SB1250-IMR",
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23 @176  	.irq_mask_ack = ack_sb1250_irq,
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23 @177  	.irq_unmask = enable_sb1250_irq,
1544129da2de9f Thomas Gleixner   2011-06-06 @178  	.irq_mask = disable_sb1250_irq,
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  179  #ifdef CONFIG_SMP
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23 @180  	.irq_set_affinity = sb1250_set_affinity
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  181  #endif
d6d5d5c4afd4c8 Thomas Gleixner   2011-03-23  182  };
^1da177e4c3f41 Linus Torvalds    2005-04-16  183  
^1da177e4c3f41 Linus Torvalds    2005-04-16  184  void __init init_sb1250_irqs(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16  185  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  186  	int i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  187  
1603b5aca4f15b Atsushi Nemoto    2006-11-02  188  	for (i = 0; i < SB1250_NR_IRQS; i++) {
e4ec7989b4e55d Thomas Gleixner   2011-03-27 @189  		irq_set_chip_and_handler(i, &sb1250_irq_type,
e4ec7989b4e55d Thomas Gleixner   2011-03-27 @190  					 handle_level_irq);
^1da177e4c3f41 Linus Torvalds    2005-04-16  191  		sb1250_irq_owner[i] = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  192  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  193  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  194  

:::::: The code at line 76 was first introduced by commit
:::::: d6d5d5c4afd4c8bb4c5e3753a2141e9c3a874629 MIPS: Sibyte: Convert to new irq_chip functions

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
