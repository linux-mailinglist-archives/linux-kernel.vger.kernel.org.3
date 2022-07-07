Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5556ABB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiGGTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiGGTSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:18:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A1659248
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657221481; x=1688757481;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=up8cq/+G3lZAX2uopGo9w8cQRtyaAUegDJnUV47QUBg=;
  b=PLY2GjaEIx1Ka8+M0+zwXCOXaM4SIUiSWy8ntneU+J/qsFhd03vl4KSF
   cpeZeCXKYsyxYeOixAu/8WByy81I4Q8G/hZdegtLLBUEGxj+eXiGpN+0y
   5w3t9K+Egnpghk8ik2WHVllDKwlF3CjBLnl0y/vLx8hy5WSavoPyrJEus
   r9XlLZJ/AY3QsRRNqw2QamnBa5K7rvql96VOSmtXimGmLVQ4EB5AdP3dO
   wWQs6W5tvx8jj72wWqBdeiDczQ+4WESe/La8XkBw79gIh3WW264hnvt1k
   w4JowirC7emTyY+oUloBXwTRVT8eyJRHuDnBKv3mXWmDyt8J4+ueUKKvq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="263885935"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="263885935"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 12:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="620919426"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 12:17:59 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9X0g-000MMM-Dh;
        Thu, 07 Jul 2022 19:17:58 +0000
Date:   Fri, 8 Jul 2022 03:17:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: ld.lld: error: undefined symbol: omap_set_dma_priority
Message-ID: <202207080322.DnumSqh8-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   5 weeks ago
config: arm-randconfig-r035-20220706 (https://download.01.org/0day-ci/archive/20220708/202207080322.DnumSqh8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7036440eab3e2d47a775d4616909f8235488d714
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7036440eab3e2d47a775d4616909f8235488d714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: omap_set_dma_priority
   >>> referenced by omapfb_main.c:1706 (drivers/video/fbdev/omap/omapfb_main.c:1706)
   >>>               video/fbdev/omap/omapfb_main.o:(omapfb_do_probe) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
