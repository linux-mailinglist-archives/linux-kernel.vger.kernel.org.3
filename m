Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD297518E95
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiECUWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiECUWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:22:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E792CCAA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651609106; x=1683145106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PNFGpvvElBUrPScpTsEoTbQdwC4CKVMwLB6Yek/DhEM=;
  b=m8mtBjcHMliMm+w0UrGIHptgG74WNfJHbgT/z1LOS24VzAVoqkYiOA1v
   H9ciXMpqJLgOvm1pH+5XP1XChNaeIrCJ0baiRbFGTyGHx5oN+Ms+gWBQe
   luCfTIbK49x6D003D9jJec8pZ8HR+X9EDDjIDA1TQ+wkOkQqZVbNkI+Hh
   ZYP5NI/aEhRX2Da5qywzB9HtUA/axF4Y73XtRT2fczeV82yvKXzt1pj0i
   ARdr9Mw2CbqakzFzGQhIA/Ng4+1TTc4npVLc5tp43pbewgpLTeNybKCkM
   FJX/ka9qk6m1s6yEeG6OrUJu5Echr+Tmt6eJpHWDY5RM43OBuQNlD8fih
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266421536"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="266421536"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516708264"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:18:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlyyV-000AlX-OQ;
        Tue, 03 May 2022 20:18:23 +0000
Date:   Wed, 4 May 2022 04:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/mm/nohash/fsl_book3e.c:61:3: sparse: sparse: symbol
 'tlbcam_addrs' was not declared. Should it be static?
Message-ID: <202205040405.EMRgwTxn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef8e4d3c2ab1f47f63b6c7e578266b7e5cc9cd1b
commit: 1a76e520ee1831a81dabf8a9a58c6453f700026e powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FSL_BOOK3E
date:   8 weeks ago
config: powerpc64-randconfig-s031-20220503 (https://download.01.org/0day-ci/archive/20220504/202205040405.EMRgwTxn-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a76e520ee1831a81dabf8a9a58c6453f700026e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1a76e520ee1831a81dabf8a9a58c6453f700026e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/mm/nohash/fsl_book3e.c:61:3: sparse: sparse: symbol 'tlbcam_addrs' was not declared. Should it be static?

vim +/tlbcam_addrs +61 arch/powerpc/mm/nohash/fsl_book3e.c

14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  56  
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  57  struct tlbcamrange {
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  58  	unsigned long start;
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  59  	unsigned long limit;
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  60  	phys_addr_t phys;
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26 @61  } tlbcam_addrs[NUM_TLBCAMS];
14cf11af6cf608 arch/powerpc/mm/fsl_booke_mmu.c Paul Mackerras 2005-09-26  62  

:::::: The code at line 61 was first introduced by commit
:::::: 14cf11af6cf608eb8c23e989ddb17a715ddce109 powerpc: Merge enough to start building in arch/powerpc.

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
