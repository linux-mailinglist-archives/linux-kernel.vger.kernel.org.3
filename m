Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78D44FA19B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiDICVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiDICVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:21:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6331E8164
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649470735; x=1681006735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S9CkP8xt7lpwuijzE1r4/xuc3kMnKC8m+tu+GwwGSB0=;
  b=fMhy2mPYzcsUGFxk3dAOUdjgYLWwhun8Y8Gqq9QBlYFbsb+W+tP5l3JJ
   sJMQchWaamt8RQ5o7I5wrULFFG0OK/wxwR+93GWpwwf2NzfjXzx2VSSBT
   sgHUjPNxqIQbdVWsRiQbdslV+kddirr96TJrML3E3/wKRkPK5eVzAwqHx
   h42FN+z9oTPCSQW/fWaD5Ahor0s+5CkOZ3PvCxTH30aPglYwYdR/OtHUC
   +tNDcxhtUgy8+Sh/wsLwGW7DIIjgW8FKz6imd5BZY3rlyUVef1oLY93gn
   hKq7Tw79yJ3wZeQZnAE0/mDncUVrnEjTTZZHeXjczPtzFquDkwmjuZmWW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260590564"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="260590564"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 19:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="610016041"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2022 19:18:53 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd0gf-0000oT-4A;
        Sat, 09 Apr 2022 02:18:53 +0000
Date:   Sat, 9 Apr 2022 10:18:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/not-zero-entropy 3/11]
 include/linux/timex.h:53: error: unterminated #ifndef
Message-ID: <202204091017.NKyTrDSt-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/not-zero-entropy
head:   ac7d8411f0216fe77e48592ed0ff2ccbd599d0de
commit: cd8e5ab92f409b4ff310fd7188f9145b5bb66fad [3/11] random: use sched_clock() for random_get_entropy() if no get_cycles()
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220409/202204091017.NKyTrDSt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/cd8e5ab92f409b4ff310fd7188f9145b5bb66fad
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/not-zero-entropy
        git checkout cd8e5ab92f409b4ff310fd7188f9145b5bb66fad
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/timex.h:53: error: unterminated #ifndef
      53 | #ifndef _LINUX_TIMEX_H
         | 
   In file included from include/linux/jiffies.h:11,
                    from include/linux/ktime.h:25,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/timex.h:53: error: unterminated #ifndef
      53 | #ifndef _LINUX_TIMEX_H
         | 
   make[2]: *** [scripts/Makefile.build:120: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +53 include/linux/timex.h

^1da177e4c3f41 Linus Torvalds 2005-04-16 @53  #ifndef _LINUX_TIMEX_H
^1da177e4c3f41 Linus Torvalds 2005-04-16  54  #define _LINUX_TIMEX_H
^1da177e4c3f41 Linus Torvalds 2005-04-16  55  

:::::: The code at line 53 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
