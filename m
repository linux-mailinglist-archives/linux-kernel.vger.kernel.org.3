Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F935477A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 23:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiFKVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFKVBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:01:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B07C38783
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654981304; x=1686517304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dd0wte+Cdpv37UYBfgqGw46kiLrKtJCEiyWEQ+n5icQ=;
  b=dNU0RqxHwsU48Wud1NGKGz0PhG1meQnk4BvO/YRgCm2zEbl/wLeCAgGj
   mHPcorkObUofcx+Tw+UkRltJX4FaFIYZ/JGYcdqazRkIgXeBRCkchc9rI
   lF3zJmqMB+LPBCAHc5L8keH5IdJxEID7H3/f3fII3F/D0WUlDRFSenFfX
   8vjP0ldBsL/4DhzV1l1nLMTdBlRTLaL1db8tjQAjJ/VQkX2wSTleckfjj
   Tj3oN0T9bBvuMWCNM4IH7lJlndKy1Z9eYEH8neiC8fWkqPfeqj6E+/tNP
   csxMChiuiPDLDZax5ldoR1cCR/yodu+eDtRipecqGHnnD5RYvkUfk6TA6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="341960219"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="341960219"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 14:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="534562140"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2022 14:01:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o08Eo-000JIJ-8f;
        Sat, 11 Jun 2022 21:01:42 +0000
Date:   Sun, 12 Jun 2022 05:00:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final
 BE8 format
Message-ID: <202206120438.Un6Wq4N0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0678afa6055d14799c1dc1eee47c8025eba56cab
commit: 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3 ARM: rework endianess selection
date:   9 weeks ago
config: arm-randconfig-r012-20220612 (https://download.01.org/0day-ci/archive/20220612/202206120438.Un6Wq4N0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8 format
   arm-linux-gnueabi-ld: failed to merge target specific data of file .btf.vmlinux.bin.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
