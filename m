Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8556E4B6451
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiBOH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:28:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiBOH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:28:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A9CEFFB0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644910072; x=1676446072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DDTsJKGHetOo7a+nWO+SVJ+F9vT14Z3iVzCv1/h6nT4=;
  b=j3Gy2kyXIu+qnanyrSSx3gGb89l+csipjur3oCi2Wo9G6bNjSjw0Ku7z
   yAHZzpUivUN9JNc9bOzBd2NnbmphBKN7PnSJ6+vna8d7DqA0bCez7J4Bz
   1+VDOKO7S7ubJDnk3PklrPzB8XMGvWSFgSJUsWsb+51MpvJeKq2BVaOk5
   H0/koCJbpIim1dZ6mf1EbvsBQ9aojYE1cdpsEGH6hZaxpPU0AB+U1qIvm
   tOPZMw0bJZxJMjQ26XWuXts6aZGxCHv41hpal3J4TiaRIzZKjHUc5Ob5k
   5M7CLxu+c0KnE0+ruNGTWpiP/e49Iy/87GdI5s4A1oC4glCqRabzrrxjk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336697388"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="336697388"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 23:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="624637978"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2022 23:27:39 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJsFO-0009Pc-Re; Tue, 15 Feb 2022 07:27:38 +0000
Date:   Tue, 15 Feb 2022 15:26:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: clk-lan966x.c:undefined reference to `devm_platform_ioremap_resource'
Message-ID: <202202151558.8lH3awZt-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d567f5db412ed52de0b3b3efca4a451263de6108
commit: 54104ee023333e3bd8062ff1cbc312ea4c5bf733 clk: lan966x: Add lan966x SoC clock driver
date:   10 weeks ago
config: s390-randconfig-r044-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151558.8lH3awZt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54104ee023333e3bd8062ff1cbc312ea4c5bf733
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54104ee023333e3bd8062ff1cbc312ea4c5bf733
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x72): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x786): undefined reference to `iounmap'
   s390-linux-ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
>> clk-lan966x.c:(.text+0x956): undefined reference to `devm_platform_ioremap_resource'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
