Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5377E4FA529
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiDIFfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiDIFfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:35:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399E1EC5F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649482378; x=1681018378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gSZGrWvtL+Wz3crmHQOvxroGfbsxwsUHkARCKgPfTz4=;
  b=agbpM1KCAelHVy/huF8UNxi4x1zKt9Xtlw2H3T59889dK8im5RhuIs6P
   gTKAfvHWnCdn7m/edmMQZ1a1hdFKbR9e75uvgxG6prX+U4LT0fGWHYpmj
   6daODxdCUoErcPTuWaX1VvHGve0oWoAZbXAQgWGf3fCqz9ropYcidEAHx
   VF6zxm5/LZmd7xeUtMwa4CAEvY+gpevZS/tJmz0K4efkE51cVcJGDfjo2
   0AEpNJa2/qT0Fk2KKh9dOiiH3xRVjznNHBmCnG3GVF2ofaMUAsPa5onbp
   KcmlmmdVXzz47U4phCM/pr+Gn5Qm+uyPLsNV4eCUQJkiaI4HTeoJXxxoz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261942117"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="261942117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 22:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="653601731"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2022 22:32:57 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd3iS-0000uV-Lw;
        Sat, 09 Apr 2022 05:32:56 +0000
Date:   Sat, 9 Apr 2022 13:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.17 60/137] WARNING: modpost:
 vmlinux.o(.text+0x1e0027): Section mismatch in reference from the function
 resctrl_init() to the function .init.text:thread_throttle_mode_init()
Message-ID: <202204091306.bwxNJVQN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.17
head:   fb7499c2de17b6b98e0e3ac5b7b023bfc5a6f3a4
commit: 0c3df0028a436752977109f708781e42e5dad5d1 [60/137] x86/resctrl: Drop __init/__exit on assorted symbols
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220409/202204091306.bwxNJVQN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=0c3df0028a436752977109f708781e42e5dad5d1
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.17
        git checkout 0c3df0028a436752977109f708781e42e5dad5d1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x1e0027): Section mismatch in reference from the function resctrl_init() to the function .init.text:thread_throttle_mode_init()
The function resctrl_init() references
the function __init thread_throttle_mode_init().
This is often because resctrl_init lacks a __init
annotation or the annotation of thread_throttle_mode_init is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
