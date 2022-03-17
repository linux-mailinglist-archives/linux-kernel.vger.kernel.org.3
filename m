Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB784DC64A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiCQMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiCQMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:50:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C271F42E2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647521319; x=1679057319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mYhgx/HiEDdDexClao7e4niJkKbELvWjIJ75bMdPt3Q=;
  b=K2oZ8BPXVkRC3nh9mQgMh/eOSQasFujxwpvd422EKBxngmVfYcTZOhfR
   cQQgxO+jaFgWWijRR9/t+Q0l8BKtZw5A7feEwy20EVU19q2gCOMcvBNt7
   YO+HCFiutahW0ZuAGC0FMmOmEoYd+ihAmQckgsRW4HmGi4jpJ70oPY18l
   OjldNHOhkMYv1OmoOGDRGqwuJ+99HPn3PKui3dUi9XatE/sXJHVfii2RW
   VZPE6qQxwBVcWeu0PPxnD/DfQRUpDO18CqGi8ZcKMmaBfY3XHvg07263d
   ONqb+LDkWX/5Vtvws9yoUuCzwR1uGhw/438QOG71G2wZfBocB8qc1jFI8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236801165"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236801165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 05:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581281562"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2022 05:48:38 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUpYT-000Dgf-C2; Thu, 17 Mar 2022 12:48:37 +0000
Date:   Thu, 17 Mar 2022 20:47:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1844/2335]
 arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for
 'sysenter_setup'
Message-ID: <202203172022.xT4Voz39-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: b2730b92628ba23505877fc0c22a6c794bdcbe1e [1844/2335] headers/deps: x86/elf: Optimize <asm/elf.h> dependencies, split out <asm/elf_api.h>
config: i386-randconfig-a001-20220314 (https://download.01.org/0day-ci/archive/20220317/202203172022.xT4Voz39-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b2730b92628ba23505877fc0c22a6c794bdcbe1e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout b2730b92628ba23505877fc0c22a6c794bdcbe1e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for 'sysenter_setup' [-Wmissing-prototypes]
      55 | int __init sysenter_setup(void)
         |            ^~~~~~~~~~~~~~


vim +/sysenter_setup +55 arch/x86/entry/vdso/vdso32-setup.c

^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  54  
a6c4e076ee4c1e arch/i386/kernel/sysenter.c        Jeremy Fitzhardinge 2007-05-02 @55  int __init sysenter_setup(void)
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  56  {
0a6d1fa0d2b48f arch/x86/entry/vdso/vdso32-setup.c Andy Lutomirski     2015-10-05  57  	init_vdso_image(&vdso_image_32);
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  58  
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  59  	return 0;
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  60  }
e6e5494cb23d19 arch/i386/kernel/sysenter.c        Ingo Molnar         2006-06-27  61  

:::::: The code at line 55 was first introduced by commit
:::::: a6c4e076ee4c1ea670e4faa55814e63dd08e3f29 [PATCH] i386: clean up identify_cpu

:::::: TO: Jeremy Fitzhardinge <jeremy@goop.org>
:::::: CC: Andi Kleen <andi@basil.nowhere.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
