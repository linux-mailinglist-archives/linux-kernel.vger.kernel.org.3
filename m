Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC74E4D1945
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbiCHNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiCHNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:37:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8349697
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646746586; x=1678282586;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lTnzKDCiv9/QLJniNg9fgD9HRuvLFymb/UZZg28Wb6Y=;
  b=iPR5v2n6xkememEa05cRqR3zFta3A3g1ExuAiKr5hDRi5qu9DCUII73/
   blHRLE5/rJ5NVVHsgBmf7gM8nqi9hyJuhOICdnwa9IeVe9j73xIWgePbV
   e+JJY817xKmGT3nQf0sGPIWsHklmfMZiQM856bNwO5g/f8UC8MshSWnNQ
   w9mElsyv7zQXPOPcgfsQur0WBUxPJzZo+9pgX+cxVdeTK00JcjJPFdhAe
   S0zJFbC2byHUR/+6sx4Us9l6W2AOa023gxrWS2ouFTtI2VGJqT1W2qhSF
   fI2sOPkf7Bo8xL7Kgm2KCYiiigsy9aeegPO/3Y7WUlUcm//A/VNKG8k/Y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="341113522"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="341113522"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:36:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="537568182"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2022 05:36:24 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRa0m-0001T3-7d; Tue, 08 Mar 2022 13:36:24 +0000
Date:   Tue, 8 Mar 2022 21:36:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:netdev/net-next/master 150/160]
 net/smc/smc_sysctl.h:23:16: warning: no previous prototype for function
 'smc_sysctl_net_init'
Message-ID: <202203082117.G0KHS6qO-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/master
head:   69adcb988a0675ce001dfc416d56fba2e8a85f48
commit: 7de8eb0d9039f16e1122d7aa524a1502a160c4ff [150/160] net/smc: fix compile warning for smc_sysctl
config: arm-randconfig-r024-20220308 (https://download.01.org/0day-ci/archive/20220308/202203082117.G0KHS6qO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/7de8eb0d9039f16e1122d7aa524a1502a160c4ff
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net-next/master
        git checkout 7de8eb0d9039f16e1122d7aa524a1502a160c4ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/smc/af_smc.c:54:
>> net/smc/smc_sysctl.h:23:16: warning: no previous prototype for function 'smc_sysctl_net_init' [-Wmissing-prototypes]
   int __net_init smc_sysctl_net_init(struct net *net)
                  ^
   net/smc/smc_sysctl.h:23:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __net_init smc_sysctl_net_init(struct net *net)
   ^
   static 
>> net/smc/smc_sysctl.h:29:17: warning: no previous prototype for function 'smc_sysctl_net_exit' [-Wmissing-prototypes]
   void __net_exit smc_sysctl_net_exit(struct net *net) { }
                   ^
   net/smc/smc_sysctl.h:29:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __net_exit smc_sysctl_net_exit(struct net *net) { }
   ^
   static 
   2 warnings generated.


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
