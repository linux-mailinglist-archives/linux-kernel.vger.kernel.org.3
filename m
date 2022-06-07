Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9E5401BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiFGOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343519AbiFGOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:48:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E50B26DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:47:57 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nyaUa-00007Y-Hs; Tue, 07 Jun 2022 16:47:36 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: arch/riscv/include/asm/pgtable-64.h:210:2: error: invalid input constraint '0' in asm
Date:   Tue, 07 Jun 2022 16:47:35 +0200
Message-ID: <1822190.CQOukoFCf9@diego>
In-Reply-To: <202206052118.lfENADgr-lkp@intel.com>
References: <202206052118.lfENADgr-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 5. Juni 2022, 15:20:08 CEST schrieb kernel test robot:
> Hi Heiko,
> 
> FYI, the error/warning still remains.

the pending change [0] fixes that issue, so should hopefully make it into
one of the next -rc kernels.

Heiko


[0] https://lore.kernel.org/all/20220518184529.454008-1-nathan@kernel.org/

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   952923ddc01120190dcf671e7b354364ce1d1362
> commit: a35707c3d850dda0ceefb75b1b3bd191921d5765 riscv: add memory-type errata for T-Head
> date:   3 weeks ago
> config: riscv-randconfig-r015-20220605 (https://download.01.org/0day-ci/archive/20220605/202206052118.lfENADgr-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a35707c3d850dda0ceefb75b1b3bd191921d5765
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a35707c3d850dda0ceefb75b1b3bd191921d5765
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:29:
>    In file included from include/linux/pgtable.h:6:
>    In file included from arch/riscv/include/asm/pgtable.h:114:
> >> arch/riscv/include/asm/pgtable-64.h:210:2: error: invalid input constraint '0' in asm
>            ALT_THEAD_PMA(prot_val);
>            ^
>    arch/riscv/include/asm/errata_list.h:88:4: note: expanded from macro 'ALT_THEAD_PMA'
>            : "0"(_val),                                                    \
>              ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                    return (set->sig[3] | set->sig[2] |
>                            ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                    return (set->sig[3] | set->sig[2] |
>                                          ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:98:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                            set->sig[1] | set->sig[0]) == 0;
>                            ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:100:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                    return (set->sig[1] | set->sig[0]) == 0;
>                            ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                    return  (set1->sig[3] == set2->sig[3]) &&
>                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                    return  (set1->sig[3] == set2->sig[3]) &&
>                                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                            (set1->sig[2] == set2->sig[2]) &&
>                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
> 
> 
> vim +/0 +210 arch/riscv/include/asm/pgtable-64.h
> 
>    205	
>    206	static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>    207	{
>    208		unsigned long prot_val = pgprot_val(prot);
>    209	
>  > 210		ALT_THEAD_PMA(prot_val);
>    211	
>    212		return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
>    213	}
>    214	
> 
> 




