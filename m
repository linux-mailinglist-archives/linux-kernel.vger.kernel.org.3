Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC9B507BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357998AbiDSVbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346877AbiDSVbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:31:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9689C39827
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650403718; x=1681939718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fSbBlg7Cy7c0Bm1hYCtAjichucsThj27NrOn/LHBa7M=;
  b=Zgv06ufac9B4uqXYNuoRiVzOlcx/6yPVdsULNwqwKWh/77i+vyVff7dC
   8orGLgWti20ljQZakjbXydg8GfeRPeRyGpiE+vXNeF9yTQH7FctpCQge6
   8bRS4/LeeDpcanCleOTFWSQGRj48JrkIOvp9S3V2GzczazwNSJ5zd6D7Q
   qAzm2jw9n31TLK770OFz454+oJWc9mGZlvuBMHE6buuh+iiQEqRNu2yvR
   DwwKjudv8VELPZRxZRsaPw0Y4kpNz6l8yfcvCNx/twaR+Z8tIdzs/vGVO
   32ai7QzVDJxF1kN4FXJHkPvn4k4tEA3nhCxngXMLBG2Nq3NfXXSwPum7G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243808962"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="243808962"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 14:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="667025442"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2022 14:28:36 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngvOm-0006CA-5I;
        Tue, 19 Apr 2022 21:28:36 +0000
Date:   Wed, 20 Apr 2022 05:28:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 108/2579] init/main.c:887:13: warning: no
 previous prototype for function 'init_per_task_early'
Message-ID: <202204200512.Po4Qok6p-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: f1d7f3a4c6b375645905a0b0b71dd202c29af929 [108/2579] headers/deps: cpusets: Move task_struct::mems_allowed_seq to per_task()
config: i386-randconfig-a013-20220418 (https://download.01.org/0day-ci/archive/20220420/202204200512.Po4Qok6p-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f1d7f3a4c6b375645905a0b0b71dd202c29af929
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f1d7f3a4c6b375645905a0b0b71dd202c29af929
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   init/main.c:783:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:783:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
>> init/main.c:887:13: warning: no previous prototype for function 'init_per_task_early' [-Wmissing-prototypes]
   void __init init_per_task_early(void)
               ^
   init/main.c:887:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init init_per_task_early(void)
   ^
   static 
   2 warnings generated.


vim +/init_per_task_early +887 init/main.c

   886	
 > 887	void __init init_per_task_early(void)
   888	{
   889	#ifdef CONFIG_POSIX_TIMERS
   890		per_task(&init_task, posix_cputimers) = (struct posix_cputimers) __INIT_CPU_TIMERS(init_task);
   891	#endif
   892	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
