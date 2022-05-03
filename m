Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663C1519226
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbiECXL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiECXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:11:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519CE41F87
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651619270; x=1683155270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V1i4irFmQ1iN2yykVzH/8phpRIhOaaEOY6AQ+nGXhAc=;
  b=BgjjZt3yGxjDyEkVd/YKqp7Hba67MN7P79FD/r+S05kiuHXWsoTWs0mm
   0G5FfQcz1BQRAhxMlhLHc+r2hjU1Hdt1yVkRRattD0KBznmrwd48NDWX2
   7W3Mw6sLa0ATHAaWcK2ec42qV/nP0MsNMgmyTcVg+SPS38gJWciCRS3u5
   CBYUZ53aaVYjDAX6EYwqtB/HpkqlRWFVOPUbq5cSlAfNb/rFdK5e8WZw5
   wS2otsocZTm6tzoJ3Zy/WZLP5gIyZCmddMp/dTbrKnOoRSIu+QrK2buhp
   TZAXh0sa+pMa/VsIkgmzSYB2nH4dMLjzg/Owj2kJUTffbbc4vSxblpodA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249595783"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="249595783"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 16:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="599274812"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2022 16:07:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm1c9-000As7-7C;
        Tue, 03 May 2022 23:07:29 +0000
Date:   Wed, 4 May 2022 07:06:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 39/39] include/asm-generic/io.h:737:14: error:
 conflicting types for 'insb'; have 'void(long unsigned int,  void *,
 unsigned int)'
Message-ID: <202205040650.dKL9OmB4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport_v3
head:   45df38c1492340a5c06ff7ad2966735c1f5c4d94
commit: 45df38c1492340a5c06ff7ad2966735c1f5c4d94 [39/39] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220504/202205040650.dKL9OmB4-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=45df38c1492340a5c06ff7ad2966735c1f5c4d94
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout 45df38c1492340a5c06ff7ad2966735c1f5c4d94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:730: warning: "inb_p" redefined
     730 | #define inb_p inb
         | 
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io.h:823: note: this is the location of the previous definition
     823 | #define inb_p(port)             inb(port)
         | 
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:731: warning: "inw_p" redefined
     731 | #define inw_p inw
         | 
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io.h:825: note: this is the location of the previous definition
     825 | #define inw_p(port)             inw(port)
         | 
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:732: warning: "inl_p" redefined
     732 | #define inl_p inl
         | 
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io.h:827: note: this is the location of the previous definition
     827 | #define inl_p(port)             inl(port)
         | 
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:733: warning: "outb_p" redefined
     733 | #define outb_p outb
         | 
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io.h:824: note: this is the location of the previous definition
     824 | #define outb_p(val, port)       (udelay(1), outb((val), (port)))
         | 
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:734: warning: "outw_p" redefined
     734 | #define outw_p outw
         | 
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io.h:826: note: this is the location of the previous definition
     826 | #define outw_p(val, port)       (udelay(1), outw((val), (port)))
         | 
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:735: warning: "outl_p" redefined
     735 | #define outl_p outl
         | 
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io.h:828: note: this is the location of the previous definition
     828 | #define outl_p(val, port)       (udelay(1), outl((val), (port)))
         | 
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:737:14: error: conflicting types for 'insb'; have 'void(long unsigned int,  void *, unsigned int)'
     737 | #define insb insb
         |              ^~~~
   include/asm-generic/io.h:738:6: note: in expansion of macro 'insb'
     738 | void insb(unsigned long addr, void *buffer, unsigned int count)
         |      ^~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io-defs.h:43:18: note: previous definition of 'insb' with type 'void(long unsigned int,  void *, long unsigned int)'
      43 | DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
         |                  ^~~~
   arch/powerpc/include/asm/io.h:635:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     635 | static inline void name at                                      \
         |                    ^~~~
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:740:14: error: conflicting types for 'insw'; have 'void(long unsigned int,  void *, unsigned int)'
     740 | #define insw insw
         |              ^~~~
   include/asm-generic/io.h:741:6: note: in expansion of macro 'insw'
     741 | void insw(unsigned long addr, void *buffer, unsigned int count)
         |      ^~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io-defs.h:45:18: note: previous definition of 'insw' with type 'void(long unsigned int,  void *, long unsigned int)'
      45 | DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
         |                  ^~~~
   arch/powerpc/include/asm/io.h:635:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     635 | static inline void name at                                      \
         |                    ^~~~
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:743:14: error: conflicting types for 'insl'; have 'void(long unsigned int,  void *, unsigned int)'
     743 | #define insl insl
         |              ^~~~
   include/asm-generic/io.h:744:6: note: in expansion of macro 'insl'
     744 | void insl(unsigned long addr, void *buffer, unsigned int count)
         |      ^~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io-defs.h:47:18: note: previous definition of 'insl' with type 'void(long unsigned int,  void *, long unsigned int)'
      47 | DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
         |                  ^~~~
   arch/powerpc/include/asm/io.h:635:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     635 | static inline void name at                                      \
         |                    ^~~~
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:746:15: error: conflicting types for 'outsb'; have 'void(long unsigned int,  const void *, unsigned int)'
     746 | #define outsb outsb
         |               ^~~~~
   include/asm-generic/io.h:747:6: note: in expansion of macro 'outsb'
     747 | void outsb(unsigned long addr, const void *buffer, unsigned int count)
         |      ^~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io-defs.h:49:18: note: previous definition of 'outsb' with type 'void(long unsigned int,  const void *, long unsigned int)'
      49 | DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
         |                  ^~~~~
   arch/powerpc/include/asm/io.h:635:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     635 | static inline void name at                                      \
         |                    ^~~~
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:749:15: error: conflicting types for 'outsw'; have 'void(long unsigned int,  const void *, unsigned int)'
     749 | #define outsw outsw
         |               ^~~~~
   include/asm-generic/io.h:750:6: note: in expansion of macro 'outsw'
     750 | void outsw(unsigned long addr, const void *buffer, unsigned int count)
         |      ^~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io-defs.h:51:18: note: previous definition of 'outsw' with type 'void(long unsigned int,  const void *, long unsigned int)'
      51 | DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
         |                  ^~~~~
   arch/powerpc/include/asm/io.h:635:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     635 | static inline void name at                                      \
         |                    ^~~~
   In file included from arch/powerpc/include/asm/io.h:1027,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:752:15: error: conflicting types for 'outsl'; have 'void(long unsigned int,  const void *, unsigned int)'
     752 | #define outsl outsl
         |               ^~~~~
   include/asm-generic/io.h:753:6: note: in expansion of macro 'outsl'
     753 | void outsl(unsigned long addr, const void *buffer, unsigned int count)
         |      ^~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   arch/powerpc/include/asm/io-defs.h:53:18: note: previous definition of 'outsl' with type 'void(long unsigned int,  const void *, long unsigned int)'
      53 | DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
         |                  ^~~~~
   arch/powerpc/include/asm/io.h:635:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     635 | static inline void name at                                      \
         |                    ^~~~
   make[2]: *** [scripts/Makefile.build:120: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +737 include/asm-generic/io.h

   701	
   702	#ifndef outsl_p
   703	#define outsl_p outsl_p
   704	static inline void outsl_p(unsigned long addr, const void *buffer,
   705				   unsigned int count)
   706	{
   707		outsl(addr, buffer, count);
   708	}
   709	#endif
   710	#else /* CONFIG_HAS_IOPORT */
   711	#define inb inb
   712	u8 inb(unsigned long addr)
   713		__compiletime_error("inb()/inb_p() requires CONFIG_HAS_IOPORT");
   714	#define inw inw
   715	u16 inw(unsigned long addr)
   716		__compiletime_error("inw()/inw_p() requires CONFIG_HAS_IOPORT");
   717	#define inl inl
   718	u32 inl(unsigned long addr)
   719		__compiletime_error("inl()/inl_p() requires CONFIG_HAS_IOPORT");
   720	#define outb outb
   721	void outb(u8 value, unsigned long addr)
   722		__compiletime_error("outb()/outb_p() requires CONFIG_HAS_IOPORT");
   723	#define outw outw
   724	void outw(u16 value, unsigned long addr)
   725		__compiletime_error("outw()/outw_p() requires CONFIG_HAS_IOPORT");
   726	#define outl outl
   727	void outl(u32 value, unsigned long addr)
   728		__compiletime_error("outl()/outl_p() requires CONFIG_HAS_IOPORT");
   729	
 > 730	#define inb_p inb
 > 731	#define inw_p inw
 > 732	#define inl_p inl
 > 733	#define outb_p outb
 > 734	#define outw_p outw
 > 735	#define outl_p outl
   736	
 > 737	#define insb insb
   738	void insb(unsigned long addr, void *buffer, unsigned int count)
   739		__compiletime_error("insb()/insb_p() requires CONFIG_HAS_IOPORT");
 > 740	#define insw insw
   741	void insw(unsigned long addr, void *buffer, unsigned int count)
   742		__compiletime_error("insw()/insw_p() requires CONFIG_HAS_IOPORT");
 > 743	#define insl insl
   744	void insl(unsigned long addr, void *buffer, unsigned int count)
   745		__compiletime_error("insl()/insl_p() requires CONFIG_HAS_IOPORT");
 > 746	#define outsb outsb
   747	void outsb(unsigned long addr, const void *buffer, unsigned int count)
   748		__compiletime_error("outsb()/outsb_p() requires CONFIG_HAS_IOPORT");
 > 749	#define outsw outsw
   750	void outsw(unsigned long addr, const void *buffer, unsigned int count)
   751		__compiletime_error("outsw()/outsw_p() requires CONFIG_HAS_IOPORT");
 > 752	#define outsl outsl
   753	void outsl(unsigned long addr, const void *buffer, unsigned int count)
   754		__compiletime_error("outsl()/outsl_p() requires CONFIG_HAS_IOPORT");
   755	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
