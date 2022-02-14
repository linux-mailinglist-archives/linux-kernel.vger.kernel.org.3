Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070694B5A71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiBNTH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:07:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiBNTH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:07:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634BF2DD3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644865631; x=1676401631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7D1GO4YJHOIRP96aOncYfWj1zSTB7tfZJ+Mw8NP2NSo=;
  b=df5focoY+vypeheVFByr99g/3Ezv8IcwILpn5+DYRg59FN7BcU5jqhWB
   lehweWaXAvI+6vpA3CMcG63VvO2pe37nSnI5YDKhvet/sFHaYBNVZ8lew
   HPKBLD0pJMbA2iZFA1rV/A3m9gT75ikUhwxrvxz7j3WZOfNBdxs4nbKTH
   gBhGg+O53cstFCnvqs66g3P85SVFwYCecjD5EbYEp5236R1aGzfme8rq9
   TuL9tFwpGNvpktNtvvQ0feKXnFJYSLizXlidk/h2w8tNx3/sIwd8weJjJ
   G8P2N1JIQf/JN3oz60WNkjwBUx9z68NtgKtShX/UnbkZYCE07gLQfCm6m
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313438223"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="313438223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 11:02:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="495930947"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2022 11:02:16 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJgc3-0008qU-Hk; Mon, 14 Feb 2022 19:02:15 +0000
Date:   Tue, 15 Feb 2022 03:02:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 9/9]
 drivers/net/wireless/mediatek/mt76/dma.c:145:17: warning: variable 'ring'
 set but not used
Message-ID: <202202150257.O7iGQocg-lkp@intel.com>
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

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   6dbc6b1e07e9f4face597784cf4069cff9f3a043
commit: 6dbc6b1e07e9f4face597784cf4069cff9f3a043 [9/9] mt76: mt7915: add Wireless Ethernet Dispatch support
config: x86_64-randconfig-a005-20220214 (https://download.01.org/0day-ci/archive/20220215/202202150257.O7iGQocg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/6dbc6b1e07e9f4face597784cf4069cff9f3a043
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout 6dbc6b1e07e9f4face597784cf4069cff9f3a043
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/dma.c:145:17: warning: variable 'ring' set but not used [-Wunused-but-set-variable]
           int ret, type, ring;
                          ^
>> drivers/net/wireless/mediatek/mt76/dma.c:165:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case MT76_WED_Q_TXFREE:
                ^~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:182:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/net/wireless/mediatek/mt76/dma.c:158:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case MT76_WED_Q_TX:
                ^~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:182:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/net/wireless/mediatek/mt76/dma.c:145:9: note: initialize the variable 'ret' to silence this warning
           int ret, type, ring;
                  ^
                   = 0
   3 warnings generated.


vim +/ring +145 drivers/net/wireless/mediatek/mt76/dma.c

   140	
   141	static int
   142	mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
   143	{
   144		struct mtk_wed_device *wed = &dev->mmio.wed;
 > 145		int ret, type, ring;
   146		u8 flags = q->flags;
   147	
   148		if (!mtk_wed_device_active(wed))
   149			q->flags &= ~MT_QFLAG_WED;
   150	
   151		if (!(q->flags & MT_QFLAG_WED))
   152			return 0;
   153	
   154		type = FIELD_GET(MT_QFLAG_WED_TYPE, q->flags);
   155		ring = FIELD_GET(MT_QFLAG_WED_RING, q->flags);
   156	
   157		switch (type) {
   158		case MT76_WED_Q_TX:
   159	#ifdef CONFIG_NET_MEDIATEK_SOC_WED
   160			ret = mtk_wed_device_tx_ring_setup(wed, ring, q->regs);
   161			if (!ret)
   162				q->wed_regs = wed->tx_ring[ring].reg_base;
   163	#endif
   164			break;
 > 165		case MT76_WED_Q_TXFREE:
   166			/* WED txfree queue needs ring to be initialized before setup */
   167			q->flags = 0;
   168			mt76_dma_queue_reset(dev, q);
   169			mt76_dma_rx_fill(dev, q);
   170			q->flags = flags;
   171	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
