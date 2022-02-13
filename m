Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015B74B3AEB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiBMKkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:40:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBMKkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:40:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C925D645
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644748828; x=1676284828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RMpOgcZogn64CK/ZiQKHNBcoXLNVX6QbmGK0bFHjZQA=;
  b=WzWajMsZMMZNQM1jPhz9npCXCia47i7IkClIFa7/EjhKJNFWToCKEWsD
   YKSbzHMnC4OfxUOQCyCPTyXxnBvuADR3mW/AxhHd8SEbHoJKotHM5ST9D
   nwdJEVY+qHorJTkhd1B5Qr0cHpuLajlbkMmltjtxvFApgpKmOJnd7SfWX
   bZCs2AM9CAL0ayFUgTny/21zsyXuFYWRNYjZvPFuPNEyoUIKeh7hvDY6r
   k49IrianPRYGFGfJbwNeXy+Zdp/b7MvvWjzpzxr3inVNl1at9iWTW5OHN
   QqjYNGqnPvOXKhV+oaXWbdMyZBCj4faKJkdwxF1EPtev4j+Xdueq0GLfi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="248770658"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="248770658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 02:40:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="484689715"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2022 02:40:26 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJCIr-0007Nh-KJ; Sun, 13 Feb 2022 10:40:25 +0000
Date:   Sun, 13 Feb 2022 18:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: gcc: error: unrecognized command-line option '-mno-space-regs'
Message-ID: <202202131837.mZeWy9J4-lkp@intel.com>
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
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e parisc: Fix compile failure when building 64-bit kernel natively
date:   6 months ago
config: parisc64-randconfig-r035-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131837.mZeWy9J4-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>> gcc: error: unrecognized command-line option '-mno-space-regs'
>> gcc: error: unrecognized command-line option '-mno-space-regs'
>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'; did you mean '-mforce-indirect-call'?
>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'; did you mean '-mforce-indirect-call'?
>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>> gcc: error: unrecognized command-line option '-mschedule=7200'
   make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>> gcc: error: unrecognized command-line option '-mschedule=7200'
   make[2]: *** [scripts/Makefile.build:271: scripts/mod/empty.o] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1216: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
