Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE6579014
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiGSBvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGSBu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:50:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FF2DD8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658195445; x=1689731445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fhLwln5nIB+9UXJvhTEmINGdGC6+zmVBVYI2XZD551E=;
  b=L7UcE6PbYYL4TDSaRB6EpFN5CE5vSsKto/iniT0TznagEOaQAeshdYUA
   IbgsWZMxTYfV7dxWqRjNxz17ugS5ydKCBJL6PRMnGoaELJE1C7opeedWc
   cxs3bYPZuu5Kdy4UmP5XW1vFxNevx6CZXtgmAykVQt2Ed3+y4t1NAOEep
   vX/rpsUW15ka4hltGHdRcKOPNt1ZKqBCwMlL18KfPc8p4pPEFUedh7Ejm
   NSomtzDDLgksr75UbZzeko/q7kJHWOBfJHazD4g4n5eWkBt65Rgplqsrc
   0WKOVsc+pAQk/XpAHh6eLa5Ih1t6QQZQuuCoB/dNt7AkpXSahTIZICE+H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283926021"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="283926021"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="547718641"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2022 18:50:06 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDcNC-00058z-0O;
        Tue, 19 Jul 2022 01:50:06 +0000
Date:   Tue, 19 Jul 2022 09:49:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: ../include/futex2test.h:18:47: warning: 'struct futex_waitv'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202207190947.pa3kz27F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: 5e59c1d1c78c9cdd8834f3242db4a76f617fa4ad selftests: futex: Add sys_futex_waitv() test
date:   10 months ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from futex_waitv.c:19:
>> ../include/futex2test.h:18:47: warning: 'struct futex_waitv' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
         |                                               ^~~~~~~~~~~
   ../include/futex2test.h: In function 'futex_waitv':
   ../include/futex2test.h:21:24: error: '__NR_futex_waitv' undeclared (first use in this function); did you mean 'futex_waitv'?
      21 |         return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
         |                        ^~~~~~~~~~~~~~~~
         |                        futex_waitv
   ../include/futex2test.h:21:24: note: each undeclared identifier is reported only once for each function it appears in
   futex_waitv.c: At top level:
   futex_waitv.c:25:27: error: array type has incomplete element type 'struct futex_waitv'
      25 | static struct futex_waitv waitv[NR_FUTEXES];
         |                           ^~~~~
   futex_waitv.c: In function 'main':
   futex_waitv.c:91:34: error: 'FUTEX_32' undeclared (first use in this function); did you mean 'FUTEX_OP'?
      91 |                 waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
         |                                  ^~~~~~~~
         |                                  FUTEX_OP
   In file included from futex_waitv.c:19:
   ../include/futex2test.h: In function 'futex_waitv':
>> ../include/futex2test.h:22:1: warning: control reaches end of non-void function [-Wreturn-type]
      22 | }
         | ^
   At top level:
>> futex_waitv.c:25:27: warning: 'waitv' defined but not used [-Wunused-variable]
      25 | static struct futex_waitv waitv[NR_FUTEXES];
         |                           ^~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
