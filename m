Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE952F0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbiETQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiETQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:29:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BEC1356B2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653064194; x=1684600194;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UGgjGDlKexlOelBygHYTc2dfZJlyNxTunfpkjS0NSqY=;
  b=T5+41lnTaxOeEtMhRcv8AVGWbdRv3wJofiWb7++70j0yjTfqFeoPXiwk
   eE7xnjX3O2MPm9yZwjM52M9T5SPWdi9Pq2zpylKo3EYn54BGVFmxV4cmS
   l9fk7u7/P6GmOVSrsVps48ch0Ke8fkQ9kLCEguCXJZg9wed16GS1M0E9k
   7/1k/NAd6rMk+0paOkR8GYFRuB60wpEYIoHkPp6mVfhXfKiWzt6VghwJF
   vZjIdKF6GmrXU9uy3CYKg2U37MiSSqwfsCasMpT/g2iSQT2qb5Bj8C77U
   dqMlkZcJIJng08siGMDFYrb7l4LejmSInEOKD3+vwrAhdUUmjxgw/e+Pk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272632208"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="272632208"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 09:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="743568296"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2022 09:29:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ns5Vg-0004vG-3Z;
        Fri, 20 May 2022 16:29:52 +0000
Date:   Sat, 21 May 2022 00:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/16]
 arch/arm/include/asm/memory.h:333:33: error: 'KERNEL_PFN_OFFSET' undeclared;
 did you mean 'KERNEL_OFFSET'?
Message-ID: <202205210032.d4z7zZwl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   b9b1d325d83c15b2e27bfa8635f99a7d20811457
commit: 16d1427dc6f44107571afbf96254956716c9ad1f [8/16] ARM: Compile the kernel into VMALLOC
config: arm-stm32_defconfig (https://download.01.org/0day-ci/archive/20220521/202205210032.d4z7zZwl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=16d1427dc6f44107571afbf96254956716c9ad1f
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 16d1427dc6f44107571afbf96254956716c9ad1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arm/kernel/asm-offsets.c:11:
   arch/arm/include/asm/memory.h: In function 'virt_to_pfn':
>> arch/arm/include/asm/memory.h:333:33: error: 'KERNEL_PFN_OFFSET' undeclared (first use in this function); did you mean 'KERNEL_OFFSET'?
     333 |                                 KERNEL_PFN_OFFSET);
         |                                 ^~~~~~~~~~~~~~~~~
         |                                 KERNEL_OFFSET
   arch/arm/include/asm/memory.h:333:33: note: each undeclared identifier is reported only once for each function it appears in
   make[2]: *** [scripts/Makefile.build:120: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +333 arch/arm/include/asm/memory.h

   322	
   323	static inline unsigned long virt_to_pfn(const void *p)
   324	{
   325		unsigned long kaddr = (unsigned long)p;
   326		if (!IS_ENABLED(CONFIG_ARM_KERNEL_IN_VMALLOC)) {
   327			return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
   328				PHYS_PFN_OFFSET);
   329		} else {
   330			if ((kaddr >= KERNEL_OFFSET) &&
   331			    (kaddr < (KERNEL_OFFSET + KERNEL_SECTION_SIZE))) {
   332				return (((kaddr - KERNEL_OFFSET) >> PAGE_SHIFT) +
 > 333					KERNEL_PFN_OFFSET);
   334			} else {
   335				return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
   336					PHYS_PFN_OFFSET);
   337			}
   338		}
   339	}
   340	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
