Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08854C2283
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiBXDnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBXDnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:43:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D400254562
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645674183; x=1677210183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ms/Xul2z61Kdw7dANi6ZFHet41fbNqkpg5veI2ABXj4=;
  b=MKTrN9C2dqkl9nMQ2d9okCctkBxviIpWK9YdbqWNtZoYZ/fwAJDcQ9zt
   jJ4kk7e/fJM10LCts/9+SupQZGwOSh/+LhGy0BWKRvuPEFU1zcaD0Vrm7
   4gxME7gsuLrQyCxMs8Z3rSIIRLi28j5vIA5Ny3xfX63lOoQt7WXFqUzO5
   8XsufEgrnAkobhovZKWkrJRnNaNduMHSBd88VoZ61SL7YZgIJijRFsF2w
   MyX+mlI5cszU/Q3kTuBPyt35hN46Vy5qSn1Q4ny7Y82Hzr24bK9ncqrFT
   kc18jXrrOAs7enKuzhLCK191emkREW2q5cpWEeGA2CngDg661XQOoNZj8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252335888"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="252335888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:43:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508709207"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2022 19:43:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN51w-0002CN-Iu; Thu, 24 Feb 2022 03:43:00 +0000
Date:   Thu, 24 Feb 2022 11:42:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 42/42]
 arch/x86/kernel/alternative.c:538:30: warning: passing argument 1 of
 'is_endbr' makes integer from pointer without a cast
Message-ID: <202202241157.jQc2OHWz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 27b6438f414b6a37b60dcd90c8980397586d49db [42/42] x86/alternative: Use .ibt_endbr_sites to seal indirect calls
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220224/202202241157.jQc2OHWz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=27b6438f414b6a37b60dcd90c8980397586d49db
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 27b6438f414b6a37b60dcd90c8980397586d49db
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:86,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask.h:14,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from arch/x86/kernel/alternative.c:4:
   arch/x86/kernel/alternative.c: In function 'apply_ibt_endbr':
>> arch/x86/kernel/alternative.c:538:30: warning: passing argument 1 of 'is_endbr' makes integer from pointer without a cast [-Wint-conversion]
     538 |   if (WARN_ON_ONCE(!is_endbr(&endbr)))
         |                              ^~~~~~
         |                              |
         |                              u32 * {aka unsigned int *}
   include/asm-generic/bug.h:104:25: note: in definition of macro 'WARN_ON_ONCE'
     104 |  int __ret_warn_on = !!(condition);   \
         |                         ^~~~~~~~~
   In file included from arch/x86/include/asm/linkage.h:6,
                    from include/linux/linkage.h:8,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from arch/x86/kernel/alternative.c:4:
   arch/x86/include/asm/ibt.h:34:42: note: expected 'unsigned int' but argument is of type 'u32 *' {aka 'unsigned int *'}
      34 | static inline bool is_endbr(unsigned int val)
         |                             ~~~~~~~~~~~~~^~~


vim +/is_endbr +538 arch/x86/kernel/alternative.c

   523	
   524	/*
   525	 * Generated by: objtool --ibt-seal
   526	 */
   527	void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
   528	{
   529		s32 *s;
   530	
   531		for (s = start; s < end; s++) {
   532			void *addr = (void *)s + *s;
   533			u32 endbr;
   534	
   535			if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
   536				continue;
   537	
 > 538			if (WARN_ON_ONCE(!is_endbr(&endbr)))
   539				continue;
   540	
   541			DPRINTK("ENDBR at: %pS (%px)", addr, addr);
   542	
   543			/*
   544			 * When we have IBT, the lack of ENDBR will trigger #CP
   545			 * When we don't have IBT, explicitly trigger #UD
   546			 */
   547			DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
   548			DUMP_BYTES(((u8*)ud1_endbr), 4, "%px: repl: ", addr);
   549			text_poke_early(addr, ud1_endbr, 4);
   550		}
   551	}
   552	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
