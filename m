Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58893579117
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiGSDBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiGSDBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:01:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0811237D7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 20:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658199658; x=1689735658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C6yvuzfFgrNoyEtzDddIYH2OnhftRML6Oun1IRdZpU4=;
  b=JHT2uysp2uiBefEWe829SKieKuE8mbBZTO6KRgWiLB1dN2kKHpEf4gs3
   wXUHp8RGcyRyxA2UiJLLV8HHcNHjJFz76s43P5i2Yf8d++k+f1HInOIrI
   ONYZIqLZnPOu+0XJGzY6QPBKEwzdqeSxTCX8aZX3oNpZ63q/lkAQbCnJD
   HHj3i007er0Spj+JCKQgUo5D+JK691GRC8G0NEeebm9QenK5E7dZLgwur
   Tzqn45i5BQkznfrNex9vu1JeMp1Qz3hLPyCeapZX9CN+vB85UNGsEQ6ZZ
   CG9rc+McxPMItXTe9AFv3IhxNpYj2d0SkIOuIIsmk0xKWjViavjqzh+Yl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="273203237"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="273203237"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 20:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="547734265"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2022 20:00:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDdTk-0005Cy-4g;
        Tue, 19 Jul 2022 03:00:56 +0000
Date:   Tue, 19 Jul 2022 11:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: futex_wait_timeout.c:101:34: warning: excess elements in struct
 initializer
Message-ID: <202207191049.VUHHxQmE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: 02e56ccbaefcb1a78bd089a7b5beca754aca4db9 selftests: futex: Test sys_futex_waitv() timeout
date:   10 months ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from futex_wait_timeout.c:20:
   ../include/futex2test.h:18:47: warning: 'struct futex_waitv' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
         |                                               ^~~~~~~~~~~
   ../include/futex2test.h: In function 'futex_waitv':
   ../include/futex2test.h:21:24: error: '__NR_futex_waitv' undeclared (first use in this function); did you mean 'futex_waitv'?
      21 |         return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
         |                        ^~~~~~~~~~~~~~~~
         |                        futex_waitv
   ../include/futex2test.h:21:24: note: each undeclared identifier is reported only once for each function it appears in
   futex_wait_timeout.c: In function 'main':
   futex_wait_timeout.c:100:16: error: variable 'waitv' has initializer but incomplete type
     100 |         struct futex_waitv waitv = {
         |                ^~~~~~~~~~~
   futex_wait_timeout.c:101:26: error: 'struct futex_waitv' has no member named 'uaddr'
     101 |                         .uaddr = (uintptr_t)&f1,
         |                          ^~~~~
>> futex_wait_timeout.c:101:34: warning: excess elements in struct initializer
     101 |                         .uaddr = (uintptr_t)&f1,
         |                                  ^
   futex_wait_timeout.c:101:34: note: (near initialization for 'waitv')
   futex_wait_timeout.c:102:26: error: 'struct futex_waitv' has no member named 'val'
     102 |                         .val = f1,
         |                          ^~~
   futex_wait_timeout.c:102:32: warning: excess elements in struct initializer
     102 |                         .val = f1,
         |                                ^~
   futex_wait_timeout.c:102:32: note: (near initialization for 'waitv')
   futex_wait_timeout.c:103:26: error: 'struct futex_waitv' has no member named 'flags'
     103 |                         .flags = FUTEX_32,
         |                          ^~~~~
   futex_wait_timeout.c:103:34: error: 'FUTEX_32' undeclared (first use in this function); did you mean 'FUTEX_OP'?
     103 |                         .flags = FUTEX_32,
         |                                  ^~~~~~~~
         |                                  FUTEX_OP
   futex_wait_timeout.c:103:34: warning: excess elements in struct initializer
   futex_wait_timeout.c:103:34: note: (near initialization for 'waitv')
   futex_wait_timeout.c:104:26: error: 'struct futex_waitv' has no member named '__reserved'
     104 |                         .__reserved = 0
         |                          ^~~~~~~~~~
   futex_wait_timeout.c:104:39: warning: excess elements in struct initializer
     104 |                         .__reserved = 0
         |                                       ^
   futex_wait_timeout.c:104:39: note: (near initialization for 'waitv')
   futex_wait_timeout.c:100:28: error: storage size of 'waitv' isn't known
     100 |         struct futex_waitv waitv = {
         |                            ^~~~~
>> futex_wait_timeout.c:100:28: warning: unused variable 'waitv' [-Wunused-variable]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
