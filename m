Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2692566077
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiGEBGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGEBGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:06:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D2A445
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656983195; x=1688519195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2kbESs4Lmg+FPc+tyowZC1hzBHF1WsUeXqjzZxAm22k=;
  b=nRtJigrmSTAruxhUreSrfgkIwR8GgmNQJTU9j/2TApzpQhv+yb9a3eon
   1oO6VV7cqidjGz8hFTriMFp1doJxelm2MmmjeS39apM4NiyKzX8EbAfhN
   v4UmgcukEEw9nNUMUmrGiSJFkQIXU71MRsjCiWFZVeDKfT/ZmKfBFVcJZ
   R99E+Kx48O8yTZfrYND07H96dy2OWE4XVGc81DozAtQhwoUIk32drxpvN
   C6X9iZu8c7738ee8thhfBmtPA68jsptsODHxhW1Vkyum9nepx6nU2Xyrl
   DgbC5I1ejqI07VC+XMigK4SCE3FbJNP1GT0CmzhjtvdeYaZAXlr0k2tti
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263012474"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263012474"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 18:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="660356420"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2022 18:06:34 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8X1N-000IXj-Bw;
        Tue, 05 Jul 2022 01:06:33 +0000
Date:   Tue, 5 Jul 2022 09:05:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 28/35] main.c:undefined
 reference to `virt_to_pfn'
Message-ID: <202207050943.NLWeuegh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: ea189c32a142b7a3e7f9bd45fd611e943991be0b [28/35] riscv: Make virt_to_pfn() a real function
config: riscv-randconfig-r012-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050943.NLWeuegh-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=ea189c32a142b7a3e7f9bd45fd611e943991be0b
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout ea189c32a142b7a3e7f9bd45fd611e943991be0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: init/main.o: in function `.L354':
>> main.c:(.init.text+0x1660): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: init/main.o: in function `.L356':
   main.c:(.init.text+0x16a4): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/fork.o: in function `.L0 ':
>> fork.c:(.text+0x4dc): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/fork.o: in function `.L245':
   fork.c:(.text+0x1484): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/fork.o: in function `dup_task_struct':
   fork.c:(.text+0x169c): undefined reference to `virt_to_pfn'
   riscv64-linux-ld: kernel/fork.o:fork.c:(.text+0x325c): more undefined references to `virt_to_pfn' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
