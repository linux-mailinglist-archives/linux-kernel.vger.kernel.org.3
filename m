Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEACF4D6BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 02:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiCLBoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 20:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLBoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 20:44:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46263251840
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647049384; x=1678585384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z8j2LPqsRu8Nn02g5awv6IpB0MLCnL1HKKZUGgOrQNI=;
  b=giHC2ZSJ38dXOtGjrOniBOzQZW8UjGvOaYzVorcxu+OvuE5D80p5Zw8+
   o8pW1FLmMqO1lUx2iSdYF0ln0SXoRcUa8Biv+xmr/XG9NZhGRXdz4wgkH
   TGXA184ovqqT33OvTlPDppHp6pVLUj3QKhD+RFlrETV6OU/qlZLFSjVoh
   mccgkmW866oauet/gYnydZjtaPsiayo8yvHwAKMMjpVxs3hLvpwwVEKyo
   xjW/y2ssRj1LMacY+l8ZcXeM6lrjZWF73nOjAEz6hkNlrNk7Tgv8pLpU8
   +3qRCKpwPCn8mDJOYZEAD4iEz36JvDwcNBPW99bR/vRC6zEXss/L4g6X+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="318929920"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="318929920"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 17:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="689259487"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2022 17:43:02 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSqmb-0007Nb-NJ; Sat, 12 Mar 2022 01:43:01 +0000
Date:   Sat, 12 Mar 2022 09:42:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:devel-stable 9/11] arm-linux-gnueabi-ld: undefined
 reference to `generic_handle_arch_irq'
Message-ID: <202203120941.zv8Hv5iE-lkp@intel.com>
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

tree:   git://git.armlinux.org.uk/~rmk/linux-arm devel-stable
head:   f6b8e3526feb025d0259c18d6dc6b8c2e2cfedf0
commit: 7a8ca84a258a79e564b77b1bbb139f3f561d149b [9/11] ARM: entry: fix unwinder problems caused by IRQ stacks
config: arm-randconfig-r022-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120941.zv8Hv5iE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm devel-stable
        git checkout 7a8ca84a258a79e564b77b1bbb139f3f561d149b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_svc':
   (.entry.text+0x158): undefined reference to `generic_handle_arch_irq'
>> arm-linux-gnueabi-ld: (.entry.text+0x15e): undefined reference to `generic_handle_arch_irq'
   arm-linux-gnueabi-ld: (.entry.text+0x162): undefined reference to `generic_handle_arch_irq'
   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_usr':
   (.entry.text+0x4ba): undefined reference to `generic_handle_arch_irq'
   arm-linux-gnueabi-ld: (.entry.text+0x4be): undefined reference to `generic_handle_arch_irq'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
