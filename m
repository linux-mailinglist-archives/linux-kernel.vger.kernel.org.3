Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C446458B409
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiHFGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiHFGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:13:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC2B20BCA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659766430; x=1691302430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ogGMYMg7jBlHDowggTQVb4JBiyykT3hE4hToiyk4z0=;
  b=Q+zHdt6llfkO95y06qwzHXMfJtQ/nUZKaC+e6l3B023bCUSGMUk+mYY/
   1Lx6HNa56ESwEiE0dV7NPnAFEV5pSA2Hu7mQfoydcTVg6CiDSTddFm6TT
   7bS6+iHz0832m8YmFvYIeY2U1gwYja1poiy1yJZ8u2ogiF9EDDwtMkhOt
   zh2JtCPiMi2D9GzCziRxj94eqEZrp3/+CepFeb0kQQrxep3UDo4NJnvtA
   p1NM3wwyR8KsnfH9pYp9huqhwmEJQ3tqOHP/rQoMxOUmDWyQLkufSBLDs
   EV9SUGP4p6vKNpJgyQeEXVqvNCnT7lM4LI8tt1vI5JERkeSPxUosvQtux
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277268769"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="277268769"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 23:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579750218"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 23:13:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKD4E-000K6f-1g;
        Sat, 06 Aug 2022 06:13:46 +0000
Date:   Sat, 6 Aug 2022 14:13:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 SERIAL_SUNPLUS_CONSOLE when selected by SOC_SP7021
Message-ID: <202208061424.imoOUdLA-lkp@intel.com>
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
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: 0aa94eea8d955c82014e5368a843da93f1dc58f8 ARM: sunplus: Add initial support for Sunplus SP7021 SoC
date:   4 weeks ago
config: arm-kismet-CONFIG_SERIAL_SUNPLUS_CONSOLE-CONFIG_SOC_SP7021-0-0 (https://download.01.org/0day-ci/archive/20220806/202208061424.imoOUdLA-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0aa94eea8d955c82014e5368a843da93f1dc58f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0aa94eea8d955c82014e5368a843da93f1dc58f8
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_SERIAL_SUNPLUS_CONSOLE --selectors CONFIG_SOC_SP7021 -a=arm
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE when selected by SOC_SP7021
   
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && (ARCH_SUNPLUS [=y] || COMPILE_TEST [=n])
     Selected by [y]:
     - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]
   
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_SUNPLUS [=y]
     Selected by [y]:
     - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
