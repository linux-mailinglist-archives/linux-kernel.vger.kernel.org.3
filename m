Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC3526F26
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiENGSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 02:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiENGSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 02:18:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A912A96
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 23:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652509106; x=1684045106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EdRQzImy2o4wcEddyVEewQovxY4rx6GTfNfmK/vOC6U=;
  b=e2AfKAqEtt7/6d8htLc+bYKvsw3z4MfnO5R0svdjaxWig7973jJuMis+
   IEwo1gtKTAzoPKyQ1RvYxfmMN4U8FJGSnrxIeVzh7IrUk8k6vbBtWVdgP
   xYFGkWYE2CQlxFssWEenDXWfifjHHHD6b9VmofTVBqIGmyBvZvnrnibVZ
   aaIBLLllhi/eXISkLzMPmbW5DxqDNrCs1P9zIHmSlWRzgOrIzJsl8T41r
   omTCNQfe3lkwFzPZDYFe1KLQP1EYja60Whkq87Jk3S5o27kQgkYWmO0Yy
   GRk6quPeNboRJgbNMe5b7ScAW7UmTqYzvU3qkbygQWx6tAIAsZxY3/o3j
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="252527535"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="252527535"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 23:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="740472885"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2022 23:18:22 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npl6b-0000Hl-6i;
        Sat, 14 May 2022 06:18:21 +0000
Date:   Sat, 14 May 2022 14:17:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [nsaenz-rpi:ct-work-defer-wip 23/25] alternative.c:undefined
 reference to `context_tracking_set_cpu_work'
Message-ID: <202205141428.JPESIxLb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git ct-work-defer-wip
head:   ed63029652239a6befad96dd473b16332913f889
commit: d79e9aa1c1e3f664fff9d4e83500d7884777cad9 [23/25] context_tracking,x86: Fix text_poke_sync() vs NOHZ_FULL
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220514/202205141428.JPESIxLb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=d79e9aa1c1e3f664fff9d4e83500d7884777cad9
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout d79e9aa1c1e3f664fff9d4e83500d7884777cad9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: enter_from_user_mode+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x1d: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   ld: arch/x86/kernel/alternative.o: in function `do_sync_core_cond':
>> alternative.c:(.text+0x68e): undefined reference to `context_tracking_set_cpu_work'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
