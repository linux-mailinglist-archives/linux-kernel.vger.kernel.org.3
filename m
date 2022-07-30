Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E65858AA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 06:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiG3E4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 00:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiG3E4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:56:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92FFF8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659157002; x=1690693002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P6KBY4wzHtS5cguP0VtgofUqSqnLHzOfpKg1q+S+lkM=;
  b=PgSZ0E89BLM/3R0RfKZHBuNPUclXzb0lXnw/pSh3OUofupC3ZMhlcsx2
   dsCsSJrQBBbyBQvwjHKCF9YXk5CDBQKjpUUvgmLaLLgn+mfeLHDgr/yQv
   fxt/pIhzCA/b7fFYCsbFstU3m+gaVQqGQ/W1vp9q+rqx3owwozYkIRMOL
   Bb3IgKd79G8gPpYYX2Se+GkEhhzlfbR4/lxvdjpeoJ2Equy6h6RxmkXv4
   SA7mTYt0AQGOEAFId2rOnxnL4OxskobD+n7XFRbonC+Y9gx/uws2LCVe8
   fxWJI3ge/BkM3J1sIcD251Wewp5eJ3t7d1hy55fDyr0G1nRrXpRSEfcLf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286447113"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="286447113"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 21:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="551953889"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jul 2022 21:56:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHeWk-000CPr-33;
        Sat, 30 Jul 2022 04:56:38 +0000
Date:   Sat, 30 Jul 2022 12:55:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 46/57] vmlinux.o:
 warning: objtool: .altinstr_replacement+0x1f: unsupported relocation in
 alternatives section
Message-ID: <202207301224.Htkh9hA4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   f6f6bdabacc1d7c5fc82f3e0b1c1f80185332dc4
commit: cc14dbacc67e5d8950faeee1de861ce97e06a2a1 [46/57] x86/retbleed: Add SKL return thunk
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220730/202207301224.Htkh9hA4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/cc14dbacc67e5d8950faeee1de861ce97e06a2a1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout cc14dbacc67e5d8950faeee1de861ce97e06a2a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: .altinstr_replacement+0x1f: unsupported relocation in alternatives section


objdump-func vmlinux.o .altinstr_replacement:
0000 0000000000000000 <.altinstr_replacement>:
0000    0:	e8 00 00 00 00       	call   5 <.altinstr_replacement+0x5>	1: R_X86_64_PLT32	clear_page_rep-0x4
0005    5:	e8 00 00 00 00       	call   a <.altinstr_replacement+0xa>	6: R_X86_64_PLT32	clear_page_erms-0x4
000a    a:	e8 00 00 00 00       	call   f <.altinstr_replacement+0xf>	b: R_X86_64_PLT32	zen_untrain_ret-0x4
000f    f:	e8 00 00 00 00       	call   14 <.altinstr_replacement+0x14>	10: R_X86_64_PLT32	entry_ibpb-0x4
0014   14:	48 c7 c0 80 00 00 00 	mov    $0x80,%rax
001b   1b:	48 c1 e0 38          	shl    $0x38,%rax
001f   1f:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	23: R_X86_64_32S	pcpu_hot+0x10
0027   27:	e9 00 00 00 00       	jmp    2c <.altinstr_replacement+0x2c>	28: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
002c   2c:	48 c1 3c 25 00 00 00 00 05 	sarq   $0x5,0x0	30: R_X86_64_32S	pcpu_hot+0x10
0035   35:	e8 00 00 00 00       	call   3a <.altinstr_replacement+0x3a>	36: R_X86_64_PLT32	__x86_indirect_thunk_rbx-0x4
003a   3a:	0f ae e8             	lfence 
003d   3d:	ff d3                	call   *%rbx
003f   3f:	e8 00 00 00 00       	call   44 <.altinstr_replacement+0x44>	40: R_X86_64_PLT32	zen_untrain_ret-0x4
0044   44:	e8 00 00 00 00       	call   49 <.altinstr_replacement+0x49>	45: R_X86_64_PLT32	entry_ibpb-0x4
0049   49:	48 c7 c0 fc 00 00 00 	mov    $0xfc,%rax
0050   50:	48 c1 e0 38          	shl    $0x38,%rax
0054   54:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	58: R_X86_64_32S	pcpu_hot+0x10
005c   5c:	0f 01 ca             	clac   
005f   5f:	e8 00 00 00 00       	call   64 <.altinstr_replacement+0x64>	60: R_X86_64_PLT32	xen_error_entry-0x4
0064   64:	0f 01 ca             	clac   
0067   67:	e8 00 00 00 00       	call   6c <.altinstr_replacement+0x6c>	68: R_X86_64_PLT32	xen_error_entry-0x4
006c   6c:	0f 01 ca             	clac   
006f   6f:	e8 00 00 00 00       	call   74 <.altinstr_replacement+0x74>	70: R_X86_64_PLT32	xen_error_entry-0x4
0074   74:	0f 01 ca             	clac   
0077   77:	e8 00 00 00 00       	call   7c <.altinstr_replacement+0x7c>	78: R_X86_64_PLT32	xen_error_entry-0x4
007c   7c:	0f 01 ca             	clac   
007f   7f:	e8 00 00 00 00       	call   84 <.altinstr_replacement+0x84>	80: R_X86_64_PLT32	xen_error_entry-0x4
0084   84:	0f 01 ca             	clac   
0087   87:	e8 00 00 00 00       	call   8c <.altinstr_replacement+0x8c>	88: R_X86_64_PLT32	xen_error_entry-0x4
008c   8c:	0f 01 ca             	clac   
008f   8f:	e8 00 00 00 00       	call   94 <.altinstr_replacement+0x94>	90: R_X86_64_PLT32	xen_error_entry-0x4
0094   94:	0f 01 ca             	clac   
0097   97:	e8 00 00 00 00       	call   9c <.altinstr_replacement+0x9c>	98: R_X86_64_PLT32	xen_error_entry-0x4
009c   9c:	0f 01 ca             	clac   
009f   9f:	e8 00 00 00 00       	call   a4 <.altinstr_replacement+0xa4>	a0: R_X86_64_PLT32	xen_error_entry-0x4
00a4   a4:	0f 01 ca             	clac   
00a7   a7:	e8 00 00 00 00       	call   ac <.altinstr_replacement+0xac>	a8: R_X86_64_PLT32	xen_error_entry-0x4
00ac   ac:	0f 01 ca             	clac   
00af   af:	e8 00 00 00 00       	call   b4 <.altinstr_replacement+0xb4>	b0: R_X86_64_PLT32	xen_error_entry-0x4
00b4   b4:	0f 01 ca             	clac   
00b7   b7:	e8 00 00 00 00       	call   bc <.altinstr_replacement+0xbc>	b8: R_X86_64_PLT32	xen_error_entry-0x4
00bc   bc:	0f 01 ca             	clac   
00bf   bf:	e8 00 00 00 00       	call   c4 <.altinstr_replacement+0xc4>	c0: R_X86_64_PLT32	xen_error_entry-0x4
00c4   c4:	0f 01 ca             	clac   
00c7   c7:	e8 00 00 00 00       	call   cc <.altinstr_replacement+0xcc>	c8: R_X86_64_PLT32	xen_error_entry-0x4
00cc   cc:	0f 01 ca             	clac   
00cf   cf:	e8 00 00 00 00       	call   d4 <.altinstr_replacement+0xd4>	d0: R_X86_64_PLT32	xen_error_entry-0x4
00d4   d4:	0f 01 ca             	clac   
00d7   d7:	e8 00 00 00 00       	call   dc <.altinstr_replacement+0xdc>	d8: R_X86_64_PLT32	xen_error_entry-0x4
00dc   dc:	0f 01 ca             	clac   
00df   df:	e8 00 00 00 00       	call   e4 <.altinstr_replacement+0xe4>	e0: R_X86_64_PLT32	xen_error_entry-0x4
00e4   e4:	0f 01 ca             	clac   
00e7   e7:	0f 01 ca             	clac   
00ea   ea:	e8 00 00 00 00       	call   ef <.altinstr_replacement+0xef>	eb: R_X86_64_PLT32	xen_error_entry-0x4
00ef   ef:	0f 01 ca             	clac   
00f2   f2:	e8 00 00 00 00       	call   f7 <.altinstr_replacement+0xf7>	f3: R_X86_64_PLT32	xen_error_entry-0x4
00f7   f7:	0f 01 ca             	clac   
00fa   fa:	e8 00 00 00 00       	call   ff <.altinstr_replacement+0xff>	fb: R_X86_64_PLT32	xen_error_entry-0x4
00ff   ff:	0f 01 ca             	clac   
0102  102:	e8 00 00 00 00       	call   107 <.altinstr_replacement+0x107>	103: R_X86_64_PLT32	xen_error_entry-0x4
0107  107:	0f 01 ca             	clac   
010a  10a:	e8 00 00 00 00       	call   10f <.altinstr_replacement+0x10f>	10b: R_X86_64_PLT32	xen_error_entry-0x4
010f  10f:	0f 01 ca             	clac   
0112  112:	e8 00 00 00 00       	call   117 <.altinstr_replacement+0x117>	113: R_X86_64_PLT32	xen_error_entry-0x4
0117  117:	0f 01 ca             	clac   
011a  11a:	e8 00 00 00 00       	call   11f <.altinstr_replacement+0x11f>	11b: R_X86_64_PLT32	xen_error_entry-0x4
011f  11f:	0f 01 ca             	clac   
0122  122:	e8 00 00 00 00       	call   127 <.altinstr_replacement+0x127>	123: R_X86_64_PLT32	xen_error_entry-0x4
0127  127:	0f 01 ca             	clac   
012a  12a:	e8 00 00 00 00       	call   12f <.altinstr_replacement+0x12f>	12b: R_X86_64_PLT32	xen_error_entry-0x4
012f  12f:	0f 01 ca             	clac   
0132  132:	e8 00 00 00 00       	call   137 <.altinstr_replacement+0x137>	133: R_X86_64_PLT32	xen_error_entry-0x4
0137  137:	0f 01 ca             	clac   
013a  13a:	e8 00 00 00 00       	call   13f <.altinstr_replacement+0x13f>	13b: R_X86_64_PLT32	xen_error_entry-0x4
013f  13f:	0f ae f0             	mfence 
0142  142:	b8 2b 00 00 00       	mov    $0x2b,%eax
0147  147:	8e e8                	mov    %eax,%gs
0149  149:	0f ae e8             	lfence 
014c  14c:	e8 00 00 00 00       	call   151 <.altinstr_replacement+0x151>	14d: R_X86_64_PLT32	zen_untrain_ret-0x4
0151  151:	e8 00 00 00 00       	call   156 <.altinstr_replacement+0x156>	152: R_X86_64_PLT32	entry_ibpb-0x4
0156  156:	48 c7 c0 fc 00 00 00 	mov    $0xfc,%rax
015d  15d:	48 c1 e0 38          	shl    $0x38,%rax
0161  161:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	165: R_X86_64_32S	pcpu_hot+0x10
0169  169:	0f ae e8             	lfence 
016c  16c:	e8 00 00 00 00       	call   171 <.altinstr_replacement+0x171>	16d: R_X86_64_PLT32	zen_untrain_ret-0x4
0171  171:	e8 00 00 00 00       	call   176 <.altinstr_replacement+0x176>	172: R_X86_64_PLT32	entry_ibpb-0x4
0176  176:	48 c7 c0 fc 00 00 00 	mov    $0xfc,%rax
017d  17d:	48 c1 e0 38          	shl    $0x38,%rax
0181  181:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	185: R_X86_64_32S	pcpu_hot+0x10
0189  189:	0f ae e8             	lfence 
018c  18c:	48 c1 3c 25 00 00 00 00 05 	sarq   $0x5,0x0	190: R_X86_64_32S	pcpu_hot+0x10
0195  195:	0f ae e8             	lfence 
0198  198:	e8 00 00 00 00       	call   19d <.altinstr_replacement+0x19d>	199: R_X86_64_PLT32	zen_untrain_ret-0x4
019d  19d:	e8 00 00 00 00       	call   1a2 <.altinstr_replacement+0x1a2>	19e: R_X86_64_PLT32	entry_ibpb-0x4
01a2  1a2:	48 c7 c0 fc 00 00 00 	mov    $0xfc,%rax
01a9  1a9:	48 c1 e0 38          	shl    $0x38,%rax
01ad  1ad:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	1b1: R_X86_64_32S	pcpu_hot+0x10
01b5  1b5:	0f 01 ca             	clac   
01b8  1b8:	0f ae e8             	lfence 
01bb  1bb:	e8 00 00 00 00       	call   1c0 <.altinstr_replacement+0x1c0>	1bc: R_X86_64_PLT32	zen_untrain_ret-0x4
01c0  1c0:	e8 00 00 00 00       	call   1c5 <.altinstr_replacement+0x1c5>	1c1: R_X86_64_PLT32	entry_ibpb-0x4
01c5  1c5:	48 c7 c0 80 00 00 00 	mov    $0x80,%rax
01cc  1cc:	48 c1 e0 38          	shl    $0x38,%rax
01d0  1d0:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	1d4: R_X86_64_32S	pcpu_hot+0x10
01d8  1d8:	e8 00 00 00 00       	call   1dd <.altinstr_replacement+0x1dd>	1d9: R_X86_64_PLT32	zen_untrain_ret-0x4
01dd  1dd:	e8 00 00 00 00       	call   1e2 <.altinstr_replacement+0x1e2>	1de: R_X86_64_PLT32	entry_ibpb-0x4
01e2  1e2:	48 c7 c0 80 00 00 00 	mov    $0x80,%rax
01e9  1e9:	48 c1 e0 38          	shl    $0x38,%rax
01ed  1ed:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	1f1: R_X86_64_32S	pcpu_hot+0x10
01f5  1f5:	e9 00 00 00 00       	jmp    1fa <.altinstr_replacement+0x1fa>	1f6: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
01fa  1fa:	e8 00 00 00 00       	call   1ff <.altinstr_replacement+0x1ff>	1fb: R_X86_64_PLT32	zen_untrain_ret-0x4
01ff  1ff:	e8 00 00 00 00       	call   204 <.altinstr_replacement+0x204>	200: R_X86_64_PLT32	entry_ibpb-0x4
0204  204:	48 c7 c0 80 00 00 00 	mov    $0x80,%rax
020b  20b:	48 c1 e0 38          	shl    $0x38,%rax
020f  20f:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	213: R_X86_64_32S	pcpu_hot+0x10
0217  217:	e9 00 00 00 00       	jmp    21c <.altinstr_replacement+0x21c>	218: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
021c  21c:	0f 01 ca             	clac   
021f  21f:	e9 00 00 00 00       	jmp    224 <.altinstr_replacement+0x224>	220: R_X86_64_PC32	.entry.text+0x13b6
0224  224:	e8 00 00 00 00       	call   229 <.altinstr_replacement+0x229>	225: R_X86_64_PLT32	zen_untrain_ret-0x4
0229  229:	e8 00 00 00 00       	call   22e <.altinstr_replacement+0x22e>	22a: R_X86_64_PLT32	entry_ibpb-0x4
022e  22e:	48 c7 c0 80 00 00 00 	mov    $0x80,%rax
0235  235:	48 c1 e0 38          	shl    $0x38,%rax
0239  239:	48 89 04 25 00 00 00 00 	mov    %rax,0x0	23d: R_X86_64_32S	pcpu_hot+0x10
0241  241:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0246  246:	f3 48 0f b8 c7       	popcnt %rdi,%rax
024b  24b:	f3 0f b8 c7          	popcnt %edi,%eax
024f  24f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0254  254:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0259  259:	0f ae e8             	lfence 
025c  25c:	0f 31                	rdtsc  
025e  25e:	0f 01 f9             	rdtscp 
0261  261:	0f ae e8             	lfence 
0264  264:	0f 31                	rdtsc  
0266  266:	0f 01 f9             	rdtscp 
0269  269:	0f ae e8             	lfence 
026c  26c:	0f 31                	rdtsc  
026e  26e:	0f 01 f9             	rdtscp 
0271  271:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0276  276:	f3 48 0f b8 c7       	popcnt %rdi,%rax
027b  27b:	e9 00 00 00 00       	jmp    280 <.altinstr_replacement+0x280>	27c: R_X86_64_PC32	.init.text+0x78cf
0280  280:	e9 00 00 00 00       	jmp    285 <.altinstr_replacement+0x285>	281: R_X86_64_PC32	.text+0x1f6a0
0285  285:	e9 00 00 00 00       	jmp    28a <.altinstr_replacement+0x28a>	286: R_X86_64_PC32	.text+0x1f6ae
028a  28a:	e9 00 00 00 00       	jmp    28f <.altinstr_replacement+0x28f>	28b: R_X86_64_PC32	.text+0x1f6e0
028f  28f:	e9 00 00 00 00       	jmp    294 <.altinstr_replacement+0x294>	290: R_X86_64_PC32	.text+0x1f6eb
0294  294:	e9 00 00 00 00       	jmp    299 <.altinstr_replacement+0x299>	295: R_X86_64_PC32	.text+0x2008e
0299  299:	e9 00 00 00 00       	jmp    29e <.altinstr_replacement+0x29e>	29a: R_X86_64_PC32	.text+0x208d7
029e  29e:	e9 00 00 00 00       	jmp    2a3 <.altinstr_replacement+0x2a3>	29f: R_X86_64_PC32	.text+0x21026
02a3  2a3:	e9 00 00 00 00       	jmp    2a8 <.altinstr_replacement+0x2a8>	2a4: R_X86_64_PC32	.text+0x2100d
02a8  2a8:	e9 00 00 00 00       	jmp    2ad <.altinstr_replacement+0x2ad>	2a9: R_X86_64_PC32	.text+0x210a1
02ad  2ad:	e9 00 00 00 00       	jmp    2b2 <.altinstr_replacement+0x2b2>	2ae: R_X86_64_PC32	.text+0x21002
02b2  2b2:	e9 00 00 00 00       	jmp    2b7 <.altinstr_replacement+0x2b7>	2b3: R_X86_64_PC32	.text+0x213db
02b7  2b7:	e9 00 00 00 00       	jmp    2bc <.altinstr_replacement+0x2bc>	2b8: R_X86_64_PC32	.text+0x214f9
02bc  2bc:	e9 00 00 00 00       	jmp    2c1 <.altinstr_replacement+0x2c1>	2bd: R_X86_64_PC32	.text+0x21507
02c1  2c1:	e9 00 00 00 00       	jmp    2c6 <.altinstr_replacement+0x2c6>	2c2: R_X86_64_PC32	.text+0x21527
02c6  2c6:	e9 00 00 00 00       	jmp    2cb <.altinstr_replacement+0x2cb>	2c7: R_X86_64_PC32	.text+0x215aa
02cb  2cb:	e9 00 00 00 00       	jmp    2d0 <.altinstr_replacement+0x2d0>	2cc: R_X86_64_PC32	.text+0x215b5
02d0  2d0:	e9 00 00 00 00       	jmp    2d5 <.altinstr_replacement+0x2d5>	2d1: R_X86_64_PC32	.text+0x21527
02d5  2d5:	e9 00 00 00 00       	jmp    2da <.altinstr_replacement+0x2da>	2d6: R_X86_64_PC32	.text+0x21f05
02da  2da:	e9 00 00 00 00       	jmp    2df <.altinstr_replacement+0x2df>	2db: R_X86_64_PC32	.text+0x21f1b
02df  2df:	e9 00 00 00 00       	jmp    2e4 <.altinstr_replacement+0x2e4>	2e0: R_X86_64_PC32	.text+0x21f26
02e4  2e4:	e9 00 00 00 00       	jmp    2e9 <.altinstr_replacement+0x2e9>	2e5: R_X86_64_PC32	.text+0x21f10
02e9  2e9:	e9 00 00 00 00       	jmp    2ee <.altinstr_replacement+0x2ee>	2ea: R_X86_64_PC32	.text+0x22175
02ee  2ee:	e9 00 00 00 00       	jmp    2f3 <.altinstr_replacement+0x2f3>	2ef: R_X86_64_PC32	.text+0x22222
02f3  2f3:	e9 00 00 00 00       	jmp    2f8 <.altinstr_replacement+0x2f8>	2f4: R_X86_64_PC32	.text+0x22283
02f8  2f8:	e9 00 00 00 00       	jmp    2fd <.altinstr_replacement+0x2fd>	2f9: R_X86_64_PC32	.text+0x22450
02fd  2fd:	e9 00 00 00 00       	jmp    302 <.altinstr_replacement+0x302>	2fe: R_X86_64_PC32	.text+0x22583
0302  302:	e9 00 00 00 00       	jmp    307 <.altinstr_replacement+0x307>	303: R_X86_64_PC32	.text+0x23261
0307  307:	e9 00 00 00 00       	jmp    30c <.altinstr_replacement+0x30c>	308: R_X86_64_PC32	.text+0x23351
030c  30c:	f3 0f b8 c7          	popcnt %edi,%eax
0310  310:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0315  315:	e9 00 00 00 00       	jmp    31a <.altinstr_replacement+0x31a>	316: R_X86_64_PC32	.noinstr.text+0x414
031a  31a:	e9 00 00 00 00       	jmp    31f <.altinstr_replacement+0x31f>	31b: R_X86_64_PC32	.noinstr.text+0x49a
031f  31f:	e9 00 00 00 00       	jmp    324 <.altinstr_replacement+0x324>	320: R_X86_64_PC32	.text+0x3d4f8
0324  324:	e9 00 00 00 00       	jmp    329 <.altinstr_replacement+0x329>	325: R_X86_64_PC32	.text+0x3d72b
0329  329:	e9 00 00 00 00       	jmp    32e <.altinstr_replacement+0x32e>	32a: R_X86_64_PC32	.text+0x3de15
032e  32e:	e9 00 00 00 00       	jmp    333 <.altinstr_replacement+0x333>	32f: R_X86_64_PC32	.text+0x3dd2a
0333  333:	e9 00 00 00 00       	jmp    338 <.altinstr_replacement+0x338>	334: R_X86_64_PC32	.text+0x3dce9
0338  338:	e9 00 00 00 00       	jmp    33d <.altinstr_replacement+0x33d>	339: R_X86_64_PC32	.text+0x3dd1a
033d  33d:	e9 00 00 00 00       	jmp    342 <.altinstr_replacement+0x342>	33e: R_X86_64_PC32	.text+0x3dfa5
0342  342:	e9 00 00 00 00       	jmp    347 <.altinstr_replacement+0x347>	343: R_X86_64_PC32	.text+0x3df79
0347  347:	0f 01 cb             	stac   
034a  34a:	0f ae e8             	lfence 
034d  34d:	0f 01 ca             	clac   
0350  350:	0f 01 ca             	clac   
0353  353:	e9 00 00 00 00       	jmp    358 <.altinstr_replacement+0x358>	354: R_X86_64_PC32	.text+0x3f40b
0358  358:	e9 00 00 00 00       	jmp    35d <.altinstr_replacement+0x35d>	359: R_X86_64_PC32	.noinstr.text+0xc84
035d  35d:	e9 00 00 00 00       	jmp    362 <.altinstr_replacement+0x362>	35e: R_X86_64_PC32	.noinstr.text+0x113f
0362  362:	e9 00 00 00 00       	jmp    367 <.altinstr_replacement+0x367>	363: R_X86_64_PC32	.init.text+0xb1ee
0367  367:	e9 00 00 00 00       	jmp    36c <.altinstr_replacement+0x36c>	368: R_X86_64_PC32	.noinstr.text+0x1dcc
036c  36c:	0f 01 cb             	stac   
036f  36f:	0f ae e8             	lfence 
0372  372:	0f 01 ca             	clac   
0375  375:	0f 01 ca             	clac   
0378  378:	e9 00 00 00 00       	jmp    37d <.altinstr_replacement+0x37d>	379: R_X86_64_PC32	.text+0x4614e
037d  37d:	e9 00 00 00 00       	jmp    382 <.altinstr_replacement+0x382>	37e: R_X86_64_PC32	.text+0x4626a
0382  382:	e9 00 00 00 00       	jmp    387 <.altinstr_replacement+0x387>	383: R_X86_64_PC32	.text+0x4618a
0387  387:	e9 00 00 00 00       	jmp    38c <.altinstr_replacement+0x38c>	388: R_X86_64_PC32	.text+0x46c19
038c  38c:	e9 00 00 00 00       	jmp    391 <.altinstr_replacement+0x391>	38d: R_X86_64_PC32	.text+0x46ce4
0391  391:	e9 00 00 00 00       	jmp    396 <.altinstr_replacement+0x396>	392: R_X86_64_PC32	.text+0x47366
0396  396:	0f ae e8             	lfence 
0399  399:	0f 31                	rdtsc  
039b  39b:	0f 01 f9             	rdtscp 
039e  39e:	e9 00 00 00 00       	jmp    3a3 <.altinstr_replacement+0x3a3>	39f: R_X86_64_PC32	.ref.text+0x4f7
03a3  3a3:	e9 00 00 00 00       	jmp    3a8 <.altinstr_replacement+0x3a8>	3a4: R_X86_64_PC32	.text+0x4ab48
03a8  3a8:	e9 00 00 00 00       	jmp    3ad <.altinstr_replacement+0x3ad>	3a9: R_X86_64_PC32	.text+0x4ab9b
03ad  3ad:	e9 00 00 00 00       	jmp    3b2 <.altinstr_replacement+0x3b2>	3ae: R_X86_64_PC32	.text+0x4abd7
03b2  3b2:	e9 00 00 00 00       	jmp    3b7 <.altinstr_replacement+0x3b7>	3b3: R_X86_64_PC32	.text+0x4ab2f
03b7  3b7:	e9 00 00 00 00       	jmp    3bc <.altinstr_replacement+0x3bc>	3b8: R_X86_64_PC32	.text+0x4adf1
03bc  3bc:	e9 00 00 00 00       	jmp    3c1 <.altinstr_replacement+0x3c1>	3bd: R_X86_64_PC32	.text+0x4aef2
03c1  3c1:	e9 00 00 00 00       	jmp    3c6 <.altinstr_replacement+0x3c6>	3c2: R_X86_64_PC32	.text+0x4af4e
03c6  3c6:	e9 00 00 00 00       	jmp    3cb <.altinstr_replacement+0x3cb>	3c7: R_X86_64_PC32	.text+0x4af47
03cb  3cb:	e9 00 00 00 00       	jmp    3d0 <.altinstr_replacement+0x3d0>	3cc: R_X86_64_PC32	.text+0x4ade2
03d0  3d0:	e9 00 00 00 00       	jmp    3d5 <.altinstr_replacement+0x3d5>	3d1: R_X86_64_PC32	.text+0x4af9a
03d5  3d5:	e9 00 00 00 00       	jmp    3da <.altinstr_replacement+0x3da>	3d6: R_X86_64_PC32	.text+0x4afd2
03da  3da:	e9 00 00 00 00       	jmp    3df <.altinstr_replacement+0x3df>	3db: R_X86_64_PC32	.text+0x4ade2
03df  3df:	48 0f ae 37          	xsaveopt64 (%rdi)
03e3  3e3:	48 0f c7 27          	xsavec64 (%rdi)
03e7  3e7:	48 0f c7 2f          	xsaves64 (%rdi)
03eb  3eb:	e9 00 00 00 00       	jmp    3f0 <.altinstr_replacement+0x3f0>	3ec: R_X86_64_PC32	.text+0x4c025
03f0  3f0:	e9 00 00 00 00       	jmp    3f5 <.altinstr_replacement+0x3f5>	3f1: R_X86_64_PC32	.text+0x4c178
03f5  3f5:	e9 00 00 00 00       	jmp    3fa <.altinstr_replacement+0x3fa>	3f6: R_X86_64_PC32	.text+0x4c1d8
03fa  3fa:	48 0f c7 1f          	xrstors64 (%rdi)
03fe  3fe:	e9 00 00 00 00       	jmp    403 <.altinstr_replacement+0x403>	3ff: R_X86_64_PC32	.text+0x4c739
0403  403:	e9 00 00 00 00       	jmp    408 <.altinstr_replacement+0x408>	404: R_X86_64_PC32	.text+0x4c929
0408  408:	e9 00 00 00 00       	jmp    40d <.altinstr_replacement+0x40d>	409: R_X86_64_PC32	.text+0x4c9ea
040d  40d:	48 0f c7 1f          	xrstors64 (%rdi)
0411  411:	e9 00 00 00 00       	jmp    416 <.altinstr_replacement+0x416>	412: R_X86_64_PC32	.text+0x4d234
0416  416:	48 0f c7 1f          	xrstors64 (%rdi)
041a  41a:	e9 00 00 00 00       	jmp    41f <.altinstr_replacement+0x41f>	41b: R_X86_64_PC32	.text+0x4d418
041f  41f:	e9 00 00 00 00       	jmp    424 <.altinstr_replacement+0x424>	420: R_X86_64_PC32	.text+0x4db04
0424  424:	e9 00 00 00 00       	jmp    429 <.altinstr_replacement+0x429>	425: R_X86_64_PC32	.text+0x4dda4
0429  429:	e8 00 00 00 00       	call   42e <.altinstr_replacement+0x42e>	42a: R_X86_64_PLT32	copy_user_generic_string-0x4
042e  42e:	e8 00 00 00 00       	call   433 <.altinstr_replacement+0x433>	42f: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0433  433:	e9 00 00 00 00       	jmp    438 <.altinstr_replacement+0x438>	434: R_X86_64_PC32	.text+0x4de7f
0438  438:	e9 00 00 00 00       	jmp    43d <.altinstr_replacement+0x43d>	439: R_X86_64_PC32	.text+0x4df7e
043d  43d:	e9 00 00 00 00       	jmp    442 <.altinstr_replacement+0x442>	43e: R_X86_64_PC32	.text+0x4e294
0442  442:	e9 00 00 00 00       	jmp    447 <.altinstr_replacement+0x447>	443: R_X86_64_PC32	.text+0x4e448
0447  447:	e8 00 00 00 00       	call   44c <.altinstr_replacement+0x44c>	448: R_X86_64_PLT32	copy_user_generic_string-0x4
044c  44c:	e8 00 00 00 00       	call   451 <.altinstr_replacement+0x451>	44d: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0451  451:	48 0f ae 37          	xsaveopt64 (%rdi)
0455  455:	48 0f c7 27          	xsavec64 (%rdi)
0459  459:	48 0f c7 2f          	xsaves64 (%rdi)
045d  45d:	e8 00 00 00 00       	call   462 <.altinstr_replacement+0x462>	45e: R_X86_64_PLT32	copy_user_generic_string-0x4
0462  462:	e8 00 00 00 00       	call   467 <.altinstr_replacement+0x467>	463: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0467  467:	e9 00 00 00 00       	jmp    46c <.altinstr_replacement+0x46c>	468: R_X86_64_PC32	.text+0x4e6b8
046c  46c:	e9 00 00 00 00       	jmp    471 <.altinstr_replacement+0x471>	46d: R_X86_64_PC32	.text+0x4e889
0471  471:	0f 01 cb             	stac   
0474  474:	0f 01 ca             	clac   
0477  477:	0f 01 cb             	stac   
047a  47a:	0f 01 ca             	clac   
047d  47d:	48 0f c7 1f          	xrstors64 (%rdi)
0481  481:	0f 01 cb             	stac   
0484  484:	0f 01 ca             	clac   
0487  487:	48 0f c7 1f          	xrstors64 (%rdi)
048b  48b:	e9 00 00 00 00       	jmp    490 <.altinstr_replacement+0x490>	48c: R_X86_64_PC32	.text+0x4ec83
0490  490:	e8 00 00 00 00       	call   495 <.altinstr_replacement+0x495>	491: R_X86_64_PLT32	copy_user_generic_string-0x4
0495  495:	e8 00 00 00 00       	call   49a <.altinstr_replacement+0x49a>	496: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
049a  49a:	e8 00 00 00 00       	call   49f <.altinstr_replacement+0x49f>	49b: R_X86_64_PLT32	copy_user_generic_string-0x4
049f  49f:	e8 00 00 00 00       	call   4a4 <.altinstr_replacement+0x4a4>	4a0: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
04a4  4a4:	e9 00 00 00 00       	jmp    4a9 <.altinstr_replacement+0x4a9>	4a5: R_X86_64_PC32	.text+0x4eef5
04a9  4a9:	e8 00 00 00 00       	call   4ae <.altinstr_replacement+0x4ae>	4aa: R_X86_64_PLT32	copy_user_generic_string-0x4
04ae  4ae:	e8 00 00 00 00       	call   4b3 <.altinstr_replacement+0x4b3>	4af: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
04b3  4b3:	e9 00 00 00 00       	jmp    4b8 <.altinstr_replacement+0x4b8>	4b4: R_X86_64_PC32	.text+0x4ef73
04b8  4b8:	e9 00 00 00 00       	jmp    4bd <.altinstr_replacement+0x4bd>	4b9: R_X86_64_PC32	.text+0x4f098
04bd  4bd:	e9 00 00 00 00       	jmp    4c2 <.altinstr_replacement+0x4c2>	4be: R_X86_64_PC32	.text+0x4f1be
04c2  4c2:	e9 00 00 00 00       	jmp    4c7 <.altinstr_replacement+0x4c7>	4c3: R_X86_64_PC32	.text+0x4f2c3
04c7  4c7:	0f 01 cb             	stac   
04ca  4ca:	0f 01 ca             	clac   
04cd  4cd:	0f 01 cb             	stac   
04d0  4d0:	0f 01 ca             	clac   
04d3  4d3:	e8 00 00 00 00       	call   4d8 <.altinstr_replacement+0x4d8>	4d4: R_X86_64_PLT32	copy_user_generic_string-0x4
04d8  4d8:	e8 00 00 00 00       	call   4dd <.altinstr_replacement+0x4dd>	4d9: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
04dd  4dd:	e9 00 00 00 00       	jmp    4e2 <.altinstr_replacement+0x4e2>	4de: R_X86_64_PC32	.text+0x4f5ef
04e2  4e2:	e9 00 00 00 00       	jmp    4e7 <.altinstr_replacement+0x4e7>	4e3: R_X86_64_PC32	.text+0x4f69d
04e7  4e7:	e9 00 00 00 00       	jmp    4ec <.altinstr_replacement+0x4ec>	4e8: R_X86_64_PC32	.text+0x4f808
04ec  4ec:	e9 00 00 00 00       	jmp    4f1 <.altinstr_replacement+0x4f1>	4ed: R_X86_64_PC32	.init.text+0xf1de
04f1  4f1:	e9 00 00 00 00       	jmp    4f6 <.altinstr_replacement+0x4f6>	4f2: R_X86_64_PC32	.text+0x4f8b4
04f6  4f6:	e9 00 00 00 00       	jmp    4fb <.altinstr_replacement+0x4fb>	4f7: R_X86_64_PC32	.text+0x4f8f2
04fb  4fb:	e9 00 00 00 00       	jmp    500 <.altinstr_replacement+0x500>	4fc: R_X86_64_PC32	.text+0x4fd75
0500  500:	e9 00 00 00 00       	jmp    505 <.altinstr_replacement+0x505>	501: R_X86_64_PC32	.text+0x4ffb3
0505  505:	e9 00 00 00 00       	jmp    50a <.altinstr_replacement+0x50a>	506: R_X86_64_PC32	.text+0x5050f
050a  50a:	e9 00 00 00 00       	jmp    50f <.altinstr_replacement+0x50f>	50b: R_X86_64_PC32	.text+0x506e1
050f  50f:	e9 00 00 00 00       	jmp    514 <.altinstr_replacement+0x514>	510: R_X86_64_PC32	.text+0x50731
0514  514:	e9 00 00 00 00       	jmp    519 <.altinstr_replacement+0x519>	515: R_X86_64_PC32	.text+0x50886
0519  519:	e9 00 00 00 00       	jmp    51e <.altinstr_replacement+0x51e>	51a: R_X86_64_PC32	.text+0x50d43
051e  51e:	e9 00 00 00 00       	jmp    523 <.altinstr_replacement+0x523>	51f: R_X86_64_PC32	.text+0x50d9e
0523  523:	e9 00 00 00 00       	jmp    528 <.altinstr_replacement+0x528>	524: R_X86_64_PC32	.init.text+0xfaa8
0528  528:	e9 00 00 00 00       	jmp    52d <.altinstr_replacement+0x52d>	529: R_X86_64_PC32	.init.text+0xfacc
052d  52d:	e9 00 00 00 00       	jmp    532 <.altinstr_replacement+0x532>	52e: R_X86_64_PC32	.init.text+0xfe2b
0532  532:	e9 00 00 00 00       	jmp    537 <.altinstr_replacement+0x537>	533: R_X86_64_PC32	.init.text+0xfe4c
0537  537:	e9 00 00 00 00       	jmp    53c <.altinstr_replacement+0x53c>	538: R_X86_64_PC32	.init.text+0xfec2
053c  53c:	e9 00 00 00 00       	jmp    541 <.altinstr_replacement+0x541>	53d: R_X86_64_PC32	.init.text+0xfee4
0541  541:	e9 00 00 00 00       	jmp    546 <.altinstr_replacement+0x546>	542: R_X86_64_PC32	.init.text+0x100e8
0546  546:	e9 00 00 00 00       	jmp    54b <.altinstr_replacement+0x54b>	547: R_X86_64_PC32	.init.text+0x10302
054b  54b:	e9 00 00 00 00       	jmp    550 <.altinstr_replacement+0x550>	54c: R_X86_64_PC32	.text+0x50ef6
0550  550:	e9 00 00 00 00       	jmp    555 <.altinstr_replacement+0x555>	551: R_X86_64_PC32	.text+0x50f4d
0555  555:	e9 00 00 00 00       	jmp    55a <.altinstr_replacement+0x55a>	556: R_X86_64_PC32	.text+0x50f29
055a  55a:	e9 00 00 00 00       	jmp    55f <.altinstr_replacement+0x55f>	55b: R_X86_64_PC32	.text+0x525ed
055f  55f:	e8 00 00 00 00       	call   564 <.altinstr_replacement+0x564>	560: R_X86_64_PLT32	copy_user_generic_string-0x4
0564  564:	e8 00 00 00 00       	call   569 <.altinstr_replacement+0x569>	565: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0569  569:	e9 00 00 00 00       	jmp    56e <.altinstr_replacement+0x56e>	56a: R_X86_64_PC32	.text+0x57d66
056e  56e:	e9 00 00 00 00       	jmp    573 <.altinstr_replacement+0x573>	56f: R_X86_64_PC32	.text+0x5989a
0573  573:	e9 00 00 00 00       	jmp    578 <.altinstr_replacement+0x578>	574: R_X86_64_PC32	.text+0x598c0
0578  578:	e9 00 00 00 00       	jmp    57d <.altinstr_replacement+0x57d>	579: R_X86_64_PC32	.text+0x598cc
057d  57d:	e9 00 00 00 00       	jmp    582 <.altinstr_replacement+0x582>	57e: R_X86_64_PC32	.text+0x59922
0582  582:	e9 00 00 00 00       	jmp    587 <.altinstr_replacement+0x587>	583: R_X86_64_PC32	.text+0x5a266
0587  587:	e9 00 00 00 00       	jmp    58c <.altinstr_replacement+0x58c>	588: R_X86_64_PC32	.init.text+0x12cda
058c  58c:	e9 00 00 00 00       	jmp    591 <.altinstr_replacement+0x591>	58d: R_X86_64_PC32	.init.text+0x12ceb
0591  591:	e9 00 00 00 00       	jmp    596 <.altinstr_replacement+0x596>	592: R_X86_64_PC32	.init.text+0x1343e
0596  596:	e9 00 00 00 00       	jmp    59b <.altinstr_replacement+0x59b>	597: R_X86_64_PC32	.text+0x5bcc9
059b  59b:	e9 00 00 00 00       	jmp    5a0 <.altinstr_replacement+0x5a0>	59c: R_X86_64_PC32	.text+0x5be05
05a0  5a0:	e9 00 00 00 00       	jmp    5a5 <.altinstr_replacement+0x5a5>	5a1: R_X86_64_PC32	.text+0x5bec7
05a5  5a5:	e9 00 00 00 00       	jmp    5aa <.altinstr_replacement+0x5aa>	5a6: R_X86_64_PC32	.text+0x5fb42
05aa  5aa:	e9 00 00 00 00       	jmp    5af <.altinstr_replacement+0x5af>	5ab: R_X86_64_PC32	.text+0x5fc30
05af  5af:	e9 00 00 00 00       	jmp    5b4 <.altinstr_replacement+0x5b4>	5b0: R_X86_64_PC32	.text+0x66955
05b4  5b4:	e9 00 00 00 00       	jmp    5b9 <.altinstr_replacement+0x5b9>	5b5: R_X86_64_PC32	.text+0x66947
05b9  5b9:	0f 01 c1             	vmcall 
05bc  5bc:	0f 01 d9             	vmmcall 
05bf  5bf:	e9 00 00 00 00       	jmp    5c4 <.altinstr_replacement+0x5c4>	5c0: R_X86_64_PC32	.init.text+0x1b1f5
05c4  5c4:	87 3c 25 00 d3 5f ff 	xchg   %edi,0xffffffffff5fd300
05cb  5cb:	87 3c 25 10 d3 5f ff 	xchg   %edi,0xffffffffff5fd310
05d2  5d2:	87 04 25 00 d3 5f ff 	xchg   %eax,0xffffffffff5fd300
05d9  5d9:	87 3c 25 00 d3 5f ff 	xchg   %edi,0xffffffffff5fd300
05e0  5e0:	87 3c 25 00 d3 5f ff 	xchg   %edi,0xffffffffff5fd300
05e7  5e7:	87 3c 25 00 d3 5f ff 	xchg   %edi,0xffffffffff5fd300
05ee  5ee:	87 b7 00 d0 5f ff    	xchg   %esi,-0xa03000(%rdi)
05f4  5f4:	0f ae e8             	lfence 
05f7  5f7:	0f 31                	rdtsc  
05f9  5f9:	0f 01 f9             	rdtscp 
05fc  5fc:	e8 00 00 00 00       	call   601 <.altinstr_replacement+0x601>	5fd: R_X86_64_PLT32	clear_page_rep-0x4
0601  601:	e8 00 00 00 00       	call   606 <.altinstr_replacement+0x606>	602: R_X86_64_PLT32	clear_page_erms-0x4
0606  606:	e8 00 00 00 00       	call   60b <.altinstr_replacement+0x60b>	607: R_X86_64_PLT32	clear_page_rep-0x4
060b  60b:	e8 00 00 00 00       	call   610 <.altinstr_replacement+0x610>	60c: R_X86_64_PLT32	clear_page_erms-0x4
0610  610:	e9 00 00 00 00       	jmp    615 <.altinstr_replacement+0x615>	611: R_X86_64_PC32	.init.text+0x1f635
0615  615:	0f ae e8             	lfence 
0618  618:	0f 31                	rdtsc  
061a  61a:	0f 01 f9             	rdtscp 
061d  61d:	e8 00 00 00 00       	call   622 <.altinstr_replacement+0x622>	61e: R_X86_64_PLT32	clear_page_rep-0x4
0622  622:	e8 00 00 00 00       	call   627 <.altinstr_replacement+0x627>	623: R_X86_64_PLT32	clear_page_erms-0x4
0627  627:	e9 00 00 00 00       	jmp    62c <.altinstr_replacement+0x62c>	628: R_X86_64_PC32	.text+0x7e91f
062c  62c:	0f 0d 88 b0 00 00 00 	prefetchw 0xb0(%rax)
0633  633:	e9 00 00 00 00       	jmp    638 <.altinstr_replacement+0x638>	634: R_X86_64_PC32	.text+0x80d3b
0638  638:	e9 00 00 00 00       	jmp    63d <.altinstr_replacement+0x63d>	639: R_X86_64_PC32	.text+0x83108
063d  63d:	e9 00 00 00 00       	jmp    642 <.altinstr_replacement+0x642>	63e: R_X86_64_PC32	.text+0x83311
0642  642:	e9 00 00 00 00       	jmp    647 <.altinstr_replacement+0x647>	643: R_X86_64_PC32	.text+0x8355d
0647  647:	e9 00 00 00 00       	jmp    64c <.altinstr_replacement+0x64c>	648: R_X86_64_PC32	.text+0x83616
064c  64c:	0f 30                	wrmsr  
064e  64e:	0f 30                	wrmsr  
0650  650:	e9 00 00 00 00       	jmp    655 <.altinstr_replacement+0x655>	651: R_X86_64_PC32	.text+0x83cfd
0655  655:	e9 00 00 00 00       	jmp    65a <.altinstr_replacement+0x65a>	656: R_X86_64_PC32	.text+0x8415e
065a  65a:	e9 00 00 00 00       	jmp    65f <.altinstr_replacement+0x65f>	65b: R_X86_64_PC32	.text+0x841e9
065f  65f:	e9 00 00 00 00       	jmp    664 <.altinstr_replacement+0x664>	660: R_X86_64_PC32	.text+0x842c9
0664  664:	66 0f ae 3b          	clflushopt (%rbx)
0668  668:	66 0f ae 3b          	clflushopt (%rbx)
066c  66c:	66 0f ae 7d 00       	clflushopt 0x0(%rbp)
0671  671:	e9 00 00 00 00       	jmp    676 <.altinstr_replacement+0x676>	672: R_X86_64_PC32	.text+0x869ee
0676  676:	e9 00 00 00 00       	jmp    67b <.altinstr_replacement+0x67b>	677: R_X86_64_PLT32	__x86_indirect_thunk_rdi-0x4
067b  67b:	0f ae e8             	lfence 
067e  67e:	ff e7                	jmp    *%rdi
0680  680:	0f 01 cb             	stac   
0683  683:	0f ae e8             	lfence 
0686  686:	0f 01 ca             	clac   
0689  689:	0f 01 ca             	clac   
068c  68c:	0f 01 cb             	stac   
068f  68f:	0f ae e8             	lfence 
0692  692:	e9 00 00 00 00       	jmp    697 <.altinstr_replacement+0x697>	693: R_X86_64_PC32	.text+0x1332d3
0697  697:	0f 01 ca             	clac   
069a  69a:	0f 01 ca             	clac   
069d  69d:	0f 30                	wrmsr  
069f  69f:	e8 00 00 00 00       	call   6a4 <.altinstr_replacement+0x6a4>	6a0: R_X86_64_PLT32	__x86_indirect_thunk_rdi-0x4
06a4  6a4:	0f ae e8             	lfence 
06a7  6a7:	ff d7                	call   *%rdi
06a9  6a9:	0f 01 cb             	stac   
06ac  6ac:	0f ae e8             	lfence 
06af  6af:	0f 01 ca             	clac   
06b2  6b2:	0f 01 ca             	clac   
06b5  6b5:	0f 01 cb             	stac   
06b8  6b8:	0f ae e8             	lfence 
06bb  6bb:	0f 01 ca             	clac   
06be  6be:	0f 01 ca             	clac   
06c1  6c1:	0f 01 cb             	stac   
06c4  6c4:	0f ae e8             	lfence 
06c7  6c7:	0f 01 ca             	clac   
06ca  6ca:	0f 01 cb             	stac   
06cd  6cd:	0f ae e8             	lfence 
06d0  6d0:	0f 01 ca             	clac   
06d3  6d3:	0f 01 ca             	clac   
06d6  6d6:	0f 01 ca             	clac   
06d9  6d9:	e8 00 00 00 00       	call   6de <.altinstr_replacement+0x6de>	6da: R_X86_64_PLT32	clear_page_rep-0x4
06de  6de:	e8 00 00 00 00       	call   6e3 <.altinstr_replacement+0x6e3>	6df: R_X86_64_PLT32	clear_page_erms-0x4
06e3  6e3:	0f 01 cb             	stac   
06e6  6e6:	0f ae e8             	lfence 
06e9  6e9:	0f 01 ca             	clac   
06ec  6ec:	0f 01 ca             	clac   
06ef  6ef:	0f 01 cb             	stac   
06f2  6f2:	0f ae e8             	lfence 
06f5  6f5:	0f 01 ca             	clac   
06f8  6f8:	0f 01 ca             	clac   
06fb  6fb:	e8 00 00 00 00       	call   700 <.altinstr_replacement+0x700>	6fc: R_X86_64_PLT32	copy_user_generic_string-0x4
0700  700:	e8 00 00 00 00       	call   705 <.altinstr_replacement+0x705>	701: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0705  705:	e8 00 00 00 00       	call   70a <.altinstr_replacement+0x70a>	706: R_X86_64_PLT32	copy_user_generic_string-0x4
070a  70a:	e8 00 00 00 00       	call   70f <.altinstr_replacement+0x70f>	70b: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
070f  70f:	0f ae e8             	lfence 
0712  712:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0717  717:	f3 48 0f b8 c7       	popcnt %rdi,%rax
071c  71c:	e8 00 00 00 00       	call   721 <.altinstr_replacement+0x721>	71d: R_X86_64_PLT32	copy_user_generic_string-0x4
0721  721:	e8 00 00 00 00       	call   726 <.altinstr_replacement+0x726>	722: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0726  726:	e8 00 00 00 00       	call   72b <.altinstr_replacement+0x72b>	727: R_X86_64_PLT32	copy_user_generic_string-0x4
072b  72b:	e8 00 00 00 00       	call   730 <.altinstr_replacement+0x730>	72c: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0730  730:	41 0f 0d 4c 24 f8    	prefetchw -0x8(%r12)
0736  736:	e8 00 00 00 00       	call   73b <.altinstr_replacement+0x73b>	737: R_X86_64_PLT32	clear_page_rep-0x4
073b  73b:	e8 00 00 00 00       	call   740 <.altinstr_replacement+0x740>	73c: R_X86_64_PLT32	clear_page_erms-0x4
0740  740:	0f 01 cb             	stac   
0743  743:	0f ae e8             	lfence 
0746  746:	0f 01 ca             	clac   
0749  749:	0f 01 cb             	stac   
074c  74c:	0f ae e8             	lfence 
074f  74f:	0f 01 ca             	clac   
0752  752:	e8 00 00 00 00       	call   757 <.altinstr_replacement+0x757>	753: R_X86_64_PLT32	copy_user_generic_string-0x4
0757  757:	e8 00 00 00 00       	call   75c <.altinstr_replacement+0x75c>	758: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
075c  75c:	e8 00 00 00 00       	call   761 <.altinstr_replacement+0x761>	75d: R_X86_64_PLT32	copy_user_generic_string-0x4
0761  761:	e8 00 00 00 00       	call   766 <.altinstr_replacement+0x766>	762: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0766  766:	e8 00 00 00 00       	call   76b <.altinstr_replacement+0x76b>	767: R_X86_64_PLT32	clear_page_rep-0x4
076b  76b:	e8 00 00 00 00       	call   770 <.altinstr_replacement+0x770>	76c: R_X86_64_PLT32	clear_page_erms-0x4
0770  770:	e8 00 00 00 00       	call   775 <.altinstr_replacement+0x775>	771: R_X86_64_PLT32	clear_page_rep-0x4
0775  775:	e8 00 00 00 00       	call   77a <.altinstr_replacement+0x77a>	776: R_X86_64_PLT32	clear_page_erms-0x4
077a  77a:	e8 00 00 00 00       	call   77f <.altinstr_replacement+0x77f>	77b: R_X86_64_PLT32	clear_page_rep-0x4
077f  77f:	e8 00 00 00 00       	call   784 <.altinstr_replacement+0x784>	780: R_X86_64_PLT32	clear_page_erms-0x4
0784  784:	e8 00 00 00 00       	call   789 <.altinstr_replacement+0x789>	785: R_X86_64_PLT32	clear_page_rep-0x4
0789  789:	e8 00 00 00 00       	call   78e <.altinstr_replacement+0x78e>	78a: R_X86_64_PLT32	clear_page_erms-0x4
078e  78e:	e8 00 00 00 00       	call   793 <.altinstr_replacement+0x793>	78f: R_X86_64_PLT32	clear_page_rep-0x4
0793  793:	e8 00 00 00 00       	call   798 <.altinstr_replacement+0x798>	794: R_X86_64_PLT32	clear_page_erms-0x4
0798  798:	e8 00 00 00 00       	call   79d <.altinstr_replacement+0x79d>	799: R_X86_64_PLT32	clear_page_rep-0x4
079d  79d:	e8 00 00 00 00       	call   7a2 <.altinstr_replacement+0x7a2>	79e: R_X86_64_PLT32	clear_page_erms-0x4
07a2  7a2:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07a7  7a7:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07ac  7ac:	e8 00 00 00 00       	call   7b1 <.altinstr_replacement+0x7b1>	7ad: R_X86_64_PLT32	clear_page_rep-0x4
07b1  7b1:	e8 00 00 00 00       	call   7b6 <.altinstr_replacement+0x7b6>	7b2: R_X86_64_PLT32	clear_page_erms-0x4
07b6  7b6:	e8 00 00 00 00       	call   7bb <.altinstr_replacement+0x7bb>	7b7: R_X86_64_PLT32	clear_page_rep-0x4
07bb  7bb:	e8 00 00 00 00       	call   7c0 <.altinstr_replacement+0x7c0>	7bc: R_X86_64_PLT32	clear_page_erms-0x4
07c0  7c0:	41 0f 0d 4d 00       	prefetchw 0x0(%r13)
07c5  7c5:	0f 0d 0b             	prefetchw (%rbx)
07c8  7c8:	e8 00 00 00 00       	call   7cd <.altinstr_replacement+0x7cd>	7c9: R_X86_64_PLT32	clear_page_rep-0x4
07cd  7cd:	e8 00 00 00 00       	call   7d2 <.altinstr_replacement+0x7d2>	7ce: R_X86_64_PLT32	clear_page_erms-0x4
07d2  7d2:	e8 00 00 00 00       	call   7d7 <.altinstr_replacement+0x7d7>	7d3: R_X86_64_PLT32	clear_page_rep-0x4
07d7  7d7:	e8 00 00 00 00       	call   7dc <.altinstr_replacement+0x7dc>	7d8: R_X86_64_PLT32	clear_page_erms-0x4
07dc  7dc:	e8 00 00 00 00       	call   7e1 <.altinstr_replacement+0x7e1>	7dd: R_X86_64_PLT32	clear_page_rep-0x4
07e1  7e1:	e8 00 00 00 00       	call   7e6 <.altinstr_replacement+0x7e6>	7e2: R_X86_64_PLT32	clear_page_erms-0x4
07e6  7e6:	e8 00 00 00 00       	call   7eb <.altinstr_replacement+0x7eb>	7e7: R_X86_64_PLT32	clear_page_rep-0x4
07eb  7eb:	e8 00 00 00 00       	call   7f0 <.altinstr_replacement+0x7f0>	7ec: R_X86_64_PLT32	clear_page_erms-0x4
07f0  7f0:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07f5  7f5:	0f 01 cb             	stac   
07f8  7f8:	0f ae e8             	lfence 
07fb  7fb:	0f 01 ca             	clac   
07fe  7fe:	0f 01 ca             	clac   
0801  801:	0f 01 cb             	stac   
0804  804:	0f ae e8             	lfence 
0807  807:	0f 01 ca             	clac   
080a  80a:	0f 01 ca             	clac   
080d  80d:	0f 01 cb             	stac   
0810  810:	0f ae e8             	lfence 
0813  813:	0f 01 ca             	clac   
0816  816:	0f 01 ca             	clac   
0819  819:	0f 01 cb             	stac   
081c  81c:	0f ae e8             	lfence 
081f  81f:	0f 01 ca             	clac   
0822  822:	0f 01 ca             	clac   
0825  825:	0f 01 cb             	stac   
0828  828:	0f ae e8             	lfence 
082b  82b:	0f 01 ca             	clac   
082e  82e:	0f 01 ca             	clac   
0831  831:	0f 01 cb             	stac   
0834  834:	0f ae e8             	lfence 
0837  837:	0f 01 ca             	clac   
083a  83a:	0f 01 ca             	clac   
083d  83d:	e8 00 00 00 00       	call   842 <.altinstr_replacement+0x842>	83e: R_X86_64_PLT32	copy_user_generic_string-0x4
0842  842:	e8 00 00 00 00       	call   847 <.altinstr_replacement+0x847>	843: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0847  847:	e8 00 00 00 00       	call   84c <.altinstr_replacement+0x84c>	848: R_X86_64_PLT32	copy_user_generic_string-0x4
084c  84c:	e8 00 00 00 00       	call   851 <.altinstr_replacement+0x851>	84d: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0851  851:	e8 00 00 00 00       	call   856 <.altinstr_replacement+0x856>	852: R_X86_64_PLT32	copy_user_generic_string-0x4
0856  856:	e8 00 00 00 00       	call   85b <.altinstr_replacement+0x85b>	857: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
085b  85b:	0f 01 cb             	stac   
085e  85e:	0f ae e8             	lfence 
0861  861:	0f 01 ca             	clac   
0864  864:	0f 01 ca             	clac   
0867  867:	0f 01 cb             	stac   
086a  86a:	0f ae e8             	lfence 
086d  86d:	0f 01 ca             	clac   
0870  870:	0f 01 ca             	clac   
0873  873:	0f 01 cb             	stac   
0876  876:	0f ae e8             	lfence 
0879  879:	0f 01 ca             	clac   
087c  87c:	0f 01 ca             	clac   
087f  87f:	0f 01 cb             	stac   
0882  882:	0f ae e8             	lfence 
0885  885:	0f 01 ca             	clac   
0888  888:	0f 01 ca             	clac   
088b  88b:	41 0f 0d 8c 24 b0 08 00 00 	prefetchw 0x8b0(%r12)
0894  894:	f3 0f b8 c7          	popcnt %edi,%eax
0898  898:	f3 0f b8 c7          	popcnt %edi,%eax
089c  89c:	f3 0f b8 c7          	popcnt %edi,%eax
08a0  8a0:	e8 00 00 00 00       	call   8a5 <.altinstr_replacement+0x8a5>	8a1: R_X86_64_PLT32	clear_page_rep-0x4
08a5  8a5:	e8 00 00 00 00       	call   8aa <.altinstr_replacement+0x8aa>	8a6: R_X86_64_PLT32	clear_page_erms-0x4
08aa  8aa:	e8 00 00 00 00       	call   8af <.altinstr_replacement+0x8af>	8ab: R_X86_64_PLT32	clear_page_rep-0x4
08af  8af:	e8 00 00 00 00       	call   8b4 <.altinstr_replacement+0x8b4>	8b0: R_X86_64_PLT32	clear_page_erms-0x4
08b4  8b4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
08b9  8b9:	f3 48 0f b8 c7       	popcnt %rdi,%rax
08be  8be:	e8 00 00 00 00       	call   8c3 <.altinstr_replacement+0x8c3>	8bf: R_X86_64_PLT32	copy_user_generic_string-0x4
08c3  8c3:	e8 00 00 00 00       	call   8c8 <.altinstr_replacement+0x8c8>	8c4: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
08c8  8c8:	e8 00 00 00 00       	call   8cd <.altinstr_replacement+0x8cd>	8c9: R_X86_64_PLT32	copy_user_generic_string-0x4
08cd  8cd:	e8 00 00 00 00       	call   8d2 <.altinstr_replacement+0x8d2>	8ce: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
08d2  8d2:	0f 01 cb             	stac   
08d5  8d5:	0f ae e8             	lfence 
08d8  8d8:	0f 01 ca             	clac   
08db  8db:	f3 0f b8 c7          	popcnt %edi,%eax
08df  8df:	f3 0f b8 c7          	popcnt %edi,%eax
08e3  8e3:	e8 00 00 00 00       	call   8e8 <.altinstr_replacement+0x8e8>	8e4: R_X86_64_PLT32	copy_user_generic_string-0x4
08e8  8e8:	e8 00 00 00 00       	call   8ed <.altinstr_replacement+0x8ed>	8e9: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
08ed  8ed:	0f 01 cb             	stac   
08f0  8f0:	0f ae e8             	lfence 
08f3  8f3:	0f 01 ca             	clac   
08f6  8f6:	0f 01 ca             	clac   
08f9  8f9:	e8 00 00 00 00       	call   8fe <.altinstr_replacement+0x8fe>	8fa: R_X86_64_PLT32	copy_user_generic_string-0x4
08fe  8fe:	e8 00 00 00 00       	call   903 <.altinstr_replacement+0x903>	8ff: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0903  903:	0f 01 cb             	stac   
0906  906:	0f ae e8             	lfence 
0909  909:	0f 01 ca             	clac   
090c  90c:	0f 01 cb             	stac   
090f  90f:	0f ae e8             	lfence 
0912  912:	0f 01 ca             	clac   
0915  915:	9c                   	pushf  
0916  916:	41 5d                	pop    %r13
0918  918:	0f 01 ca             	clac   
091b  91b:	41 55                	push   %r13
091d  91d:	9d                   	popf   
091e  91e:	9c                   	pushf  
091f  91f:	8f 44 24 08          	pop    0x8(%rsp)
0923  923:	0f 01 ca             	clac   
0926  926:	ff 74 24 08          	push   0x8(%rsp)
092a  92a:	9d                   	popf   
092b  92b:	e9 00 00 00 00       	jmp    930 <.altinstr_replacement+0x930>	92c: R_X86_64_PC32	.text+0x781b11
0930  930:	e9 00 00 00 00       	jmp    935 <.altinstr_replacement+0x935>	931: R_X86_64_PC32	.text+0x781bd7
0935  935:	0f 01 cb             	stac   
0938  938:	0f 01 ca             	clac   
093b  93b:	e8 00 00 00 00       	call   940 <.altinstr_replacement+0x940>	93c: R_X86_64_PLT32	copy_user_generic_string-0x4
0940  940:	e8 00 00 00 00       	call   945 <.altinstr_replacement+0x945>	941: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0945  945:	0f 01 cb             	stac   
0948  948:	0f 01 cb             	stac   
094b  94b:	0f 01 ca             	clac   
094e  94e:	0f 01 cb             	stac   
0951  951:	0f 01 ca             	clac   
0954  954:	0f 01 ca             	clac   
0957  957:	0f 01 ca             	clac   
095a  95a:	0f 01 ca             	clac   
095d  95d:	0f 01 cb             	stac   
0960  960:	0f 01 ca             	clac   
0963  963:	0f 01 cb             	stac   
0966  966:	0f ae e8             	lfence 
0969  969:	0f 01 ca             	clac   
096c  96c:	0f 01 cb             	stac   
096f  96f:	0f ae e8             	lfence 
0972  972:	0f 01 ca             	clac   
0975  975:	0f ae e8             	lfence 
0978  978:	0f 31                	rdtsc  
097a  97a:	0f 01 f9             	rdtscp 
097d  97d:	0f ae e8             	lfence 
0980  980:	0f 31                	rdtsc  
0982  982:	0f 01 f9             	rdtscp 
0985  985:	0f ae e8             	lfence 
0988  988:	0f 31                	rdtsc  
098a  98a:	0f 01 f9             	rdtscp 
098d  98d:	0f ae e8             	lfence 
0990  990:	0f 31                	rdtsc  
0992  992:	0f 01 f9             	rdtscp 
0995  995:	0f 01 cb             	stac   
0998  998:	0f 01 ca             	clac   
099b  99b:	0f 01 cb             	stac   
099e  99e:	0f 01 ca             	clac   
09a1  9a1:	0f 01 cb             	stac   
09a4  9a4:	0f 01 ca             	clac   
09a7  9a7:	0f 01 cb             	stac   
09aa  9aa:	0f 01 ca             	clac   
09ad  9ad:	0f 01 cb             	stac   
09b0  9b0:	0f ae e8             	lfence 
09b3  9b3:	0f 01 ca             	clac   
09b6  9b6:	0f 01 cb             	stac   
09b9  9b9:	0f ae e8             	lfence 
09bc  9bc:	0f 01 ca             	clac   
09bf  9bf:	0f 01 cb             	stac   
09c2  9c2:	0f ae e8             	lfence 
09c5  9c5:	0f 01 ca             	clac   
09c8  9c8:	0f 01 cb             	stac   
09cb  9cb:	0f ae e8             	lfence 
09ce  9ce:	0f 01 ca             	clac   
09d1  9d1:	0f 01 ca             	clac   
09d4  9d4:	e8 00 00 00 00       	call   9d9 <.altinstr_replacement+0x9d9>	9d5: R_X86_64_PLT32	copy_user_generic_string-0x4
09d9  9d9:	e8 00 00 00 00       	call   9de <.altinstr_replacement+0x9de>	9da: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
09de  9de:	e9 00 00 00 00       	jmp    9e3 <.altinstr_replacement+0x9e3>	9df: R_X86_64_PC32	.noinstr.text+0x36ac
09e3  9e3:	e9 00 00 00 00       	jmp    9e8 <.altinstr_replacement+0x9e8>	9e4: R_X86_64_PC32	.text+0x787569
09e8  9e8:	e9 00 00 00 00       	jmp    9ed <.altinstr_replacement+0x9ed>	9e9: R_X86_64_PC32	.text+0x7875dc
09ed  9ed:	0f 01 cb             	stac   
09f0  9f0:	0f 01 ca             	clac   
09f3  9f3:	0f 01 cb             	stac   
09f6  9f6:	0f 01 ca             	clac   
09f9  9f9:	0f 01 cb             	stac   
09fc  9fc:	0f 01 ca             	clac   
09ff  9ff:	0f 01 cb             	stac   
0a02  a02:	0f 01 ca             	clac   
0a05  a05:	0f 01 cb             	stac   
0a08  a08:	0f 01 ca             	clac   
0a0b  a0b:	0f 01 cb             	stac   
0a0e  a0e:	0f 01 ca             	clac   
0a11  a11:	0f 01 cb             	stac   
0a14  a14:	0f 01 ca             	clac   
0a17  a17:	0f 01 cb             	stac   
0a1a  a1a:	0f 01 ca             	clac   
0a1d  a1d:	0f 01 ca             	clac   
0a20  a20:	0f ae e8             	lfence 
0a23  a23:	ff e0                	jmp    *%rax
0a25  a25:	cc                   	int3   
0a26  a26:	ff e0                	jmp    *%rax
0a28  a28:	0f ae e8             	lfence 
0a2b  a2b:	ff e1                	jmp    *%rcx
0a2d  a2d:	cc                   	int3   
0a2e  a2e:	ff e1                	jmp    *%rcx
0a30  a30:	0f ae e8             	lfence 
0a33  a33:	ff e2                	jmp    *%rdx
0a35  a35:	cc                   	int3   
0a36  a36:	ff e2                	jmp    *%rdx
0a38  a38:	0f ae e8             	lfence 
0a3b  a3b:	ff e3                	jmp    *%rbx
0a3d  a3d:	cc                   	int3   
0a3e  a3e:	ff e3                	jmp    *%rbx
0a40  a40:	0f ae e8             	lfence 
0a43  a43:	ff e4                	jmp    *%rsp
0a45  a45:	cc                   	int3   
0a46  a46:	ff e4                	jmp    *%rsp
0a48  a48:	0f ae e8             	lfence 
0a4b  a4b:	ff e5                	jmp    *%rbp
0a4d  a4d:	cc                   	int3   
0a4e  a4e:	ff e5                	jmp    *%rbp
0a50  a50:	0f ae e8             	lfence 
0a53  a53:	ff e6                	jmp    *%rsi
0a55  a55:	cc                   	int3   
0a56  a56:	ff e6                	jmp    *%rsi
0a58  a58:	0f ae e8             	lfence 
0a5b  a5b:	ff e7                	jmp    *%rdi
0a5d  a5d:	cc                   	int3   
0a5e  a5e:	ff e7                	jmp    *%rdi
0a60  a60:	0f ae e8             	lfence 
0a63  a63:	41 ff e0             	jmp    *%r8
0a66  a66:	cc                   	int3   
0a67  a67:	41 ff e0             	jmp    *%r8
0a6a  a6a:	0f ae e8             	lfence 
0a6d  a6d:	41 ff e1             	jmp    *%r9
0a70  a70:	cc                   	int3   
0a71  a71:	41 ff e1             	jmp    *%r9
0a74  a74:	0f ae e8             	lfence 
0a77  a77:	41 ff e2             	jmp    *%r10
0a7a  a7a:	cc                   	int3   
0a7b  a7b:	41 ff e2             	jmp    *%r10
0a7e  a7e:	0f ae e8             	lfence 
0a81  a81:	41 ff e3             	jmp    *%r11
0a84  a84:	cc                   	int3   
0a85  a85:	41 ff e3             	jmp    *%r11
0a88  a88:	0f ae e8             	lfence 
0a8b  a8b:	41 ff e4             	jmp    *%r12
0a8e  a8e:	cc                   	int3   
0a8f  a8f:	41 ff e4             	jmp    *%r12
0a92  a92:	0f ae e8             	lfence 
0a95  a95:	41 ff e5             	jmp    *%r13
0a98  a98:	cc                   	int3   
0a99  a99:	41 ff e5             	jmp    *%r13
0a9c  a9c:	0f ae e8             	lfence 
0a9f  a9f:	41 ff e6             	jmp    *%r14
0aa2  aa2:	cc                   	int3   
0aa3  aa3:	41 ff e6             	jmp    *%r14
0aa6  aa6:	0f ae e8             	lfence 
0aa9  aa9:	41 ff e7             	jmp    *%r15
0aac  aac:	cc                   	int3   
0aad  aad:	41 ff e7             	jmp    *%r15
0ab0  ab0:	e8 00 00 00 00       	call   ab5 <.altinstr_replacement+0xab5>	ab1: R_X86_64_PLT32	copy_user_generic_string-0x4
0ab5  ab5:	e8 00 00 00 00       	call   aba <.altinstr_replacement+0xaba>	ab6: R_X86_64_PLT32	copy_user_enhanced_fast_string-0x4
0aba  aba:	66 0f ae 38          	clflushopt (%rax)
0abe  abe:	66 0f ae 30          	clwb   (%rax)
0ac2  ac2:	0f 01 cb             	stac   
0ac5  ac5:	0f 01 ca             	clac   
0ac8  ac8:	0f 30                	wrmsr  
0aca  aca:	0f 30                	wrmsr  
0acc  acc:	0f 30                	wrmsr  
0ace  ace:	e9 00 00 00 00       	jmp    ad3 <.altinstr_replacement+0xad3>	acf: R_X86_64_PC32	.text+0x843679
0ad3  ad3:	e9 00 00 00 00       	jmp    ad8 <.altinstr_replacement+0xad8>	ad4: R_X86_64_PC32	.text+0x8450ee
0ad8  ad8:	f3 0f b8 c7          	popcnt %edi,%eax
0adc  adc:	f3 0f b8 c7          	popcnt %edi,%eax
0ae0  ae0:	e9 00 00 00 00       	jmp    ae5 <.altinstr_replacement+0xae5>	ae1: R_X86_64_PC32	.text+0x91d1ed
0ae5  ae5:	e9 00 00 00 00       	jmp    aea <.altinstr_replacement+0xaea>	ae6: R_X86_64_PC32	.text+0x91dfab
0aea  aea:	e9 00 00 00 00       	jmp    aef <.altinstr_replacement+0xaef>	aeb: R_X86_64_PC32	.text+0x91dffe
0aef  aef:	e9 00 00 00 00       	jmp    af4 <.altinstr_replacement+0xaf4>	af0: R_X86_64_PC32	.init.text+0x537ba
0af4  af4:	e9 00 00 00 00       	jmp    af9 <.altinstr_replacement+0xaf9>	af5: R_X86_64_PC32	.text+0x952032
0af9  af9:	66 0f ae 3b          	clflushopt (%rbx)
0afd  afd:	66 0f ae 7d ff       	clflushopt -0x1(%rbp)
0b02  b02:	66 0f ae 38          	clflushopt (%rax)
0b06  b06:	e9 00 00 00 00       	jmp    b0b <.altinstr_replacement+0xb0b>	b07: R_X86_64_PC32	.text+0x952271
0b0b  b0b:	e9 00 00 00 00       	jmp    b10 <.altinstr_replacement+0xb10>	b0c: R_X86_64_PC32	.text+0x95234b
0b10  b10:	e9 00 00 00 00       	jmp    b15 <.altinstr_replacement+0xb15>	b11: R_X86_64_PC32	.text+0x95277c
0b15  b15:	f3 0f b8 c7          	popcnt %edi,%eax
0b19  b19:	f3 0f b8 c7          	popcnt %edi,%eax
0b1d  b1d:	f3 0f b8 c7          	popcnt %edi,%eax
0b21  b21:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b26  b26:	f3 0f b8 c7          	popcnt %edi,%eax
0b2a  b2a:	f3 0f b8 c7          	popcnt %edi,%eax
0b2e  b2e:	f3 0f b8 c7          	popcnt %edi,%eax
0b32  b32:	f3 0f b8 c7          	popcnt %edi,%eax
0b36  b36:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b3b  b3b:	f3 0f b8 c7          	popcnt %edi,%eax
0b3f  b3f:	f3 0f b8 c7          	popcnt %edi,%eax
0b43  b43:	f3 0f b8 c7          	popcnt %edi,%eax
0b47  b47:	f3 0f b8 c7          	popcnt %edi,%eax
0b4b  b4b:	f3 0f b8 c7          	popcnt %edi,%eax
0b4f  b4f:	0f 0d 4d 00          	prefetchw 0x0(%rbp)
0b53  b53:	0f 0d 0b             	prefetchw (%rbx)
0b56  b56:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b5b  b5b:	f3 0f b8 c7          	popcnt %edi,%eax
0b5f  b5f:	f3 0f b8 c7          	popcnt %edi,%eax
0b63  b63:	0f 30                	wrmsr  
0b65  b65:	0f 30                	wrmsr  
0b67  b67:	0f 30                	wrmsr  
0b69  b69:	0f 30                	wrmsr  
0b6b  b6b:	0f 30                	wrmsr  
0b6d  b6d:	0f 30                	wrmsr  
0b6f  b6f:	0f 30                	wrmsr  
0b71  b71:	0f 30                	wrmsr  
0b73  b73:	0f 30                	wrmsr  
0b75  b75:	0f 30                	wrmsr  
0b77  b77:	0f 30                	wrmsr  
0b79  b79:	0f 30                	wrmsr  
0b7b  b7b:	0f 30                	wrmsr  
0b7d  b7d:	0f 30                	wrmsr  
0b7f  b7f:	0f 30                	wrmsr  
0b81  b81:	0f 30                	wrmsr  
0b83  b83:	0f 30                	wrmsr  
0b85  b85:	0f 30                	wrmsr  
0b87  b87:	0f 30                	wrmsr  
0b89  b89:	0f 30                	wrmsr  
0b8b  b8b:	0f 30                	wrmsr  
0b8d  b8d:	0f 30                	wrmsr  
0b8f  b8f:	0f 30                	wrmsr  
0b91  b91:	0f 30                	wrmsr  
0b93  b93:	0f 30                	wrmsr  
0b95  b95:	0f 30                	wrmsr  
0b97  b97:	0f 30                	wrmsr  
0b99  b99:	0f 30                	wrmsr  
0b9b  b9b:	0f 30                	wrmsr  
0b9d  b9d:	0f 30                	wrmsr  
0b9f  b9f:	0f 30                	wrmsr  
0ba1  ba1:	0f 30                	wrmsr  
0ba3  ba3:	0f 30                	wrmsr  
0ba5  ba5:	0f 30                	wrmsr  
0ba7  ba7:	0f 30                	wrmsr  
0ba9  ba9:	0f 30                	wrmsr  
0bab  bab:	0f 30                	wrmsr  
0bad  bad:	0f 30                	wrmsr  
0baf  baf:	0f 30                	wrmsr  
0bb1  bb1:	0f 30                	wrmsr  
0bb3  bb3:	0f 30                	wrmsr  
0bb5  bb5:	0f 30                	wrmsr  
0bb7  bb7:	e9 00 00 00 00       	jmp    bbc <.altinstr_replacement+0xbbc>	bb8: R_X86_64_PC32	.init.text+0x6eb4f
0bbc  bbc:	f3 0f b8 c7          	popcnt %edi,%eax
0bc0  bc0:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bc5  bc5:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bca  bca:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bcf  bcf:	41 0f 0d 0c 24       	prefetchw (%r12)
0bd4  bd4:	41 0f 0d 0c 06       	prefetchw (%r14,%rax,1)
0bd9  bd9:	0f 01 cb             	stac   
0bdc  bdc:	0f ae e8             	lfence 
0bdf  bdf:	0f 01 ca             	clac   
0be2  be2:	0f 01 ca             	clac   
0be5  be5:	f3 0f b8 c7          	popcnt %edi,%eax
0be9  be9:	f3 0f b8 c7          	popcnt %edi,%eax
0bed  bed:	f3 0f b8 c7          	popcnt %edi,%eax
0bf1  bf1:	f3 0f b8 c7          	popcnt %edi,%eax
0bf5  bf5:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bfa  bfa:	0f 0d 4d 00          	prefetchw 0x0(%rbp)
0bfe  bfe:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c03  c03:	f3 48 0f b8 c7       	popcnt %rdi,%rax

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
