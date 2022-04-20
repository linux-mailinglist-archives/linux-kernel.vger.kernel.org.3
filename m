Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04936508047
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359333AbiDTEsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359324AbiDTEsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:48:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF5F27169
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650429965; x=1681965965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6Jq42IRGEEJWZkcmP/MYUdDiJ4JiyROYfjSGbMV+q4Y=;
  b=R6oU3aAQ9ORGorGLW6Mm24H3ZKLnvJMgObb5jU+sm5Tp39rsC6CjUbcG
   713kqUT0IYx2Asxoe0PdFm03T1Ra1gZL7jfTQkokBvW8G3WD0TaliDpiT
   GxwK9dDSZ/NlS5qDUP+foaaWINW2iPZjVqehYVu6mJHX163QSBng6PJSq
   ihRK3lMpG4Y2v7yxK9jW/VCzG8uoIvCrwe5iFwU52MiGxCtvwzVbhDUjH
   0+T7vOGO0aSt+Far5hovKUADB3P5q1pahcJzzh3Gyi6eGwmx0Kewod3dC
   1TQt/b4quEkS+eXepNXpMCj60ZjpV8lTB4xEBijnrkEvoawM/N4p12OgA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="244521018"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="244521018"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="667730569"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2022 21:46:03 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh2E6-0006ZH-9C;
        Wed, 20 Apr 2022 04:46:02 +0000
Date:   Wed, 20 Apr 2022 12:45:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/x86/amperf 7/10]
 arch/x86/kernel/cpu/aperfmperf.c:502:6: warning: no previous prototype for
 'arch_scale_freq_tick'
Message-ID: <202204201220.MiahK9Vg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/x86/amperf
head:   9968b9bf69c36ec939d25ac6e0cc8e1d52075490
commit: 1d1a6fffce4ecc387d657ef959e5b7519098265e [7/10] x86/aperfmperf: Make parts of the frequency invariance code unconditional
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220420/202204201220.MiahK9Vg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/1d1a6fffce4ecc387d657ef959e5b7519098265e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/x86/amperf
        git checkout 1d1a6fffce4ecc387d657ef959e5b7519098265e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/aperfmperf.c:502:6: warning: no previous prototype for 'arch_scale_freq_tick' [-Wmissing-prototypes]
     502 | void arch_scale_freq_tick(void)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/arch_scale_freq_tick +502 arch/x86/kernel/cpu/aperfmperf.c

a700c9188e7c84 Thomas Gleixner 2022-04-13  501  
a700c9188e7c84 Thomas Gleixner 2022-04-13 @502  void arch_scale_freq_tick(void)
a700c9188e7c84 Thomas Gleixner 2022-04-13  503  {
a700c9188e7c84 Thomas Gleixner 2022-04-13  504  	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
a700c9188e7c84 Thomas Gleixner 2022-04-13  505  	u64 acnt, mcnt, aperf, mperf;
a700c9188e7c84 Thomas Gleixner 2022-04-13  506  
1d1a6fffce4ecc Thomas Gleixner 2022-04-13  507  	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
a700c9188e7c84 Thomas Gleixner 2022-04-13  508  		return;
a700c9188e7c84 Thomas Gleixner 2022-04-13  509  
a700c9188e7c84 Thomas Gleixner 2022-04-13  510  	rdmsrl(MSR_IA32_APERF, aperf);
a700c9188e7c84 Thomas Gleixner 2022-04-13  511  	rdmsrl(MSR_IA32_MPERF, mperf);
a700c9188e7c84 Thomas Gleixner 2022-04-13  512  	acnt = aperf - s->aperf;
a700c9188e7c84 Thomas Gleixner 2022-04-13  513  	mcnt = mperf - s->mperf;
a700c9188e7c84 Thomas Gleixner 2022-04-13  514  
a700c9188e7c84 Thomas Gleixner 2022-04-13  515  	s->aperf = aperf;
a700c9188e7c84 Thomas Gleixner 2022-04-13  516  	s->mperf = mperf;
a700c9188e7c84 Thomas Gleixner 2022-04-13  517  
a700c9188e7c84 Thomas Gleixner 2022-04-13  518  	scale_freq_tick(acnt, mcnt);
a700c9188e7c84 Thomas Gleixner 2022-04-13  519  }
1d1a6fffce4ecc Thomas Gleixner 2022-04-13  520  

:::::: The code at line 502 was first introduced by commit
:::::: a700c9188e7c842054b480a303988ea37e111e8b x86/aperfmperf: Restructure arch_scale_freq_tick()

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
