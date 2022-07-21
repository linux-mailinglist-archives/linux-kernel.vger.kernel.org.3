Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30B57C86F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiGUKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiGUKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:00:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E1118E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658397649; x=1689933649;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eABttColpd3cgqYPtpB5OBMyFwXZpipYlil6gXYr9hA=;
  b=iGWdUiqYeo6FZ2DOOd15CArwoZqvS9CFBbfN/giKKg0i3I07tU0kx3FU
   JmVJp2WKJWsWRb2mFIpCTx6dlZ6q13oD4kx36JLqXL2gZ8YSXG0fUIYKh
   ClGiMmSSf733gZihwNXFNlbckT7CoYTLUNSpUzG2yCZBPWYlHy2UaIR3t
   ne1YDEgHGDYcyPGAk/W8xUsYfHBUh3fVzEVq1RJeZ3xss/O9LZFQDDLez
   LzVr5HpDMFefW4j20pfrt7vAqDuHlfzX5addjn4CA0l2ICsLbfwaHSqw0
   cZzDd+QzjS3jbuG9QHQ75NTuYmkcdnRo0DVjq4F6G41y9Xi8uKzOrfsD1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273850988"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="273850988"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 03:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="631115298"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2022 03:00:47 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oESz8-0001hZ-OK;
        Thu, 21 Jul 2022 10:00:46 +0000
Date:   Thu, 21 Jul 2022 18:00:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 2/45]
 arch/x86/kernel/cpu/common.c:760:37: error: implicit declaration of function
 'cpu_kernelmode_gs_base'
Message-ID: <202207211722.nx5vSFbQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   714d29e3e7e3faac27142424ae2533163ddd3a46
commit: 3adc8d7057cc2f5e8dbbaa4b7d8b68f94dadb6ad [2/45] x86/cpu: Remove segment load from switch_to_new_gdt()
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220721/202207211722.nx5vSFbQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/3adc8d7057cc2f5e8dbbaa4b7d8b68f94dadb6ad
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 3adc8d7057cc2f5e8dbbaa4b7d8b68f94dadb6ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/common.c: In function 'switch_to_new_gdt':
>> arch/x86/kernel/cpu/common.c:760:37: error: implicit declaration of function 'cpu_kernelmode_gs_base' [-Werror=implicit-function-declaration]
     760 |                 wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
