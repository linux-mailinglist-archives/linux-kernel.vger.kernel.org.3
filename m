Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018E34B1E13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiBKGDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:03:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbiBKGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:03:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94981175
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644559413; x=1676095413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R6IP7K+zop7CpJGGibFled+rUIwKXUOWi9fkxvxAnEw=;
  b=DFtQdBhbbBAq9ftDoJv+Llm79P/OEqJPHm/Nq1vqKnOigSQD3i+Y6XuQ
   WUj8VvGbVjc+KdKks3isRwntlbQZgHjn3pSSKNFCmQSCVJyT4+VaAeo3V
   8kpZ0KwQsUZD4bUB8JHm46WvZ6FfqslekOz52AeG85Ofy/m9UaY4mciiT
   ldBjyTfznglYtxbJlwUuyYQA+Pke5huJxyaX4fyaMLxMvpu6bObKkU9JI
   KOqEPnXo8DObGzJFVbwZ7iyr1muSczeV7MWXAAIOmLg7Yv40PbXOZzr0N
   ZZXIl38G5ic7n8KfTforJEYj9ZPZr3KqKQ4j/bdnNSeMtcULx35Kp3+4J
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="237072007"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="237072007"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500669143"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2022 22:03:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIP1n-0004C7-2j; Fri, 11 Feb 2022 06:03:31 +0000
Date:   Fri, 11 Feb 2022 14:02:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: arch/x86/include/asm/paravirt.h:221:9: sparse: sparse: cast
 truncates bits from constant value (c000000000100000 becomes 100000)
Message-ID: <202202111322.CtsKURBj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1baf68e1383f6ed93eb9cff2866d46562607a43
commit: faff44069ff538ccdfef187c4d7ec83d22dfb3a4 x86/hyperv: Add Write/Read MSR registers via ghcb page
date:   4 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220211/202202111322.CtsKURBj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=faff44069ff538ccdfef187c4d7ec83d22dfb3a4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout faff44069ff538ccdfef187c4d7ec83d22dfb3a4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hv/vmbus_drv.c: note: in included file (through arch/x86/include/asm/msr.h, arch/x86/include/asm/processor.h, arch/x86/include/asm/timex.h, ...):
>> arch/x86/include/asm/paravirt.h:221:9: sparse: sparse: cast truncates bits from constant value (c000000000100000 becomes 100000)
   arch/x86/include/asm/paravirt.h:221:9: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)

vim +221 arch/x86/include/asm/paravirt.h

d3561b7fa0fb0fc include/asm-i386/paravirt.h     Rusty Russell   2006-12-07  218  
47edb65178cb705 arch/x86/include/asm/paravirt.h Andy Lutomirski 2015-07-23  219  static inline void wrmsrl(unsigned msr, u64 val)
47edb65178cb705 arch/x86/include/asm/paravirt.h Andy Lutomirski 2015-07-23  220  {
47edb65178cb705 arch/x86/include/asm/paravirt.h Andy Lutomirski 2015-07-23 @221  	wrmsr(msr, (u32)val, (u32)(val>>32));
47edb65178cb705 arch/x86/include/asm/paravirt.h Andy Lutomirski 2015-07-23  222  }
47edb65178cb705 arch/x86/include/asm/paravirt.h Andy Lutomirski 2015-07-23  223  

:::::: The code at line 221 was first introduced by commit
:::::: 47edb65178cb7056c2eea0b6c41a7d8c84547192 x86/asm/msr: Make wrmsrl() a function

:::::: TO: Andy Lutomirski <luto@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
