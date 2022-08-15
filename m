Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E155928E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiHOE7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiHOE7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:59:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69413F07
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660539570; x=1692075570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/JwBGS9PqkfTwus26GEuq8ZmXRa/b3BVmsGKpEpeFBM=;
  b=KFfhbmHWBjG7wrVn72HDICPRPhvMOeg+3UVjCFjgogF+kmPZxgkX9DIc
   H6dzns7/T5BT/1/n58EKNMWtRM7I/TQSKgP5uHJdzyYC1D/uTyQSD8phL
   UpmwUZofT9VNSTFG5JUjIT477fXi/1jZNXYHOS1reKZ5/VV2HXi5sqbIz
   +XWr6li16+U8Q1B9CNV1FDrtiQUqFimKcgkTiaAxQh0mFDSPGiZOC514S
   48Wj9EZyVBlNslGCCH4gsfsethrTCMBCUDNoYFM1RWjqhLlkhRA23s4FO
   FGe2550z011wB0f4Csg80KG0Tv/rlvmgZuTg+KF8CFx35reIfoTXZIC89
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="355895885"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="355895885"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="748813216"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2022 21:59:28 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNSCF-0000nN-1n;
        Mon, 15 Aug 2022 04:59:27 +0000
Date:   Mon, 15 Aug 2022 12:58:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: vmlinux.o: warning: objtool: nmi_panic+0x30: unreachable instruction
Message-ID: <202208151234.YgufKC9A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: 2028a255f4df3af9e759f01f958d3237f825f256 x86/extable: Annotate ex_handler_msr_mce() as a dead end
date:   3 months ago
config: x86_64-randconfig-a006-20220815 (https://download.01.org/0day-ci/archive/20220815/202208151234.YgufKC9A-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2028a255f4df3af9e759f01f958d3237f825f256
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2028a255f4df3af9e759f01f958d3237f825f256
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: nmi_panic+0x30: unreachable instruction


objdump-func vmlinux.o nmi_panic:
0000 00000000000aeb50 <nmi_panic>:
0000    aeb50:	f3 0f 1e fa          	endbr64 
0004    aeb54:	55                   	push   %rbp
0005    aeb55:	48 89 e5             	mov    %rsp,%rbp
0008    aeb58:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx        # aeb5f <nmi_panic+0xf>	aeb5b: R_X86_64_PC32	cpu_number-0x4
000f    aeb5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
0014    aeb64:	f0 0f b1 15 00 00 00 00 	lock cmpxchg %edx,0x0(%rip)        # aeb6c <nmi_panic+0x1c>	aeb68: R_X86_64_PC32	panic_cpu-0x4
001c    aeb6c:	83 f8 ff             	cmp    $0xffffffff,%eax
001f    aeb6f:	0f 84 00 00 00 00    	je     aeb75 <nmi_panic+0x25>	aeb71: R_X86_64_PC32	.text.unlikely+0x886a
0025    aeb75:	39 c2                	cmp    %eax,%edx
0027    aeb77:	75 02                	jne    aeb7b <nmi_panic+0x2b>
0029    aeb79:	5d                   	pop    %rbp
002a    aeb7a:	c3                   	ret    
002b    aeb7b:	e8 00 00 00 00       	call   aeb80 <nmi_panic+0x30>	aeb7c: R_X86_64_PLT32	nmi_panic_self_stop-0x4
0030    aeb80:	5d                   	pop    %rbp
0031    aeb81:	c3                   	ret    
0032    aeb82:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
003d    aeb8d:	0f 1f 00             	nopl   (%rax)
0000 000000000000886e <nmi_panic.cold>:
0000     886e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	8871: R_X86_64_32S	.rodata.str1.1+0x8244
0007     8875:	e8 00 00 00 00       	call   887a <add_taint.cold>	8876: R_X86_64_PLT32	panic-0x4

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
