Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5755166A6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353236AbiEARfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiEARfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:35:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB4A19A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651426312; x=1682962312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=94gJY802+7MmTS+7/i3dw7bQ/nPs2nvASExVe0txqaY=;
  b=TPtIzoG9CzPQI83oYYILdom9f58dQm19+dbyyBpJthJE53+sE42oCilY
   NpeAAeXQ7YeSTEu3O5CscH2FC6bE8uTnSYxrDnzex5aRduL/FbIRqLe1s
   n8+dlKqOa2DA4HC0PxTBM9tqO5naYmQkROWLcO1jG/GKB4ecLrIQgrbJJ
   hzT3QzRhS63fE9Fc0BdJykGeaEriWuR2dIvF+qBWEtEn5nUQTQsSgmhbf
   iDZsKvQujGSDDudhdsrcl2f7cYMeS61MeW87O0AqoBAtwrEfSaqfkauBr
   HfrGJru2ZQ1YPe8zXMr5qUq4Ujh8lUf/t7E3fNc8SucEvehfOBbRiOGPc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="292215849"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="292215849"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 10:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707284985"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 10:31:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlDQE-0008wS-4L;
        Sun, 01 May 2022 17:31:50 +0000
Date:   Mon, 2 May 2022 01:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [masahiroy:lto-cleanup-v2 48/55] s390-linux-ld:
 .tmp_vmlinux.kallsyms1: warning: allocated section `.rodata' not in segment
Message-ID: <202205020142.tuVjG3mE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git lto-cleanup-v2
head:   0f0c2c6e09ad55e3c5ddb69915460ee54eb913e4
commit: 58024b1713c48e2cc450f3301fc48077638298cc [48/55] kbuild: embed symbol versions at final link of vmlinux or modules
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220502/202205020142.tuVjG3mE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=58024b1713c48e2cc450f3301fc48077638298cc
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy lto-cleanup-v2
        git checkout 58024b1713c48e2cc450f3301fc48077638298cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> s390-linux-ld: .tmp_vmlinux.kallsyms1: warning: allocated section `.rodata' not in segment
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0xea): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x1f8): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x5e4): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x7a): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x4f4): undefined reference to `iounmap'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x90): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0xcc): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x144): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x76e): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x968): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0x684): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0xcda): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
