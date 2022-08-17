Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34B6597201
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiHQOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHQOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:54:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D59C2D7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660748065; x=1692284065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dCdRxStUGXbBF+GDc+W4MlpHKu7RQjLpl0vntiPXJ4A=;
  b=QQDOxHwhpoNY1/oN/KH8m6CkH18fGb777CHESuFwLMtsUOQzTrkN+poF
   AdQp7g3eJHFaMLG54Oq2burrjaZqQWKX7rr8QdmlchleqiYuu47YBkjDp
   6x0KRPpklCbs+3xjtuF5gwuzPraAypxZYegzImraC9rYbPrIm2wC4CzZ9
   uQD7LYuJVkNI7Zhk3clqg4iZQnItJ8/P0i9zGUFdScj7OjSPGrKMUk8+0
   zyhdT1P+muOAnNvIxsyBxrfagsFiuy04sU0pwPIyMauB2AOoTUTnRkzpj
   YEBegbTffLkEqzF6vqDLsYUWF/h5RjbtgzaNJo324aGGXb3jfHupfVZR4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="272902504"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="272902504"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 07:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="558147809"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2022 07:54:22 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOKR4-00012R-0k;
        Wed, 17 Aug 2022 14:54:22 +0000
Date:   Wed, 17 Aug 2022 22:54:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 296/308] vmlinux.o: warning:
 objtool: np_seamldr_launch+0x129: missing int3 after ret
Message-ID: <202208172207.tuDYr0QR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   85c097fdd1667a842a9e75d8f658fc16bd72981a
commit: 162e15f7453b287f01a32a7fe68de3cb416ffd81 [296/308] [REVERTME] x86/virt/tdx: Boot-time tdx module loading
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220817/202208172207.tuDYr0QR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/162e15f7453b287f01a32a7fe68de3cb416ffd81
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 162e15f7453b287f01a32a7fe68de3cb416ffd81
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: do_machine_check+0xb9: call to ex_get_fixup_type() leaves .noinstr.text section
   vmlinux.o: warning: objtool: check_stackleak_irqoff+0x309: call to _printk() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: np_seamldr_launch+0x129: missing int3 after ret


objdump-func vmlinux.o np_seamldr_launch:
0000 000000000009a4d0 <np_seamldr_launch>:
0000    9a4d0:	f3 0f 1e fa          	endbr64
0004    9a4d4:	55                   	push   %rbp
0005    9a4d5:	48 89 e5             	mov    %rsp,%rbp
0008    9a4d8:	41 57                	push   %r15
000a    9a4da:	41 56                	push   %r14
000c    9a4dc:	41 55                	push   %r13
000e    9a4de:	41 54                	push   %r12
0010    9a4e0:	53                   	push   %rbx
0011    9a4e1:	9c                   	pushf
0012    9a4e2:	f3 48 0f ae c8       	rdgsbase %rax
0017    9a4e7:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 9a4ee <np_seamldr_launch+0x1e>	9a4ea: R_X86_64_PC32	np_seamldr_saved_gs_base-0x4
001e    9a4ee:	41 0f 20 db          	mov    %cr3,%r11
0022    9a4f2:	41 53                	push   %r11
0024    9a4f4:	49 81 e3 00 f0 ff ff 	and    $0xfffffffffffff000,%r11
002b    9a4fb:	0f 20 e0             	mov    %cr4,%rax
002e    9a4fe:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 9a505 <np_seamldr_launch+0x35>	9a501: R_X86_64_PC32	np_seamldr_saved_cr4-0x4
0035    9a505:	0f 20 c0             	mov    %cr0,%rax
0038    9a508:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 9a50f <np_seamldr_launch+0x3f>	9a50b: R_X86_64_PC32	np_seamldr_saved_cr0-0x4
003f    9a50f:	0f 20 e0             	mov    %cr4,%rax
0042    9a512:	48 0d 00 40 00 00    	or     $0x4000,%rax
0048    9a518:	0f 22 e0             	mov    %rax,%cr4
004b    9a51b:	0f 01 05 00 00 00 00 	sgdt   0x0(%rip)        # 9a522 <np_seamldr_launch+0x52>	9a51e: R_X86_64_PC32	.init.data+0x1090dc
0052    9a522:	4c 8b 0d 00 00 00 00 	mov    0x0(%rip),%r9        # 9a529 <np_seamldr_launch+0x59>	9a525: R_X86_64_PC32	.init.data+0x1090de
0059    9a529:	4c 8d 15 27 00 00 00 	lea    0x27(%rip),%r10        # 9a557 <np_seamldr_launch+0x87>
0060    9a530:	0f 01 0d 00 00 00 00 	sidt   0x0(%rip)        # 9a537 <np_seamldr_launch+0x67>	9a533: R_X86_64_PC32	.init.data+0x1090ec
0067    9a537:	4c 8b 25 00 00 00 00 	mov    0x0(%rip),%r12        # 9a53e <np_seamldr_launch+0x6e>	9a53a: R_X86_64_PC32	.init.data+0x1090ee
006e    9a53e:	48 89 25 00 00 00 00 	mov    %rsp,0x0(%rip)        # 9a545 <np_seamldr_launch+0x75>	9a541: R_X86_64_PC32	.init.data+0x1090fc
0075    9a545:	48 89 2d 00 00 00 00 	mov    %rbp,0x0(%rip)        # 9a54c <np_seamldr_launch+0x7c>	9a548: R_X86_64_PC32	.init.data+0x109104
007c    9a54c:	89 fb                	mov    %edi,%ebx
007e    9a54e:	89 f1                	mov    %esi,%ecx
0080    9a550:	b8 02 00 00 00       	mov    $0x2,%eax
0085    9a555:	0f 37                	getsec
0087    9a557:	48 c7 c0 00 04 00 00 	mov    $0x400,%rax
008e    9a55e:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
0095    9a565:	b9 30 08 00 00       	mov    $0x830,%ecx
009a    9a56a:	0f 30                	wrmsr
009c    9a56c:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
00a3    9a573:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
00aa    9a57a:	b9 3f 08 00 00       	mov    $0x83f,%ecx
00af    9a57f:	0f 30                	wrmsr
00b1    9a581:	b8 18 00 00 00       	mov    $0x18,%eax
00b6    9a586:	8e d8                	mov    %eax,%ds
00b8    9a588:	8e c0                	mov    %eax,%es
00ba    9a58a:	8e d0                	mov    %eax,%ss
00bc    9a58c:	48 8b 2d 00 00 00 00 	mov    0x0(%rip),%rbp        # 9a593 <np_seamldr_launch+0xc3>	9a58f: R_X86_64_PC32	.init.data+0x109104
00c3    9a593:	48 8b 25 00 00 00 00 	mov    0x0(%rip),%rsp        # 9a59a <np_seamldr_launch+0xca>	9a596: R_X86_64_PC32	.init.data+0x1090fc
00ca    9a59a:	6a 10                	push   $0x10
00cc    9a59c:	48 8d 05 03 00 00 00 	lea    0x3(%rip),%rax        # 9a5a6 <np_seamldr_launch+0xd6>
00d3    9a5a3:	50                   	push   %rax
00d4    9a5a4:	48 cb                	lretq
00d6    9a5a6:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 9a5ad <np_seamldr_launch+0xdd>	9a5a9: R_X86_64_PC32	np_seamldr_saved_cr0-0x4
00dd    9a5ad:	0f 22 c0             	mov    %rax,%cr0
00e0    9a5b0:	48 c7 05 00 00 00 00 00 00 00 00 	movq   $0x0,0x0(%rip)        # 9a5bb <np_seamldr_launch+0xeb>	9a5b3: R_X86_64_PC32	np_seamldr_saved_cr0-0x8
00eb    9a5bb:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 9a5c2 <np_seamldr_launch+0xf2>	9a5be: R_X86_64_PC32	np_seamldr_saved_cr4-0x4
00f2    9a5c2:	0f 22 e0             	mov    %rax,%cr4
00f5    9a5c5:	48 c7 05 00 00 00 00 00 00 00 00 	movq   $0x0,0x0(%rip)        # 9a5d0 <np_seamldr_launch+0x100>	9a5c8: R_X86_64_PC32	np_seamldr_saved_cr4-0x8
0100    9a5d0:	58                   	pop    %rax
0101    9a5d1:	0f 22 d8             	mov    %rax,%cr3
0104    9a5d4:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 9a5db <np_seamldr_launch+0x10b>	9a5d7: R_X86_64_PC32	np_seamldr_saved_gs_base-0x4
010b    9a5db:	f3 48 0f ae d8       	wrgsbase %rax
0110    9a5e0:	48 c7 05 00 00 00 00 00 00 00 00 	movq   $0x0,0x0(%rip)        # 9a5eb <np_seamldr_launch+0x11b>	9a5e3: R_X86_64_PC32	np_seamldr_saved_gs_base-0x8
011b    9a5eb:	9d                   	popf
011c    9a5ec:	4c 89 c8             	mov    %r9,%rax
011f    9a5ef:	5b                   	pop    %rbx
0120    9a5f0:	41 5c                	pop    %r12
0122    9a5f2:	41 5d                	pop    %r13
0124    9a5f4:	41 5e                	pop    %r14
0126    9a5f6:	41 5f                	pop    %r15
0128    9a5f8:	5d                   	pop    %rbp
0129    9a5f9:	c3                   	ret
012a    9a5fa:	49 c7 c1 f2 ff ff ff 	mov    $0xfffffffffffffff2,%r9
0131    9a601:	e9 7b ff ff ff       	jmp    9a581 <np_seamldr_launch+0xb1>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
