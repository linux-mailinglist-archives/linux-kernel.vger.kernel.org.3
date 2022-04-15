Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44739502095
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348725AbiDOCjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiDOCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:39:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1594C4CD6E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649990238; x=1681526238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=thBFcQ0G/vME42tjSQQVYRK2sX437g+HH5IioFUXTKg=;
  b=D59t6ldojvB4M1ASk7xxhDN9PyZxvicQLH2VOCki2MUs9owtSqDU1Bbv
   SKxMplT4jjUVLF+20cbNT+if9Pd8smweCSp04Z8/SI2vaGAu0VtoenUCH
   R5TnUrOCgVG1JiRAVv6obimgXj07Ad6ksJB0EQxMkghDU7TDNXcobyKjP
   Mg1bUfsjUXvzk7wOuZI1Od3LBrOLbAT/1uJ7Hf6CRjqxBYkwNpaAKT/ri
   3myz5RiPLx0Qev17hUXyHMPqoRe9ntCPLTMBBB/K8xPrTREfJ1oMIjzJi
   es/Viq4tOFx5srbQJrXa5amwOmVOkV6CQvBuGAizuaCk+odnDPOhInYEc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243663974"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="243663974"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="527644854"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 19:37:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfBpj-0001RZ-9P;
        Fri, 15 Apr 2022 02:37:15 +0000
Date:   Fri, 15 Apr 2022 10:37:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 14/29] vmlinux.o: warning: objtool:
 exit_to_user_mode()+0x10: .noinstr.text+0x3425: call to
 static_key_count.constprop.0() leaves .noinstr.text section
Message-ID: <202204151047.7ZlroG22-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-run
head:   47d3f4f7a72524799c1f646713e2377e3c4e239f
commit: f27083b059ff86b9c4c7a64c7afa46fd9249b6c3 [14/29] objtool: Add sec+offset to warnings
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220415/202204151047.7ZlroG22-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=f27083b059ff86b9c4c7a64c7afa46fd9249b6c3
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout f27083b059ff86b9c4c7a64c7afa46fd9249b6c3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x1b: .noinstr.text+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_syscall_64()+0xc: .noinstr.text+0xf6: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_int80_syscall_32()+0x1b: .noinstr.text+0x18e: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x18: .noinstr.text+0x30b8: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x1d: .noinstr.text+0x31d2: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x18: .noinstr.text+0x3313: call to __kcsan_check_access() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: exit_to_user_mode()+0x10: .noinstr.text+0x3425: call to static_key_count.constprop.0() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: syscall_exit_to_user_mode()+0x29: .noinstr.text+0x346a: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x18: .noinstr.text+0x349e: call to __kcsan_check_access() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode()+0x17: .noinstr.text+0x35fb: call to static_key_count.constprop.0() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
