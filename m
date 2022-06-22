Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F63655423B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiFVFZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356897AbiFVFZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:25:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C7D36172
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655875535; x=1687411535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sro/Y1blQT+t3/mv6TlJSR9GJUCFgbiWF8T+5qiw/dw=;
  b=R9SAsNIcrQ9o8nAWjXW9Benu4NcDwU4CMNurVxcMZQkivtw2Wxd28MdX
   AIPosfGzTAUXZ5nULM2Ln9DsWS6LMHfy93ASiX7Y6yVVe52/0vpAW1Nqs
   j7+9rQ/twWKutbHRXf7+itSOKKW+KKrkfO7cWC39Hf4veb5OpCtFnBQ0F
   xgCt+DjbpGbooGJ6U2ovmL51sNo3oXIm1lJfT2rF+G4zooqBpliA7q2K6
   dZtbA6lwsGyQLE6i7xuDzOPoxHzYsIIfovXAp1IkRSLlxv5YZlyWFNXpk
   f1JxS0X0RcrbSLpUlNkp8y1QSsbyodBeEVt4H+5Z9MdWNvlJp8Os1ucWK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="342000567"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="342000567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 22:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="715247932"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2022 22:25:33 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3srs-0000sN-N6;
        Wed, 22 Jun 2022 05:25:32 +0000
Date:   Wed, 22 Jun 2022 13:25:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 84/107] drivers/net/dsa/ocelot/felix_vsc9959.c:964:13:
 error: 'state' undeclared; did you mean 'statx'?
Message-ID: <202206221327.UPS1BcWt-lkp@intel.com>
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

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   aedc75cf78fca1c8b7052c5d59981354f47e2e48
commit: 7d384dc3e28afd432b6ce219a699c0f02003e899 [84/107] net: dsa: ocelot: use phylink_validate_mask_caps()
config: alpha-randconfig-r022-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221327.UPS1BcWt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 7d384dc3e28afd432b6ce219a699c0f02003e899
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/dsa/ocelot/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/dsa/ocelot/felix_vsc9959.c: In function 'vsc9959_phylink_caps':
>> drivers/net/dsa/ocelot/felix_vsc9959.c:964:13: error: 'state' undeclared (first use in this function); did you mean 'statx'?
     964 |         if (state->interface == PHY_INTERFACE_MODE_INTERNAL ||
         |             ^~~~~
         |             statx
   drivers/net/dsa/ocelot/felix_vsc9959.c:964:13: note: each undeclared identifier is reported only once for each function it appears in


vim +964 drivers/net/dsa/ocelot/felix_vsc9959.c

56051948773eeb Vladimir Oltean       2019-11-14  958  
7d384dc3e28afd Russell King (Oracle  2022-06-18  959) static unsigned long vsc9959_phylink_caps(phy_interface_t interface)
375e1314292194 Vladimir Oltean       2020-07-13  960  {
7d384dc3e28afd Russell King (Oracle  2022-06-18  961) 	unsigned long caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
7d384dc3e28afd Russell King (Oracle  2022-06-18  962) 			     MAC_10 | MAC_100 | MAC_1000;
375e1314292194 Vladimir Oltean       2020-07-13  963  
375e1314292194 Vladimir Oltean       2020-07-13 @964  	if (state->interface == PHY_INTERFACE_MODE_INTERNAL ||
375e1314292194 Vladimir Oltean       2020-07-13  965  	    state->interface == PHY_INTERFACE_MODE_2500BASEX ||
7d384dc3e28afd Russell King (Oracle  2022-06-18  966) 	    state->interface == PHY_INTERFACE_MODE_USXGMII)
7d384dc3e28afd Russell King (Oracle  2022-06-18  967) 		caps |= MAC_2500FD;
375e1314292194 Vladimir Oltean       2020-07-13  968  
7d384dc3e28afd Russell King (Oracle  2022-06-18  969) 	return caps;
375e1314292194 Vladimir Oltean       2020-07-13  970  }
375e1314292194 Vladimir Oltean       2020-07-13  971  

:::::: The code at line 964 was first introduced by commit
:::::: 375e131429219486e581df8bd11b0dff87f0895a net: dsa: felix: move probing to felix_vsc9959.c

:::::: TO: Vladimir Oltean <vladimir.oltean@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
