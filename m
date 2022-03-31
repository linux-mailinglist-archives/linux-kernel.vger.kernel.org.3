Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354D4ED960
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiCaMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiCaMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:10:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A61DA8CE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648728548; x=1680264548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVXwslGG5mJmBH7F1YzsQY4BUv8l5EsLgz96S/tfYb4=;
  b=FmsIEOLLidN0Uwx96dCUw3foMXmu7lMSeVtKYCe+eG0vqsJ3DmBBh5Pg
   rbYz+blUvZidkUYQlaVli+4Pb/ye/IWlaUnGMs+xxVhK65gJMCJ1EV9vN
   2B8rur9CRNoYSpf3EbduMc8OPdeGqeDMmRIRzpuJ3aKKjfFWs4oQpzYm4
   OiETNmiI7U2FnY5q7xpFSI/xL0rtVKXNon/fIhwLpb5fIeUvtwDA1JIKE
   D8fMMZTR0aexUi16YCzkxBuoUbUufb2lW4O3SybcOeUOL1/OSm6jQAE0Y
   dHfSrv+SFZv746tw0WUHPlwcKKcamRRq0R4ry1A4QAqNGnx2ye5CKUife
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258645806"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="258645806"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 05:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="654693052"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 05:09:05 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZtbt-0000Ee-1A;
        Thu, 31 Mar 2022 12:09:05 +0000
Date:   Thu, 31 Mar 2022 20:08:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 28/122] arch/arm64/kernel/irq.c:44:11: error: use of
 undeclared identifier 'irq_shadow_call_stack_ptr'
Message-ID: <202203312036.a74e2QM9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   074b4ea9811e2c47ae1ecada177629c19fa56d59
commit: da4561bd9c6b23e9579b85ffaced3f3b0b8dcd4c [28/122] arm64, scs: save scs_sp values per-cpu when switching stacks
config: arm64-randconfig-r012-20220331 (https://download.01.org/0day-ci/archive/20220331/202203312036.a74e2QM9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 881350a92d821d4f8e4fa648443ed1d17e251188)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/hnaz/linux-mm/commit/da4561bd9c6b23e9579b85ffaced3f3b0b8dcd4c
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout da4561bd9c6b23e9579b85ffaced3f3b0b8dcd4c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/irq.c:44:11: error: use of undeclared identifier 'irq_shadow_call_stack_ptr'
                   per_cpu(irq_shadow_call_stack_ptr, cpu) =
                           ^
>> arch/arm64/kernel/irq.c:44:11: error: use of undeclared identifier 'irq_shadow_call_stack_ptr'
>> arch/arm64/kernel/irq.c:44:11: error: use of undeclared identifier 'irq_shadow_call_stack_ptr'
>> arch/arm64/kernel/irq.c:44:3: error: indirection requires pointer operand ('void' invalid)
                   per_cpu(irq_shadow_call_stack_ptr, cpu) =
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:269:28: note: expanded from macro 'per_cpu'
   #define per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/irq.c:105:13: warning: no previous prototype for function 'init_IRQ' [-Wmissing-prototypes]
   void __init init_IRQ(void)
               ^
   arch/arm64/kernel/irq.c:105:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init init_IRQ(void)
   ^
   static 
   1 warning and 4 errors generated.


vim +/irq_shadow_call_stack_ptr +44 arch/arm64/kernel/irq.c

ac20ffbb0279aa Sami Tolvanen 2020-11-30  35  
ac20ffbb0279aa Sami Tolvanen 2020-11-30  36  static void init_irq_scs(void)
ac20ffbb0279aa Sami Tolvanen 2020-11-30  37  {
ac20ffbb0279aa Sami Tolvanen 2020-11-30  38  	int cpu;
ac20ffbb0279aa Sami Tolvanen 2020-11-30  39  
ac20ffbb0279aa Sami Tolvanen 2020-11-30  40  	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK))
ac20ffbb0279aa Sami Tolvanen 2020-11-30  41  		return;
ac20ffbb0279aa Sami Tolvanen 2020-11-30  42  
ac20ffbb0279aa Sami Tolvanen 2020-11-30  43  	for_each_possible_cpu(cpu)
ac20ffbb0279aa Sami Tolvanen 2020-11-30 @44  		per_cpu(irq_shadow_call_stack_ptr, cpu) =
ac20ffbb0279aa Sami Tolvanen 2020-11-30  45  			scs_alloc(cpu_to_node(cpu));
ac20ffbb0279aa Sami Tolvanen 2020-11-30  46  }
ac20ffbb0279aa Sami Tolvanen 2020-11-30  47  

:::::: The code at line 44 was first introduced by commit
:::::: ac20ffbb0279aae7be48567fb734eae7d050769e arm64: scs: use vmapped IRQ and SDEI shadow stacks

:::::: TO: Sami Tolvanen <samitolvanen@google.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
