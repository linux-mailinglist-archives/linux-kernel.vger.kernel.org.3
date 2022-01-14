Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF70348E2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiANC7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:59:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:63184 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232070AbiANC7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642129163; x=1673665163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wni4/zjbv34Ml0Un9rq+495iCn+wzFl19UvDy6ziRLQ=;
  b=HIXHW4nhTTxytjEgub9dAZn5UAqomHq5KNCYtPkTmyTNaROUHDrDY+RV
   NMTO9WXtGD2aB7HfEtPnUx3jLYfI+BhXHKGA721N1/SVYgpemWhmQBn6Z
   Q9j5R1h9VnajorkK/WW1GAse9HGGbOU3JtBdEbKO3Gb5DBGtzWAdjhFyr
   xEZPOR6Qje1hkilhMXCOAMpg3wB5gRIsV8HB30bud2ypST+J/GdNaW4MY
   98OZX83Q4RvPuyGN4uAPntjcuE2FaFFM+XQJycYRiXDnQ+tYWJCrgvx9S
   6MoZIhJwlAHA/ZcOfheZrnO97MCzprq0CJNL9KBVVx38EDwUi/PmfmEFT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="268534705"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="268534705"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 18:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="475623300"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 18:59:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8CoD-00080l-18; Fri, 14 Jan 2022 02:59:21 +0000
Date:   Fri, 14 Jan 2022 10:58:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2232/2382] arch/x86/kernel/cpu/mtrr/mtrr.c:570:5:
 warning: no previous prototype for 'arch_phys_wc_add'
Message-ID: <202201141011.xY2EpZxX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: a097e96997f0e6b9c840e1de19af68c01be7b12e [2232/2382] headers/deps: mm: Optimize <linux/dmapool.h> dependencies, remove <linux/scatterlist.h> and <asm/io.h> inclusion
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220114/202201141011.xY2EpZxX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a097e96997f0e6b9c840e1de19af68c01be7b12e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout a097e96997f0e6b9c840e1de19af68c01be7b12e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/kernel/cpu/mtrr/ net/ipv6/

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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
