Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A90509835
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385099AbiDUGsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381410AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7EB1570C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523433; x=1682059433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ToGkXtQX+ir0RIfYEWcQB7wd9RoHuPc+n6U8jCMV6pE=;
  b=k9WJXHDcHFZ7ngd2dm4vgEq3GEIHWgSKoxXVZbA3dwAhvtNosNDhR1w+
   dKRsHUSCBSjrQSztjjj414kb8LS2L50uGdRdCvXgBdwrPPKO+mUGHY19I
   XN0A0wAsTVf6xwMC9JVsKJrgEoYIMYWvlLnMbOO5ZcZiAgUtFSs85YszP
   DxJC8UO3gXMI65dliyhCyXcSBe10PosIN/zlvs0DxgUdcudFSYUjh3OZ6
   0WWLxdBj53+eS5hOuRjmZpxllYXrcY/e2xlKB6FHNvOdm4ObdWZ1tRx6v
   2sUbCk3fI5n8Q55eFybeG8WJeqd7JA4Jv+Hd4tp6QZ56l8J44Y5+DtQff
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="350704798"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="350704798"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="658391762"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXe-00080P-R3;
        Thu, 21 Apr 2022 06:43:50 +0000
Date:   Thu, 21 Apr 2022 14:43:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2327/2579]
 arch/x86/kernel/cpu/mtrr/mtrr.c:570:5: warning: no previous prototype for
 function 'arch_phys_wc_add'
Message-ID: <202204210827.G48SY3cg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 461fdf14bb97fa52bde6588dfdf116899a79a74d [2327/2579] headers/deps: mm: Optimize <linux/dmapool.h> dependencies, remove <linux/scatterlist.h> and <asm/io.h> inclusion
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220421/202204210827.G48SY3cg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=461fdf14bb97fa52bde6588dfdf116899a79a74d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 461fdf14bb97fa52bde6588dfdf116899a79a74d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/mtrr/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mtrr/mtrr.c:570:5: warning: no previous prototype for function 'arch_phys_wc_add' [-Wmissing-prototypes]
   int arch_phys_wc_add(unsigned long base, unsigned long size)
       ^
   arch/x86/kernel/cpu/mtrr/mtrr.c:570:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int arch_phys_wc_add(unsigned long base, unsigned long size)
   ^
   static 
>> arch/x86/kernel/cpu/mtrr/mtrr.c:596:6: warning: no previous prototype for function 'arch_phys_wc_del' [-Wmissing-prototypes]
   void arch_phys_wc_del(int handle)
        ^
   arch/x86/kernel/cpu/mtrr/mtrr.c:596:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void arch_phys_wc_del(int handle)
   ^
   static 
>> arch/x86/kernel/cpu/mtrr/mtrr.c:616:5: warning: no previous prototype for function 'arch_phys_wc_index' [-Wmissing-prototypes]
   int arch_phys_wc_index(int handle)
       ^
   arch/x86/kernel/cpu/mtrr/mtrr.c:616:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int arch_phys_wc_index(int handle)
   ^
   static 
   3 warnings generated.


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
