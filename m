Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D253B446
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiFBHYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiFBHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:24:11 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6E21F89B5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:24:10 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id b11so3063125qvv.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ttVAIF+wGdlpO6DJPONxYdz8jQOa/xA/mWMkzgLc+k=;
        b=i1JVUX3cz/n2GsXywle01OODLA+GfjUzq6BDzd4AQT3wzGfyOiNnsxsnOg4yABuTLo
         KROdI/fd8jitYEtuKwfJU1lSyda+QQs4ROEvFW367Il6MnsIf+1ZEE3k6lwyi2edRjfe
         ZO9hWGzCdzYuEPeRNBaoswHpt/PmtscCAw2244Hr280ibRNWCX06JC7vBumF93BzjlJZ
         vDhcvDVXMIyDp0aeMfXEBR1GTVD73GVkB6t70yXPtXL2/c2jToxvJSCufj3zMVjrp8/7
         9BZTDNvolPwixcUPuBVWQRSsZsYuSTPryYsQLKAnpLTzvKVy+0hwJSBH4srWlQJqVIT1
         1BGA==
X-Gm-Message-State: AOAM533DRwymzSf0nTD+G5n4eaWocTsFK3E8W7DKZuQR7fxPEHRpG8aI
        OmWx3xHnAs3Y/lxOGEsP5RSmv37d5JTYQg==
X-Google-Smtp-Source: ABdhPJytipfFLDy2h19EIonsUpbH8SIyWKo/rM+ICPk/kL+ymMfZxih8YaTtrif/PRdHFJR6I+didA==
X-Received: by 2002:a05:6214:242d:b0:462:65b0:d129 with SMTP id gy13-20020a056214242d00b0046265b0d129mr33434050qvb.8.1654154649370;
        Thu, 02 Jun 2022 00:24:09 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a040200b0069fd12a957bsm2688325qkp.17.2022.06.02.00.24.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 00:24:09 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id e184so6852798ybf.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:24:09 -0700 (PDT)
X-Received: by 2002:a25:cc53:0:b0:65c:b19c:fac1 with SMTP id
 l80-20020a25cc53000000b0065cb19cfac1mr3588936ybf.89.1654154648804; Thu, 02
 Jun 2022 00:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <202205310707.ppwnnzce-lkp@intel.com>
In-Reply-To: <202205310707.ppwnnzce-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Jun 2022 09:23:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvE=TtqHLOgcdpKGzYgg4JeBcB7YGRBq0qubFxYepULg@mail.gmail.com>
Message-ID: <CAMuHMdWvE=TtqHLOgcdpKGzYgg4JeBcB7YGRBq0qubFxYepULg@mail.gmail.com>
Subject: Re: arch/m68k/68000/ints.c:82:30: error: 'ISR' undeclared
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 5:44 PM kernel test robot <lkp@intel.com> wrote:
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
> commit: 6b8be804ff376f6657ccdf6b29974e7c793d88c4 m68knommu: fix 68000 CPU link with no platform selected
> date:   6 days ago
> config: m68k-buildonly-randconfig-r004-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310707.ppwnnzce-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6b8be804ff376f6657ccdf6b29974e7c793d88c4
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6b8be804ff376f6657ccdf6b29974e7c793d88c4
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/68000/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/m68k/68000/ints.c:77:6: warning: no previous prototype for 'process_int' [-Wmissing-prototypes]
>       77 | void process_int(int vec, struct pt_regs *fp)
>          |      ^~~~~~~~~~~
>    arch/m68k/68000/ints.c: In function 'process_int':
> >> arch/m68k/68000/ints.c:82:30: error: 'ISR' undeclared (first use in this function)
>       82 |         unsigned long pend = ISR;
>          |                              ^~~
>    arch/m68k/68000/ints.c:82:30: note: each undeclared identifier is reported only once for each function it appears in
>    arch/m68k/68000/ints.c: In function 'intc_irq_unmask':
> >> arch/m68k/68000/ints.c:135:9: error: 'IMR' undeclared (first use in this function)
>      135 |         IMR &= ~(1 << d->irq);
>          |         ^~~
>    arch/m68k/68000/ints.c: In function 'intc_irq_mask':
>    arch/m68k/68000/ints.c:140:9: error: 'IMR' undeclared (first use in this function)
>      140 |         IMR |= (1 << d->irq);
>          |         ^~~
>    arch/m68k/68000/ints.c: At top level:
>    arch/m68k/68000/ints.c:153:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
>      153 | void __init trap_init(void)
>          |             ^~~~~~~~~
>    arch/m68k/68000/ints.c:172:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
>      172 | void __init init_IRQ(void)
>          |             ^~~~~~~~
>    arch/m68k/68000/ints.c: In function 'init_IRQ':
> >> arch/m68k/68000/ints.c:176:9: error: 'IVR' undeclared (first use in this function)
>      176 |         IVR = 0x40; /* Set DragonBall IVR (interrupt base) to 64 */
>          |         ^~~
>    arch/m68k/68000/ints.c:179:9: error: 'IMR' undeclared (first use in this function)
>      179 |         IMR = ~0;
>          |         ^~~

If M68000=y, but none of M68{,EZ,VZ}328 are enabled, ISR and IMR are
not defined. Most of the code in arch/m68k/68000/ints.c is specific
to the '328 series, and does not apply to plain 68000, but we can't
just not compile ints.c, as we do need definitions of trap_init()
and init_IRQ().
Factor out the '328 parts in dragonball.o, and keep a __weak dummy
init_IRQ() in ints.c?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
