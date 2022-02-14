Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A784B4CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349413AbiBNKyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:54:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349530AbiBNKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:54:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1927D00C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644833993; x=1676369993;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0yLFNOIGToq/p2/KVakPCZoAWj5AOgxJXSVl05HdvEI=;
  b=YtRLNQwFLxygqv8sybyRwKmzItlwSIEyfj4wpf/39Nntfc8DyjdEV4Ne
   X37chYfV5yeUHHtiFmqCPHJ4cINLursPVdZS4UWD4RXjCpE7IS5A9z5ra
   4ZhJNTs3qBiC0V91UGUVkenRCrkSfRKZCJ+onKqF9lUv+1xFRQGM2Peko
   zna0JfQTMt43XkYVtK6FZv03bJBt/Iwo0j15NEa0BtDh+azq4gQRm4f9j
   wcqkFM0Df1qjfcek7GJqwXC6tBap5hJs5KQf2bk6ZBQSXw6ri9Hz2BfLl
   ZNjpaDSFs+LiHSnGhZYUy+0OMK6x5KJiBwig44wenbZbI0Og3ypg8pL+r
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250007151"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250007151"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="635071019"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2022 02:19:52 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJYSV-0008OI-Ex; Mon, 14 Feb 2022 10:19:51 +0000
Date:   Mon, 14 Feb 2022 18:19:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/entry/common.c:736:24: warning: no previous prototype for
 function 'xen_pv_evtchn_do_upcall'
Message-ID: <202202141812.bb7YTaL8-lkp@intel.com>
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
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: 2f6474e4636bcc68af6c44abb2703f12d7f083da x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
date:   1 year, 8 months ago
config: x86_64-randconfig-a006-20220214 (https://download.01.org/0day-ci/archive/20220214/202202141812.bb7YTaL8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f6474e4636bcc68af6c44abb2703f12d7f083da
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2f6474e4636bcc68af6c44abb2703f12d7f083da
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/entry/common.c:59:24: warning: no previous prototype for function 'enter_from_user_mode' [-Wmissing-prototypes]
   __visible noinstr void enter_from_user_mode(void)
                          ^
   arch/x86/entry/common.c:59:19: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible noinstr void enter_from_user_mode(void)
                     ^
                     static 
   arch/x86/entry/common.c:274:24: warning: no previous prototype for function 'prepare_exit_to_usermode' [-Wmissing-prototypes]
   __visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
                          ^
   arch/x86/entry/common.c:274:19: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
                     ^
                     static 
   arch/x86/entry/common.c:336:24: warning: no previous prototype for function 'syscall_return_slowpath' [-Wmissing-prototypes]
   __visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
                          ^
   arch/x86/entry/common.c:336:19: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
                     ^
                     static 
>> arch/x86/entry/common.c:736:24: warning: no previous prototype for function 'xen_pv_evtchn_do_upcall' [-Wmissing-prototypes]
   __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
                          ^
   arch/x86/entry/common.c:736:19: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
                     ^
                     static 
   4 warnings generated.


vim +/xen_pv_evtchn_do_upcall +736 arch/x86/entry/common.c

   735	
 > 736	__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
