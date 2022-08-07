Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746C458B8DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 03:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiHGBHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 21:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiHGBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 21:07:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6F4BC3E
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659834437; x=1691370437;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rv0qmgQmMmeXHa+oUCfglKP45toA2WSo5gSDNs3RUrY=;
  b=kG8iZ0bpuYzIyK93Y5jlj//zxkD8qMrHLiu+mNNkQ+Z9AeCUpA52tXU1
   MvdkOPcsYiWzLg30yVW/02OyO/QLOtGDSRZDi1eS7eXghy7S4aE6O2Rgo
   CPT+cW5xURcylz1lwKoCRPiYZBbGo+udNnDJlOOZkIb2s8Op2IV0kyTJz
   DRyiP0+fDuV9T70WKHng+b6gNDs94PSA6W7EFiRTCxXflk7AQE0HUQlaz
   fyyPqCHaom4Ilhpe+8rRHpUK1Q/UelUByjo4TxbQA0lA1ks1gpfDr9LAT
   CcDTytrse6dMckh7exgf1msq040D403Pevx4mGLVAYQbgW5/yHRIZW29J
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="316302182"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="316302182"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 18:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="632438337"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2022 18:07:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKUl8-000KpN-2W;
        Sun, 07 Aug 2022 01:07:14 +0000
Date:   Sun, 7 Aug 2022 09:06:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 32/59] vmlinux.o:
 warning: objtool: ftrace_replace_code.cold+0x0: unreachable instruction
Message-ID: <202208070926.VGxv4GTD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   b518e558c49324fa002255761d2a7324ba31f7b5
commit: 1da8c357194195fff4d08bf92d75c50ea495c726 [32/59] objtool: Allow STT_NOTYPE -> STT_FUNC+0 tail-calls
config: x86_64-randconfig-a011-20220801 (https://download.01.org/0day-ci/archive/20220807/202208070926.VGxv4GTD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/1da8c357194195fff4d08bf92d75c50ea495c726
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 1da8c357194195fff4d08bf92d75c50ea495c726
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: ftrace_replace_code.cold+0x0: unreachable instruction


objdump-func vmlinux.o ftrace_replace_code.cold:
0000 0000000000012fdd <ftrace_replace_code.cold>:
0000    12fdd:	5b                   	pop    %rbx
0001    12fde:	48 89 ee             	mov    %rbp,%rsi
0004    12fe1:	89 c7                	mov    %eax,%edi
0006    12fe3:	5d                   	pop    %rbp
0007    12fe4:	41 5c                	pop    %r12
0009    12fe6:	41 5d                	pop    %r13
000b    12fe8:	41 5e                	pop    %r14
000d    12fea:	e9 9d fd ff ff       	jmp    12d8c <ftrace_bug>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
