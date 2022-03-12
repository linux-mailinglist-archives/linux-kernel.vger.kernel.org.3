Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5D4D6FED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiCLQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiCLQCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:02:39 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15DA40A27
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647100893; x=1678636893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=17L0jtmhqiCUAgmqBfHLwYGjKtJTpJDjg0CGt3GwGSQ=;
  b=URi89qMseQQs/6L2rqH8Wj72q32owLzsWSBtKbmfH2lRKv0ACPDqynP9
   vjQyhpljka7uSrC2pkuM+zzx5CDL659NxzT1wNTxCVAaQtnLRiZBey3p/
   jghSS/keBBNYgjEDRRbqzF25F13uVTzXqSf3FEFsk8bIkY2llf6JvRykA
   Dcr+RWz9c67DRLkt0W9VtrGF9QpbCwR+wXZ3DIBA8NJFJasAoqs/iHr7R
   FKiYN/aLkR1oSRno5mHR5A32gUObdtlEaJXbTBILXh+j/vSmOsNMLocgL
   k80kh/XvAM0rGh78LVosWSYWultOufd17oAhdclL1UWkDRS8NcmaaXOGB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="316524197"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="316524197"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 08:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="645287021"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 08:01:32 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT4BP-00081d-CW; Sat, 12 Mar 2022 16:01:31 +0000
Date:   Sun, 13 Mar 2022 00:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:cex7 194/199] drivers/net/phy/qsfp.c:1229:3: warning:
 misleading indentation; statement is not part of the previous 'if'
Message-ID: <202203122301.EwZ4OlxD-lkp@intel.com>
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

tree:   git://git.armlinux.org.uk/~rmk/linux-arm cex7
head:   e62b9c0824c20d882136cee642512fe1135a3855
commit: 2a180695c3b3730b08f9a216a691d0cd17fcca60 [194/199] net: add qsfp support                              [*experimental*]
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220312/202203122301.EwZ4OlxD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 43f668b98e8d87290fc6bbf5ed13c3ab542e3497)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm cex7
        git checkout 2a180695c3b3730b08f9a216a691d0cd17fcca60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/phy/qsfp.c:1229:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   qsfp_sm_ins_next(qsfp, SFP_MOD_PRESENT, 0);
                   ^
   drivers/net/phy/qsfp.c:1222:2: note: previous statement is here
           if (!qsfp->gpio_irq[GPIO_INTL])
           ^
   1 warning generated.


vim +/if +1229 drivers/net/phy/qsfp.c

  1215	
  1216		if (qsfp->sm_dev_state == SFP_DEV_DETACHED) {
  1217			qsfp_sm_ins_next(qsfp, SFP_MOD_WATTACH, 0);
  1218			return;
  1219		}
  1220	
  1221		// Start the poller if there is no interrupt support if not running
  1222		if (!qsfp->gpio_irq[GPIO_INTL])
  1223			queue_delayed_work(system_wq, &qsfp->poll, poll_jiffies);
  1224	
  1225	//	ret = sfp_module_insert(qsfp->sfp_bus, &id);
  1226	//	if (ret < 0)
  1227	//		qsfp_sm_ins_next(qsfp, SFP_MOD_ERROR, 0);
  1228	//	else
> 1229			qsfp_sm_ins_next(qsfp, SFP_MOD_PRESENT, 0);
  1230	}
  1231	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
