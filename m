Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23458D06C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiHHXRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHHXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:17:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC05DECD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660000657; x=1691536657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q0KIsSXu22CDpJk2mO5GSRQbvfbA8Rrz5WGUhDSP3Sk=;
  b=E8zV6wo6aV4kzRRO8a8FoU3VvFPMYUbxJzroFQdj/q/lralmBb53ZE5L
   jrPSPJ8hqkI6K7YdiF2h2kCqsr8dBTE5tLnqSLBpb9z+6mhheZCR1+CKX
   TwGAqD8ZWCO+CIK73EpbSM7ke+HMZeyzOSysMIeq+3rRpHtjqA5UK3YqL
   b6rYexKwRmPmuPYzLmnV3J/zCXF3WdQ2N2gfGF0gHOilafmLIs1NanO42
   i1b8NcTakjmrLM1pYN1b4jOGDz+Mj/FK1W/Ik31r5EXcInTcTm1/Lm4Mq
   MhT4xWCZPdPtn3bbYlAFA4PhdN9HqHxrJsOBK0ldOWCzcy8m9BFzjLRL5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352441218"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="352441218"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 16:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="746827163"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2022 16:17:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLC06-000MaP-2Y;
        Mon, 08 Aug 2022 23:17:34 +0000
Date:   Tue, 9 Aug 2022 07:16:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.4.y 2112/4782]
 arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_timed_out()+0x67:
 unreachable instruction
Message-ID: <202208090707.H0QqGpZ3-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   8d8935e76f6f419ef2f7617de252f258b6a597d3
commit: bca5aa920274a1609c46a386d743c9d9bf214dcb [2112/4782] x86/mce: Mark mce_panic() noinstr
config: x86_64-randconfig-c022-20220808 (https://download.01.org/0day-ci/archive/20220809/202208090707.H0QqGpZ3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=bca5aa920274a1609c46a386d743c9d9bf214dcb
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout bca5aa920274a1609c46a386d743c9d9bf214dcb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_timed_out()+0x67: unreachable instruction


objdump-func vmlinux.o mce_timed_out:
0000 0000000000058d40 <mce_timed_out>:
0000    58d40:	e8 00 00 00 00       	call   58d45 <mce_timed_out+0x5>	58d41: R_X86_64_PLT32	__fentry__-0x4
0005    58d45:	55                   	push   %rbp
0006    58d46:	48 89 e5             	mov    %rsp,%rbp
0009    58d49:	41 54                	push   %r12
000b    58d4b:	49 89 f4             	mov    %rsi,%r12
000e    58d4e:	53                   	push   %rbx
000f    58d4f:	48 89 fb             	mov    %rdi,%rbx
0012    58d52:	0f ae e8             	lfence 
0015    58d55:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 58d5b <mce_timed_out+0x1b>	58d57: R_X86_64_PC32	.bss+0x7b38
001b    58d5b:	85 c0                	test   %eax,%eax
001d    58d5d:	75 43                	jne    58da2 <mce_timed_out+0x62>
001f    58d5f:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 58d65 <mce_timed_out+0x25>	58d61: R_X86_64_PC32	mca_cfg+0x14
0025    58d65:	85 c0                	test   %eax,%eax
0027    58d67:	74 10                	je     58d79 <mce_timed_out+0x39>
0029    58d69:	48 8b 03             	mov    (%rbx),%rax
002c    58d6c:	48 83 f8 63          	cmp    $0x63,%rax
0030    58d70:	7e 13                	jle    58d85 <mce_timed_out+0x45>
0032    58d72:	48 83 e8 64          	sub    $0x64,%rax
0036    58d76:	48 89 03             	mov    %rax,(%rbx)
0039    58d79:	e8 00 00 00 00       	call   58d7e <mce_timed_out+0x3e>	58d7a: R_X86_64_PLT32	touch_softlockup_watchdog-0x4
003e    58d7e:	31 c0                	xor    %eax,%eax
0040    58d80:	5b                   	pop    %rbx
0041    58d81:	41 5c                	pop    %r12
0043    58d83:	5d                   	pop    %rbp
0044    58d84:	c3                   	ret    
0045    58d85:	83 3d 00 00 00 00 01 	cmpl   $0x1,0x0(%rip)        # 58d8c <mce_timed_out+0x4c>	58d87: R_X86_64_PC32	mca_cfg+0xf
004c    58d8c:	7e 1b                	jle    58da9 <mce_timed_out+0x69>
004e    58d8e:	c7 05 00 00 00 00 01 00 00 00 	movl   $0x1,0x0(%rip)        # 58d98 <mce_timed_out+0x58>	58d90: R_X86_64_PC32	.bss+0x7bc8
0058    58d98:	5b                   	pop    %rbx
0059    58d99:	b8 01 00 00 00       	mov    $0x1,%eax
005e    58d9e:	41 5c                	pop    %r12
0060    58da0:	5d                   	pop    %rbp
0061    58da1:	c3                   	ret    
0062    58da2:	e8 79 fb ff ff       	call   58920 <wait_for_panic>
0067    58da7:	eb b6                	jmp    58d5f <mce_timed_out+0x1f>
0069    58da9:	31 d2                	xor    %edx,%edx
006b    58dab:	31 f6                	xor    %esi,%esi
006d    58dad:	4c 89 e7             	mov    %r12,%rdi
0070    58db0:	e8 00 00 00 00       	call   58db5 <mce_timed_out+0x75>	58db1: R_X86_64_PC32	.noinstr.text-0x4
0075    58db5:	eb d7                	jmp    58d8e <mce_timed_out+0x4e>
0077    58db7:	66 0f 1f 84 00 00 00 00 00 	nopw   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
