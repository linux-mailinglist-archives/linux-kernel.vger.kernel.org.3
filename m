Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318794BDC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357012AbiBULzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:55:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356977AbiBULzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:55:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082F14092
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645444515; x=1676980515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xtEvAXlznXfq+n86L7vUawxXnTP/M/7+XuTruWUM/Fk=;
  b=HX9mP2ZMcDZu54XNGf0dCIjOo65vA/Q6+ehQe6dmHMbI6V9EP4eEGvIP
   HXB1RUFcldlkqWQZ2E40rZV9/fv/IzXSMY865bSj/jThSi2FwvBEb8j8A
   K+FgJRjO59mUbdZMzIXUrRZur1mHFt9h+Z04QWDrxSkCCdj8vWEDXkvX/
   yHGM+1ahgBIIIrwwsflykZcACdH6KMoOUFWYpdVIIJeyS7epQy2RhpBCT
   i3LQxxWikLkL6OC/HRBJXyD1iD3HLOrgW5pa37l5DfQNmNUz+VA35pM2u
   sR2TKXkTkiX+k9t0HzwB4xL1iFt6tquhmsFlyZwGJMObp2Y9t0LJ7+G4v
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="232115671"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="232115671"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 03:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="507612280"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 03:55:14 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM7Hd-0001Yc-HZ; Mon, 21 Feb 2022 11:55:13 +0000
Date:   Mon, 21 Feb 2022 19:54:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:generic-get_user-prototype 3/3]
 include/linux/uaccess.h:546:4: warning: variable 'v' set but not used
Message-ID: <202202211934.btUGYgRN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git generic-get_user-prototype
head:   23cc2497095e8c0820d042f28c507aded31674c1
commit: 23cc2497095e8c0820d042f28c507aded31674c1 [3/3] uaccess: add new generic get_user/put_user
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220221/202202211934.btUGYgRN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=23cc2497095e8c0820d042f28c507aded31674c1
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground generic-get_user-prototype
        git checkout 23cc2497095e8c0820d042f28c507aded31674c1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/irq_work.h:6,
                    from arch/x86/include/asm/nmi.h:5,
                    from include/linux/nmi.h:212,
                    from arch/x86/include/asm/mshyperv.h:6,
                    from include/clocksource/hyperv_timer.h:18,
                    from arch/x86/include/asm/vdso/gettimeofday.h:21,
                    from include/vdso/datapage.h:137,
                    from arch/x86/entry/vdso/vdso32/../../../../../lib/vdso/gettimeofday.c:5,
                    from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/x86/entry/vdso/vdso32/vclock_gettime.c:29:
   include/linux/uaccess.h: In function 'raw_put_user_u64':
>> include/linux/uaccess.h:546:4: warning: variable 'v' set but not used [-Wunused-but-set-variable]
     546 |  } v;
         |    ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:29:
   arch/x86/entry/vdso/vdso32/../vclock_gettime.c: At top level:
   arch/x86/entry/vdso/vdso32/../vclock_gettime.c:70:5: warning: no previous prototype for '__vdso_clock_gettime64' [-Wmissing-prototypes]
      70 | int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/v +546 include/linux/uaccess.h

   538	
   539	#ifndef CONFIG_64BIT
   540	static __always_inline int
   541	raw_put_user_u64(u64 __user *to, u64 val, size_t size, bool check)
   542	{
   543		union {
   544			u64 v64;
   545			u32 v32[2];
 > 546		} v;
   547		int err;
   548	
   549		if (check) {
   550			if (!access_ok(to, size))
   551				return -EFAULT;
   552			might_fault();
   553		}
   554		if (0)
   555			goto out;
   556	
   557		__uaccess_begin_nospec();
   558	
   559		v.v64 = val;
   560		err = 0;
   561	#ifdef __put_user_asm_8
   562		__put_user_asm_8(val, to, err, out);
   563	#else
   564		__put_user_asm_4(v.v32[0], (u32 __user*)to, err, out);
   565		if (!err)
   566			__put_user_asm_4(v.v32[1], (u32 __user*)to + 1, err, out);
   567	#endif
   568		__uaccess_end();
   569		return err;
   570	out:
   571		__uaccess_end();
   572		return -EFAULT;
   573	}
   574	#define raw_put_user_word(to, val, err, out)				\
   575		__builtin_choose_expr(sizeof(*to) == 8,				\
   576			raw_put_user_u64, raw_put_user_word)(to, val, err, out)
   577	#endif
   578	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
