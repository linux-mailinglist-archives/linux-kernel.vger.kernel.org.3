Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4745140FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiD2DLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiD2DLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:11:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5842D8878B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651201672; x=1682737672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VN5ocenvhOYqVxCBuw26CS0MlC3YMxAvCJ4V4rznNdI=;
  b=SvyIWoGeuVj+smEejealhW6GWPVoikv05pDFxmDKZtjJ3JvNK4QioTrp
   2LSP5zsC0AhogElRVWWW3zE/ILK+rtmQh5Fah1O0JDj63w8nPWRLTCs9Y
   J+rtU52AKyxi7CRvgfMlhd/fK9y+y2gxRAt2xR4CxdBAy0/HJ4sNPOnuk
   XXGLkbLC2P/ldrxZ2HqYtNoRe+TMwTPSSux07gDM3XK13T+qlZTfQQSvw
   RqT5pBoVRgfA9Z3mocy31Ecjwa334eQ23VG1NrxD5Uoty4Jf9cHMZBuRi
   3JP/ANZDt9aadpl1e7TpRNTcdnV4/o3KIKNigMDes3sfQxaLk0x5x04fd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265359674"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="265359674"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 20:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="683863622"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2022 20:07:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkGyz-0005vZ-Le;
        Fri, 29 Apr 2022 03:07:49 +0000
Date:   Fri, 29 Apr 2022 11:07:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 3/7] include/linux/ptrace.h:220:4:
 error: call to undeclared function 'task_set_jobctl_pending'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <202204291101.AE4DJ2gY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   a1b437cfec0d2b0060cf85538c2379c74fb63ad5
commit: 4cb4f3dc01c45f8a1621f13b55705ba4a6844081 [3/7] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
config: s390-randconfig-r044-20220428 (https://download.01.org/0day-ci/archive/20220429/202204291101.AE4DJ2gY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4cb4f3dc01c45f8a1621f13b55705ba4a6844081
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 4cb4f3dc01c45f8a1621f13b55705ba4a6844081
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:160:
   include/linux/compat.h:425:10: warning: array index 7 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:425:42: warning: array index 6 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:425:53: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                                                              ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:14:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:160:
   include/linux/compat.h:427:22: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                               ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:14:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:160:
   include/linux/compat.h:427:10: warning: array index 5 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:427:42: warning: array index 4 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:427:53: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                                                              ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:14:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:160:
   include/linux/compat.h:429:22: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                               ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:14:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:160:
   include/linux/compat.h:429:10: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:429:42: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:429:53: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                                                              ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/ftrace.h:16:
>> include/linux/ptrace.h:220:4: error: call to undeclared function 'task_set_jobctl_pending'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           task_set_jobctl_pending(child, JOBCTL_TRAP_STOP);
                           ^
   include/linux/ptrace.h:220:4: note: did you mean 'task_clear_jobctl_pending'?
   include/linux/sched/jobctl.h:43:13: note: 'task_clear_jobctl_pending' declared here
   extern void task_clear_jobctl_pending(struct task_struct *task, unsigned long mask);
               ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:41:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:41:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:41:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   24 warnings and 5 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/task_set_jobctl_pending +220 include/linux/ptrace.h

4e52365f279564 Matthew Dempsky   2014-06-06  196  
09a05394fe2448 Roland McGrath    2008-07-25  197  /**
09a05394fe2448 Roland McGrath    2008-07-25  198   * ptrace_init_task - initialize ptrace state for a new child
09a05394fe2448 Roland McGrath    2008-07-25  199   * @child:		new child task
09a05394fe2448 Roland McGrath    2008-07-25  200   * @ptrace:		true if child should be ptrace'd by parent's tracer
09a05394fe2448 Roland McGrath    2008-07-25  201   *
09a05394fe2448 Roland McGrath    2008-07-25  202   * This is called immediately after adding @child to its parent's children
09a05394fe2448 Roland McGrath    2008-07-25  203   * list.  @ptrace is false in the normal case, and true to ptrace @child.
09a05394fe2448 Roland McGrath    2008-07-25  204   *
09a05394fe2448 Roland McGrath    2008-07-25  205   * Called with current's siglock and write_lock_irq(&tasklist_lock) held.
09a05394fe2448 Roland McGrath    2008-07-25  206   */
09a05394fe2448 Roland McGrath    2008-07-25  207  static inline void ptrace_init_task(struct task_struct *child, bool ptrace)
09a05394fe2448 Roland McGrath    2008-07-25  208  {
09a05394fe2448 Roland McGrath    2008-07-25  209  	INIT_LIST_HEAD(&child->ptrace_entry);
09a05394fe2448 Roland McGrath    2008-07-25  210  	INIT_LIST_HEAD(&child->ptraced);
6634ae1033ceae Oleg Nesterov     2011-07-08  211  	child->jobctl = 0;
09a05394fe2448 Roland McGrath    2008-07-25  212  	child->ptrace = 0;
6634ae1033ceae Oleg Nesterov     2011-07-08  213  	child->parent = child->real_parent;
6634ae1033ceae Oleg Nesterov     2011-07-08  214  
6634ae1033ceae Oleg Nesterov     2011-07-08  215  	if (unlikely(ptrace) && current->ptrace) {
09a05394fe2448 Roland McGrath    2008-07-25  216  		child->ptrace = current->ptrace;
c70d9d809fdeec Eric W. Biederman 2017-05-22  217  		__ptrace_link(child, current->parent, current->ptracer_cred);
dcace06cc29df9 Oleg Nesterov     2011-07-08  218  
d184d6eb1dc3c9 Oleg Nesterov     2011-07-08  219  		if (child->ptrace & PT_SEIZED)
d184d6eb1dc3c9 Oleg Nesterov     2011-07-08 @220  			task_set_jobctl_pending(child, JOBCTL_TRAP_STOP);
d184d6eb1dc3c9 Oleg Nesterov     2011-07-08  221  		else
dcace06cc29df9 Oleg Nesterov     2011-07-08  222  			sigaddset(&child->pending.signal, SIGSTOP);
09a05394fe2448 Roland McGrath    2008-07-25  223  	}
c70d9d809fdeec Eric W. Biederman 2017-05-22  224  	else
c70d9d809fdeec Eric W. Biederman 2017-05-22  225  		child->ptracer_cred = NULL;
09a05394fe2448 Roland McGrath    2008-07-25  226  }
09a05394fe2448 Roland McGrath    2008-07-25  227  

:::::: The code at line 220 was first introduced by commit
:::::: d184d6eb1dc3c9869e25a8e422be5c55ab0db4ac ptrace: dont send SIGSTOP on auto-attach if PT_SEIZED

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Oleg Nesterov <oleg@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
