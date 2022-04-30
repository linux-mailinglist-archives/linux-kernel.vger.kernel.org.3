Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F948515FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbiD3Rzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiD3Rzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:55:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BB57CB21
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651341149; x=1682877149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zfXNhN6bes2n9mNNqcPGpAn93H8AVDtlF3fFFppLe7I=;
  b=nl0chc0+MEokomH7iPZ3tE6R8ogf9eVkPlnQ2/JAdO15w0X1YYT/u2HS
   EgOLNIWGf+0M6oH+Kn+TOSb32Ktwb50XJvk6a/rav8WFELP5LOGsBKYOk
   bC40pYtqI8kFNA3WDe7ahP9WStAbpOubtpkABwtWLFsGj7/uihcTxzouS
   b7nwvWIwqbNSsuyoxl3tWBpDAYKLKQ3PVInCnvhsMD7A/21ImJSUNke1t
   1rrYaNmCYd9TACinM3d6+rvDO6tbxiN0iQXcE5LcHgiFD8BJA7GMAnmLv
   k+9+wvzDhhCexc49dDD1aKE8wcUOpWVlxj98gBecuxE+W12ipat+0Gf4H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="292084755"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="292084755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 10:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="652235246"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2022 10:52:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkrGd-0007TJ-CV;
        Sat, 30 Apr 2022 17:52:27 +0000
Date:   Sun, 1 May 2022 01:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [tip:x86/cleanups 7/11] arch/x86/kernel/cpu/aperfmperf.c:502:6:
 warning: no previous prototype for 'arch_scale_freq_tick'
Message-ID: <202205010106.06xRBR2C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
head:   fb4c77c21aba03677f283acda3cae748ef866abf
commit: bb6e89df9028b2fab0ce6ac71cd9ef25b6ada32d [7/11] x86/aperfmperf: Make parts of the frequency invariance code unconditional
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220501/202205010106.06xRBR2C-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=bb6e89df9028b2fab0ce6ac71cd9ef25b6ada32d
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/cleanups
        git checkout bb6e89df9028b2fab0ce6ac71cd9ef25b6ada32d
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

73a5fa7d51366a Thomas Gleixner 2022-04-15  501  
73a5fa7d51366a Thomas Gleixner 2022-04-15 @502  void arch_scale_freq_tick(void)
73a5fa7d51366a Thomas Gleixner 2022-04-15  503  {
73a5fa7d51366a Thomas Gleixner 2022-04-15  504  	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
73a5fa7d51366a Thomas Gleixner 2022-04-15  505  	u64 acnt, mcnt, aperf, mperf;
73a5fa7d51366a Thomas Gleixner 2022-04-15  506  
bb6e89df9028b2 Thomas Gleixner 2022-04-15  507  	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
73a5fa7d51366a Thomas Gleixner 2022-04-15  508  		return;
73a5fa7d51366a Thomas Gleixner 2022-04-15  509  
73a5fa7d51366a Thomas Gleixner 2022-04-15  510  	rdmsrl(MSR_IA32_APERF, aperf);
73a5fa7d51366a Thomas Gleixner 2022-04-15  511  	rdmsrl(MSR_IA32_MPERF, mperf);
73a5fa7d51366a Thomas Gleixner 2022-04-15  512  	acnt = aperf - s->aperf;
73a5fa7d51366a Thomas Gleixner 2022-04-15  513  	mcnt = mperf - s->mperf;
73a5fa7d51366a Thomas Gleixner 2022-04-15  514  
73a5fa7d51366a Thomas Gleixner 2022-04-15  515  	s->aperf = aperf;
73a5fa7d51366a Thomas Gleixner 2022-04-15  516  	s->mperf = mperf;
73a5fa7d51366a Thomas Gleixner 2022-04-15  517  
73a5fa7d51366a Thomas Gleixner 2022-04-15  518  	scale_freq_tick(acnt, mcnt);
73a5fa7d51366a Thomas Gleixner 2022-04-15  519  }
bb6e89df9028b2 Thomas Gleixner 2022-04-15  520  

:::::: The code at line 502 was first introduced by commit
:::::: 73a5fa7d51366a549a9f2e3ee875ae51aa0b5580 x86/aperfmperf: Restructure arch_scale_freq_tick()

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
