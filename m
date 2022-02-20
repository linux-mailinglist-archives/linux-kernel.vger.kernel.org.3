Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493EB4BD08B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiBTSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 13:07:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiBTSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:07:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B5BCAE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645380407; x=1676916407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sbiZxOrgW//HcteGfIkrEpaynizGy24z7JIr3ToYbLo=;
  b=QfcX4kkwKlsOs5bhEr0Seh+USZtKBzzw7mOwuU4GZTPRodgpirfuiTTi
   G9h1AIfPLJOtLUUfxIzU82cfQmUlq3LiccOci7S2PszpRq4IinbnayX9R
   +UfP5ZJYWvk0JqGZ/EWdJO9RDBFED3FoDszzt4ChDF3Zs/yaPRy72qRUV
   nDB4Q1ZfSQUOduHZQkUIavpSKL/0ajiLWXMjOgRK2IXnNZGSOXXpaqUbL
   rklebdKQlkjqgEsZoD6JMyWwKej0D/LeDox0eTYbe/LssMqD19VOA7xjR
   Di/kcqlva1/b0CU54Q7QFdo8jkNgDKDnSYRcbTamqltJ43q4bGoFsycx4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251144353"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="251144353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 10:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="705979699"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 10:06:46 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLqbd-0000YY-Br; Sun, 20 Feb 2022 18:06:45 +0000
Date:   Mon, 21 Feb 2022 02:06:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: timer-of.c:undefined reference to `of_iomap'
Message-ID: <202202210200.80owElMy-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b
commit: 25259f7a5de2de9d67793dc584b15c83a3134c93 clocksource/drivers/timer-microchip-pit64b: Select CONFIG_TIMER_OF
date:   1 year, 10 months ago
config: s390-randconfig-r044-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210200.80owElMy-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=25259f7a5de2de9d67793dc584b15c83a3134c93
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 25259f7a5de2de9d67793dc584b15c83a3134c93
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x832): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0xa8): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0x250): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.constprop.0':
   dpaa2-console.c:(.text+0x3a0): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x3dc): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x3f2): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x540): undefined reference to `iounmap'
   s390-linux-ld: drivers/ptp/ptp_qoriq.o: in function `ptp_qoriq_probe':
   ptp_qoriq.c:(.text+0x216c): undefined reference to `ioremap'
   s390-linux-ld: ptp_qoriq.c:(.text+0x21cc): undefined reference to `iounmap'
   s390-linux-ld: drivers/ptp/ptp_qoriq.o: in function `ptp_qoriq_free':
   ptp_qoriq.c:(.text+0x23b6): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
>> timer-of.c:(.init.text+0xc0): undefined reference to `of_iomap'
>> s390-linux-ld: timer-of.c:(.init.text+0x5a6): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
>> timer-of.c:(.init.text+0x740): undefined reference to `iounmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
