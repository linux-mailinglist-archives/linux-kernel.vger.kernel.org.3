Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1BA58941D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiHCVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiHCVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:43:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504C4D823
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659563006; x=1691099006;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=31EkGTKWoJ67xuQHsf9/JeBk/obWAn8p0DWaIUbjN0o=;
  b=U5F/a1AeCVsFt+ExOgAPk8D3JKAzceWLO1fJDUxuVqosaJnRX1fD0eHr
   +vzd5CgsjcZGfqiSW9O/FHjZqAc/GoCSl+4hssVkYsNmFNLBUtO2UOGjP
   9pIpkyqIh8pwPmbvIgB/ber+DmrmlZLt/37zzB1XlRO7hDef45nzyEUnt
   8YuWUZ/fYKGbKK3yBgA3Yuhvbj7KI4W5fUmeHMhbpZt9BlnVyJ3ZwFvV3
   gdRKASK1Xj0RlcIXHpt9JiZJqsDgRqkjlZXImiN+484tluYdz48UgTQOT
   jaJCSO27aRXyxR03gQUCOJWdBsonfWW1wluEVJaquCa14pwtZ5/zlSLBv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="276701223"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="276701223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578818113"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 14:43:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJM9D-000HgN-2b;
        Wed, 03 Aug 2022 21:43:23 +0000
Date:   Thu, 4 Aug 2022 05:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [egtvedt-avr32:avr32-cleanup 9/9]
 drivers/net/ethernet/cadence/macb_main.c:4114:9: error: use of undeclared
 identifier 'MACB_MII_OFFSET'
Message-ID: <202208040507.2IhizbEP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git avr32-cleanup
head:   127c95b209653b261277d3a6346b6fc5f9a9ef2e
commit: 127c95b209653b261277d3a6346b6fc5f9a9ef2e [9/9] net:cadence: remove bitfields only used by AVR32
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220804/202208040507.2IhizbEP-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git/commit/?id=127c95b209653b261277d3a6346b6fc5f9a9ef2e
        git remote add egtvedt-avr32 https://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git
        git fetch --no-tags egtvedt-avr32 avr32-cleanup
        git checkout 127c95b209653b261277d3a6346b6fc5f9a9ef2e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/cadence/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/cadence/macb_main.c:4114:9: error: use of undeclared identifier 'MACB_MII_OFFSET'
           .mii = MACB_BIT(MII),
                  ^
   drivers/net/ethernet/cadence/macb.h:725:8: note: expanded from macro 'MACB_BIT'
           (1 << MACB_##name##_OFFSET)
                 ^
   <scratch space>:112:1: note: expanded from here
   MACB_MII_OFFSET
   ^
   1 error generated.


vim +/MACB_MII_OFFSET +4114 drivers/net/ethernet/cadence/macb_main.c

421d9df0628be1 drivers/net/ethernet/cadence/macb.c      Cyrille Pitchen 2015-03-07  4112  
b12422362ce947 drivers/net/ethernet/cadence/macb_main.c Atish Patra     2021-03-03  4113  static const struct macb_usrio_config macb_default_usrio = {
b12422362ce947 drivers/net/ethernet/cadence/macb_main.c Atish Patra     2021-03-03 @4114  	.mii = MACB_BIT(MII),
b12422362ce947 drivers/net/ethernet/cadence/macb_main.c Atish Patra     2021-03-03  4115  	.rmii = MACB_BIT(RMII),
b12422362ce947 drivers/net/ethernet/cadence/macb_main.c Atish Patra     2021-03-03  4116  	.rgmii = GEM_BIT(RGMII),
b12422362ce947 drivers/net/ethernet/cadence/macb_main.c Atish Patra     2021-03-03  4117  	.refclk = MACB_BIT(CLKEN),
b12422362ce947 drivers/net/ethernet/cadence/macb_main.c Atish Patra     2021-03-03  4118  };
b12422362ce947 drivers/net/ethernet/cadence/macb_main.c Atish Patra     2021-03-03  4119  

:::::: The code at line 4114 was first introduced by commit
:::::: b12422362ce947098ac420ac3c975fc006af4c02 net: macb: Add default usrio config to default gem config

:::::: TO: Atish Patra <atish.patra@wdc.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
