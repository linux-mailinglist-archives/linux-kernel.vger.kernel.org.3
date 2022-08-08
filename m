Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C458C4CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiHHIQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiHHIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:16:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BEB267F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:16:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oKxw8-0006JP-Oh; Mon, 08 Aug 2022 10:16:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [ammarfaizi2-block:palmer/linux/riscv-zicbom 6/6] arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')' before '__nops'
Date:   Mon, 08 Aug 2022 10:16:32 +0200
Message-ID: <2111135.irdbgypaU6@diego>
In-Reply-To: <202208050445.jnUp8dLc-lkp@intel.com>
References: <202208050445.jnUp8dLc-lkp@intel.com>
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

Am Donnerstag, 4. August 2022, 22:47:29 CEST schrieb kernel test robot:
> tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-zicbom
> head:   d20ec7529236a2fcdb2d856fc0bd80b409a217fc
> commit: d20ec7529236a2fcdb2d856fc0bd80b409a217fc [6/6] riscv: implement cache-management errata for T-Head SoCs
> config: riscv-randconfig-r035-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050445.jnUp8dLc-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/d20ec7529236a2fcdb2d856fc0bd80b409a217fc
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-zicbom
>         git checkout d20ec7529236a2fcdb2d856fc0bd80b409a217fc
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/ kernel/dma/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/riscv/include/asm/alternative.h:11,
>                     from arch/riscv/include/asm/errata_list.h:8,
>                     from arch/riscv/include/asm/tlbflush.h:12,
>                     from arch/riscv/include/asm/pgtable.h:108,
>                     from arch/riscv/include/asm/uaccess.h:12,
>                     from include/linux/uaccess.h:11,
>                     from include/linux/sched/task.h:11,
>                     from include/linux/sched/signal.h:9,
>                     from include/linux/rcuwait.h:6,
>                     from include/linux/percpu-rwsem.h:7,
>                     from include/linux/fs.h:33,
>                     from include/linux/compat.h:17,
>                     from arch/riscv/include/asm/elf.h:12,
>                     from include/linux/elf.h:6,
>                     from include/linux/module.h:19,
>                     from include/linux/device/driver.h:21,
>                     from include/linux/device.h:32,
>                     from include/linux/dma-mapping.h:7,
>                     from include/linux/dma-direct.h:9,
>                     from arch/riscv/mm/dma-noncoherent.c:8:
>    arch/riscv/mm/dma-noncoherent.c: In function 'arch_sync_dma_for_device':
> >> arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')' before '__nops'
>      128 |         __nops(6),                                                      \

As the error suggests, the zicbom assembly uses the newly introduced nops
macros for better readability, so I guess in Palmer's tree they should sit
on top of the riscv-nops branch.

Heiko


