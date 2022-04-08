Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A64F9BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiDHRsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbiDHRsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:48:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BFB27FC7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649439962; x=1680975962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aiYrbIzkZuJJv2xRXgdcn+FZqtiYSqurXUEW8KqJxJo=;
  b=YikyCEbdBDzd+Yb0RYcGrTxUeC0trq/kBmZNTeD/+WSjhlyvrK5pPJMS
   i8ub22uk1jxPAYgD2V5L9UMpNNzZZkKQoD1Hq5JUVQ7qfIHflY2P3/aVP
   bHQQafuMY7PugHVmSmWlaFQpsOUD6ifSh7ciI5/PQVRrqVBDda5yKnVNu
   0Z7OShiExAeSA4TuC8xgZlliundAG/41J/2tCgaQp49EmEbWsS4Ffqugu
   qBQ4Sf7FBZSuT5FGxTpKXIIifEfGvuHJ2Qvp+8pjJC4N7vA5xUTHVdMjs
   UlftJs2r4vFFqMxwGGeI3mOtrQZgrkcs5hr5FbfvT/jENOB9qUNBGzaFT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261339480"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261339480"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="609837736"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2022 10:45:58 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncsgI-0000Vc-Ao;
        Fri, 08 Apr 2022 17:45:58 +0000
Date:   Sat, 9 Apr 2022 01:45:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] drivers/tee/tee_core.c:449:29: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202204090112.3szEQIsN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   73447e771c55e18598a6fbf6adee1002aee18ea0
commit: 92948bd2c12648f2fb8256ae69dd092ce4398a3a [6/10] x86/uaccess: Remove tags from the address before checking
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220409/202204090112.3szEQIsN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=92948bd2c12648f2fb8256ae69dd092ce4398a3a
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 92948bd2c12648f2fb8256ae69dd092ce4398a3a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ arch/x86/kernel/ arch/x86/mm/ drivers/acpi/apei/ drivers/char/ drivers/firewire/ drivers/fpga/ drivers/gpu/drm/ drivers/i2c/ drivers/input/serio/ drivers/misc/ drivers/pps/ drivers/tee/ drivers/tty/ drivers/watchdog/ drivers/xen/ fs/ kernel/ net/ sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/tee/tee_core.c:449:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:449:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:449:29: sparse:     got unsigned long long *__ptr_clean
>> drivers/tee/tee_core.c:449:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:449:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:449:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:450:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:450:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:450:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:450:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:450:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:450:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:451:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:451:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:451:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:451:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:451:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:451:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:456:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:456:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:456:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:456:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:456:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:456:29: sparse:     got unsigned long long *__ptr_clean
>> drivers/tee/tee_core.c:518:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:518:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:518:13: sparse:     got unsigned int *__ptr_clean
>> drivers/tee/tee_core.c:518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:518:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:518:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:519:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:519:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:519:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:519:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:519:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:519:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:520:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:520:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:520:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:520:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:520:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:520:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:588:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:588:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:588:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:588:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:588:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:588:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:589:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:589:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:589:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:589:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:589:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:701:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:701:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:701:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:719:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:719:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:719:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:719:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:719:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:719:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:720:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:720:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:720:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:720:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:720:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:720:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:799:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:799:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:799:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:800:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:800:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:800:13: sparse:     got unsigned int *__ptr_clean
--
>> fs/orangefs/devorangefs-req.c:605:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:605:26: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/devorangefs-req.c:605:26: sparse:     got signed int *__ptr_clean
>> fs/orangefs/devorangefs-req.c:605:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:605:26: sparse:     expected void [noderef] __user *__ptr_pu
   fs/orangefs/devorangefs-req.c:605:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:609:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:609:26: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/devorangefs-req.c:609:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:609:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:609:26: sparse:     expected void [noderef] __user *__ptr_pu
   fs/orangefs/devorangefs-req.c:609:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:614:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:614:26: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/devorangefs-req.c:614:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:614:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:614:26: sparse:     expected void [noderef] __user *__ptr_pu
   fs/orangefs/devorangefs-req.c:614:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:254:28: sparse: sparse: context imbalance in 'orangefs_devreq_read' - different lock contexts for basic block
--
>> drivers/tty/tty_io.c:2285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/tty/tty_io.c:2285:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2285:13: sparse:     got char *__ptr_clean
>> drivers/tty/tty_io.c:2430:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2430:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2430:13: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2456:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2456:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2456:15: sparse:     got int *__ptr_clean
>> drivers/tty/tty_io.c:2456:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2456:15: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2456:15: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2517:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2517:34: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2517:34: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2517:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2517:34: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2517:34: sparse:     got int *__ptr_clean
>> drivers/tty/tty_io.c:2542:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_io.c:2542:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2542:18: sparse:     got unsigned int *__ptr_clean
   drivers/tty/tty_io.c:2709:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2709:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2709:24: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2709:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_io.c:2709:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2709:24: sparse:     got int *__ptr_clean
   drivers/tty/tty_io.c:2724:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_io.c:2724:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_io.c:2724:24: sparse:     got unsigned int *__ptr_clean
>> drivers/tty/tty_io.c:2724:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_io.c:2724:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_io.c:2724:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/tty/n_tty.c:2371:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/n_tty.c:2371:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/n_tty.c:2371:24: sparse:     got int *__ptr_clean
>> drivers/tty/n_tty.c:2371:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/n_tty.c:2371:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/n_tty.c:2371:24: sparse:     got int *__ptr_clean
>> drivers/tty/n_tty.c:2379:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/n_tty.c:2379:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/n_tty.c:2379:24: sparse:     got unsigned int *__ptr_clean
>> drivers/tty/n_tty.c:2379:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/n_tty.c:2379:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/n_tty.c:2379:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/tty/tty_ioctl.c:801:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_ioctl.c:801:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_ioctl.c:801:23: sparse:     got int *__ptr_clean
>> drivers/tty/tty_ioctl.c:801:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_ioctl.c:801:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_ioctl.c:801:23: sparse:     got int *__ptr_clean
>> drivers/tty/tty_ioctl.c:805:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/tty_ioctl.c:805:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_ioctl.c:805:21: sparse:     got unsigned int *__ptr_clean
   drivers/tty/tty_ioctl.c: note: in included file (through arch/x86/include/generated/uapi/asm/termios.h, include/uapi/linux/termios.h):
>> include/asm-generic/termios.h:25:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:25:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:25:13: sparse:     got unsigned short const *__ptr_clean
   include/asm-generic/termios.h:29:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:29:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:29:13: sparse:     got unsigned short const *__ptr_clean
   include/asm-generic/termios.h:33:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:33:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:33:13: sparse:     got unsigned short const *__ptr_clean
   include/asm-generic/termios.h:37:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__ptr_clean @@
   include/asm-generic/termios.h:37:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:37:13: sparse:     got unsigned short const *__ptr_clean
>> include/asm-generic/termios.h:41:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__ptr_clean @@
   include/asm-generic/termios.h:41:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:41:13: sparse:     got unsigned char const *__ptr_clean
>> include/asm-generic/termios.h:59:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:59:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:59:13: sparse:     got unsigned short *__ptr_clean
>> include/asm-generic/termios.h:59:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:59:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:59:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:60:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:60:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:60:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:60:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:60:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:60:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:61:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:61:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:61:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:61:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:61:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:61:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:62:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:62:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:62:13: sparse:     got unsigned short *__ptr_clean
   include/asm-generic/termios.h:62:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   include/asm-generic/termios.h:62:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:62:13: sparse:     got unsigned short *__ptr_clean
>> include/asm-generic/termios.h:63:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   include/asm-generic/termios.h:63:13: sparse:     expected void const volatile [noderef] __user *ptr
   include/asm-generic/termios.h:63:13: sparse:     got unsigned char *__ptr_clean
>> include/asm-generic/termios.h:63:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   include/asm-generic/termios.h:63:13: sparse:     expected void [noderef] __user *__ptr_pu
   include/asm-generic/termios.h:63:13: sparse:     got unsigned char *__ptr_clean
--
   drivers/tty/tty_jobctrl.c:80:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:80:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:80:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:83:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:83:34: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:83:34: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:124:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:124:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:124:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:126:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:126:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:126:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:135:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:135:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:135:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:156:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:156:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:156:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:165:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:165:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:167:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:167:40: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:167:40: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:205:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:205:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:205:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:215:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:215:51: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:215:51: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:227:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:227:43: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:227:43: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:291:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:291:39: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:291:39: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:294:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:294:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:294:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:303:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:303:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:303:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:307:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:307:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:307:33: sparse:     got struct spinlock [noderef] __rcu *
>> drivers/tty/tty_jobctrl.c:472:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:472:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:472:16: sparse:     got int *__ptr_clean
>> drivers/tty/tty_jobctrl.c:472:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:472:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_jobctrl.c:472:16: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:499:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:499:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:499:13: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:556:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/tty_jobctrl.c:556:16: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:556:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/tty_jobctrl.c:556:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/tty_jobctrl.c:556:16: sparse:     got int *__ptr_clean
   drivers/tty/tty_jobctrl.c:19:41: sparse: sparse: dereference of noderef expression
--
>> drivers/tty/pty.c:151:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:151:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:151:13: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:164:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:164:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:164:16: sparse:     got int *__ptr_clean
>> drivers/tty/pty.c:164:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/pty.c:164:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/pty.c:164:16: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:172:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:172:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:172:13: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:194:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/tty/pty.c:194:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:194:16: sparse:     got int *__ptr_clean
   drivers/tty/pty.c:194:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/tty/pty.c:194:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/pty.c:194:16: sparse:     got int *__ptr_clean
>> drivers/tty/pty.c:665:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/pty.c:665:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/pty.c:665:24: sparse:     got unsigned int *__ptr_clean
>> drivers/tty/pty.c:665:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/pty.c:665:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/pty.c:665:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/tty/sysrq.c:1158:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/tty/sysrq.c:1158:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/sysrq.c:1158:21: sparse:     got char const *__ptr_clean
   drivers/tty/sysrq.c: note: in included file (through include/linux/rculist.h, include/linux/sched/signal.h):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
>> kernel/futex/core.c:648:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/core.c:648:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:648:13: sparse:     got unsigned int *__ptr_clean
>> kernel/futex/core.c:783:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/futex/core.c:783:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:783:13: sparse:     got long *__ptr_clean
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/futex/core.c:750:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:750:13: sparse:     got unsigned long *__ptr_clean
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/futex/core.c:750:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:750:13: sparse:     got unsigned long *__ptr_clean
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/futex/core.c:750:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/core.c:750:13: sparse:     got unsigned long *__ptr_clean
--
>> kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/futex/syscalls.c:75:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned long *__ptr_clean
>> kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   kernel/futex/syscalls.c:75:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned long *__ptr_clean
>> kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct robust_list_head [noderef] __user **__ptr_clean @@
   kernel/futex/syscalls.c:77:16: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **__ptr_clean
>> kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got struct robust_list_head [noderef] __user **__ptr_clean @@
   kernel/futex/syscalls.c:77:16: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **__ptr_clean
--
>> kernel/futex/pi.c:1112:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/pi.c:1112:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/pi.c:1112:13: sparse:     got unsigned int *__ptr_clean
   kernel/futex/pi.c:675:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   kernel/futex/pi.c:803:9: sparse: sparse: context imbalance in '__fixup_pi_state_owner' - unexpected unlock
   kernel/futex/pi.c:1068:9: sparse: sparse: context imbalance in 'futex_lock_pi' - unexpected unlock
   kernel/futex/pi.c:1100:5: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
--
>> kernel/futex/requeue.c:458:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/requeue.c:458:31: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/requeue.c:458:31: sparse:     got unsigned int *__ptr_clean
   kernel/futex/requeue.c:455:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
--
>> kernel/futex/waitwake.c:473:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/waitwake.c:473:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/waitwake.c:473:29: sparse:     got unsigned int *__ptr_clean
   kernel/futex/waitwake.c:614:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/futex/waitwake.c:614:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/futex/waitwake.c:614:23: sparse:     got unsigned int *__ptr_clean
   kernel/futex/waitwake.c:262:33: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex/waitwake.c:328:6: sparse: sparse: context imbalance in 'futex_wait_queue' - unexpected unlock
   kernel/futex/waitwake.c:449:36: sparse: sparse: context imbalance in 'futex_wait_multiple_setup' - unexpected unlock
--
>> drivers/tty/serial/serial_core.c:1041:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tty/serial/serial_core.c:1041:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/serial/serial_core.c:1041:16: sparse:     got unsigned int *__ptr_clean
>> drivers/tty/serial/serial_core.c:1041:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tty/serial/serial_core.c:1041:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tty/serial/serial_core.c:1041:16: sparse:     got unsigned int *__ptr_clean
   drivers/tty/serial/serial_core.c:139:9: sparse: sparse: context imbalance in 'uart_start' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:211:17: sparse: sparse: context imbalance in 'uart_port_startup' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:320:9: sparse: sparse: context imbalance in 'uart_shutdown' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:540:9: sparse: sparse: context imbalance in 'uart_put_char' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:588:9: sparse: sparse: context imbalance in 'uart_write' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:601:9: sparse: sparse: context imbalance in 'uart_write_room' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:614:9: sparse: sparse: context imbalance in 'uart_chars_in_buffer' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:641:9: sparse: sparse: context imbalance in 'uart_flush_buffer' - different lock contexts for basic block
--
>> net/mptcp/protocol.c:3352:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/protocol.c:3352:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/protocol.c:3352:16: sparse:     got int *__ptr_clean
>> net/mptcp/protocol.c:3352:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/protocol.c:3352:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/protocol.c:3352:16: sparse:     got int *__ptr_clean
   net/mptcp/protocol.c:2922:24: sparse: sparse: context imbalance in 'mptcp_sk_clone' - unexpected unlock
--
>> net/mptcp/sockopt.c:895:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:895:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:895:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:902:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:902:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:902:13: sparse:     got int *__ptr_clean
>> net/mptcp/sockopt.c:902:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:902:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:902:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:923:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:923:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:923:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:923:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:923:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:923:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:937:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:937:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1119:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1119:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:1119:13: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1128:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1128:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:1128:21: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1128:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1128:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:1128:21: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1134:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1134:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/mptcp/sockopt.c:1134:21: sparse:     got int *__ptr_clean
   net/mptcp/sockopt.c:1134:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/mptcp/sockopt.c:1134:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/mptcp/sockopt.c:1134:21: sparse:     got int *__ptr_clean
--
   kernel/trace/trace.c:5739:1: sparse: sparse: trying to concatenate 8236-character string (8191 bytes max)
   kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
>> kernel/trace/trace.c:1601:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   kernel/trace/trace.c:1601:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1601:15: sparse:     got char const *__ptr_clean
   kernel/trace/trace.c:1615:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   kernel/trace/trace.c:1615:31: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1615:31: sparse:     got char const *__ptr_clean
   kernel/trace/trace.c:1640:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   kernel/trace/trace.c:1640:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/trace/trace.c:1640:23: sparse:     got char const *__ptr_clean
   kernel/trace/trace.c:2861:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2861:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2861:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:360:9: sparse:    struct trace_export *
   kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:375:9: sparse:    struct trace_export *
--
>> kernel/time/time.c:67:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:67:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:67:21: sparse:     got long *__ptr_clean
>> kernel/time/time.c:67:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   kernel/time/time.c:67:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/time/time.c:67:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:86:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:86:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:86:13: sparse:     got long *__ptr_clean
>> kernel/time/time.c:112:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   kernel/time/time.c:112:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:112:21: sparse:     got signed int *__ptr_clean
>> kernel/time/time.c:112:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   kernel/time/time.c:112:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/time/time.c:112:21: sparse:     got signed int *__ptr_clean
   kernel/time/time.c:124:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   kernel/time/time.c:124:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:124:13: sparse:     got signed int *__ptr_clean
   kernel/time/time.c:147:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:147:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:147:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:147:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   kernel/time/time.c:147:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/time/time.c:147:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:148:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:148:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:148:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:148:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   kernel/time/time.c:148:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/time/time.c:148:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:206:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:206:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:206:21: sparse:     got long *__ptr_clean
   kernel/time/time.c:207:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   kernel/time/time.c:207:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/time/time.c:207:21: sparse:     got long *__ptr_clean
--
>> kernel/bpf/syscall.c:1457:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:1457:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:1457:13: sparse:     got unsigned int *__ptr_clean
>> kernel/bpf/syscall.c:1457:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:1457:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:1457:13: sparse:     got unsigned int *__ptr_clean
>> kernel/bpf/syscall.c:2940:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   kernel/bpf/syscall.c:2940:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:2940:21: sparse:     got char *__ptr_clean
>> kernel/bpf/syscall.c:2940:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   kernel/bpf/syscall.c:2940:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:2940:21: sparse:     got char *__ptr_clean
   kernel/bpf/syscall.c:3398:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3398:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3398:23: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3398:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3398:23: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3398:23: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3673:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3673:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3673:29: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3673:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3673:29: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3673:29: sparse:     got unsigned int *__ptr_clean
>> kernel/bpf/syscall.c:3796:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:3796:45: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3796:45: sparse:     got unsigned long long *__ptr_clean
>> kernel/bpf/syscall.c:3796:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:3796:45: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3796:45: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:3802:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:3802:37: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3802:37: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:3802:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:3802:37: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3802:37: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:3824:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3824:45: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3824:45: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3824:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3824:45: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3824:45: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3829:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3829:37: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3829:37: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3829:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3829:37: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3829:37: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3877:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:3877:37: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3877:37: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:3877:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:3877:37: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3877:37: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:3910:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3910:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3910:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3910:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3910:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3910:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3955:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3955:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:3955:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:3955:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:3955:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:3955:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4007:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4007:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4007:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4007:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4007:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4007:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4084:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4084:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4084:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4084:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4084:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4084:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4092:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   kernel/bpf/syscall.c:4092:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4092:29: sparse:     got char *__ptr_clean
   kernel/bpf/syscall.c:4092:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   kernel/bpf/syscall.c:4092:29: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4092:29: sparse:     got char *__ptr_clean
   kernel/bpf/syscall.c:4107:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   kernel/bpf/syscall.c:4107:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4107:29: sparse:     got char *__ptr_clean
   kernel/bpf/syscall.c:4107:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   kernel/bpf/syscall.c:4107:29: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4107:29: sparse:     got char *__ptr_clean
   kernel/bpf/syscall.c:4112:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4112:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4112:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4112:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4112:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4112:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4113:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4113:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4113:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4113:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/syscall.c:4113:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4113:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/syscall.c:4114:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:4114:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4114:13: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:4114:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:4114:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4114:13: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:4115:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:4115:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/syscall.c:4115:13: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c:4115:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   kernel/bpf/syscall.c:4115:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/syscall.c:4115:13: sparse:     got unsigned long long *__ptr_clean
   kernel/bpf/syscall.c: note: in included file (through include/linux/bpf.h):
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:81:43: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:81:43: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
--
>> kernel/bpf/bpf_iter.c:473:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   kernel/bpf/bpf_iter.c:473:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/bpf_iter.c:473:29: sparse:     got char *__ptr_clean
>> kernel/bpf/bpf_iter.c:473:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   kernel/bpf/bpf_iter.c:473:29: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/bpf_iter.c:473:29: sparse:     got char *__ptr_clean
   kernel/bpf/bpf_iter.c: note: in included file (through include/linux/bpf.h, include/linux/filter.h):
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
--
>> kernel/bpf/hashtab.c:1621:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/hashtab.c:1621:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/hashtab.c:1621:13: sparse:     got unsigned int *__ptr_clean
>> kernel/bpf/hashtab.c:1621:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/hashtab.c:1621:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/hashtab.c:1621:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/hashtab.c:1791:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/hashtab.c:1791:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/hashtab.c:1791:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/hashtab.c:1791:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/hashtab.c:1791:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/hashtab.c:1791:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/hashtab.c:764:27: sparse: sparse: context imbalance in 'htab_lru_map_delete_node' - unexpected unlock
   kernel/bpf/hashtab.c:1111:27: sparse: sparse: context imbalance in 'htab_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1178:27: sparse: sparse: context imbalance in 'htab_lru_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1239:27: sparse: sparse: context imbalance in '__htab_percpu_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1304:27: sparse: sparse: context imbalance in '__htab_lru_percpu_map_update_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1356:27: sparse: sparse: context imbalance in 'htab_map_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1390:27: sparse: sparse: context imbalance in 'htab_lru_map_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1546:27: sparse: sparse: context imbalance in '__htab_map_lookup_and_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c: note: in included file (through include/linux/workqueue.h, include/linux/bpf.h):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in '__htab_map_lookup_and_delete_batch' - unexpected unlock
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'bpf_hash_map_seq_find_next' - unexpected unlock
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'bpf_hash_map_seq_stop' - unexpected unlock
--
>> kernel/bpf/verifier.c:320:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   kernel/bpf/verifier.c:320:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/verifier.c:320:13: sparse:     got char *__ptr_clean
>> kernel/bpf/verifier.c:320:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   kernel/bpf/verifier.c:320:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/verifier.c:320:13: sparse:     got char *__ptr_clean
   kernel/bpf/verifier.c:13727:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
--
   kernel/bpf/btf.c:2661:17: sparse: sparse: Using plain integer as NULL pointer
   kernel/bpf/btf.c:2663:17: sparse: sparse: Using plain integer as NULL pointer
   kernel/bpf/btf.c:3489:17: sparse: sparse: Using plain integer as NULL pointer
   kernel/bpf/btf.c:3840:9: sparse: sparse: Using plain integer as NULL pointer
>> kernel/bpf/btf.c:6342:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   kernel/bpf/btf.c:6342:29: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/btf.c:6342:29: sparse:     got char *__ptr_clean
>> kernel/bpf/btf.c:6342:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   kernel/bpf/btf.c:6342:29: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/btf.c:6342:29: sparse:     got char *__ptr_clean
>> kernel/bpf/btf.c:6350:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/bpf/btf.c:6350:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/btf.c:6350:13: sparse:     got unsigned int *__ptr_clean
>> kernel/bpf/btf.c:6350:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/bpf/btf.c:6350:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/bpf/btf.c:6350:13: sparse:     got unsigned int *__ptr_clean
   kernel/bpf/btf.c: note: in included file (through include/linux/bpf.h, include/linux/bpf_verifier.h):
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
--
   kernel/events/core.c:1493:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1493:15: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1493:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1506:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1506:28: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1506:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3492:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3492:18: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3492:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3493:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3493:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3493:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3541:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3541:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3541:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3542:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3542:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3542:25: sparse:    struct perf_event_context *
   kernel/events/core.c:4788:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4788:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:4788:25: sparse:    struct perf_event_context *
   kernel/events/core.c:6053:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6053:9: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:6053:9: sparse:    struct perf_buffer *
   kernel/events/core.c:5525:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
>> kernel/events/core.c:11814:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/events/core.c:11926:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
>> kernel/events/core.c:11926:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/events/core.c:5769:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5769:22: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5769:22: sparse:    struct perf_buffer *
   kernel/events/core.c:5893:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5893:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5893:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5926:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5926:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5926:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5983:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5983:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5983:14: sparse:    struct perf_buffer *
   kernel/events/core.c:6074:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6074:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:6074:14: sparse:    struct perf_buffer *
   kernel/events/core.c:6090:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6090:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:6090:14: sparse:    struct perf_buffer *
   kernel/events/core.c:7733:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7733:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7733:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7785:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7785:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7785:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7824:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7824:13: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:7824:13: sparse:    struct perf_buffer *
   kernel/events/core.c:7929:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7929:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7929:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:7931:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7931:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7931:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:8632:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8632:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:8632:23: sparse:    struct perf_event_context *
   kernel/events/core.c:9626:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9626:9: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9626:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:9665:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9665:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9665:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9846:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9846:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:9846:23: sparse:    struct perf_event_context *
   kernel/events/core.c:11025:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:12826:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12826:9: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12826:9: sparse:    struct perf_event_context *
   kernel/events/core.c:12936:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12936:17: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12936:17: sparse:    struct perf_event_context *
   kernel/events/core.c:13366:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:13366:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:13366:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:167:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:175:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c: note: in included file (through include/linux/rculist.h, include/linux/dcache.h, include/linux/fs.h):
   include/linux/rcupdate.h:723:9: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1540:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:2865:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:4760:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:204:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *buf @@
   kernel/events/core.c:9475:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9475:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9475:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9495:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9495:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9495:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9615:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9615:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9615:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9615:16: sparse:    struct swevent_hlist *
--
>> net/ethtool/ioctl.c:107:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ethtool/ioctl.c:107:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ethtool/ioctl.c:107:13: sparse:     got unsigned int *__ptr_clean
--
>> net/ipv4/ip_sockglue.c:1485:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1485:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1485:13: sparse:     got int *__ptr_clean
>> net/ipv4/ip_sockglue.c:1485:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1485:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1485:13: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1517:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1517:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1517:13: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1517:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1517:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1517:13: sparse:     got int *__ptr_clean
>> net/ipv4/ip_sockglue.c:1518:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1518:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1518:13: sparse:     got unsigned int *__ptr_clean
>> net/ipv4/ip_sockglue.c:1518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1518:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1518:13: sparse:     got unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1519:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1519:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1519:13: sparse:     got unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1519:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1519:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1519:13: sparse:     got unsigned int *__ptr_clean
   net/ipv4/ip_sockglue.c:1538:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1538:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1538:13: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1564:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1564:32: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1564:32: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1564:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1564:32: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1564:32: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1569:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1569:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1569:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1569:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1569:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1569:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1662:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1662:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1662:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1662:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1662:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1662:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1725:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1725:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1725:24: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1725:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1725:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1725:24: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1745:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1745:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1745:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1745:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1745:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1745:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1751:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1751:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/ip_sockglue.c:1751:21: sparse:     got int *__ptr_clean
   net/ipv4/ip_sockglue.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/ip_sockglue.c:1751:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/ip_sockglue.c:1751:21: sparse:     got int *__ptr_clean
--
>> net/ipv4/tcp.c:637:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:637:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:637:16: sparse:     got int *__ptr_clean
>> net/ipv4/tcp.c:637:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:637:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:637:16: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:3958:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:3958:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:3958:13: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4007:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4007:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4007:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4013:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4013:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4013:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4013:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4013:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4013:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4025:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4025:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4025:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4033:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4033:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4033:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4033:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4033:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4033:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4044:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4044:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4044:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4047:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4047:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4047:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4047:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4047:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4047:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4054:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4054:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4054:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4058:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4058:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4058:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4058:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4058:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4058:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4062:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4062:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4062:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4062:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4062:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4062:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4072:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4072:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4072:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4078:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4078:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4078:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4078:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4078:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4078:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4106:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4106:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4106:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4167:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4167:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4167:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4173:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4173:37: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4173:37: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4173:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4173:37: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4173:37: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4182:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4182:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4182:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4182:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4182:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4182:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4195:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4195:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4195:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4195:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4195:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4195:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4206:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4206:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4206:21: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4217:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4217:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4217:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4217:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4217:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4217:29: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4270:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4270:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/tcp.c:4270:13: sparse:     got int *__ptr_clean
   net/ipv4/tcp.c:4270:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/tcp.c:4270:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/tcp.c:4270:13: sparse:     got int *__ptr_clean
--
>> net/ipv4/raw.c:830:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:830:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:830:13: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:838:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:838:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:838:13: sparse:     got int *__ptr_clean
>> net/ipv4/raw.c:838:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/raw.c:838:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/raw.c:838:13: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:891:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:891:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:891:24: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:891:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/raw.c:891:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/raw.c:891:24: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:902:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/raw.c:902:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/raw.c:902:24: sparse:     got int *__ptr_clean
   net/ipv4/raw.c:902:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/raw.c:902:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/raw.c:902:24: sparse:     got int *__ptr_clean
--
>> net/ipv4/udp.c:1710:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1710:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:1710:24: sparse:     got int *__ptr_clean
>> net/ipv4/udp.c:1710:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1710:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/udp.c:1710:24: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:1717:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1717:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:1717:24: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:1717:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/udp.c:1717:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/udp.c:1717:24: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:2808:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:2808:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:2808:13: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:2855:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/udp.c:2855:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/udp.c:2855:13: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:2855:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/udp.c:2855:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/udp.c:2855:13: sparse:     got int *__ptr_clean
   net/ipv4/udp.c:1476:28: sparse: sparse: context imbalance in 'udp_rmem_release' - unexpected unlock
   net/ipv4/udp.c:1508:19: sparse: sparse: context imbalance in 'busylock_acquire' - wrong count at exit
   net/ipv4/udp.c:1520:28: sparse: sparse: context imbalance in 'busylock_release' - unexpected unlock
   net/ipv4/udp.c:2994:9: sparse: sparse: context imbalance in 'udp_get_first' - wrong count at exit
   net/ipv4/udp.c:3016:39: sparse: sparse: context imbalance in 'udp_get_next' - unexpected unlock
   net/ipv4/udp.c:3066:31: sparse: sparse: context imbalance in 'udp_seq_stop' - unexpected unlock
--
>> net/ipv4/igmp.c:2568:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv4/igmp.c:2568:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv4/igmp.c:2568:13: sparse:     got int *__ptr_clean
>> net/ipv4/igmp.c:2568:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv4/igmp.c:2568:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv4/igmp.c:2568:13: sparse:     got int *__ptr_clean
   net/ipv4/igmp.c:2919:31: sparse: sparse: context imbalance in 'igmp_mcf_get_next' - unexpected unlock
   net/ipv4/igmp.c:2947:9: sparse: sparse: context imbalance in 'igmp_mcf_get_idx' - wrong count at exit
   net/ipv4/igmp.c:2964:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_next' - wrong count at exit
   net/ipv4/igmp.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/buildid.h, ...):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_stop' - unexpected unlock
--
>> fs/cifs/cifs_debug.c:798:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   fs/cifs/cifs_debug.c:798:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/cifs_debug.c:798:14: sparse:     got char const *__ptr_clean
--
>> fs/cifs/ioctl.c:163:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/cifs/ioctl.c:163:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/ioctl.c:163:13: sparse:     got unsigned int *__ptr_clean
>> fs/cifs/ioctl.c:353:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/cifs/ioctl.c:353:38: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/ioctl.c:353:38: sparse:     got int *__ptr_clean
>> fs/cifs/ioctl.c:353:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/cifs/ioctl.c:353:38: sparse:     expected void [noderef] __user *__ptr_pu
   fs/cifs/ioctl.c:353:38: sparse:     got int *__ptr_clean
   fs/cifs/ioctl.c:363:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/cifs/ioctl.c:363:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/ioctl.c:363:29: sparse:     got int *__ptr_clean
--
>> fs/cifs/smb2ops.c:2207:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/cifs/smb2ops.c:2207:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/cifs/smb2ops.c:2207:13: sparse:     got unsigned int *__ptr_clean
--
>> drivers/input/serio/serport.c:216:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/input/serio/serport.c:216:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/serio/serport.c:216:21: sparse:     got unsigned long *__ptr_clean
--
>> drivers/watchdog/watchdog_dev.c:687:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:687:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:687:21: sparse:     got char const *__ptr_clean
>> drivers/watchdog/watchdog_dev.c:749:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     got int *__ptr_clean
>> drivers/watchdog/watchdog_dev.c:749:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:752:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:752:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:755:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:755:21: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:775:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:775:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:775:21: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:795:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:795:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:801:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:801:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:804:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:804:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:804:21: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:811:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     got int *__ptr_clean
   drivers/watchdog/watchdog_dev.c:811:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse:     got char const *__ptr_clean
>> drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     got int *__ptr_clean
>> drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/ib700wdt.c:156:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/ib700wdt.c:156:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/ib700wdt.c:156:37: sparse:     got char const *__ptr_clean
>> drivers/watchdog/ib700wdt.c:188:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/ib700wdt.c:188:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/ib700wdt.c:188:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/ib700wdt.c:188:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/ib700wdt.c:188:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/ib700wdt.c:188:24: sparse:     got int *__ptr_clean
   drivers/watchdog/ib700wdt.c:194:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/ib700wdt.c:194:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/ib700wdt.c:194:21: sparse:     got int *__ptr_clean
   drivers/watchdog/ib700wdt.c:212:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/ib700wdt.c:212:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/ib700wdt.c:212:21: sparse:     got int *__ptr_clean
   drivers/watchdog/ib700wdt.c:220:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/ib700wdt.c:220:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/ib700wdt.c:220:24: sparse:     got int *__ptr_clean
   drivers/watchdog/ib700wdt.c:220:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/ib700wdt.c:220:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/ib700wdt.c:220:24: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/cpu5wdt.c:157:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/cpu5wdt.c:157:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     got int *__ptr_clean
   drivers/watchdog/cpu5wdt.c:159:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     got int *__ptr_clean
   drivers/watchdog/cpu5wdt.c:159:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     got int *__ptr_clean
   drivers/watchdog/cpu5wdt.c:161:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/cpu5wdt.c:161:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/cpu5wdt.c:161:21: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/it8712f_wdt.c:243:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:243:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/it8712f_wdt.c:243:29: sparse:     got char const *__ptr_clean
>> drivers/watchdog/it8712f_wdt.c:282:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:282:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/it8712f_wdt.c:282:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/it8712f_wdt.c:282:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:282:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/it8712f_wdt.c:282:24: sparse:     got int *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:284:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:284:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/it8712f_wdt.c:284:24: sparse:     got int *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:284:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:284:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/it8712f_wdt.c:284:24: sparse:     got int *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:289:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:289:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/it8712f_wdt.c:289:21: sparse:     got int *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:307:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:307:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/it8712f_wdt.c:307:21: sparse:     got int *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:307:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/it8712f_wdt.c:307:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/it8712f_wdt.c:307:21: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/w83977f_wdt.c:343:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:343:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/w83977f_wdt.c:343:37: sparse:     got char const *__ptr_clean
>> drivers/watchdog/w83977f_wdt.c:392:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/w83977f_wdt.c:392:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     got int *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:395:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     got int *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:395:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     got int *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:398:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:398:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/w83977f_wdt.c:398:21: sparse:     got int *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:418:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:418:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/w83977f_wdt.c:418:21: sparse:     got int *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:428:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     got int *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:428:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/acquirewdt.c:131:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/acquirewdt.c:131:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/acquirewdt.c:131:37: sparse:     got char const *__ptr_clean
>> drivers/watchdog/acquirewdt.c:161:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/acquirewdt.c:161:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/acquirewdt.c:161:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/acquirewdt.c:161:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/acquirewdt.c:161:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/acquirewdt.c:161:24: sparse:     got int *__ptr_clean
   drivers/watchdog/acquirewdt.c:165:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/acquirewdt.c:165:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/acquirewdt.c:165:21: sparse:     got int *__ptr_clean
   drivers/watchdog/acquirewdt.c:182:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/acquirewdt.c:182:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/acquirewdt.c:182:24: sparse:     got int *__ptr_clean
   drivers/watchdog/acquirewdt.c:182:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/acquirewdt.c:182:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/acquirewdt.c:182:24: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/sbc60xxwdt.c:180:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/sbc60xxwdt.c:180:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc60xxwdt.c:180:37: sparse:     got char const *__ptr_clean
>> drivers/watchdog/sbc60xxwdt.c:237:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/sbc60xxwdt.c:237:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/wafer5823wdt.c:109:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     got char const *__ptr_clean
>> drivers/watchdog/wafer5823wdt.c:143:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/wafer5823wdt.c:143:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     got int *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:149:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     got int *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:170:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     got int *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     got int *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:179:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/smsc37b787_wdt.c:404:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     got char const *__ptr_clean
>> drivers/watchdog/smsc37b787_wdt.c:444:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/smsc37b787_wdt.c:444:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     got int *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     got int *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     got int *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     got int *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     got int *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     got int *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/machzwd.c:285:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/watchdog/machzwd.c:285:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/machzwd.c:285:37: sparse:     got char const *__ptr_clean
>> drivers/watchdog/machzwd.c:315:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/machzwd.c:315:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/machzwd.c:315:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/machzwd.c:315:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/machzwd.c:315:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/machzwd.c:315:24: sparse:     got int *__ptr_clean
--
>> drivers/watchdog/sbc_epx_c3.c:119:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     got int *__ptr_clean
>> drivers/watchdog/sbc_epx_c3.c:119:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     got int *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     got int *__ptr_clean
--
>> net/unix/af_unix.c:3080:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3080:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/unix/af_unix.c:3080:23: sparse:     got int *__ptr_clean
>> net/unix/af_unix.c:3080:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3080:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/unix/af_unix.c:3080:23: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3087:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3087:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/unix/af_unix.c:3087:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3087:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3087:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/unix/af_unix.c:3087:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3101:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3101:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/unix/af_unix.c:3101:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:3101:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/unix/af_unix.c:3101:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/unix/af_unix.c:3101:31: sparse:     got int *__ptr_clean
   net/unix/af_unix.c:161:13: sparse: sparse: context imbalance in 'unix_table_double_lock' - wrong count at exit
   net/unix/af_unix.c:174:13: sparse: sparse: context imbalance in 'unix_table_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1268:13: sparse: sparse: context imbalance in 'unix_state_double_lock' - wrong count at exit
   net/unix/af_unix.c:1286:17: sparse: sparse: context imbalance in 'unix_state_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1590:18: sparse: sparse: context imbalance in 'unix_stream_connect' - different lock contexts for basic block
   net/unix/af_unix.c:1956:25: sparse: sparse: context imbalance in 'unix_dgram_sendmsg' - unexpected unlock
   net/unix/af_unix.c:3245:20: sparse: sparse: context imbalance in 'unix_get_first' - wrong count at exit
   net/unix/af_unix.c:3274:20: sparse: sparse: context imbalance in 'unix_get_next' - unexpected unlock
   net/unix/af_unix.c:3304:28: sparse: sparse: context imbalance in 'unix_seq_stop' - unexpected unlock
   net/unix/af_unix.c:3410:20: sparse: sparse: context imbalance in 'bpf_iter_unix_hold_batch' - unexpected unlock
--
>> drivers/xen/gntdev.c:817:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed short *__ptr_clean @@
   drivers/xen/gntdev.c:817:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/xen/gntdev.c:817:13: sparse:     got signed short *__ptr_clean
>> drivers/xen/gntdev.c:817:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed short *__ptr_clean @@
   drivers/xen/gntdev.c:817:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/xen/gntdev.c:817:13: sparse:     got signed short *__ptr_clean
--
>> drivers/xen/privcmd.c:375:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/xen/privcmd.c:375:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/xen/privcmd.c:375:31: sparse:     got unsigned long *__ptr_clean
   drivers/xen/privcmd.c:559:35: sparse: sparse: cast removes address space '__user' of expression
   drivers/xen/privcmd.c:559:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] [usertype] __user *[addressable] [assigned] user_gfn @@     got unsigned long [usertype] * @@
   drivers/xen/privcmd.c:559:32: sparse:     expected unsigned long [noderef] [usertype] __user *[addressable] [assigned] user_gfn
   drivers/xen/privcmd.c:559:32: sparse:     got unsigned long [usertype] *
   drivers/xen/privcmd.c:686:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[usertype] h @@     got void [noderef] __user *uptr @@
   drivers/xen/privcmd.c:686:17: sparse:     expected void *[usertype] h
   drivers/xen/privcmd.c:686:17: sparse:     got void [noderef] __user *uptr
--
>> net/ipv6/ipv6_sockglue.c:1087:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     got int *__ptr_clean
>> net/ipv6/ipv6_sockglue.c:1087:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1105:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1128:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1128:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     got int *__ptr_clean
>> net/ipv6/ipv6_sockglue.c:1129:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     got unsigned int *__ptr_clean
>> net/ipv6/ipv6_sockglue.c:1129:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     got unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1130:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     got unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1130:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     got unsigned int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1145:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1215:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1215:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1275:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1275:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1329:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1329:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1477:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     got int *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1477:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     got int *__ptr_clean
--
>> net/ipv6/raw.c:998:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:998:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:998:21: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1004:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1004:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1004:21: sparse:     got int *__ptr_clean
>> net/ipv6/raw.c:1004:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1004:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1004:21: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1096:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1096:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1096:13: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1121:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1121:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1121:13: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1121:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1121:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1121:13: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1157:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1157:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1157:24: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1157:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1157:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1157:24: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1168:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1168:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/raw.c:1168:24: sparse:     got int *__ptr_clean
   net/ipv6/raw.c:1168:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ipv6/raw.c:1168:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/raw.c:1168:24: sparse:     got int *__ptr_clean
--
>> net/ipv6/sit.c:361:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/ipv6/sit.c:361:54: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/sit.c:361:54: sparse:     got unsigned int *__ptr_clean
>> net/ipv6/sit.c:361:54: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/ipv6/sit.c:361:54: sparse:     expected void [noderef] __user *__ptr_pu
   net/ipv6/sit.c:361:54: sparse:     got unsigned int *__ptr_clean
--
>> net/packet/af_packet.c:4019:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4019:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4019:13: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4119:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4119:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4119:13: sparse:     got int *__ptr_clean
>> net/packet/af_packet.c:4119:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4119:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/packet/af_packet.c:4119:13: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4187:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4187:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4187:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4187:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4187:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/packet/af_packet.c:4187:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4199:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4199:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:4199:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:4199:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/packet/af_packet.c:4199:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/packet/af_packet.c:4199:24: sparse:     got int *__ptr_clean
   net/packet/af_packet.c:1050:13: sparse: sparse: context imbalance in '__packet_lookup_frame_in_block' - different lock contexts for basic block
   net/packet/af_packet.c:2480:17: sparse: sparse: context imbalance in 'tpacket_rcv' - unexpected unlock
--
>> drivers/misc/xilinx_sdfec.c:735:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int enum xsdfec_order *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     got unsigned int enum xsdfec_order *__ptr_clean
>> drivers/misc/xilinx_sdfec.c:760:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got bool *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     got bool *__ptr_clean
   drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got bool *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool *__ptr_clean
>> drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got bool *__ptr_clean @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool *__ptr_clean
--
>> net/sunrpc/rpc_pipe.c:380:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sunrpc/rpc_pipe.c:380:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/sunrpc/rpc_pipe.c:380:24: sparse:     got int *__ptr_clean
>> net/sunrpc/rpc_pipe.c:380:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sunrpc/rpc_pipe.c:380:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/sunrpc/rpc_pipe.c:380:24: sparse:     got int *__ptr_clean
--
>> net/sunrpc/cache.c:1003:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/sunrpc/cache.c:1003:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/sunrpc/cache.c:1003:16: sparse:     got int *__ptr_clean
>> net/sunrpc/cache.c:1003:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/sunrpc/cache.c:1003:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/sunrpc/cache.c:1003:16: sparse:     got int *__ptr_clean
--
>> arch/x86/kernel/process.c:278:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   arch/x86/kernel/process.c:278:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/process.c:278:16: sparse:     got unsigned int *__ptr_clean
>> arch/x86/kernel/process.c:278:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   arch/x86/kernel/process.c:278:16: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/process.c:278:16: sparse:     got unsigned int *__ptr_clean
--
>> arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *__ptr_clean
>> arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *__ptr_clean
--
>> arch/x86/kernel/process_64.c:810:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/process_64.c:810:23: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/process_64.c:810:23: sparse:     got unsigned long *__ptr_clean
>> arch/x86/kernel/process_64.c:810:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/process_64.c:810:23: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/process_64.c:810:23: sparse:     got unsigned long *__ptr_clean
   arch/x86/kernel/process_64.c:816:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/process_64.c:816:23: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/process_64.c:816:23: sparse:     got unsigned long *__ptr_clean
   arch/x86/kernel/process_64.c:816:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   arch/x86/kernel/process_64.c:816:23: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/process_64.c:816:23: sparse:     got unsigned long *__ptr_clean
--
>> arch/x86/kernel/traps.c:620:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   arch/x86/kernel/traps.c:620:13: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/traps.c:620:13: sparse:     got char const *__ptr_clean
--
>> arch/x86/mm/fault.c:152:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   arch/x86/mm/fault.c:152:29: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/mm/fault.c:152:29: sparse:     got unsigned char *__ptr_clean
--
>> arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse:     got unsigned long *__ptr_clean
--
   arch/x86/kernel/fpu/xstate.c:1508:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1508:9: sparse:     expected struct lockdep_map const *lock
   arch/x86/kernel/fpu/xstate.c:1508:9: sparse:     got struct lockdep_map [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1598:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1598:31: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1598:31: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1606:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1606:33: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1606:33: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1624:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1624:31: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1624:31: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1628:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1628:41: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1628:41: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1643:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1643:33: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1643:33: sparse:     got struct spinlock [noderef] __rcu *
>> arch/x86/kernel/fpu/xstate.c:1703:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     got unsigned long long *__ptr_clean
>> arch/x86/kernel/fpu/xstate.c:1703:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/fpu/xstate.c:1703:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/fpu/xstate.c:1712:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     got unsigned long long *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     expected void [noderef] __user *__ptr_pu
   arch/x86/kernel/fpu/xstate.c:1717:24: sparse:     got unsigned long long *__ptr_clean
--
   kernel/fork.c:1304:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
   kernel/fork.c:1304:24: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/fork.c:1304:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1304:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/fork.c:1304:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1304:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
>> kernel/fork.c:1469:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/fork.c:1469:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/fork.c:1469:25: sparse:     got int *__ptr_clean
>> kernel/fork.c:1469:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/fork.c:1469:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/fork.c:1469:25: sparse:     got int *__ptr_clean
   kernel/fork.c:1635:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1635:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1635:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1644:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1644:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1644:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1645:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1645:9: sparse:     expected void const *
   kernel/fork.c:1645:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1645:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1645:9: sparse:     expected void const *
   kernel/fork.c:1645:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1645:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1645:9: sparse:     expected void const *
   kernel/fork.c:1645:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1646:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1646:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1646:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1739:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/fork.c:1739:9: sparse:     expected struct qspinlock *lock
   kernel/fork.c:1739:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/fork.c:2058:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2058:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2058:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2062:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2062:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2062:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2279:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/fork.c:2279:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/fork.c:2279:26: sparse:     got int *__ptr_clean
   kernel/fork.c:2279:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/fork.c:2279:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/fork.c:2279:26: sparse:     got int *__ptr_clean
   kernel/fork.c:2379:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2379:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2379:32: sparse:     got struct task_struct *
   kernel/fork.c:2388:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2388:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2388:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2433:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2433:54: sparse:     expected struct list_head *head
   kernel/fork.c:2433:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2454:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2454:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2454:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2475:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2475:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2475:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2502:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2502:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2502:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2531:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2531:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2531:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2533:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2533:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2533:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2655:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/fork.c:2655:17: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/fork.c:2655:17: sparse:     got int *__ptr_clean
   kernel/fork.c:2655:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/fork.c:2655:17: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/fork.c:2655:17: sparse:     got int *__ptr_clean
   kernel/fork.c:2942:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2942:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2942:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3023:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3023:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3023:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2100:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:217:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:217:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:217:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:217:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:217:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:217:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2431:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2432:59: sparse: sparse: dereference of noderef expression
--
   kernel/exit.c:281:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:281:37: sparse:     expected struct task_struct *tsk
   kernel/exit.c:281:37: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:284:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:284:32: sparse:     expected struct task_struct *task
   kernel/exit.c:284:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:285:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:285:35: sparse:     expected struct task_struct *task
   kernel/exit.c:285:35: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:330:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:330:24: sparse:     expected struct task_struct *parent
   kernel/exit.c:330:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:357:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:357:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:357:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:360:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:360:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:360:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:583:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:583:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:583:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:585:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:585:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:585:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:909:63: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *const sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/exit.c:909:63: sparse:     expected struct sighand_struct *const sighand
   kernel/exit.c:909:63: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/exit.c:1064:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1064:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1064:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1089:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1089:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1089:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1178:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1178:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1178:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1193:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1193:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1193:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1244:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1244:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1244:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1247:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1247:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1247:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1253:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1253:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1253:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1434:59: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/exit.c:1434:59: sparse:    void *
   kernel/exit.c:1434:59: sparse:    struct task_struct [noderef] __rcu *
   kernel/exit.c:1450:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu * @@
   kernel/exit.c:1450:25: sparse:     expected struct task_struct *parent
   kernel/exit.c:1450:25: sparse:     got struct task_struct [noderef] __rcu *
>> kernel/exit.c:1683:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/exit.c:1683:37: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/exit.c:1683:37: sparse:     got int *__ptr_clean
>> kernel/exit.c:1683:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/exit.c:1683:37: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/exit.c:1683:37: sparse:     got int *__ptr_clean
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c: note: in included file (through include/linux/sched/signal.h, include/linux/rcuwait.h, include/linux/percpu-rwsem.h, ...):
   include/linux/sched/task.h:106:21: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
   include/linux/sched/task.h:106:21: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
   include/linux/sched/task.h:106:21: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:99:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:99:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c:1542:9: sparse: sparse: context imbalance in 'do_wait' - wrong count at exit
--
>> kernel/capability.c:86:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/capability.c:86:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:86:13: sparse:     got unsigned int *__ptr_clean
   kernel/capability.c:101:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/capability.c:101:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:101:21: sparse:     got unsigned int *__ptr_clean
>> kernel/capability.c:101:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/capability.c:101:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/capability.c:101:21: sparse:     got unsigned int *__ptr_clean
>> kernel/capability.c:159:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/capability.c:159:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:159:13: sparse:     got int *__ptr_clean
   kernel/capability.c:195:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct __user_cap_data_struct [noderef] __user * @@
   kernel/capability.c:195:43: sparse:     expected void const *from
   kernel/capability.c:195:43: sparse:     got struct __user_cap_data_struct [noderef] __user *
   kernel/capability.c:171:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:172:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:173:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:235:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/capability.c:235:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/capability.c:235:13: sparse:     got int *__ptr_clean
   kernel/capability.c:246:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct __user_cap_data_struct [noderef] __user ( * )[2] @@
   kernel/capability.c:246:29: sparse:     expected void *to
   kernel/capability.c:246:29: sparse:     got struct __user_cap_data_struct [noderef] __user ( * )[2]
   kernel/capability.c:250:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:251:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:252:43: sparse: sparse: dereference of noderef expression
--
   kernel/ptrace.c:54:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:54:22: sparse:    struct task_struct *
   kernel/ptrace.c:54:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:73:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:73:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:73:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:74:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:74:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:74:29: sparse:     got struct cred const *
   kernel/ptrace.c:128:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:128:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:128:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:132:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:132:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:132:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:170:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:170:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:170:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:197:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:197:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:197:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:203:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:203:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:203:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:213:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:213:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:213:9: sparse:    struct task_struct *
   kernel/ptrace.c:258:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:258:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:258:44: sparse:    struct task_struct *
   kernel/ptrace.c:458:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:458:24: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:458:24: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:481:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:481:26: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:481:26: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:517:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:517:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:517:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:525:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:525:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:525:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:573:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:573:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:573:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:575:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:575:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:575:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:766:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:766:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:766:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:774:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:774:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:774:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:897:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:897:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:897:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:901:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:901:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:901:39: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/ptrace.c:1071:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1071:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/ptrace.c:1071:23: sparse:     got unsigned long *__ptr_clean
>> kernel/ptrace.c:1071:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1071:23: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/ptrace.c:1071:23: sparse:     got unsigned long *__ptr_clean
   kernel/ptrace.c:1131:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1131:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1131:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1133:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1133:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1133:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1346:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1346:16: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/ptrace.c:1346:16: sparse:     got unsigned long *__ptr_clean
   kernel/ptrace.c:1346:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   kernel/ptrace.c:1346:16: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/ptrace.c:1346:16: sparse:     got unsigned long *__ptr_clean
   kernel/ptrace.c:523:38: sparse: sparse: dereference of noderef expression
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:713:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:729:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:903:9: sparse: sparse: context imbalance in 'ptrace_resume' - different lock contexts for basic block
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1285:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
--
>> kernel/sys.c:1971:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:1971:24: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:1971:24: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:1971:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:1971:24: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:1971:24: sparse:     got unsigned int *__ptr_clean
>> kernel/sys.c:2238:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int [noderef] __user **__ptr_clean @@
   kernel/sys.c:2238:16: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2238:16: sparse:     got int [noderef] __user **__ptr_clean
>> kernel/sys.c:2238:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int [noderef] __user **__ptr_clean @@
   kernel/sys.c:2238:16: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2238:16: sparse:     got int [noderef] __user **__ptr_clean
   kernel/sys.c:738:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:738:18: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:738:18: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:738:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:738:18: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:738:18: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:740:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:740:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:740:26: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:740:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:740:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:740:26: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:742:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:742:32: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:742:32: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:742:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:742:32: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:742:32: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:821:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:821:18: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:821:18: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:821:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:821:18: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:821:18: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:823:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:823:26: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:823:26: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:823:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:823:26: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:823:26: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:825:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:825:34: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:825:34: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:825:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:825:34: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:825:34: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:1077:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/sys.c:1077:32: sparse:     expected struct task_struct *p1
   kernel/sys.c:1077:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/sys.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:731:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:731:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:731:37: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/sys.c:2363:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/sys.c:2363:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2363:25: sparse:     got int *__ptr_clean
>> kernel/sys.c:2363:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/sys.c:2363:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2363:25: sparse:     got int *__ptr_clean
   kernel/sys.c:2499:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/sys.c:2499:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2499:25: sparse:     got int *__ptr_clean
   kernel/sys.c:2499:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/sys.c:2499:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2499:25: sparse:     got int *__ptr_clean
   kernel/sys.c:2628:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2628:24: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2628:24: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:2628:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2628:24: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2628:24: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:2630:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2630:24: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sys.c:2630:24: sparse:     got unsigned int *__ptr_clean
   kernel/sys.c:2630:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sys.c:2630:24: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sys.c:2630:24: sparse:     got unsigned int *__ptr_clean
--
>> kernel/groups.c:47:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/groups.c:47:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/groups.c:47:21: sparse:     got unsigned int *__ptr_clean
>> kernel/groups.c:47:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/groups.c:47:21: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/groups.c:47:21: sparse:     got unsigned int *__ptr_clean
   kernel/groups.c:64:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/groups.c:64:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/groups.c:64:21: sparse:     got unsigned int *__ptr_clean
--
>> kernel/kcov.c:698:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/kcov.c:698:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/kcov.c:698:21: sparse:     got unsigned int *__ptr_clean
--
>> fs/read_write.c:1285:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/read_write.c:1285:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/read_write.c:1285:21: sparse:     got long *__ptr_clean
   fs/read_write.c:1289:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/read_write.c:1289:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/read_write.c:1289:21: sparse:     got long *__ptr_clean
>> fs/read_write.c:1289:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   fs/read_write.c:1289:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/read_write.c:1289:21: sparse:     got long *__ptr_clean
>> fs/read_write.c:1306:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long long *__ptr_clean @@
   fs/read_write.c:1306:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/read_write.c:1306:21: sparse:     got long long *__ptr_clean
>> fs/read_write.c:1306:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long long *__ptr_clean @@
   fs/read_write.c:1306:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/read_write.c:1306:21: sparse:     got long long *__ptr_clean
--
>> fs/exec.c:420:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const [noderef] __user *const *__ptr_clean @@
   fs/exec.c:420:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/exec.c:420:13: sparse:     got char const [noderef] __user *const *__ptr_clean
   fs/exec.c:421:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:421:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:421:31: sparse:     got void *
   fs/exec.c:1044:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1044:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1044:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1151:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1151:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1151:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1186:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1186:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1186:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1758:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1758:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1758:70: sparse:     got struct task_struct [noderef] __rcu *parent
--
>> fs/pipe.c:626:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/pipe.c:626:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/pipe.c:626:24: sparse:     got int *__ptr_clean
>> fs/pipe.c:626:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/pipe.c:626:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/pipe.c:626:24: sparse:     got int *__ptr_clean
--
>> fs/ioctl.c:69:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:69:17: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:69:17: sparse:     got int *__ptr_clean
   fs/ioctl.c:91:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:91:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:91:13: sparse:     got int *__ptr_clean
>> fs/ioctl.c:91:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ioctl.c:91:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:91:13: sparse:     got int *__ptr_clean
   fs/ioctl.c:346:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:346:17: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:346:17: sparse:     got int *__ptr_clean
   fs/ioctl.c:370:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:370:17: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:370:17: sparse:     got int *__ptr_clean
>> fs/ioctl.c:424:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/ioctl.c:424:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:424:13: sparse:     got unsigned short *__ptr_clean
>> fs/ioctl.c:711:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/ioctl.c:711:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:711:23: sparse:     got unsigned int *__ptr_clean
>> fs/ioctl.c:711:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/ioctl.c:711:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:711:23: sparse:     got unsigned int *__ptr_clean
   fs/ioctl.c:723:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/ioctl.c:723:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:723:15: sparse:     got unsigned int *__ptr_clean
   fs/ioctl.c:817:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:817:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:817:24: sparse:     got int *__ptr_clean
   fs/ioctl.c:817:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ioctl.c:817:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:817:24: sparse:     got int *__ptr_clean
   fs/ioctl.c:832:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/ioctl.c:832:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ioctl.c:832:24: sparse:     got int *__ptr_clean
   fs/ioctl.c:832:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/ioctl.c:832:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/ioctl.c:832:24: sparse:     got int *__ptr_clean
--
>> fs/fcntl.c:258:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:258:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fcntl.c:258:16: sparse:     got unsigned int *__ptr_clean
>> fs/fcntl.c:258:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:258:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fcntl.c:258:16: sparse:     got unsigned int *__ptr_clean
   fs/fcntl.c:259:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:259:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fcntl.c:259:16: sparse:     got unsigned int *__ptr_clean
   fs/fcntl.c:259:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/fcntl.c:259:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fcntl.c:259:16: sparse:     got unsigned int *__ptr_clean
   fs/fcntl.c:931:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:931:9: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:931:9: sparse:    struct fasync_struct *
   fs/fcntl.c:1006:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:1006:22: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:1006:22: sparse:    struct fasync_struct *
   fs/fcntl.c:1017:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:1017:33: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:1017:33: sparse:    struct fasync_struct *
--
>> fs/readdir.c:293:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/readdir.c:293:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/readdir.c:293:21: sparse:     got unsigned long *__ptr_clean
>> fs/readdir.c:293:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   fs/readdir.c:293:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/readdir.c:293:21: sparse:     got unsigned long *__ptr_clean
>> fs/readdir.c:377:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/readdir.c:377:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/readdir.c:377:21: sparse:     got signed long long *__ptr_clean
>> fs/readdir.c:377:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/readdir.c:377:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/readdir.c:377:21: sparse:     got signed long long *__ptr_clean
--
   fs/file.c:379:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:379:17: sparse:     expected struct file **old_fds
   fs/file.c:379:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:380:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:380:17: sparse:     expected struct file **new_fds
   fs/file.c:380:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:395:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:395:17: sparse:    struct file [noderef] __rcu *
   fs/file.c:395:17: sparse:    struct file *
   fs/file.c:430:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   fs/file.c:470:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] __rcu *fdt @@     got struct fdtable * @@
   fs/file.c:649:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] file @@     got struct file [noderef] __rcu * @@
   fs/file.c:807:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:858:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:1127:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] __rcu * @@
>> fs/file.c:1200:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
>> fs/file.c:1200:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
--
>> fs/namespace.c:3261:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   fs/namespace.c:3261:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/namespace.c:3261:21: sparse:     got char const *__ptr_clean
--
>> fs/utimes.c:273:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:273:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:273:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:274:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:274:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:274:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:275:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:275:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:275:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:276:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:276:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:276:21: sparse:     got signed int *__ptr_clean
>> fs/utimes.c:219:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/utimes.c:219:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:219:21: sparse:     got long *__ptr_clean
   fs/utimes.c:220:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/utimes.c:220:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:220:21: sparse:     got long *__ptr_clean
   fs/utimes.c:241:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:241:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:241:21: sparse:     got signed int *__ptr_clean
   fs/utimes.c:242:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/utimes.c:242:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/utimes.c:242:21: sparse:     got signed int *__ptr_clean
--
>> fs/nsfs.c:211:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/nsfs.c:211:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nsfs.c:211:24: sparse:     got unsigned int *__ptr_clean
>> fs/nsfs.c:211:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/nsfs.c:211:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/nsfs.c:211:24: sparse:     got unsigned int *__ptr_clean
--
>> fs/timerfd.c:316:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/timerfd.c:316:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/timerfd.c:316:23: sparse:     got unsigned long long *__ptr_clean
>> fs/timerfd.c:316:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/timerfd.c:316:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/timerfd.c:316:23: sparse:     got unsigned long long *__ptr_clean
--
>> fs/userfaultfd.c:1501:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/userfaultfd.c:1501:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/userfaultfd.c:1501:21: sparse:     got unsigned long long *__ptr_clean
>> fs/userfaultfd.c:1501:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/userfaultfd.c:1501:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/userfaultfd.c:1501:21: sparse:     got unsigned long long *__ptr_clean
>> fs/userfaultfd.c:1734:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/userfaultfd.c:1734:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/userfaultfd.c:1734:13: sparse:     got signed long long *__ptr_clean
>> fs/userfaultfd.c:1734:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/userfaultfd.c:1734:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/userfaultfd.c:1734:13: sparse:     got signed long long *__ptr_clean
   fs/userfaultfd.c:1786:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/userfaultfd.c:1786:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/userfaultfd.c:1786:13: sparse:     got signed long long *__ptr_clean
   fs/userfaultfd.c:1786:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/userfaultfd.c:1786:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/userfaultfd.c:1786:13: sparse:     got signed long long *__ptr_clean
   fs/userfaultfd.c:1897:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/userfaultfd.c:1897:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/userfaultfd.c:1897:13: sparse:     got signed long long *__ptr_clean
   fs/userfaultfd.c:1897:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/userfaultfd.c:1897:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/userfaultfd.c:1897:13: sparse:     got signed long long *__ptr_clean
--
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:326:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:326:13: sparse:     got unsigned long long *__ptr_clean
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:326:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:326:13: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:333:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:333:21: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:333:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:333:21: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:340:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:340:13: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:340:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:340:13: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:348:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:348:21: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:348:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:348:21: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:355:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_elf.c:355:13: sparse:     got unsigned long long *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/binfmt_elf.c:355:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/binfmt_elf.c:355:13: sparse:     got unsigned long long *__ptr_clean
--
>> fs/fhandle.c:72:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/fhandle.c:72:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fhandle.c:72:13: sparse:     got int *__ptr_clean
>> fs/fhandle.c:72:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/fhandle.c:72:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fhandle.c:72:13: sparse:     got int *__ptr_clean
--
   kernel/sched/core.c:264:56: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:264:56: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:264:56: sparse:    struct task_struct *
   kernel/sched/core.c:1043:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1043:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1043:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1101:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:1101:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:1101:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:2200:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2200:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2200:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2200:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2200:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2200:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3600:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:3600:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:3600:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:3797:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3797:28: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:3797:28: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:8996:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:8996:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:8996:43: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:5013:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/sched/core.c:5013:17: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core.c:5013:17: sparse:     got int *__ptr_clean
>> kernel/sched/core.c:5013:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/sched/core.c:5013:17: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sched/core.c:5013:17: sparse:     got int *__ptr_clean
   kernel/sched/core.c:5331:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5331:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5331:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5422:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5422:14: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5422:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5965:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:5965:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:5965:32: sparse:    struct task_struct *
   kernel/sched/core.c:5992:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:5992:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:5992:23: sparse:    struct task_struct *
   kernel/sched/core.c:6000:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6000:46: sparse:    struct task_struct *
   kernel/sched/core.c:6000:46: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:6055:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:6055:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:6055:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:6271:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6271:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6271:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6796:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6796:17: sparse:    struct task_struct *
   kernel/sched/core.c:6796:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7000:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7000:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7000:22: sparse:    struct task_struct *
>> kernel/sched/core.c:7633:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sched/core.c:7633:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core.c:7633:15: sparse:     got unsigned int *__ptr_clean
   kernel/sched/core.c:7663:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/sched/core.c:7663:9: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core.c:7663:9: sparse:     got unsigned int *__ptr_clean
>> kernel/sched/core.c:7663:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/sched/core.c:7663:9: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sched/core.c:7663:9: sparse:     got unsigned int *__ptr_clean
   kernel/sched/core.c:11028:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11028:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11028:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:323:9: sparse: sparse: context imbalance in 'sched_core_lock' - different lock contexts for basic block
   kernel/sched/core.c:333:17: sparse: sparse: context imbalance in 'sched_core_unlock' - unexpected unlock
   kernel/sched/core.c:547:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:572:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1162:30: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/sched.h:1170:30: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/sched.h:1170:30: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:78:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:78:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:78:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2191:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2192:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2193:37: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/core.c:2166:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2166:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2166:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2017:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2017:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2175:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2175:9: sparse:    struct task_struct *
--
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/stats.c:148:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/stats.c:148:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/stats.c:148:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/stop_task.c:73:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/stop_task.c:73:38: sparse:     expected struct task_struct *curr
   kernel/sched/stop_task.c:73:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:460:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct perf_domain *pd @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:460:19: sparse:     expected struct perf_domain *pd
   kernel/sched/topology.c:460:19: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:622:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:622:49: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:622:49: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:693:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:693:50: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:693:50: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:700:55: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child @@     got struct sched_domain *[assigned] tmp @@
   kernel/sched/topology.c:700:55: sparse:     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child
   kernel/sched/topology.c:700:55: sparse:     got struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:710:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:710:29: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:710:29: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:715:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:715:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:715:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:736:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *sd @@
   kernel/sched/topology.c:736:13: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:736:13: sparse:     got struct sched_domain [noderef] __rcu *sd
   kernel/sched/topology.c:898:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:898:70: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:898:70: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:927:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:927:59: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:927:59: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:973:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:973:57: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:973:57: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:975:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:975:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:975:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:983:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:983:55: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:983:55: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:985:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:985:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:985:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1055:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1055:62: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1055:62: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1159:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1159:40: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:1159:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1568:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain [noderef] __rcu *child @@     got struct sched_domain *child @@
   kernel/sched/topology.c:1568:43: sparse:     expected struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1568:43: sparse:     got struct sched_domain *child
   kernel/sched/topology.c:2165:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *parent @@     got struct sched_domain *sd @@
   kernel/sched/topology.c:2165:31: sparse:     expected struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2165:31: sparse:     got struct sched_domain *sd
   kernel/sched/topology.c:2268:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2268:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2268:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2289:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:2289:56: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:2289:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:2288:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2288:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2288:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2336:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2336:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2336:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
>> kernel/sched/core_sched.c:180:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   kernel/sched/core_sched.c:180:23: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/sched/core_sched.c:180:23: sparse:     got unsigned long long *__ptr_clean
>> kernel/sched/core_sched.c:180:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   kernel/sched/core_sched.c:180:23: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/sched/core_sched.c:180:23: sparse:     got unsigned long long *__ptr_clean
   kernel/sched/core_sched.c:275:37: sparse: sparse: incompatible types in conditional expression (different address spaces):
   kernel/sched/core_sched.c:275:37: sparse:    struct task_struct *
   kernel/sched/core_sched.c:275:37: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/psi.c:143:1: sparse: sparse: symbol 'psi_cgroups_enabled' was not declared. Should it be static?
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:1731:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1731:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1731:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1744:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1744:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1744:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1731:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1731:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1731:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1744:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1744:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1744:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:928:31: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1589:19: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2319:51: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2320:49: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2322:52: sparse: sparse: dereference of noderef expression
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:1170:30: sparse: sparse: context imbalance in 'sched_core_update_cookie' - wrong count at exit
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/psi.c:746:13: sparse: sparse: dereference of noderef expression
   kernel/sched/psi.c:770:38: sparse: sparse: dereference of noderef expression
   kernel/sched/psi.c:990:6: sparse: sparse: context imbalance in 'cgroup_move_task' - different lock contexts for basic block
--
>> fs/notify/inotify/inotify_user.c:322:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/notify/inotify/inotify_user.c:322:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/notify/inotify/inotify_user.c:322:23: sparse:     got int *__ptr_clean
>> fs/notify/inotify/inotify_user.c:322:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/notify/inotify/inotify_user.c:322:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/notify/inotify/inotify_user.c:322:23: sparse:     got int *__ptr_clean
   fs/notify/inotify/inotify_user.c:563:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *conn @@     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks @@
   fs/notify/inotify/inotify_user.c:563:51: sparse:     expected struct fsnotify_mark_connector *conn
   fs/notify/inotify/inotify_user.c:563:51: sparse:     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks
--
   fs/notify/fanotify/fanotify_user.c:267:63: sparse: sparse: restricted fmode_t degrades to integer
>> fs/notify/fanotify/fanotify_user.c:929:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     got int *__ptr_clean
>> fs/notify/fanotify/fanotify_user.c:929:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/notify/fanotify/fanotify_user.c:929:23: sparse:     got int *__ptr_clean
   fs/notify/fanotify/fanotify_user.c:1351:28: sparse: sparse: restricted fmode_t degrades to integer
--
>> fs/crypto/keyring.c:1003:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/crypto/keyring.c:1003:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/crypto/keyring.c:1003:23: sparse:     got unsigned int *__ptr_clean
>> fs/crypto/keyring.c:1003:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/crypto/keyring.c:1003:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/crypto/keyring.c:1003:23: sparse:     got unsigned int *__ptr_clean
--
>> fs/crypto/policy.c:445:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__ptr_clean @@
   fs/crypto/policy.c:445:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/crypto/policy.c:445:13: sparse:     got unsigned char const *__ptr_clean
--
>> drivers/acpi/apei/erst-dbg.c:73:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/acpi/apei/erst-dbg.c:73:22: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/acpi/apei/erst-dbg.c:73:22: sparse:     got unsigned int *__ptr_clean
>> drivers/acpi/apei/erst-dbg.c:73:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/acpi/apei/erst-dbg.c:73:22: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/acpi/apei/erst-dbg.c:73:22: sparse:     got unsigned int *__ptr_clean
--
>> drivers/char/random.c:1578:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1578:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1578:21: sparse:     got int *__ptr_clean
>> drivers/char/random.c:1578:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/char/random.c:1578:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/random.c:1578:21: sparse:     got int *__ptr_clean
   drivers/char/random.c:1584:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1584:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1584:21: sparse:     got int *__ptr_clean
   drivers/char/random.c:1593:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1593:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1593:21: sparse:     got int *__ptr_clean
   drivers/char/random.c:1597:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/char/random.c:1597:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/random.c:1597:21: sparse:     got int *__ptr_clean
--
>> sound/core/timer.c:2044:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/timer.c:2044:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/timer.c:2044:13: sparse:     got int *__ptr_clean
   sound/core/timer.c:2083:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/timer.c:2083:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/timer.c:2083:24: sparse:     got int *__ptr_clean
>> sound/core/timer.c:2083:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/timer.c:2083:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/timer.c:2083:24: sparse:     got int *__ptr_clean
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:92:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:92:29: sparse:     got int *__ptr_clean
   sound/core/pcm.c:97:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:97:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:97:29: sparse:     got int *__ptr_clean
>> sound/core/pcm.c:97:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/pcm.c:97:29: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm.c:97:29: sparse:     got int *__ptr_clean
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm.c:112:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:112:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:114:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:114:29: sparse:     got int *__ptr_clean
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm.c:119:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:119:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm.c:155:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm.c:155:29: sparse:     got int *__ptr_clean
--
>> sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int *__ptr_clean
--
>> sound/core/pcm_native.c:1082:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:1082:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1082:20: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:1108:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:1108:20: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:1108:20: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3039:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3134:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3134:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3134:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3135:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3135:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3135:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3136:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3136:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3136:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3171:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
>> sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3171:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3172:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3172:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3173:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *__ptr_clean
>> sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3173:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3174:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3174:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3175:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got restricted snd_pcm_state_t *__ptr_clean @@
   sound/core/pcm_native.c:3175:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3176:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3176:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3177:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   sound/core/pcm_native.c:3177:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3178:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3178:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3179:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3179:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *__ptr_clean
>> sound/core/pcm_native.c:3191:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm_native.c:3191:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3191:13: sparse:     got int *__ptr_clean
>> sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3208:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *__ptr_clean
>> sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3208:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3216:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3216:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3233:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3233:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3246:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3246:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *__ptr_clean
>> sound/core/pcm_native.c:3257:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3257:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3257:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3259:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *__ptr_clean
>> sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3259:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3262:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3262:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3273:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3273:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3273:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3275:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3275:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3278:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   sound/core/pcm_native.c:3278:13: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *__ptr_clean
   sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/pcm_native.c:3302:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3302:24: sparse:     got int *__ptr_clean
>> sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/pcm_native.c:3302:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3302:24: sparse:     got int *__ptr_clean
   sound/core/pcm_native.c:3310:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   sound/core/pcm_native.c:3310:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3310:21: sparse:     got unsigned int *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3357:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long *__ptr_clean @@
   sound/core/pcm_native.c:3357:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *__ptr_clean
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:184:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:201:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1261:44: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1331:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
   sound/core/control.c:815:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:815:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:835:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:864:41: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:957:34: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1529:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
>> sound/core/control.c:1638:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1638:13: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1638:13: sparse:     got int *__ptr_clean
   sound/core/control.c:1642:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1642:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1642:21: sparse:     got int *__ptr_clean
>> sound/core/control.c:1642:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/control.c:1642:21: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/control.c:1642:21: sparse:     got int *__ptr_clean
   sound/core/control.c:1779:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1779:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1779:24: sparse:     got int *__ptr_clean
   sound/core/control.c:1779:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/control.c:1779:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/control.c:1779:24: sparse:     got int *__ptr_clean
   sound/core/control.c:1820:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/control.c:1820:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/control.c:1820:24: sparse:     got int *__ptr_clean
   sound/core/control.c:1820:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/control.c:1820:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/control.c:1820:24: sparse:     got int *__ptr_clean
--
>> sound/core/oss/mixer_oss.c:335:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:335:29: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:335:29: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:340:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:340:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:340:32: sparse:     got int *__ptr_clean
>> sound/core/oss/mixer_oss.c:340:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:340:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:340:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:342:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:342:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:342:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:342:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:342:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:342:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:344:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:344:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:344:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:344:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:344:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:344:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:349:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:349:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:349:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:349:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:349:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:349:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:354:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:354:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:354:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:354:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:354:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:354:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:359:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:359:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:359:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:359:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:359:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:359:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:364:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:364:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:364:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:364:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:364:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:364:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:369:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:369:32: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:369:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:369:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:369:32: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:369:32: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:373:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:373:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:373:21: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:378:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:378:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:378:24: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:378:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:378:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:378:24: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:383:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:383:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/mixer_oss.c:383:24: sparse:     got int *__ptr_clean
   sound/core/oss/mixer_oss.c:383:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/mixer_oss.c:383:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/mixer_oss.c:383:24: sparse:     got int *__ptr_clean
--
>> sound/core/oss/pcm_oss.c:2608:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2608:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2608:24: sparse:     got int *__ptr_clean
>> sound/core/oss/pcm_oss.c:2608:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2608:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2608:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2610:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2610:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2610:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2610:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2610:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2610:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2636:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2636:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2636:21: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2641:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2641:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2641:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2641:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2641:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2641:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2646:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2646:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2646:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2646:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2646:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2646:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2648:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2648:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2648:21: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2654:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2654:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2654:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2654:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2654:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2654:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2659:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2659:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2659:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2659:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2659:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2659:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2661:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2661:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2661:21: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2666:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2666:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2666:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2666:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2666:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2666:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2671:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2671:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2671:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2671:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2671:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2671:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2673:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2673:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2673:21: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2678:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2678:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2678:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2678:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2678:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2678:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2683:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2683:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2683:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2683:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2683:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2683:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2690:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2690:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2690:21: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2695:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2695:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2695:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2695:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2695:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2695:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2697:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2697:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2697:21: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2704:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2704:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2704:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2704:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2704:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2704:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2717:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2717:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2717:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2717:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2717:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2717:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2722:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2722:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/oss/pcm_oss.c:2722:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2722:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2722:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/oss/pcm_oss.c:2722:24: sparse:     got int *__ptr_clean
   sound/core/oss/pcm_oss.c:2724:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/oss/pcm_oss.c:2724:21: sparse:     expected void const volatile [noderef] __user *ptr
--
>> fs/quota/quota.c:224:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:224:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:224:21: sparse:     got unsigned int *__ptr_clean
>> fs/quota/quota.c:224:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:224:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:224:21: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:298:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:298:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:298:21: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:411:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:411:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:411:13: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:411:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:411:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:411:13: sparse:     got unsigned int *__ptr_clean
>> fs/quota/quota.c:419:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:419:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:419:13: sparse:     got signed char *__ptr_clean
>> fs/quota/quota.c:419:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:419:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:419:13: sparse:     got signed char *__ptr_clean
>> fs/quota/quota.c:420:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:420:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:420:13: sparse:     got unsigned short *__ptr_clean
>> fs/quota/quota.c:420:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:420:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:420:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:421:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:421:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:421:13: sparse:     got signed char *__ptr_clean
   fs/quota/quota.c:421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:421:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:421:13: sparse:     got signed char *__ptr_clean
   fs/quota/quota.c:424:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:424:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:424:13: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:424:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:424:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:424:13: sparse:     got unsigned int *__ptr_clean
>> fs/quota/quota.c:425:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:425:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:425:13: sparse:     got signed int *__ptr_clean
>> fs/quota/quota.c:425:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:425:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:425:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:426:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:426:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:426:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:426:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:426:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:426:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:427:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:427:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:427:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:427:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:427:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:427:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:428:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:428:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:428:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:428:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:429:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:429:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:429:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:429:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:429:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:429:13: sparse:     got unsigned short *__ptr_clean
--
>> fs/proc/page.c:75:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:75:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/proc/page.c:75:21: sparse:     got unsigned long long *__ptr_clean
>> fs/proc/page.c:75:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:75:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/proc/page.c:75:21: sparse:     got unsigned long long *__ptr_clean
   fs/proc/page.c:252:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:252:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/proc/page.c:252:21: sparse:     got unsigned long long *__ptr_clean
   fs/proc/page.c:252:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:252:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/proc/page.c:252:21: sparse:     got unsigned long long *__ptr_clean
--
>> net/socket.c:1180:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1180:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1180:29: sparse:     got int *__ptr_clean
   net/socket.c:1186:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1186:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1186:31: sparse:     got int *__ptr_clean
>> net/socket.c:1186:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/socket.c:1186:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:1186:31: sparse:     got int *__ptr_clean
   net/socket.c:278:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:278:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:278:15: sparse:     got int *__ptr_clean
   net/socket.c:1606:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1606:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1606:15: sparse:     got int *__ptr_clean
   net/socket.c:1606:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/socket.c:1606:15: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:1606:15: sparse:     got int *__ptr_clean
   net/socket.c:1610:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/socket.c:1610:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1610:15: sparse:     got int *__ptr_clean
   net/socket.c:1610:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/socket.c:1610:15: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:1610:15: sparse:     got int *__ptr_clean
>> net/socket.c:2558:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/socket.c:2558:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:2558:31: sparse:     got unsigned int *__ptr_clean
>> net/socket.c:2558:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/socket.c:2558:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:2558:31: sparse:     got unsigned int *__ptr_clean
   net/socket.c:2774:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/socket.c:2774:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:2774:31: sparse:     got unsigned int *__ptr_clean
   net/socket.c:2774:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/socket.c:2774:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/socket.c:2774:31: sparse:     got unsigned int *__ptr_clean
--
>> net/core/dev_ioctl.c:79:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/dev_ioctl.c:79:16: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/dev_ioctl.c:79:16: sparse:     got int *__ptr_clean
>> net/core/dev_ioctl.c:79:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/dev_ioctl.c:79:16: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/dev_ioctl.c:79:16: sparse:     got int *__ptr_clean
--
>> net/core/scm.c:324:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/scm.c:324:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/scm.c:324:23: sparse:     got int *__ptr_clean
>> net/core/scm.c:324:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/scm.c:324:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/scm.c:324:23: sparse:     got int *__ptr_clean
   net/core/scm.c:326:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/scm.c:326:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/scm.c:326:31: sparse:     got int *__ptr_clean
   net/core/scm.c:326:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/scm.c:326:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/scm.c:326:31: sparse:     got int *__ptr_clean
>> net/core/scm.c:328:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   net/core/scm.c:328:31: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/scm.c:328:31: sparse:     got unsigned long *__ptr_clean
>> net/core/scm.c:328:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   net/core/scm.c:328:31: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/scm.c:328:31: sparse:     got unsigned long *__ptr_clean
--
>> net/core/sock.c:717:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:717:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:717:13: sparse:     got int *__ptr_clean
>> net/core/sock.c:717:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/sock.c:717:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:717:13: sparse:     got int *__ptr_clean
>> net/core/sock.c:1498:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/core/sock.c:1498:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1498:21: sparse:     got unsigned int *__ptr_clean
>> net/core/sock.c:1498:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/core/sock.c:1498:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:1498:21: sparse:     got unsigned int *__ptr_clean
   net/core/sock.c:1524:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:1524:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1524:13: sparse:     got int *__ptr_clean
   net/core/sock.c:1677:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:1677:32: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1677:32: sparse:     got int *__ptr_clean
   net/core/sock.c:1677:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/sock.c:1677:32: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:1677:32: sparse:     got int *__ptr_clean
   net/core/sock.c:1862:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/core/sock.c:1862:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1862:13: sparse:     got int *__ptr_clean
   net/core/sock.c:1862:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/core/sock.c:1862:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/core/sock.c:1862:13: sparse:     got int *__ptr_clean
   net/core/sock.c:2249:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2253:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:3810:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:3822:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit
--
>> drivers/firewire/core-cdev.c:1108:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/firewire/core-cdev.c:1108:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firewire/core-cdev.c:1108:21: sparse:     got unsigned int *__ptr_clean
--
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse:     got int *__ptr_clean
>> sound/core/seq/oss/seq_oss_timer.c:229:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int *__ptr_clean
--
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse:     got int *__ptr_clean
>> sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse:     got int *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse:     expected void [noderef] __user *__ptr_pu
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse:     got int *__ptr_clean
--
>> drivers/fpga/dfl.c:1831:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/fpga/dfl.c:1831:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl.c:1831:16: sparse:     got unsigned int *__ptr_clean
>> drivers/fpga/dfl.c:1831:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/fpga/dfl.c:1831:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/fpga/dfl.c:1831:16: sparse:     got unsigned int *__ptr_clean
--
>> drivers/pps/pps.c:170:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/pps/pps.c:170:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/pps/pps.c:170:23: sparse:     got int *__ptr_clean
>> drivers/pps/pps.c:170:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/pps/pps.c:170:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/pps/pps.c:170:23: sparse:     got int *__ptr_clean
--
>> drivers/gpu/drm/drm_crtc.c:785:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_crtc.c:785:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_crtc.c:785:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_connector.c:2683:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/drm_connector.c:2683:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_connector.c:2683:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_mode_object.c:404:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/drm_mode_object.c:404:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/drm_mode_object.c:407:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     got unsigned long long *__ptr_clean
>> drivers/gpu/drm/drm_mode_object.c:407:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/gpu/drm/drm_property.c:484:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_property.c:484:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_property.c:484:21: sparse:     got unsigned long long *__ptr_clean
>> drivers/gpu/drm/drm_property.c:484:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/gpu/drm/drm_property.c:484:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_property.c:484:21: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/gpu/drm/drm_plane.c:672:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/drm_plane.c:672:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_mode_config.c:113:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/drm_mode_config.c:113:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:113:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:132:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:143:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_mode_config.c:160:29: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_lease.c:614:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     got unsigned int *__ptr_clean
>> drivers/gpu/drm/drm_lease.c:614:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_lease.c:669:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_lease.c:669:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     got unsigned int *__ptr_clean
--
>> drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     got signed int *__ptr_clean
>> drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:381:13: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:483:21: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:1134:13: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     got signed int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/gpu/drm/drm_atomic_uapi.c:1310:21: sparse:     got signed int *__ptr_clean
>> drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1389:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1406:21: sparse:     got unsigned int *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_atomic_uapi.c:1419:29: sparse:     got unsigned int *__ptr_clean
--
>> net/netlink/af_netlink.c:1730:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1730:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1730:13: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1741:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1741:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1741:21: sparse:     got int *__ptr_clean
>> net/netlink/af_netlink.c:1741:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1741:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1741:21: sparse:     got int *__ptr_clean
>> net/netlink/af_netlink.c:1742:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1742:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1742:21: sparse:     got char *__ptr_clean
>> net/netlink/af_netlink.c:1742:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1742:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1742:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1751:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1751:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1751:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1751:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1751:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1752:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1752:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1752:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1752:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1752:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1752:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1761:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1761:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1761:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1761:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1761:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1761:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1762:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1762:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1762:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1762:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1762:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1762:21: sparse:     got char *__ptr_clean
>> net/netlink/af_netlink.c:1777:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/netlink/af_netlink.c:1777:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1777:29: sparse:     got unsigned int *__ptr_clean
>> net/netlink/af_netlink.c:1777:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/netlink/af_netlink.c:1777:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1777:29: sparse:     got unsigned int *__ptr_clean
   net/netlink/af_netlink.c:1783:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1783:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1783:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1783:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1783:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1783:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1793:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1793:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1793:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1793:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1793:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1793:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1794:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1794:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1794:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1794:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1794:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1794:21: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1803:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1803:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1803:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1803:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1803:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1803:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1803:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1803:46: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1803:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1803:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1803:46: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1803:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1812:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1812:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1812:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1812:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/netlink/af_netlink.c:1812:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1812:21: sparse:     got int *__ptr_clean
   net/netlink/af_netlink.c:1812:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1812:46: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1812:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:1812:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/netlink/af_netlink.c:1812:46: sparse:     expected void [noderef] __user *__ptr_pu
   net/netlink/af_netlink.c:1812:46: sparse:     got char *__ptr_clean
   net/netlink/af_netlink.c:2563:13: sparse: sparse: context imbalance in 'netlink_walk_start' - wrong count at exit
   net/netlink/af_netlink.c:2569:13: sparse: sparse: context imbalance in 'netlink_walk_stop' - unexpected unlock
   net/netlink/af_netlink.c:2619:9: sparse: sparse: context imbalance in 'netlink_seq_start' - wrong count at exit
--
>> drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *__ptr_clean
>> drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *__ptr_clean
--
>> fs/autofs/root.c:820:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/root.c:820:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:820:16: sparse:     got int *__ptr_clean
>> fs/autofs/root.c:820:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/autofs/root.c:820:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:820:16: sparse:     got int *__ptr_clean
   fs/autofs/root.c:827:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/root.c:827:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:827:16: sparse:     got int *__ptr_clean
   fs/autofs/root.c:827:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/autofs/root.c:827:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:827:16: sparse:     got int *__ptr_clean
>> fs/autofs/root.c:798:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/autofs/root.c:798:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:798:14: sparse:     got unsigned long *__ptr_clean
   fs/autofs/root.c:802:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   fs/autofs/root.c:802:14: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:802:14: sparse:     got unsigned long *__ptr_clean
>> fs/autofs/root.c:802:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   fs/autofs/root.c:802:14: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:802:14: sparse:     got unsigned long *__ptr_clean
   fs/autofs/root.c:842:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/root.c:842:18: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/root.c:842:18: sparse:     got int *__ptr_clean
   fs/autofs/root.c:842:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/autofs/root.c:842:18: sparse:     expected void [noderef] __user *__ptr_pu
   fs/autofs/root.c:842:18: sparse:     got int *__ptr_clean
--
>> fs/autofs/expire.c:616:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/autofs/expire.c:616:20: sparse:     expected void const volatile [noderef] __user *ptr
   fs/autofs/expire.c:616:20: sparse:     got int *__ptr_clean

vim +449 drivers/tee/tee_core.c

967c9cca2cc505 Jens Wiklander      2015-03-11  436  
967c9cca2cc505 Jens Wiklander      2015-03-11  437  static int params_to_user(struct tee_ioctl_param __user *uparams,
967c9cca2cc505 Jens Wiklander      2015-03-11  438  			  size_t num_params, struct tee_param *params)
967c9cca2cc505 Jens Wiklander      2015-03-11  439  {
967c9cca2cc505 Jens Wiklander      2015-03-11  440  	size_t n;
967c9cca2cc505 Jens Wiklander      2015-03-11  441  
967c9cca2cc505 Jens Wiklander      2015-03-11  442  	for (n = 0; n < num_params; n++) {
967c9cca2cc505 Jens Wiklander      2015-03-11  443  		struct tee_ioctl_param __user *up = uparams + n;
967c9cca2cc505 Jens Wiklander      2015-03-11  444  		struct tee_param *p = params + n;
967c9cca2cc505 Jens Wiklander      2015-03-11  445  
967c9cca2cc505 Jens Wiklander      2015-03-11  446  		switch (p->attr) {
967c9cca2cc505 Jens Wiklander      2015-03-11  447  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
967c9cca2cc505 Jens Wiklander      2015-03-11  448  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
967c9cca2cc505 Jens Wiklander      2015-03-11 @449  			if (put_user(p->u.value.a, &up->a) ||
967c9cca2cc505 Jens Wiklander      2015-03-11  450  			    put_user(p->u.value.b, &up->b) ||
967c9cca2cc505 Jens Wiklander      2015-03-11  451  			    put_user(p->u.value.c, &up->c))
967c9cca2cc505 Jens Wiklander      2015-03-11  452  				return -EFAULT;
967c9cca2cc505 Jens Wiklander      2015-03-11  453  			break;
967c9cca2cc505 Jens Wiklander      2015-03-11  454  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
967c9cca2cc505 Jens Wiklander      2015-03-11  455  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
967c9cca2cc505 Jens Wiklander      2015-03-11  456  			if (put_user((u64)p->u.memref.size, &up->b))
967c9cca2cc505 Jens Wiklander      2015-03-11  457  				return -EFAULT;
963cdcc37e98b8 Gustavo A. R. Silva 2020-11-20  458  			break;
967c9cca2cc505 Jens Wiklander      2015-03-11  459  		default:
967c9cca2cc505 Jens Wiklander      2015-03-11  460  			break;
967c9cca2cc505 Jens Wiklander      2015-03-11  461  		}
967c9cca2cc505 Jens Wiklander      2015-03-11  462  	}
967c9cca2cc505 Jens Wiklander      2015-03-11  463  	return 0;
967c9cca2cc505 Jens Wiklander      2015-03-11  464  }
967c9cca2cc505 Jens Wiklander      2015-03-11  465  
967c9cca2cc505 Jens Wiklander      2015-03-11  466  static int tee_ioctl_open_session(struct tee_context *ctx,
967c9cca2cc505 Jens Wiklander      2015-03-11  467  				  struct tee_ioctl_buf_data __user *ubuf)
967c9cca2cc505 Jens Wiklander      2015-03-11  468  {
967c9cca2cc505 Jens Wiklander      2015-03-11  469  	int rc;
967c9cca2cc505 Jens Wiklander      2015-03-11  470  	size_t n;
967c9cca2cc505 Jens Wiklander      2015-03-11  471  	struct tee_ioctl_buf_data buf;
967c9cca2cc505 Jens Wiklander      2015-03-11  472  	struct tee_ioctl_open_session_arg __user *uarg;
967c9cca2cc505 Jens Wiklander      2015-03-11  473  	struct tee_ioctl_open_session_arg arg;
967c9cca2cc505 Jens Wiklander      2015-03-11  474  	struct tee_ioctl_param __user *uparams = NULL;
967c9cca2cc505 Jens Wiklander      2015-03-11  475  	struct tee_param *params = NULL;
967c9cca2cc505 Jens Wiklander      2015-03-11  476  	bool have_session = false;
967c9cca2cc505 Jens Wiklander      2015-03-11  477  
967c9cca2cc505 Jens Wiklander      2015-03-11  478  	if (!ctx->teedev->desc->ops->open_session)
967c9cca2cc505 Jens Wiklander      2015-03-11  479  		return -EINVAL;
967c9cca2cc505 Jens Wiklander      2015-03-11  480  
967c9cca2cc505 Jens Wiklander      2015-03-11  481  	if (copy_from_user(&buf, ubuf, sizeof(buf)))
967c9cca2cc505 Jens Wiklander      2015-03-11  482  		return -EFAULT;
967c9cca2cc505 Jens Wiklander      2015-03-11  483  
967c9cca2cc505 Jens Wiklander      2015-03-11  484  	if (buf.buf_len > TEE_MAX_ARG_SIZE ||
967c9cca2cc505 Jens Wiklander      2015-03-11  485  	    buf.buf_len < sizeof(struct tee_ioctl_open_session_arg))
967c9cca2cc505 Jens Wiklander      2015-03-11  486  		return -EINVAL;
967c9cca2cc505 Jens Wiklander      2015-03-11  487  
967c9cca2cc505 Jens Wiklander      2015-03-11  488  	uarg = u64_to_user_ptr(buf.buf_ptr);
967c9cca2cc505 Jens Wiklander      2015-03-11  489  	if (copy_from_user(&arg, uarg, sizeof(arg)))
967c9cca2cc505 Jens Wiklander      2015-03-11  490  		return -EFAULT;
967c9cca2cc505 Jens Wiklander      2015-03-11  491  
967c9cca2cc505 Jens Wiklander      2015-03-11  492  	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
967c9cca2cc505 Jens Wiklander      2015-03-11  493  		return -EINVAL;
967c9cca2cc505 Jens Wiklander      2015-03-11  494  
967c9cca2cc505 Jens Wiklander      2015-03-11  495  	if (arg.num_params) {
967c9cca2cc505 Jens Wiklander      2015-03-11  496  		params = kcalloc(arg.num_params, sizeof(struct tee_param),
967c9cca2cc505 Jens Wiklander      2015-03-11  497  				 GFP_KERNEL);
967c9cca2cc505 Jens Wiklander      2015-03-11  498  		if (!params)
967c9cca2cc505 Jens Wiklander      2015-03-11  499  			return -ENOMEM;
967c9cca2cc505 Jens Wiklander      2015-03-11  500  		uparams = uarg->params;
967c9cca2cc505 Jens Wiklander      2015-03-11  501  		rc = params_from_user(ctx, params, arg.num_params, uparams);
967c9cca2cc505 Jens Wiklander      2015-03-11  502  		if (rc)
967c9cca2cc505 Jens Wiklander      2015-03-11  503  			goto out;
967c9cca2cc505 Jens Wiklander      2015-03-11  504  	}
967c9cca2cc505 Jens Wiklander      2015-03-11  505  
104edb94cc4b31 Sumit Garg          2020-03-27  506  	if (arg.clnt_login >= TEE_IOCTL_LOGIN_REE_KERNEL_MIN &&
104edb94cc4b31 Sumit Garg          2020-03-27  507  	    arg.clnt_login <= TEE_IOCTL_LOGIN_REE_KERNEL_MAX) {
104edb94cc4b31 Sumit Garg          2020-03-27  508  		pr_debug("login method not allowed for user-space client\n");
104edb94cc4b31 Sumit Garg          2020-03-27  509  		rc = -EPERM;
104edb94cc4b31 Sumit Garg          2020-03-27  510  		goto out;
104edb94cc4b31 Sumit Garg          2020-03-27  511  	}
104edb94cc4b31 Sumit Garg          2020-03-27  512  
967c9cca2cc505 Jens Wiklander      2015-03-11  513  	rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
967c9cca2cc505 Jens Wiklander      2015-03-11  514  	if (rc)
967c9cca2cc505 Jens Wiklander      2015-03-11  515  		goto out;
967c9cca2cc505 Jens Wiklander      2015-03-11  516  	have_session = true;
967c9cca2cc505 Jens Wiklander      2015-03-11  517  
967c9cca2cc505 Jens Wiklander      2015-03-11 @518  	if (put_user(arg.session, &uarg->session) ||
967c9cca2cc505 Jens Wiklander      2015-03-11  519  	    put_user(arg.ret, &uarg->ret) ||
967c9cca2cc505 Jens Wiklander      2015-03-11  520  	    put_user(arg.ret_origin, &uarg->ret_origin)) {
967c9cca2cc505 Jens Wiklander      2015-03-11  521  		rc = -EFAULT;
967c9cca2cc505 Jens Wiklander      2015-03-11  522  		goto out;
967c9cca2cc505 Jens Wiklander      2015-03-11  523  	}
967c9cca2cc505 Jens Wiklander      2015-03-11  524  	rc = params_to_user(uparams, arg.num_params, params);
967c9cca2cc505 Jens Wiklander      2015-03-11  525  out:
967c9cca2cc505 Jens Wiklander      2015-03-11  526  	/*
967c9cca2cc505 Jens Wiklander      2015-03-11  527  	 * If we've succeeded to open the session but failed to communicate
967c9cca2cc505 Jens Wiklander      2015-03-11  528  	 * it back to user space, close the session again to avoid leakage.
967c9cca2cc505 Jens Wiklander      2015-03-11  529  	 */
967c9cca2cc505 Jens Wiklander      2015-03-11  530  	if (rc && have_session && ctx->teedev->desc->ops->close_session)
967c9cca2cc505 Jens Wiklander      2015-03-11  531  		ctx->teedev->desc->ops->close_session(ctx, arg.session);
967c9cca2cc505 Jens Wiklander      2015-03-11  532  
967c9cca2cc505 Jens Wiklander      2015-03-11  533  	if (params) {
967c9cca2cc505 Jens Wiklander      2015-03-11  534  		/* Decrease ref count for all valid shared memory pointers */
967c9cca2cc505 Jens Wiklander      2015-03-11  535  		for (n = 0; n < arg.num_params; n++)
84debcc53533f1 Jens Wiklander      2016-12-23  536  			if (tee_param_is_memref(params + n) &&
967c9cca2cc505 Jens Wiklander      2015-03-11  537  			    params[n].u.memref.shm)
967c9cca2cc505 Jens Wiklander      2015-03-11  538  				tee_shm_put(params[n].u.memref.shm);
967c9cca2cc505 Jens Wiklander      2015-03-11  539  		kfree(params);
967c9cca2cc505 Jens Wiklander      2015-03-11  540  	}
967c9cca2cc505 Jens Wiklander      2015-03-11  541  
967c9cca2cc505 Jens Wiklander      2015-03-11  542  	return rc;
967c9cca2cc505 Jens Wiklander      2015-03-11  543  }
967c9cca2cc505 Jens Wiklander      2015-03-11  544  

:::::: The code at line 449 was first introduced by commit
:::::: 967c9cca2cc50569efc65945325c173cecba83bd tee: generic TEE subsystem

:::::: TO: Jens Wiklander <jens.wiklander@linaro.org>
:::::: CC: Jens Wiklander <jens.wiklander@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
