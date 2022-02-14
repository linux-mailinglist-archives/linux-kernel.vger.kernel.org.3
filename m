Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BD04B5DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiBNW5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:57:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiBNW5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:57:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF2188D43
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644879444; x=1676415444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ncSQu8h4Gt3EXP+EgHZpewcBCqr4mMwF1iZsd9W1S5I=;
  b=LxTFm/CbL4N4MZg1t85HKQuCjjZpmgF9FfTgJiNMNxsdImMWL2FVlJ7o
   +QvnxXMCZ1rP65Ba9+Yww7Cv+SUPZnlhfLVVuP3DZrzdO91Sob990eGe0
   XhOGFxBjX7lRDfngNsQriMU3F0EhzhRWYetKYnk21DH2Fx0wzM6CRwtmD
   tTkW2yPoD8bGrjCPzo2Fm3jnHz/aHKLpnTiSuOykb37FAhPL/h60nEacI
   Rdbkft2CRJAH0zGOFE4KZn/ELzJzGAs5kA/N20abuCXQHVQN4VQLwXcxS
   dt2hCBjvo6RgXyW5U7nNSWOsoCRATbgCOwD47ySd1kAW57DPBZ1PfP4Og
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250148444"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250148444"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="528488703"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2022 14:57:21 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJkHZ-00090k-AZ; Mon, 14 Feb 2022 22:57:21 +0000
Date:   Tue, 15 Feb 2022 06:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [nbd168-wireless:mt76 8/15]
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c:106:18: warning: variable
 'temp' set but not used
Message-ID: <202202150606.d9hKxuTN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   56435dc5c16dfd2c15afd83933b8fe3689a299d6
commit: 91eeaef2523f3456f24a7dbdbf1e0e7deb133a48 [8/15] mt76: mt7915: add support for MT7986
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220215/202202150606.d9hKxuTN-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/91eeaef2523f3456f24a7dbdbf1e0e7deb133a48
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout 91eeaef2523f3456f24a7dbdbf1e0e7deb133a48
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/soc.c: In function 'mt7986_wmac_adie_efuse_read':
>> drivers/net/wireless/mediatek/mt76/mt7915/soc.c:106:18: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
     106 |         int ret, temp;
         |                  ^~~~
   drivers/net/wireless/mediatek/mt76/mt7915/soc.c: In function 'mt7986_wmac_probe':
>> drivers/net/wireless/mediatek/mt76/mt7915/soc.c:1131:19: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1131 |         chip_id = (u64)of_device_get_match_data(&pdev->dev);
         |                   ^


vim +/temp +106 drivers/net/wireless/mediatek/mt76/mt7915/soc.c

   101	
   102	static int
   103	mt7986_wmac_adie_efuse_read(struct mt7915_dev *dev, u8 adie,
   104				    u32 addr, u32 *data)
   105	{
 > 106		int ret, temp;
   107		u32 val, mask;
   108	
   109		ret = mt76_wmac_spi_write(dev, adie, MT_ADIE_EFUSE_CFG,
   110					  MT_ADIE_EFUSE_CTRL_MASK);
   111		if (ret)
   112			return ret;
   113	
   114		ret = mt76_wmac_spi_rmw(dev, adie, MT_ADIE_EFUSE2_CTRL, BIT(30), 0x0);
   115		if (ret)
   116			return ret;
   117	
   118		mask = (MT_ADIE_EFUSE_MODE_MASK | MT_ADIE_EFUSE_ADDR_MASK |
   119			MT_ADIE_EFUSE_KICK_MASK);
   120		val = FIELD_PREP(MT_ADIE_EFUSE_MODE_MASK, 0) |
   121		      FIELD_PREP(MT_ADIE_EFUSE_ADDR_MASK, addr) |
   122		      FIELD_PREP(MT_ADIE_EFUSE_KICK_MASK, 1);
   123		ret = mt76_wmac_spi_rmw(dev, adie, MT_ADIE_EFUSE2_CTRL, mask, val);
   124		if (ret)
   125			return ret;
   126	
   127		ret = read_poll_timeout(mt76_wmac_spi_read, temp,
   128					!FIELD_GET(MT_ADIE_EFUSE_KICK_MASK, val),
   129					USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
   130					dev, adie, MT_ADIE_EFUSE2_CTRL, &val);
   131		if (ret)
   132			return ret;
   133	
   134		ret = mt76_wmac_spi_read(dev, adie, MT_ADIE_EFUSE2_CTRL, &val);
   135		if (ret)
   136			return ret;
   137	
   138		if (FIELD_GET(MT_ADIE_EFUSE_VALID_MASK, val) == 1)
   139			ret = mt76_wmac_spi_read(dev, adie, MT_ADIE_EFUSE_RDATA0,
   140						 data);
   141	
   142		return ret;
   143	}
   144	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
