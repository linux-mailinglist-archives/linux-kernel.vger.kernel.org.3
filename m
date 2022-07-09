Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F656CA9C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGIQYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGIQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:24:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB92D1E4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657383893; x=1688919893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZZ9lbxa7dIrj/IE1hyK6OS6d2Ha02XShiO2IltDuxWw=;
  b=IHb5l4J6Dk7FdSnOIBTG9GUePqU/WFle+Bw+Yiy731J1GI9pNwaHRJJf
   D7TXTTISpYd/2jBR5QrjpWJR2V5scDH6rPXdhaxHQre9phbWWchy4rfpj
   ew2ST70ICfjvluCaamIt6njgA3O+RxkSw1Drq0vgkjEsBLXqDwQDMgJaP
   Fx3OhpddIWAdpo6IbHT6LwqAYeD74nePpCrHR0PleGh3o+ub2xd35T2e/
   8PgCknIhBGFO+SUYrnWICHyPSSaN1trnHfnlRx+lTok2wieIQPCHss9lj
   9l2vjO+sqbWjb+ZwI6T95+nYvRGgyfKcFTDbnZ9SmVTVwUD8A5kOsRWep
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="281997599"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="281997599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 09:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="621577994"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 09:24:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oADGE-000Ouc-Ob;
        Sat, 09 Jul 2022 16:24:50 +0000
Date:   Sun, 10 Jul 2022 00:24:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 27/35] collect2: error:
 ld returned 1 exit status
Message-ID: <202207100051.GAEQG09J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: 67a0731f120a735a7d6f8685d1fed092e460902e [27/35] powerpc: Make virt_to_pfn() a static inline
config: powerpc-motionpro_defconfig (https://download.01.org/0day-ci/archive/20220710/202207100051.GAEQG09J-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=67a0731f120a735a7d6f8685d1fed092e460902e
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout 67a0731f120a735a7d6f8685d1fed092e460902e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /opt/cross/gcc-11.3.0-nolibc/powerpc-linux/bin/../lib/gcc/powerpc-linux/11.3.0/../../../../powerpc-linux/bin/ld:arch/powerpc/kernel/vdso/vdso32.lds:242: syntax error
>> collect2: error: ld returned 1 exit status
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:66: arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:422: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
