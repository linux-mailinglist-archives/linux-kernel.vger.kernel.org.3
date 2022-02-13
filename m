Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168AD4B39F1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiBMHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 02:38:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiBMHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 02:38:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784E55E178
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644737902; x=1676273902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6nfLP+ycixpiW1/ie4TZJwbviTHKJoLPmBzM22i4RI4=;
  b=RZ9ucy5iWLnBuPrqZkMJ9lLxtbWC3ryDAevmd5CF87oxSreTbQ1FdotX
   zVpVRtQZbiNRepogbaO70542aFrKFuw70zrz9qz+VRBjpbzee3fefBGQr
   dH1W1eQhESep39cf5/NSxKsuLCe5sAD5eEEYk9xvYw2ReN0Lg8MGqxHQN
   fWHs26px78av07LEmRhGiAJYoCcEM2I4XrZqltlA4TyNeMit1yFDEoBAO
   gxIN7UuhLNkV3SBeJi8hE6X094FdaFdplW+Fd8RTLPF38xlNyUiFvy2wA
   a2m8Vz7HqzIMAXNyRkAKPyTqLmIC3r3ikw+yTQBoEbzfalaCUgNtwqTE2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="229892458"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="229892458"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 23:38:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="493282456"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2022 23:38:20 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ9Sd-0007Eh-LC; Sun, 13 Feb 2022 07:38:19 +0000
Date:   Sun, 13 Feb 2022 15:37:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:set_fs 6/11] lib/test_lockup.c:420:13: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202202131523.w4Vvi8jc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs
head:   0a081326831928b0d739bce68b8c0f9138b9c8ba
commit: a954036380ae20dbfa0c203bf6cafb21d1f3cedd [6/11] uaccess: generalize access_ok()
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220213/202202131523.w4Vvi8jc-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs
        git checkout a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/test_lockup.c:420:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got void *ptr @@
   lib/test_lockup.c:420:13: sparse:     expected void const [noderef] __user *ptr
   lib/test_lockup.c:420:13: sparse:     got void *ptr
>> lib/test_lockup.c:421:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got void * @@
   lib/test_lockup.c:421:13: sparse:     expected void const [noderef] __user *ptr
   lib/test_lockup.c:421:13: sparse:     got void *
   lib/test_lockup.c:230:9: sparse: sparse: context imbalance in 'test_lock' - wrong count at exit
   lib/test_lockup.c:250:25: sparse: sparse: context imbalance in 'test_unlock' - unexpected unlock

vim +420 lib/test_lockup.c

30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  410  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  411  static bool test_kernel_ptr(unsigned long addr, int size)
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  412  {
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  413  	void *ptr = (void *)addr;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  414  	char buf;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  415  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  416  	if (!addr)
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  417  		return false;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  418  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  419  	/* should be at least readable kernel address */
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06 @420  	if (access_ok(ptr, 1) ||
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06 @421  	    access_ok(ptr + size - 1, 1) ||
25f12ae45fc193 Christoph Hellwig     2020-06-17  422  	    get_kernel_nofault(buf, ptr) ||
25f12ae45fc193 Christoph Hellwig     2020-06-17  423  	    get_kernel_nofault(buf, ptr + size - 1)) {
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  424  		pr_err("invalid kernel ptr: %#lx\n", addr);
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  425  		return true;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  426  	}
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  427  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  428  	return false;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  429  }
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  430  

:::::: The code at line 420 was first introduced by commit
:::::: 30428ef5d1e8caf78639cc70a802f1cb7b1cec04 lib/test_lockup: test module to generate lockups

:::::: TO: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
