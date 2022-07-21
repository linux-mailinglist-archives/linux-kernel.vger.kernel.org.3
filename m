Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690F357C8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiGUKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiGUKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:11:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E31599E4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658398310; x=1689934310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J4gWq4l0Kz9gsRUplQImHNFuVqK6HKqp0nF0DuJOcCw=;
  b=Q2RwlKZE26v8z6jQiSlkBTUPx8Le3OVGqLYgOjjLq0KmGnCTtVlg0fMd
   mYaCGhtucXzSLca8vmKWkDw5dsNgaH1tSzdJ223EElTNsflb9uHbnhl9s
   EnPku4BpbIQEGDvOs9QRpp2J2QiHrLCmA4xd7NigOwPQjtA7BJPzmrnpb
   HXYbD++HL3vZAAQRf+I1OTcO+PLhSaol0iOOPNgD6IZr4+kCd++a2KgCs
   fItu/fp/tNZMVJOGUvg5GWskGcTiegnBzwqZH69vO2pSuy6h+WGFiPA6k
   wn4HukIEgKra4oRUFkskNBKBwvYMk9AHb8ZF7Hjd+AdlVzx9GpjvjEBCQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="288172291"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="288172291"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 03:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="548716824"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 03:11:47 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oET9n-0001iQ-6F;
        Thu, 21 Jul 2022 10:11:47 +0000
Date:   Thu, 21 Jul 2022 18:11:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 2/45]
 arch/x86/kernel/cpu/common.c:760:23: error: call to undeclared function
 'cpu_kernelmode_gs_base'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202207211807.FC1G4J9o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   714d29e3e7e3faac27142424ae2533163ddd3a46
commit: 3adc8d7057cc2f5e8dbbaa4b7d8b68f94dadb6ad [2/45] x86/cpu: Remove segment load from switch_to_new_gdt()
config: i386-randconfig-a003-20220718 (https://download.01.org/0day-ci/archive/20220721/202207211807.FC1G4J9o-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dd5635541cd7bbd62cd59b6694dfb759b6e9a0d8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3adc8d7057cc2f5e8dbbaa4b7d8b68f94dadb6ad
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 3adc8d7057cc2f5e8dbbaa4b7d8b68f94dadb6ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/common.c:760:23: error: call to undeclared function 'cpu_kernelmode_gs_base'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
                                       ^
   1 error generated.


vim +/cpu_kernelmode_gs_base +760 arch/x86/kernel/cpu/common.c

   730	
   731	/**
   732	 * switch_to_new_gdt - Switch form early GDT to the direct one
   733	 * @cpu:	The CPU number for which this is invoked
   734	 *
   735	 * Invoked during early boot to switch from early GDT and early per CPU
   736	 * (%fs on 32bit, GS_BASE on 64bit) to the direct GDT and the runtime per
   737	 * CPU area.
   738	 */
   739	void switch_to_new_gdt(int cpu)
   740	{
   741		load_direct_gdt(cpu);
   742	
   743		/*
   744		 * No need to load the %gs (%fs for 32bit) segment. It is already
   745		 * correct, %gs is 0 on 64bit and %fs is __KERNEL_PERCPU on 32 bit.
   746		 *
   747		 * Writing %gs on 64bit would zero GSBASE which would make any per
   748		 * CPU operation up to the point of the wrmsrl() fault.
   749		 *
   750		 * 64bit requires to point GSBASE to the new offset. Until the
   751		 * wrmsrl() happens the early mapping is still valid. That means
   752		 * the GSBASE update will lose any prior per CPU data which was
   753		 * not copied over in setup_per_cpu_areas().
   754		 *
   755		 * For secondary CPUs this is not a problem because they start
   756		 * already with the direct GDT and the real GSBASE. This invocation
   757		 * is pointless and will be removed in a subsequent step.
   758		 */
   759		if (IS_ENABLED(CONFIG_X86_64))
 > 760			wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
   761	}
   762	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
