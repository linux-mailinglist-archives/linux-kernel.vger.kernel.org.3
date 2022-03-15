Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13EF4D92AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiCOCis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiCOCir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:38:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF14755F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647311856; x=1678847856;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4zB0EluaBLUlbrJtFNQECe8zx0RpNQBtFyPNsRfg9xI=;
  b=EJyASLzGsHuKHWg4+3KUkTWuwiu5KQ7X7DkfVsAIv/gV3lyGlJY7CvhG
   VwfZ1Wn/KOCi2lgt3XUgLxsJJZY6n5zHvF6EIByEoV7CUIpCkcj97rYz2
   Z7tlTLUhEOAuw8VO+hsIJokJXkxAsLTLU0+9ehdCJl1rfy8+/nMY9zeVu
   Yl7JfPWj25gGK7fQH+MnDyMMIAYUtR3CoILCJLT103TWU1jExqkLvYmWW
   toCC98738JZJNVobBBq0sqjCCumF1hZIykZElMDk5sJHNelCn+LJGD6us
   9L+keYGyo42AAwX5pgzR7HwSzbor1vMmF1QrjWPko8RZoe3r8uMHuf7Nj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255923655"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="255923655"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 19:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="497852010"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2022 19:37:34 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTx41-000ATL-8a; Tue, 15 Mar 2022 02:37:33 +0000
Date:   Tue, 15 Mar 2022 10:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:netdev/net-next/master 111/126]
 drivers/net/ethernet/mscc/ocelot.c:2920:14: error: use of undeclared
 identifier 'IEEE_8021QAZ_MAX_TCS'
Message-ID: <202203151054.NrsDHU0t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/master
head:   5e7350e8a618ebfea0713b30986976fcbb90b8bb
commit: 978777d0fb06663523281aa50a5040c3aa31fbe7 [111/126] net: dsa: felix: configure default-prio and dscp priorities
config: hexagon-randconfig-r032-20220313 (https://download.01.org/0day-ci/archive/20220315/202203151054.NrsDHU0t-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3e4950d7fa78ac83f33bbf1658e2f49a73719236)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/978777d0fb06663523281aa50a5040c3aa31fbe7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net-next/master
        git checkout 978777d0fb06663523281aa50a5040c3aa31fbe7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/ethernet/mscc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mscc/ocelot.c:2920:14: error: use of undeclared identifier 'IEEE_8021QAZ_MAX_TCS'
           if (prio >= IEEE_8021QAZ_MAX_TCS)
                       ^
   drivers/net/ethernet/mscc/ocelot.c:2962:14: error: use of undeclared identifier 'IEEE_8021QAZ_MAX_TCS'
           if (prio >= IEEE_8021QAZ_MAX_TCS)
                       ^
   2 errors generated.


vim +/IEEE_8021QAZ_MAX_TCS +2920 drivers/net/ethernet/mscc/ocelot.c

  2917	
  2918	int ocelot_port_set_default_prio(struct ocelot *ocelot, int port, u8 prio)
  2919	{
> 2920		if (prio >= IEEE_8021QAZ_MAX_TCS)
  2921			return -ERANGE;
  2922	
  2923		ocelot_rmw_gix(ocelot,
  2924			       ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL(prio),
  2925			       ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL_M,
  2926			       ANA_PORT_QOS_CFG,
  2927			       port);
  2928	
  2929		return 0;
  2930	}
  2931	EXPORT_SYMBOL_GPL(ocelot_port_set_default_prio);
  2932	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
