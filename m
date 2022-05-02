Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA738516EE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384721AbiEBLbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384719AbiEBLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:31:18 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360513E23
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:27:49 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 242BRMTj031467
        for <linux-kernel@vger.kernel.org>; Mon, 2 May 2022 20:27:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 242BRMTj031467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651490843;
        bh=jRIYi0K/zXrncbt7rG02dALfK/eGcYU2kRYa0B8Stt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cVBg9HlKk3ruwhOY/GFYGkF3SnRDC9FGk56vxfHM6gZmV636bKMbRtzIXcg9YrHbs
         AQMRePWqD0iafJhGBxUg+L1YY0GXSi4Nur+vqDke3L4dfghs5a2rVKha4W1fJK5qLO
         eeszXAGFlnZXLcTJp0oq7SkH/2fLgQdDHtP9kjt8NL0LkQOopiDf+KFlrJ119VmZG0
         BBPFuEi5Yu8mjQCizXhUfd8hj9w2300tVIKT5pKkBj5spxXRZc3FDJ33+MpLWC8XJ3
         sVvGHlbNC8aF6XpGon8GwW1Yte/7eDl2hozlDec91BYNG1qDYXBfz7qBlTNBMfV/4Y
         NCbcqcTs1vy9g==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id k1so3616818pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 04:27:22 -0700 (PDT)
X-Gm-Message-State: AOAM531A7Chq2SQKlgbUz1NT5RyYiUVaMqwSzu6NmgHe2yOUREPao7PM
        mEFGQ/Yg4G5JzfDsnVohiKSWvYNzwZS3jpd9aHY=
X-Google-Smtp-Source: ABdhPJxPmiNjTbkZ5ORDpWpTcCe8fvXO0EY0VtkkcMJcO157hziUiL1uEE/25A5KVgrKfTdLtP+uhiWraqAMectCbiE=
X-Received: by 2002:a17:902:bf07:b0:158:d334:852f with SMTP id
 bi7-20020a170902bf0700b00158d334852fmr11419010plb.136.1651490842179; Mon, 02
 May 2022 04:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <202205020142.tuVjG3mE-lkp@intel.com>
In-Reply-To: <202205020142.tuVjG3mE-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 2 May 2022 20:26:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6sQ0+9qWz8Xi8P9x8Hszpq_KBsqSfZJbO64-ZnvaCiA@mail.gmail.com>
Message-ID: <CAK7LNAS6sQ0+9qWz8Xi8P9x8Hszpq_KBsqSfZJbO64-ZnvaCiA@mail.gmail.com>
Subject: Re: [masahiroy:lto-cleanup-v2 48/55] s390-linux-ld:
 .tmp_vmlinux.kallsyms1: warning: allocated section `.rodata' not in segment
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 2:31 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git lto-cleanup-v2
> head:   0f0c2c6e09ad55e3c5ddb69915460ee54eb913e4
> commit: 58024b1713c48e2cc450f3301fc48077638298cc [48/55] kbuild: embed symbol versions at final link of vmlinux or modules
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220502/202205020142.tuVjG3mE-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=58024b1713c48e2cc450f3301fc48077638298cc
>         git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>         git fetch --no-tags masahiroy lto-cleanup-v2
>         git checkout 58024b1713c48e2cc450f3301fc48077638298cc
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash


Hmm, OK.
CONFIG_MODULE_REL_CRCS needs more effort.

I will fix it in v3.
Thanks for the report.







> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> s390-linux-ld: .tmp_vmlinux.kallsyms1: warning: allocated section `.rodata' not in segment
>    s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
>    coherent.c:(.text+0xea): undefined reference to `memremap'
>    s390-linux-ld: coherent.c:(.text+0x1f8): undefined reference to `memunmap'
>    s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
>    coherent.c:(.text+0x5e4): undefined reference to `memunmap'
>    s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
>    irq-al-fic.c:(.init.text+0x7a): undefined reference to `of_iomap'
>    s390-linux-ld: irq-al-fic.c:(.init.text+0x4f4): undefined reference to `iounmap'
>    s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
>    clk-fixed-mmio.c:(.text+0x90): undefined reference to `of_iomap'
>    s390-linux-ld: clk-fixed-mmio.c:(.text+0xcc): undefined reference to `iounmap'
>    s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
>    timer-of.c:(.init.text+0x144): undefined reference to `of_iomap'
>    s390-linux-ld: timer-of.c:(.init.text+0x76e): undefined reference to `iounmap'
>    s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
>    timer-of.c:(.init.text+0x968): undefined reference to `iounmap'
>    s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
>    timer-microchip-pit64b.c:(.init.text+0x684): undefined reference to `of_iomap'
>    s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0xcda): undefined reference to `iounmap'
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
Masahiro Yamada
