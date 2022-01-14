Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8F48E433
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiANGXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:23:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:29078 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236448AbiANGXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642141410; x=1673677410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m0AWWWDQUV25Fjtcsh/VsL/SXRQ4f3gZqeS5Ci0O2eg=;
  b=VyFj/uMhleiwnuKDho3uYmS3xXtFQU00fu/y8OCbIGpz9ZCJH+RnVOLq
   azZvVh6kqBucECwdLGKKXPd6thFCv54jCy16JRGc60ESFDiOc6A/WrpwE
   CMmLeKOp5/h3bGSwP+fxv4idAvSYwAjFahT/0gNcBVWmSOIIwDG0AiToA
   v+ZqhYMp6I9K+6ErOYieE7tKNYHLBa1yyyi2n9G8NlnJj/MqsSZFPGLEm
   iPsFPEsfzWFmTzdqcTgFaX3AAzSYkfKkX0OKhPqVObWlAo+BsqJK9cS8m
   8L3PvSQHvziT/BoVWTFUXkhljOK1GswnWBUmqUh8QXctz2SwUcdVEMq8h
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="268554928"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="268554928"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 22:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="516240365"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2022 22:23:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Fzj-0008C3-O9; Fri, 14 Jan 2022 06:23:27 +0000
Date:   Fri, 14 Jan 2022 14:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 25/28] drivers/tty/mxser.c:1745:30: warning: unused
 variable 'mxser_ops'
Message-ID: <202201141428.PLNSXkwB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   54c28df496f290b0dfbb55d569ce5ddf8cafc4be
commit: 6f7621dd2f7f908ab9ca6882cebf663d4aac4e3e [25/28] mxser: switch to uart_driver
config: arm-randconfig-c002-20220111 (https://download.01.org/0day-ci/archive/20220114/202201141428.PLNSXkwB-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=6f7621dd2f7f908ab9ca6882cebf663d4aac4e3e
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 6f7621dd2f7f908ab9ca6882cebf663d4aac4e3e
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/mxser.c:1745:30: warning: unused variable 'mxser_ops' [-Wunused-const-variable]
   static const struct uart_ops mxser_ops = {
                                ^
   1 warning generated.


clang-analyzer warnings: (new ones prefixed by >>)
   9 warnings generated.
   Suppressed 9 warnings (4 in non-user code, 5 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   kernel/sched/deadline.c:1534:22: warning: Value stored to 'p' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct task_struct *p = dl_task_of(dl_se);
                               ^   ~~~~~~~~~~~~~~~~~
   kernel/sched/deadline.c:1534:22: note: Value stored to 'p' during its initialization is never read
           struct task_struct *p = dl_task_of(dl_se);
                               ^   ~~~~~~~~~~~~~~~~~
   Suppressed 6 warnings (4 in non-user code, 2 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   Suppressed 4 warnings (4 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   Suppressed 4 warnings (4 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   drivers/iio/adc/ltc2497.c:18:8: warning: Excessive padding in 'struct ltc2497_driverdata' (32 padding bytes, where 0 is optimal). 
   Optimal fields order: 
   buf, 
   client, 
   common_ddata, 
   consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ltc2497_driverdata {
   ~~~~~~~^~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ltc2497.c:18:8: note: Excessive padding in 'struct ltc2497_driverdata' (32 padding bytes, where 0 is optimal). Optimal fields order: buf, client, common_ddata, consider reordering the fields or adding explicit padding members
   struct ltc2497_driverdata {
   ~~~~~~~^~~~~~~~~~~~~~~~~~~~
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   8 warnings generated.
   drivers/w1/w1.c:589:3: warning: Value stored to 'event_owner' is never read [clang-analyzer-deadcode.DeadStores]
                   event_owner = "master";
                   ^             ~~~~~~~~
   drivers/w1/w1.c:589:3: note: Value stored to 'event_owner' is never read
                   event_owner = "master";
                   ^             ~~~~~~~~
   drivers/w1/w1.c:590:3: warning: Value stored to 'name' is never read [clang-analyzer-deadcode.DeadStores]
                   name = md->name;
                   ^      ~~~~~~~~
   drivers/w1/w1.c:590:3: note: Value stored to 'name' is never read
                   name = md->name;
                   ^      ~~~~~~~~
   drivers/w1/w1.c:593:3: warning: Value stored to 'event_owner' is never read [clang-analyzer-deadcode.DeadStores]
                   event_owner = "slave";
                   ^             ~~~~~~~
   drivers/w1/w1.c:593:3: note: Value stored to 'event_owner' is never read
                   event_owner = "slave";
                   ^             ~~~~~~~
   drivers/w1/w1.c:594:3: warning: Value stored to 'name' is never read [clang-analyzer-deadcode.DeadStores]
                   name = sl->name;
                   ^      ~~~~~~~~
   drivers/w1/w1.c:594:3: note: Value stored to 'name' is never read
                   name = sl->name;
                   ^      ~~~~~~~~
   drivers/w1/w1.c:997:2: warning: Value stored to 'search_bit' is never read [clang-analyzer-deadcode.DeadStores]
           search_bit = 0;
           ^            ~
   drivers/w1/w1.c:997:2: note: Value stored to 'search_bit' is never read
           search_bit = 0;
           ^            ~
   drivers/w1/w1.c:999:2: warning: Value stored to 'last_rn' is never read [clang-analyzer-deadcode.DeadStores]
           last_rn = 0;
           ^         ~
   drivers/w1/w1.c:999:2: note: Value stored to 'last_rn' is never read
           last_rn = 0;
           ^         ~
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   drivers/tty/mxser.c:396:7: warning: Although the value stored to 'hwid' is used in the enclosing expression, the value is never actually read from 'hwid' [clang-analyzer-deadcode.DeadStores]
           if ((hwid = inb(io + UART_MCR)) != 0) {
                ^
   drivers/tty/mxser.c:396:7: note: Although the value stored to 'hwid' is used in the enclosing expression, the value is never actually read from 'hwid'
>> drivers/tty/mxser.c:1693:4: warning: Value stored to 'int_cnt' is never read [clang-analyzer-deadcode.DeadStores]
                           int_cnt = 0;
                           ^         ~
   drivers/tty/mxser.c:1693:4: note: Value stored to 'int_cnt' is never read
                           int_cnt = 0;
                           ^         ~
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   drivers/iio/adc/qcom-spmi-vadc.c:326:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
                   ret = vadc_poll_wait_eoc(vadc, timeout);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/qcom-spmi-vadc.c:326:3: note: Value stored to 'ret' is never read
                   ret = vadc_poll_wait_eoc(vadc, timeout);
                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   sound/isa/gus/interwave.c:686:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(wss->pcm->name, " (codec)");
           ^~~~~~
   sound/isa/gus/interwave.c:686:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(wss->pcm->name, " (codec)");
           ^~~~~~
   sound/isa/gus/interwave.c:740:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(card->driver, str);
           ^~~~~~
   sound/isa/gus/interwave.c:740:2: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
           strcpy(card->driver, str);
           ^~~~~~
   sound/isa/gus/interwave.c:741:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(card->shortname, str);
--
           if (unlikely(__ret_warn_on))                                    \
           ^
   drivers/nvme/host/fc.c:540:2: note: Memory is released
           kfree(rport);
           ^~~~~~~~~~~~
   include/linux/kref.h:65:3: note: Returning; memory was released
                   release(kref);
                   ^~~~~~~~~~~~~
   drivers/nvme/host/fc.c:548:2: note: Returning; memory was released
           kref_put(&rport->ref, nvme_fc_free_rport);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/fc.c:3826:3: note: Returning; memory was released
                   nvme_fc_rport_put(rport);
                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/fc.c:3829:3: note: Loop condition is false.  Exiting loop
                   spin_lock_irqsave(&nvme_fc_lock, flags);
                   ^
   include/linux/spinlock.h:384:2: note: expanded from macro 'spin_lock_irqsave'
           raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
           ^
   include/linux/spinlock.h:240:2: note: expanded from macro 'raw_spin_lock_irqsave'
           do {                                            \
           ^
   drivers/nvme/host/fc.c:3829:3: note: Loop condition is false.  Exiting loop
                   spin_lock_irqsave(&nvme_fc_lock, flags);
                   ^
   include/linux/spinlock.h:382:43: note: expanded from macro 'spin_lock_irqsave'
   #define spin_lock_irqsave(lock, flags)                          \
                                                                   ^
   drivers/nvme/host/fc.c:3817:2: note: Loop condition is true.  Entering loop body
           while (!list_empty(&local_disc_list)) {
           ^
   drivers/nvme/host/fc.c:3820:3: note: Calling 'list_del_init'
                   list_del_init(&rport->disc_list);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:206:2: note: Calling '__list_del_entry'
           __list_del_entry(entry);
           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:134:6: note: Assuming the condition is false
           if (!__list_del_entry_valid(entry))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:134:2: note: Taking false branch
           if (!__list_del_entry_valid(entry))
           ^
   include/linux/list.h:137:13: note: Use of memory after it is freed
           __list_del(entry->prev, entry->next);
                      ^~~~~~~~~~~
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   drivers/tty/serial/fsl_lpuart.c:1283:33: warning: The result of the left shift is undefined because the right operand is negative [clang-analyzer-core.UndefinedBinaryOperatorResult]
           sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
                                          ^
   drivers/tty/serial/fsl_lpuart.c:2868:6: note: Assuming field 'suspended' is 0
           if (sport->port.suspended && !irq_wake)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_lpuart.c:2868:28: note: Left side of '&&' is false
           if (sport->port.suspended && !irq_wake)
                                     ^
   drivers/tty/serial/fsl_lpuart.c:2871:2: note: Taking false branch
           if (lpuart_is_32(sport))
           ^
   drivers/tty/serial/fsl_lpuart.c:2876:6: note: Assuming field 'lpuart_dma_rx_use' is true
           if (sport->lpuart_dma_rx_use) {
               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_lpuart.c:2876:2: note: Taking true branch
           if (sport->lpuart_dma_rx_use) {
           ^
   drivers/tty/serial/fsl_lpuart.c:2877:7: note: Assuming 'irq_wake' is true
                   if (irq_wake) {
                       ^~~~~~~~
   drivers/tty/serial/fsl_lpuart.c:2877:3: note: Taking true branch
                   if (irq_wake) {
                   ^
   drivers/tty/serial/fsl_lpuart.c:2878:9: note: Calling 'lpuart_start_rx_dma'
                           if (!lpuart_start_rx_dma(sport))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_lpuart.c:1274:9: note: Assuming the condition is false
           bits = (termios->c_cflag & CSIZE) == CS7 ? 9 : 10;
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_lpuart.c:1274:9: note: '?' condition is false
   drivers/tty/serial/fsl_lpuart.c:1275:6: note: Assuming the condition is false
           if (termios->c_cflag & PARENB)
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_lpuart.c:1275:2: note: Taking false branch
           if (termios->c_cflag & PARENB)
           ^
   drivers/tty/serial/fsl_lpuart.c:1283:33: note: The result of the left shift is undefined because the right operand is negative
           sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
                                          ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   drivers/tty/mxser.c:396:7: warning: Although the value stored to 'hwid' is used in the enclosing expression, the value is never actually read from 'hwid' [clang-analyzer-deadcode.DeadStores]
           if ((hwid = inb(io + UART_MCR)) != 0) {
                ^
   drivers/tty/mxser.c:396:7: note: Although the value stored to 'hwid' is used in the enclosing expression, the value is never actually read from 'hwid'
>> drivers/tty/mxser.c:1693:4: warning: Value stored to 'int_cnt' is never read [clang-analyzer-deadcode.DeadStores]
                           int_cnt = 0;
                           ^         ~
   drivers/tty/mxser.c:1693:4: note: Value stored to 'int_cnt' is never read
                           int_cnt = 0;
                           ^         ~
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   drivers/leds/leds-pwm.c:146:15: warning: Access to field 'name' results in a dereference of a null pointer [clang-analyzer-core.NullDereference]
                           led.name = to_of_node(fwnode)->name;
                                      ^
   include/linux/of.h:161:2: note: expanded from macro 'to_of_node'
           ({                                                              \
           ^
   drivers/leds/leds-pwm.c:180:6: note: Assuming 'count' is not equal to 0
           if (!count)
               ^~~~~~
   drivers/leds/leds-pwm.c:180:2: note: Taking false branch
           if (!count)
           ^
   drivers/leds/leds-pwm.c:185:6: note: Assuming 'priv' is non-null
           if (!priv)
               ^~~~~
   drivers/leds/leds-pwm.c:185:2: note: Taking false branch
           if (!priv)
           ^
   drivers/leds/leds-pwm.c:188:8: note: Calling 'led_pwm_create_fwnode'
           ret = led_pwm_create_fwnode(&pdev->dev, priv);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-pwm.c:143:2: note: Loop condition is true.  Entering loop body
           device_for_each_child_node(dev, fwnode) {
           ^
   include/linux/property.h:112:2: note: expanded from macro 'device_for_each_child_node'
           for (child = device_get_next_child_node(dev, NULL); child;      \
           ^
   drivers/leds/leds-pwm.c:145:7: note: Assuming 'ret' is not equal to 0
                   if (ret && is_of_node(fwnode))
                       ^~~
   drivers/leds/leds-pwm.c:145:7: note: Left side of '&&' is true
   drivers/leds/leds-pwm.c:145:14: note: Assuming the condition is true
                   if (ret && is_of_node(fwnode))
                              ^~~~~~~~~~~~~~~~~~
   drivers/leds/leds-pwm.c:145:3: note: Taking true branch
                   if (ret && is_of_node(fwnode))
                   ^
   drivers/leds/leds-pwm.c:146:15: note: Assuming the condition is false
                           led.name = to_of_node(fwnode)->name;
                                      ^
   include/linux/of.h:164:3: note: expanded from macro 'to_of_node'
                   is_of_node(__to_of_node_fwnode) ?                       \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-pwm.c:146:15: note: '?' condition is false
                           led.name = to_of_node(fwnode)->name;
                                      ^
   include/linux/of.h:164:3: note: expanded from macro 'to_of_node'
                   is_of_node(__to_of_node_fwnode) ?                       \
                   ^
   drivers/leds/leds-pwm.c:146:15: note: Access to field 'name' results in a dereference of a null pointer
                           led.name = to_of_node(fwnode)->name;
                                      ^
   include/linux/of.h:161:2: note: expanded from macro 'to_of_node'
           ({                                                              \
           ^
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   drivers/ata/pata_pdc2027x.c:521:2: warning: Value stored to 'pll_ctl' is never read [clang-analyzer-deadcode.DeadStores]
           pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
           ^
   drivers/ata/pata_pdc2027x.c:521:2: note: Value stored to 'pll_ctl' is never read
   drivers/ata/pata_pdc2027x.c:570:2: warning: Value stored to 'pll_ctl' is never read [clang-analyzer-deadcode.DeadStores]
           pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
           ^
   drivers/ata/pata_pdc2027x.c:570:2: note: Value stored to 'pll_ctl' is never read
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   drivers/ata/pata_sis.c:417:6: warning: Value stored to 'speed' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           int speed = adev->dma_mode - XFER_MW_DMA_0;

vim +/mxser_ops +1745 drivers/tty/mxser.c

  1612	
  1613	static bool mxser_port_isr(struct mxser_port *port)
  1614	{
  1615		struct uart_port *uport = &port->uport;
  1616		struct tty_struct *tty;
  1617		u8 iir, status;
  1618		bool error = false;
  1619	
  1620		iir = inb(uport->iobase + UART_IIR);
  1621		if (iir & UART_IIR_NO_INT)
  1622			return true;
  1623	
  1624		iir &= MOXA_MUST_IIR_MASK;
  1625		tty = tty_port_tty_get(&port->port);
  1626		if (!tty) {
  1627			status = inb(uport->iobase + UART_LSR);
  1628			outb(port->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
  1629					uport->iobase + UART_FCR);
  1630			inb(uport->iobase + UART_MSR);
  1631	
  1632			error = true;
  1633			goto put_tty;
  1634		}
  1635	
  1636		status = inb(uport->iobase + UART_LSR);
  1637	
  1638		if (port->board->must_hwid) {
  1639			if (iir == MOXA_MUST_IIR_GDA ||
  1640			    iir == MOXA_MUST_IIR_RDA ||
  1641			    iir == MOXA_MUST_IIR_RTO ||
  1642			    iir == MOXA_MUST_IIR_LSR)
  1643				status = mxser_receive_chars(tty, port, status);
  1644		} else {
  1645			status &= uport->read_status_mask;
  1646			if (status & UART_LSR_DR)
  1647				status = mxser_receive_chars(tty, port, status);
  1648		}
  1649	
  1650		mxser_check_modem_status(tty, port);
  1651	
  1652		if (port->board->must_hwid) {
  1653			if (iir == 0x02 && (status & UART_LSR_THRE))
  1654				mxser_transmit_chars(tty, port);
  1655		} else {
  1656			if (status & UART_LSR_THRE)
  1657				mxser_transmit_chars(tty, port);
  1658		}
  1659	
  1660	put_tty:
  1661		tty_kref_put(tty);
  1662	
  1663		return error;
  1664	}
  1665	#endif
  1666	/*
  1667	 * This is the serial driver's generic interrupt routine
  1668	 */
  1669	static irqreturn_t mxser_interrupt(int irq, void *dev_id)
  1670	{
  1671		struct mxser_board *brd = dev_id;
  1672		struct mxser_port *port;
  1673		struct uart_port *uport;
  1674		unsigned int int_cnt, pass_counter = 0;
  1675		unsigned int i, max = brd->nports;
  1676		int handled = IRQ_NONE;
  1677		u8 irqbits, bits, mask = BIT(max) - 1;
  1678	
  1679		while (pass_counter++ < MXSER_ISR_PASS_LIMIT) {
  1680			irqbits = inb(brd->vector) & mask;
  1681			if (irqbits == mask)
  1682				break;
  1683	
  1684			handled = IRQ_HANDLED;
  1685			for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
  1686				if (irqbits == mask)
  1687					break;
  1688				if (bits & irqbits)
  1689					continue;
  1690				port = &brd->ports[i];
  1691				uport = &port->uport;
  1692	
> 1693				int_cnt = 0;
  1694				spin_lock(&uport->lock);
  1695				do {
  1696					//if (mxser_port_isr(port))
  1697						break;
  1698				} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
  1699				spin_unlock(&uport->lock);
  1700			}
  1701		}
  1702	
  1703		return handled;
  1704	}
  1705	#ifdef OLD
  1706	static const struct tty_operations mxser_ops = {
  1707		.open = mxser_open,
  1708		.close = mxser_close,
  1709		.write = mxser_write,
  1710		.put_char = mxser_put_char,
  1711		.flush_chars = mxser_flush_chars,
  1712		.write_room = mxser_write_room,
  1713		.chars_in_buffer = mxser_chars_in_buffer,
  1714		.flush_buffer = mxser_flush_buffer,
  1715		.ioctl = mxser_ioctl,
  1716		.throttle = mxser_throttle,
  1717		.unthrottle = mxser_unthrottle,
  1718		.set_termios = mxser_set_termios,
  1719		.stop = mxser_stop,
  1720		.start = mxser_start,
  1721		.hangup = mxser_hangup,
  1722		.break_ctl = mxser_rs_break,
  1723		.wait_until_sent = mxser_wait_until_sent,
  1724		.tiocmget = mxser_tiocmget,
  1725		.tiocmset = mxser_tiocmset,
  1726		.set_serial = mxser_set_serial_info,
  1727		.get_serial = mxser_get_serial_info,
  1728		.get_icount = mxser_get_icount,
  1729	};
  1730	
  1731	static const struct tty_port_operations mxser_port_ops = {
  1732		.carrier_raised = mxser_carrier_raised,
  1733		.dtr_rts = mxser_dtr_rts,
  1734		.activate = mxser_activate,
  1735		.shutdown = mxser_shutdown_port,
  1736	};
  1737	#endif
  1738	
  1739	static struct uart_driver mxser_uart_driver = {
  1740		.owner		= THIS_MODULE,
  1741		.dev_name	= "ttyMI",
  1742		.nr		= MXSER_PORTS,
  1743	};
  1744	
> 1745	static const struct uart_ops mxser_ops = {
  1746		.tx_empty       = mxser_tx_empty,
  1747		//.get_mctrl      = mxser_get_mctrl,
  1748		//.set_mctrl      = mxser_set_mctrl,
  1749		.stop_tx        = mxser_stop_tx,
  1750		.start_tx       = mxser_start_tx,
  1751		.stop_rx        = mxser_stop_rx,
  1752		.break_ctl      = mxser_break_ctl,
  1753		.startup        = mxser_startup,
  1754		.shutdown       = mxser_shutdown,
  1755		.set_termios    = mxser_set_termios,
  1756		//.pm             = mxser_pm,
  1757		//.type           = mxser_type,
  1758		//.release_port   = mxser_release_port,
  1759		//.request_port   = mxser_request_port,
  1760		//.config_port    = mxser_config_port,
  1761		//.verify_port    = mxser_verify_port,
  1762	};
  1763	
  1764	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
