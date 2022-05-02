Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9611751765D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386701AbiEBSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbiEBSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:18:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFECF2A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651515278; x=1683051278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPpe6VAMOiLpnTdW7yBa/TtsFWVoUvsg/hRr+MHjv2U=;
  b=DfAoIeZuhyX+iILidSSnDYoFY1MU0EHK20Mpta4uMBaWycEceVWtAJ0f
   CgMWcNo3KuJoy6DP1ovbqtDm54pK0q8qqTR2rv3DgWNDLd5xbBo1Uv9BQ
   NKMYHaRKametCLCMM8Sd+t/mUfkW0Q2tGsOTZOHOrxwW8GAE0lKZXOl60
   WnlahiLrGxoxukqXQfKlhj69KtdoDeFvrm3btXdhwsRtr6FHqHCcfzSHG
   0QDZhr8N6Fo7+aOwRhmZU8eH39mj+lXbnB1fyU+oRHeyCf1mAnq4Ov8CB
   WG/1+xHTtEPRTnie42LI2DnNx49qUDQYV56u6n2pgsfNjIn8QRbIcyblO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330280296"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="330280296"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 11:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="516223108"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 11:14:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlaZ9-0009lD-7p;
        Mon, 02 May 2022 18:14:35 +0000
Date:   Tue, 3 May 2022 02:14:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/100-shutdown-notifier 4/20] vmlinux.o: warning:
 objtool: sys_off_handler_power_off() falls through to next function
 type_store()
Message-ID: <202205030240.yKG1jNwn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/100-shutdown-notifier
head:   06115822707a3ed6f89da2ea9c157c283b6750ee
commit: 6025f4b3d1a321e1cfc8a6b6651395cc43ceb2f3 [4/20] kernel: Add combined power-off+restart handler call chain API
config: x86_64-randconfig-c001-20220502 (https://download.01.org/0day-ci/archive/20220503/202205030240.yKG1jNwn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/6025f4b3d1a321e1cfc8a6b6651395cc43ceb2f3
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/100-shutdown-notifier
        git checkout 6025f4b3d1a321e1cfc8a6b6651395cc43ceb2f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ibt_selftest()+0x11: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ftrace_caller()+0x98: call without frame pointer save/setup
   vmlinux.o: warning: objtool: ftrace_regs_caller()+0xe2: call without frame pointer save/setup
   vmlinux.o: warning: objtool: return_to_handler()+0x14: call without frame pointer save/setup
>> vmlinux.o: warning: objtool: sys_off_handler_power_off() falls through to next function type_store()
   vmlinux.o: warning: objtool: kvm_spurious_fault()+0x21: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive()+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __rdgsbase_inactive()+0x29: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret()+0x7e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug()+0x45: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi()+0xba: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler()+0x49: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x11: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check()+0x57: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check()+0x57: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter()+0x50: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit()+0x40: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x24: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x28: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x24: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exit_to_user_mode()+0x18: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_exit_to_user_mode()+0x31: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x24: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit_to_user_mode()+0x1f: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit()+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ibt_selftest()+0x1e: return with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
