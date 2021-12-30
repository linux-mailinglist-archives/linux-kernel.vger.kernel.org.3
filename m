Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213DD481A24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhL3HOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:14:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:42479 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236741AbhL3HOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640848484; x=1672384484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3iCjkqny1bw9QGjKT/Pra5Z2ikgjU4Kl6PkVp/L7hg4=;
  b=AQEOBYfj4N7GmfCEtd30ooVTWky83eu40SFcFVpCPgypCrY3c0mA3b9g
   5BaeBwt7BU6wQeefaOJBjlg3MUaaPHceFe48g5usL3vO6JUHW6RYIuVDx
   DjP+NL8I2sTxAjYeL12LGm7V4VaCWybFEaYxJqGamlICHAG15+rfrkQZs
   c/DZrXPaslNV2wQ2CRAAIijkNsnuGiqybEg7WemhLif6lzw20WsRI7O0T
   lB2/UuM03hD2dE4kqRymLhFBqPyqy2QDfZjcm7q8spAnhVAhhEbL4fTn0
   GXXcb0/mPtBcPIgjD5HwnMSF864wE5DGB+KDn1QigkuAjtwGHfuRncX2O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241585749"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="241585749"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 23:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="687136315"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Dec 2021 23:14:42 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2pe5-0009sB-If; Thu, 30 Dec 2021 07:14:41 +0000
Date:   Thu, 30 Dec 2021 15:13:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [nathan:wip/llvm-objdump-posttest 1/1]
 arch/x86/tools/insn_decoder_test: error: malformed line 7230868:
Message-ID: <202112301509.DL4ccRU2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git wip/llvm-objdump-posttest
head:   2f137c324b21f1c21b8830d8896cb9957009f969
commit: 2f137c324b21f1c21b8830d8896cb9957009f969 [1/1] x86/tools: Remove chkobjdump.awk
config: i386-randconfig-a015-20211228 (https://download.01.org/0day-ci/archive/20211230/202112301509.DL4ccRU2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/commit/?id=2f137c324b21f1c21b8830d8896cb9957009f969
        git remote add nathan https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git
        git fetch --no-tags nathan wip/llvm-objdump-posttest
        git checkout 2f137c324b21f1c21b8830d8896cb9957009f969
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cb1: 84 db                        	testb	%bl, %bl
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cb3: 8b 48 04                     	movl	4(%eax), %ecx
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cb6: 8b 50 08                     	movl	8(%eax), %edx
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cb9: 8b 58 0c                     	movl	12(%eax), %ebx
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cbc: 8b 68 14                     	movl	20(%eax), %ebp
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cbf: 8b 70 18                     	movl	24(%eax), %esi
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cc2: 8b 78 1c                     	movl	28(%eax), %edi
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cc5: 8b 00                        	movl	(%eax), %eax
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cc7: e8 b4 ff ff ff               	calll	0xc2841c80 <vmx_vmenter>
   arch/x86/tools/insn_decoder_test: warning: objdump says 1 bytes, but insn_get_length() says 3
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ccc: 76 2f                        	jbe	0xc2841cfd <__vmx_vcpu_run+0x61>
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cce: 50                           	pushl	%eax
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ccf: 8b 44 24 04                  	movl	4(%esp), %eax
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cd3: 8f 00                        	popl	(%eax)
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cd5: 89 48 04                     	movl	%ecx, 4(%eax)
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cd8: 89 50 08                     	movl	%edx, 8(%eax)
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cdb: 89 58 0c                     	movl	%ebx, 12(%eax)
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cde: 89 68 14                     	movl	%ebp, 20(%eax)
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ce1: 89 70 18                     	movl	%esi, 24(%eax)
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ce4: 89 78 1c                     	movl	%edi, 28(%eax)
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ce7: 31 c0                        	xorl	%eax, %eax
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ce9: 31 c9                        	xorl	%ecx, %ecx
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ceb: 31 d2                        	xorl	%edx, %edx
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841ced: 31 db                        	xorl	%ebx, %ebx
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cef: 31 ed                        	xorl	%ebp, %ebp
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cf1: 31 f6                        	xorl	%esi, %esi
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cf3: 31 ff                        	xorl	%edi, %edi
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cf5: 83 c4 04                     	addl	$4, %esp
   arch/x86/tools/insn_decoder_test: warning: objdump says 1 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cf8: 5b                           	popl	%ebx
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cf9: 5e                           	popl	%esi
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cfa: 5f                           	popl	%edi
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cfb: 5d                           	poplretl	%ebp
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841cfd: b8 01 00 00 00               	movl	$1, %eax
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
   arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
   arch/x86/tools/insn_decoder_test: warning: c2841d02: eb e5                        	jmppushfl	0xc2841ce9 <__vmx_vcpu_run+0x4d>
   arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but insn_get_length() says 2
>> arch/x86/tools/insn_decoder_test: error: malformed line 7230868:
   c2841d05: 58                           	poplretlint3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int3int

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
