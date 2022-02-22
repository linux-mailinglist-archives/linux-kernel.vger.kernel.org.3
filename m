Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E254C049E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiBVWag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiBVWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:30:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F5107A80
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645569008; x=1677105008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UyRRlRgeHXJbBNOEGIoVcy0ptObVChJE7ejNROH1Y/Q=;
  b=a+G7psE1Fmwu09IjULay9y83nhOZjx2HWZBf2hgRpi/JjtvdgVhUMaaB
   fMa8vrdgchv9t7yM2Hie18MaAjKWVElwh5VvuzP58HqW8OP9EB9eNoq9I
   MGHGVaFiRFuq9SBAmiznQkjaKXTQJQsWETtk406bWwDsc/K8v253qDAuz
   AVr4DowJKu2A8hZqxusN4Im1zaOnrI09mw4Ex6QyaWOX/Ocak5+w8bgJp
   SwfAM5Hbc8aGt9L9ezi8gEx8SLMCDFsrTSxzQBRUpJ15EbgijUhp3uWTn
   1Q5K8OjMNeTRbVVnds5oNEXjWM7FW6YBI7mgkQLhuVVIwrKYtZVOOvbAd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239216889"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="239216889"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 14:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="508180300"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 14:30:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMdfZ-0000gF-8t; Tue, 22 Feb 2022 22:30:05 +0000
Date:   Wed, 23 Feb 2022 06:29:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [nbd168-wireless:mt76 8/22] soc.c:undefined reference to
 `__aeabi_uldivmod'
Message-ID: <202202230633.AxQ32wcu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   5a42c2f71d00b1df6f5790623bce66596a640e5f
commit: 1df906b554bcad9da1eb7e42952fa58133f577e8 [8/22] mt76: mt7915: add support for MT7986
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202230633.AxQ32wcu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/1df906b554bcad9da1eb7e42952fa58133f577e8
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout 1df906b554bcad9da1eb7e42952fa58133f577e8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/net/wireless/mediatek/mt76/mt7915/soc.o: in function `mt7986_wmac_afe_cal':
>> soc.c:(.text+0x1f30): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: drivers/net/wireless/mediatek/mt76/mt7915/soc.o: in function `mt7986_wmac_adie_cfg':
   soc.c:(.text+0x3c54): undefined reference to `__aeabi_uldivmod'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
