Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447BE56400F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiGBMR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGBMRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:17:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51746B7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656764274; x=1688300274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l7QMLMP5KsrcSOnYFm+HwWK9zfOnqhdyZ/eUibIp4C0=;
  b=LPYLjLF3FHxiilLRRYdA3lHCowNtFnFxP/ccIy0hLyyaACtR+/uTgLG+
   QOpETIq686wp2Fq5Nl7TPYgm+H4TxIuVgryN4oPFYqvGgTHIEWNnDNeS7
   mwQpeIruPVte+bzYPh6BqaRzXtk/cX0qVPb9xjw9pqiqlHUdQElF6Z0iG
   RaIO0dFWGNiQvsU6ww6g6tRUujIv7agt5oUL2jrgM/4f7d/8rNh+A7Sjf
   qCks8b7Mywr5nb4y40j8TM95QLiF72WbV78kREUDQoA8KjTiJMmZ1vvDU
   21J+pnZqB8Ub4FalsVb0c2ZncV7upKLOZm/nBV8W5pVcgtjlSld474h82
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="271597003"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="271597003"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 05:17:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="566618093"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2022 05:17:52 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7c4N-000FDh-PG;
        Sat, 02 Jul 2022 12:17:51 +0000
Date:   Sat, 2 Jul 2022 20:17:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Simon Que <sque@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 661/6555]
 arch/x86/um/user-offsets.c:30:6: error: no previous prototype for 'foo'
Message-ID: <202207022055.ARalrDZa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

First bad commit (maybe != root cause):

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: 1b944fcc75978529942e762d8cf0dc21d6531a91 [661/6555] CHROMIUM: Add -Werror build option
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20220702/202207022055.ARalrDZa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/1b944fcc75978529942e762d8cf0dc21d6531a91
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout 1b944fcc75978529942e762d8cf0dc21d6531a91
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/um/user-offsets.c:30:6: error: no previous prototype for 'foo' [-Werror=missing-prototypes]
      30 | void foo(void)
         |      ^~~
   cc1: all warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:131: arch/x86/um/user-offsets.s] Error 1
   make[1]: *** [arch/um/Makefile:152: arch/x86/um/user-offsets.s] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:146: sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/foo +30 arch/x86/um/user-offsets.c

45db1c6176c817 arch/x86/um/user-offsets.c        H. Peter Anvin 2011-12-05  23  
8d0b9dc9be3919 arch/um/sys-x86_64/user-offsets.c Al Viro        2005-05-05  24  #define DEFINE(sym, val) \
8d0b9dc9be3919 arch/um/sys-x86_64/user-offsets.c Al Viro        2005-05-05  25  	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
8d0b9dc9be3919 arch/um/sys-x86_64/user-offsets.c Al Viro        2005-05-05  26  
ecba97d4aacf4e arch/um/sys-x86_64/user-offsets.c Al Viro        2005-09-28  27  #define DEFINE_LONGS(sym, val) \
ecba97d4aacf4e arch/um/sys-x86_64/user-offsets.c Al Viro        2005-09-28  28  	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
ecba97d4aacf4e arch/um/sys-x86_64/user-offsets.c Al Viro        2005-09-28  29  
8d0b9dc9be3919 arch/um/sys-x86_64/user-offsets.c Al Viro        2005-05-05 @30  void foo(void)

:::::: The code at line 30 was first introduced by commit
:::::: 8d0b9dc9be3919e9979eac59fd12e8f82b098325 [PATCH] uml: start cross-build support : mk_user_constants

:::::: TO: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
