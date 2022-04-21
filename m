Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4C5097BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384903AbiDUGfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbiDUGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:35:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39213F36
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650522770; x=1682058770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HjVQanIuM1BYBElba6NqAn0zIn/a7OPVDnlc56p23Zg=;
  b=Eqi394mzorZCeOFs14NbmYvA97WcOf+OOsm0npHdLO6ArSHXCGiWEZGH
   LMxW5zi2pnJ4ZokxlAc8xh3/BO5kJFeqxgLgTBq7x0okBkQVsjs6uWIyo
   3Hh5h6g306hCaRKqVDAofssHUCn905vs99OE6rWdcX5DHsQx23vjrRPRk
   z6upDWtin4bMtODMJ9+4p7MZhh45WD1MdNAbNtbT+HXYt3ZTVfOB8t+b0
   oi9KE1AxZjVx1FI3AtVNA18IvPXfoNYfVYQhTmyvsxTGuxP51nAdzfw/K
   rX5rfyb00xk9MH7Y6HNIRQuXj7S9gVjKFQiXTbJUvNhLah+f4zg9dBJRn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263107510"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="263107510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="530128322"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2022 23:32:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQMy-0007wn-EA;
        Thu, 21 Apr 2022 06:32:48 +0000
Date:   Thu, 21 Apr 2022 14:32:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1952/2579]
 arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for
 'sysenter_setup'
Message-ID: <202204202001.5zD2lyss-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 143f41d47c158e8acbbce44c87a78966d3e9f62f [1952/2579] headers/deps: x86/cpu, arm64/cpu: Split out <asm/processor_api.h> from <asm/processor.h>
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220420/202204202001.5zD2lyss-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=143f41d47c158e8acbbce44c87a78966d3e9f62f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 143f41d47c158e8acbbce44c87a78966d3e9f62f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/kernel/cpu/mtrr/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for 'sysenter_setup' [-Wmissing-prototypes]
      55 | int __init sysenter_setup(void)
         |            ^~~~~~~~~~~~~~


vim +/sysenter_setup +55 arch/x86/entry/vdso/vdso32-setup.c

^1da177e4c3f4152 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  54  
a6c4e076ee4c1ea6 arch/i386/kernel/sysenter.c        Jeremy Fitzhardinge 2007-05-02 @55  int __init sysenter_setup(void)
^1da177e4c3f4152 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  56  {
0a6d1fa0d2b48fba arch/x86/entry/vdso/vdso32-setup.c Andy Lutomirski     2015-10-05  57  	init_vdso_image(&vdso_image_32);
^1da177e4c3f4152 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  58  
^1da177e4c3f4152 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  59  	return 0;
^1da177e4c3f4152 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  60  }
e6e5494cb23d1933 arch/i386/kernel/sysenter.c        Ingo Molnar         2006-06-27  61  

:::::: The code at line 55 was first introduced by commit
:::::: a6c4e076ee4c1ea670e4faa55814e63dd08e3f29 [PATCH] i386: clean up identify_cpu

:::::: TO: Jeremy Fitzhardinge <jeremy@goop.org>
:::::: CC: Andi Kleen <andi@basil.nowhere.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
