Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433B4507FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbiDTEH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:07:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7415F4D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650427503; x=1681963503;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bdsAy7GmmCS1c8cTVN7/4mzmHl4NbIXxGehbKQIE7Jk=;
  b=d/cIkWenQxueUu/X5aPxTpahytELssqCml2SiSiwKBDlJ7dkpEGJvU6V
   sueRIc/KYpj1Y8+EejFSDDVX96MznMp1bZF/qmcD6E/BoHWbJi7lR7jda
   NXfZ8S8Jxk5XMpiYqH4BXYiwkizniNBmYiADFPWHKFawnngfeL1knpt6F
   e1kC8WA3hdARdcoH7GjLma1phIi0wNJHAdHGw7yg2bEcHihzrbZycwX+R
   lDWPHeD5iPPUW0nI0jifK2341j2HVKZchi1uN3BHy20gt8CPsk2CJR3eV
   /5VVch4ZSEBoWVFEEfvpaTkqyaU7TI3yDOmlTiRxSS6YNbae99DjVKVs+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243864851"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="243864851"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="510395037"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2022 21:05:00 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh1aO-0006Ww-0v;
        Wed, 20 Apr 2022 04:05:00 +0000
Date:   Wed, 20 Apr 2022 12:04:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/x86/amperf 7/10]
 arch/x86/kernel/cpu/aperfmperf.c:502:6: warning: no previous prototype for
 function 'arch_scale_freq_tick'
Message-ID: <202204201130.1qUqMmBQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/x86/amperf
head:   9968b9bf69c36ec939d25ac6e0cc8e1d52075490
commit: 1d1a6fffce4ecc387d657ef959e5b7519098265e [7/10] x86/aperfmperf: Make parts of the frequency invariance code unconditional
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220420/202204201130.1qUqMmBQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1d1a6fffce4ecc387d657ef959e5b7519098265e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/x86/amperf
        git checkout 1d1a6fffce4ecc387d657ef959e5b7519098265e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/aperfmperf.c:502:6: warning: no previous prototype for function 'arch_scale_freq_tick' [-Wmissing-prototypes]
   void arch_scale_freq_tick(void)
        ^
   arch/x86/kernel/cpu/aperfmperf.c:502:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void arch_scale_freq_tick(void)
   ^
   static 
   1 warning generated.


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
