Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825C5536EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 02:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiE2AWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 20:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiE2AWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 20:22:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36336128B
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653783725; x=1685319725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G3SzwzgH6U90mNeORTOYFSFMHmyFrXPh3QZbsig10Lw=;
  b=FPbdBT+zjJQcB6von/1fH1BWWHeCzNhf9bKTvMs1npV/3E3xCEw8TktC
   wbMnsz1iNEg3/v3A9FlR+eD8kM+88bXF11bkXPlf/b+ShzM8Wvkn1dgq4
   RFxUsu3v5I+odr8W0tmCfpbBKLii5R4yYmd8HH0xlY5eXfUJau8vB8Mye
   6uN6bETvHqh2+/DcTWyUDlZ2YJeDBrfsrZjwIxt/kl+fJVzcKu1JjFi8F
   xBP0ILq84y1q+beWYmyHU8WifcVghL5xC6YGV6B1E9+znUKnOYC57AnSZ
   adD7bLx0aDIUtQIBFlJO6Ngqv6tzS4qgqoGei2mKpdUde6S7xJYjLnNvW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="335379784"
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="335379784"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 17:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="705667350"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2022 17:22:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nv6h1-0000cm-0q;
        Sun, 29 May 2022 00:22:03 +0000
Date:   Sun, 29 May 2022 08:21:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: <instantiation>:2:2: error: out of range pc-relative fixup value
Message-ID: <202205290805.1vZLAr36-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
commit: 508074607c7b95b24f0adf633fdf606761bb7824 ARM: 9195/1: entry: avoid explicit literal loads
date:   9 days ago
config: arm-randconfig-r005-20220529 (https://download.01.org/0day-ci/archive/20220529/202205290805.1vZLAr36-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=508074607c7b95b24f0adf633fdf606761bb7824
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 508074607c7b95b24f0adf633fdf606761bb7824
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <instantiation>:2:2: error: out of range pc-relative fixup value
    ldr tsk, =__current
    ^

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
