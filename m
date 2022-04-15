Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16F1502DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355815AbiDOQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355856AbiDOQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:27:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB4419B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650039911; x=1681575911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B36/RaVcjkCRny+oxQ/PTFetPsrjjelekUyEPUIGMKk=;
  b=GKywbCRQEQ7MrGuRII131L462RsGaaYOjqQMifmWTirq5jZfk3kwcIju
   BYL/bd79PymFn77qzBoeVAYHqbrZqx8LmeOP6xeqSJzBXS2E9Bo3D3ipd
   3irfwJlAFJDjjUQIknn/PsoGUeRac1tQDNvAEpdFN/Te4nKODHuI2agn1
   06H63Mg79tjoF2FQtWTNcHnj2OESfwp3jRajX8Xqzp2L1XuE0NBpIOt1i
   rJv3ogdq6EzzXbIoE6oM9AIPr8S9bLPRsbIHgU74SuyolWaQFvT2X7m0K
   0lUY5kNw/Urg8oTEqtrfXIjPyQDyjIfGDZy7za0ALHVfLS5CicFKIKvLF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262934888"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262934888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 09:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="508985464"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2022 09:23:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfOjA-000297-Ma;
        Fri, 15 Apr 2022 16:23:20 +0000
Date:   Sat, 16 Apr 2022 00:22:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 19/35] vmlinux.o: warning: objtool:
 exit_to_user_mode+0x10: call to static_key_count.constprop.0() leaves
 .noinstr.text section
Message-ID: <202204160031.TT2073NX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-run
head:   b8646d8664875281b48db7752d3dc7880b7561e1
commit: f2bec70312f62ef4f1ea21c134d9def627182ad3 [19/35] objtool: Don't print parentheses in function addresses
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220416/202204160031.TT2073NX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=f2bec70312f62ef4f1ea21c134d9def627182ad3
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout f2bec70312f62ef4f1ea21c134d9def627182ad3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __do_fast_syscall_32+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_syscall_64+0xc: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_int80_syscall_32+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x1d: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x18: call to __kcsan_check_access() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: exit_to_user_mode+0x10: call to static_key_count.constprop.0() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x29: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x18: call to __kcsan_check_access() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x17: call to static_key_count.constprop.0() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
