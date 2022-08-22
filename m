Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D459CBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiHVWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbiHVWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:44:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F251A2B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661208254; x=1692744254;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2xeIorpJheoBtdm/CSetaHopp9lwCCU4CAT//VeGZA4=;
  b=WTZB4LA/dqFgvaarnD0PnqVL30DC02NP+dSm+WFVsV++RPOruWKAJtVC
   BZPTla4zLMVsEfLOovOFVzz8nNmf9wNvFjoBrYFd5THifv6MFwXBl60ZM
   bCNew/K5XiQ6vGsqnoCb6mXxIyFvCUu9PIhzC7Oa4/9Lzr96KiYk9aw5y
   co15ks7pT5ehGU+jRTiTYj+WJde1pWHB7x1mbruz5WHpmLVLmCmyN+DLm
   ioqdVXxRDqUTZbEcV48g2NOCWfTP6BuSWT2wpTCvjc8b+RApDlVqHmAfd
   tjfDTdBNMGxFLo/vttH7DhIuHjJ8fnTq0bTquzXLmzegAmfxSXqEWQot2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293536193"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="293536193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751458270"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 15:44:12 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQG9U-0000oV-0X;
        Mon, 22 Aug 2022 22:44:12 +0000
Date:   Tue, 23 Aug 2022 06:43:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [linux-stable-rc:linux-5.15.y 8690/9817] scripts/link-vmlinux.sh:
 123: is_enabled: not found
Message-ID: <202208230606.C8kP9zQs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   a0a7e0b2b8b22901945ea2aef1b65871d718accf
commit: dab72c3c32ccde4f362fff993759b0133448d394 [8690/9817] objtool: Add entry UNRET validation
config: x86_64-buildonly-randconfig-r001-20220822 (https://download.01.org/0day-ci/archive/20220823/202208230606.C8kP9zQs-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=dab72c3c32ccde4f362fff993759b0133448d394
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout dab72c3c32ccde4f362fff993759b0133448d394
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> scripts/link-vmlinux.sh: 123: is_enabled: not found
   vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x97: call to vmload() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret()+0x1e: call to memset() leaves .noinstr.text section
   vmlinux.o: warning: objtool: in_task_stack()+0xc: call to task_stack_page() leaves .noinstr.text section
   vmlinux.o: warning: objtool: in_entry_stack()+0x10: call to cpu_entry_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_setup()+0xa3: call to cpuid_eax() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_read_aux()+0x42: call to {dynamic}() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check()+0xdf: call to mce_gather_info() leaves .noinstr.text section
   ld.lld: error: undefined symbol: fb_set_suspend
   >>> referenced by drm_fb_helper.c
   >>>               gpu/drm/drm_fb_helper.o:(drm_fb_helper_resume_worker) in archive drivers/built-in.a
   >>> referenced by drm_fb_helper.c
   >>>               gpu/drm/drm_fb_helper.o:(drm_fb_helper_set_suspend) in archive drivers/built-in.a
   >>> referenced by drm_fb_helper.c
   >>>               gpu/drm/drm_fb_helper.o:(drm_fb_helper_set_suspend_unlocked) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
