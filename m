Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF964DA6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352818AbiCPAcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiCPAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:32:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEAB54FB9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647390685; x=1678926685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1HIIL9H8xOu6LnGedxpbB0i9mQPKsZsrogCv3711xaE=;
  b=PQanUT+Qo/yAsNQNMyw0CyU8dO60IqHoKlEU3z3wxQr8C0C2Z5T+cMkb
   h0omiiBCkS+h+ji3Tu/czNF3JiULFDCL52g3k/LtBDjDFOvIDmjzXNq7I
   HIsepCXvvCiOFShYNVR7w2kF+m/QNFi9/7Rhm47pBXf5iz58UsCfvTQx6
   toHRVmSguxx7vfC2ZIby2BI0rHuV/s67eiW0S1/eZAjE8vNocXR7cJwFr
   TQRYPMZ1xy872UB8y5I0M3+vV9V+ITGIG09r5lM9nLjCllL9vtA5OqPuQ
   iRHsKfkw7iSAClOErl8BgR09XhYf1x5VP/jPs/6LtggKApiCqAp5yCIBP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="254012879"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="254012879"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="646435488"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 17:31:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUHZS-000BhA-W9; Wed, 16 Mar 2022 00:31:22 +0000
Date:   Wed, 16 Mar 2022 08:30:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2186/2335] arch/x86/kernel/cpu/mtrr/mtrr.c:570:5:
 warning: no previous prototype for 'arch_phys_wc_add'
Message-ID: <202203160805.EghtjTcK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 5fb81b2e44b84e7813efac1c2bc801f8a290eb96 [2186/2335] headers/deps: mm: Optimize <linux/dmapool.h> dependencies, remove <linux/scatterlist.h> and <asm/io.h> inclusion
config: i386-randconfig-a005-20220314 (https://download.01.org/0day-ci/archive/20220316/202203160805.EghtjTcK-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5fb81b2e44b84e7813efac1c2bc801f8a290eb96
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 5fb81b2e44b84e7813efac1c2bc801f8a290eb96
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/mtrr/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mtrr/mtrr.c:570:5: warning: no previous prototype for 'arch_phys_wc_add' [-Wmissing-prototypes]
     570 | int arch_phys_wc_add(unsigned long base, unsigned long size)
         |     ^~~~~~~~~~~~~~~~
>> arch/x86/kernel/cpu/mtrr/mtrr.c:596:6: warning: no previous prototype for 'arch_phys_wc_del' [-Wmissing-prototypes]
     596 | void arch_phys_wc_del(int handle)
         |      ^~~~~~~~~~~~~~~~
>> arch/x86/kernel/cpu/mtrr/mtrr.c:616:5: warning: no previous prototype for 'arch_phys_wc_index' [-Wmissing-prototypes]
     616 | int arch_phys_wc_index(int handle)
         |     ^~~~~~~~~~~~~~~~~~


vim +/arch_phys_wc_add +570 arch/x86/kernel/cpu/mtrr/mtrr.c

^1da177e4c3f41 arch/i386/kernel/cpu/mtrr/main.c Linus Torvalds    2005-04-16  554  
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  555  /**
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  556   * arch_phys_wc_add - add a WC MTRR and handle errors if PAT is unavailable
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  557   * @base: Physical base address
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  558   * @size: Size of region
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  559   *
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  560   * If PAT is available, this does nothing.  If PAT is unavailable, it
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  561   * attempts to add a WC MTRR covering size bytes starting at base and
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  562   * logs an error if this fails.
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  563   *
2f9e897353fcb9 arch/x86/kernel/cpu/mtrr/main.c  Luis R. Rodriguez 2015-05-26  564   * The called should provide a power of two size on an equivalent
2f9e897353fcb9 arch/x86/kernel/cpu/mtrr/main.c  Luis R. Rodriguez 2015-05-26  565   * power of two boundary.
2f9e897353fcb9 arch/x86/kernel/cpu/mtrr/main.c  Luis R. Rodriguez 2015-05-26  566   *
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  567   * Drivers must store the return value to pass to mtrr_del_wc_if_needed,
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  568   * but drivers should not try to interpret that return value.
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  569   */
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13 @570  int arch_phys_wc_add(unsigned long base, unsigned long size)
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  571  {
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  572  	int ret;
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  573  
cb32edf65bf219 arch/x86/kernel/cpu/mtrr/main.c  Luis R. Rodriguez 2015-05-26  574  	if (pat_enabled() || !mtrr_enabled())
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  575  		return 0;  /* Success!  (We don't need to do anything.) */
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  576  
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  577  	ret = mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  578  	if (ret < 0) {
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  579  		pr_warn("Failed to add WC MTRR for [%p-%p]; performance may suffer.",
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  580  			(void *)base, (void *)(base + size - 1));
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  581  		return ret;
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  582  	}
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  583  	return ret + MTRR_TO_PHYS_WC_OFFSET;
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  584  }
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  585  EXPORT_SYMBOL(arch_phys_wc_add);
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  586  
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  587  /*
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  588   * arch_phys_wc_del - undoes arch_phys_wc_add
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  589   * @handle: Return value from arch_phys_wc_add
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  590   *
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  591   * This cleans up after mtrr_add_wc_if_needed.
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  592   *
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  593   * The API guarantees that mtrr_del_wc_if_needed(error code) and
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  594   * mtrr_del_wc_if_needed(0) do nothing.
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  595   */
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13 @596  void arch_phys_wc_del(int handle)
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  597  {
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  598  	if (handle >= 1) {
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  599  		WARN_ON(handle < MTRR_TO_PHYS_WC_OFFSET);
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  600  		mtrr_del(handle - MTRR_TO_PHYS_WC_OFFSET, 0, 0);
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  601  	}
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  602  }
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  603  EXPORT_SYMBOL(arch_phys_wc_del);
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  604  
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  605  /*
7d010fdf299929 arch/x86/kernel/cpu/mtrr/main.c  Luis R. Rodriguez 2015-05-26  606   * arch_phys_wc_index - translates arch_phys_wc_add's return value
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  607   * @handle: Return value from arch_phys_wc_add
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  608   *
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  609   * This will turn the return value from arch_phys_wc_add into an mtrr
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  610   * index suitable for debugging.
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  611   *
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  612   * Note: There is no legitimate use for this function, except possibly
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  613   * in printk line.  Alas there is an illegitimate use in some ancient
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  614   * drm ioctls.
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  615   */
7d010fdf299929 arch/x86/kernel/cpu/mtrr/main.c  Luis R. Rodriguez 2015-05-26 @616  int arch_phys_wc_index(int handle)
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  617  {
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  618  	if (handle < MTRR_TO_PHYS_WC_OFFSET)
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  619  		return -1;
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  620  	else
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  621  		return handle - MTRR_TO_PHYS_WC_OFFSET;
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  622  }
7d010fdf299929 arch/x86/kernel/cpu/mtrr/main.c  Luis R. Rodriguez 2015-05-26  623  EXPORT_SYMBOL_GPL(arch_phys_wc_index);
d0d98eedee2178 arch/x86/kernel/cpu/mtrr/main.c  Andy Lutomirski   2013-05-13  624  

:::::: The code at line 570 was first introduced by commit
:::::: d0d98eedee2178c803dd824bb09f52b0e2ac1811 Add arch_phys_wc_{add, del} to manipulate WC MTRRs if needed

:::::: TO: Andy Lutomirski <luto@amacapital.net>
:::::: CC: Dave Airlie <airlied@redhat.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
