Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9614D4D0E19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiCHCpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCHCpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:45:11 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102632AC6B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646707453; x=1678243453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPAXmr2pj7+3M/Pdt3tlrgi6KM7VAala6MaoHANO0Fs=;
  b=aslu0mm7sB+Man065GROLKLBLShL5jvZyFIrTtXtRvS+0VAJ+6tXSZvO
   EsJrDLtHZkRmzEcullmIffHPnmqOMX4g4LuZGAhUgAWulzG04oDw7e/F1
   86XJoM6hMwglTwc0M06YdFLfo5OlAcfv83ub/WcJkjxmo1mXQejICcdPF
   mFndChaW1OomyOfb4shtQ0l+5Jy8A5W2asE9ri2EPmba4F3/Awc8JzCas
   rT9OJ2p1X3mgS3xE0OBSYFcYWRMHnzqew24FmVTaKfVRliqEbZ1r0DV66
   N02vRVnD2pQbB3uIqU0g0TVgq9UMC0dNY/UFDEKOqYDTtaCTDuBa21/Rf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315286581"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="315286581"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 18:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="495292276"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2022 18:44:11 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRPpa-0000sf-L1; Tue, 08 Mar 2022 02:44:10 +0000
Date:   Tue, 8 Mar 2022 10:43:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [saeed:net-next 154/185] net/smc/smc_sysctl.h:23:16: warning: no
 previous prototype for 'smc_sysctl_net_init'
Message-ID: <202203081012.KgONXWsS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next
head:   03200f4a126b1a08c0f16dea7f67e6bff9c83c90
commit: 7de8eb0d9039f16e1122d7aa524a1502a160c4ff [154/185] net/smc: fix compile warning for smc_sysctl
config: arc-randconfig-r016-20220308 (https://download.01.org/0day-ci/archive/20220308/202203081012.KgONXWsS-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=7de8eb0d9039f16e1122d7aa524a1502a160c4ff
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed net-next
        git checkout 7de8eb0d9039f16e1122d7aa524a1502a160c4ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/smc/af_smc.c:54:
>> net/smc/smc_sysctl.h:23:16: warning: no previous prototype for 'smc_sysctl_net_init' [-Wmissing-prototypes]
      23 | int __net_init smc_sysctl_net_init(struct net *net)
         |                ^~~~~~~~~~~~~~~~~~~
>> net/smc/smc_sysctl.h:29:17: warning: no previous prototype for 'smc_sysctl_net_exit' [-Wmissing-prototypes]
      29 | void __net_exit smc_sysctl_net_exit(struct net *net) { }
         |                 ^~~~~~~~~~~~~~~~~~~


vim +/smc_sysctl_net_init +23 net/smc/smc_sysctl.h

    22	
  > 23	int __net_init smc_sysctl_net_init(struct net *net)
    24	{
    25		net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
    26		return 0;
    27	}
    28	
  > 29	void __net_exit smc_sysctl_net_exit(struct net *net) { }
    30	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
