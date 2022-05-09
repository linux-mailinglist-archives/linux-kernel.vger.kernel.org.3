Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DC5206C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiEIVl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEIVl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:41:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D67AAB5C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652132281; x=1683668281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QcAWB0AgFZaO0DsfejmAUc/6q/61aU9ZhlVoiR+/dO0=;
  b=UJZPVLSIs7F2Vt+Af99TKbw5Fypx/PCt2/nClRa+UmppksLXGurin4Uv
   EtEMoHY/KvOgo+JViOMFABiQ4+Arxxrjxc/7HHkDf+T2WRjyri9z+coM5
   /tRuftZ58y1LYhJ0O5qpaB9Ma52mrn8D4ETrBY7Mtspez4DKt1d1C33wG
   1u8pA/0rlz+P0ymjN0/u88EvCDYgIy2nOUuA6JOisNKPNzWJpVblxYhYi
   mrjrvl3mADa71Zb580AeCiNX2Zh3Pydi8BFUHc29shwvevEjV6yJraaex
   cjo06og+SHW9a72hmDdu+etYyCDfhiNUJs/bGlany2pOMkL5faz9ViT4Q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="256713562"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="256713562"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="519423217"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 May 2022 14:37:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noB4o-000Gvu-BF;
        Mon, 09 May 2022 21:37:58 +0000
Date:   Tue, 10 May 2022 05:37:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Subject: drivers/bluetooth/btmtkuart.c:1071:36: warning: 'mt7668_data'
 defined but not used
Message-ID: <202205100506.o9bhQ6UB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: 22eaf6c9946ae269061d95bb9ceee02524166474 Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices
date:   3 years, 2 months ago
config: x86_64-randconfig-r011-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100506.o9bhQ6UB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=22eaf6c9946ae269061d95bb9ceee02524166474
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 22eaf6c9946ae269061d95bb9ceee02524166474
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/bluetooth/ drivers/input/misc/ drivers/rtc/ drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btmtkuart.c:1071:36: warning: 'mt7668_data' defined but not used [-Wunused-const-variable=]
    1071 | static const struct btmtkuart_data mt7668_data = {
         |                                    ^~~~~~~~~~~
>> drivers/bluetooth/btmtkuart.c:1066:36: warning: 'mt7663_data' defined but not used [-Wunused-const-variable=]
    1066 | static const struct btmtkuart_data mt7663_data = {
         |                                    ^~~~~~~~~~~
>> drivers/bluetooth/btmtkuart.c:1062:36: warning: 'mt7622_data' defined but not used [-Wunused-const-variable=]
    1062 | static const struct btmtkuart_data mt7622_data = {
         |                                    ^~~~~~~~~~~


vim +/mt7668_data +1071 drivers/bluetooth/btmtkuart.c

  1061	
> 1062	static const struct btmtkuart_data mt7622_data = {
  1063		.fwname = FIRMWARE_MT7622,
  1064	};
  1065	
> 1066	static const struct btmtkuart_data mt7663_data = {
  1067		.flags = BTMTKUART_FLAG_STANDALONE_HW,
  1068		.fwname = FIRMWARE_MT7663,
  1069	};
  1070	
> 1071	static const struct btmtkuart_data mt7668_data = {
  1072		.flags = BTMTKUART_FLAG_STANDALONE_HW,
  1073		.fwname = FIRMWARE_MT7668,
  1074	};
  1075	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
