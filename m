Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE95515EB6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbiD3Pjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiD3Pjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:39:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81508BE37;
        Sat, 30 Apr 2022 08:36:27 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJW18-1nQxsH3phg-00Jrrc; Sat, 30 Apr 2022 17:36:26 +0200
Received: by mail-yb1-f177.google.com with SMTP id i38so19282348ybj.13;
        Sat, 30 Apr 2022 08:36:25 -0700 (PDT)
X-Gm-Message-State: AOAM531z+MGdWa6hEOfZuDFmLdlXvB1dVtCYNEqN2DLo6KKFMaIaSsuH
        lLp1pwbO/pVUkn9tMjxkQEvpZM0kK5FbYD58JTc=
X-Google-Smtp-Source: ABdhPJyfO2PwrQxkf+Me5M4uGKwEX41QhXuja2/xtRLD/hamtl5IFskaDXBjhEc5vusFgYirAEWEpRJRn31ba9P226k=
X-Received: by 2002:a25:75c5:0:b0:648:dccd:e1c with SMTP id
 q188-20020a2575c5000000b00648dccd0e1cmr4140516ybc.452.1651332984537; Sat, 30
 Apr 2022 08:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
 <YmkBAsa+fKlp/GcV@atomide.com> <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
 <4CE23DC3-B3E5-45C1-91F3-B88E5444AE7C@goldelico.com>
In-Reply-To: <4CE23DC3-B3E5-45C1-91F3-B88E5444AE7C@goldelico.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 17:36:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3EFfF0gr5kFkboRfJifrY-D+NgHFekBfSePWuY2c8PMA@mail.gmail.com>
Message-ID: <CAK8P3a3EFfF0gr5kFkboRfJifrY-D+NgHFekBfSePWuY2c8PMA@mail.gmail.com>
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JlrKGN8Fic+R2akaznm9YXKoQRNpECTSE78DMBHrlqXmXY/KXX3
 ju4P2qBS9WSNX1RafAHuY2w7wxrfSzB2buOHMnxTcZSkbG2ONZt7bm88c4gLryRQAHTkkLF
 FSZ+DYTdljKC2HeFwT/QVMFizEzlWBnOGaiFzRXvA/dzuwS0vTBXdNNtnP/hlxliLUw1BVa
 485hbUY2T1ny0C/Zfjqdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:spD3M0MSaGY=:Djd7R4ic291cJ80QEu8iAT
 iMN/7/xzfwsjhtqUeEIExGvoKqmBU7fVK84CWwRYIQeRUZ6W27j0UFFa8MqRb2vuMWchmDLyl
 Z7r+RjDkWcpsSAj0i0BYupBNuzqvzfOcFCYVQAKS8wdSJgGPR1JInP0EyzxW1tV1LrpaagOOL
 xIAeaC+i94FJ51hLUpgrYOXaKhjU7D2MzR/utBwuE19IP8DGRVwBq912+GlB6IIPsRoblTTzT
 PWKkS17N5H+miGK5GVVt2KykbOHDAGpQTiDwgdE/UR5ZHyAfyDwx6Um7lWXsbsT9bqcmhGthU
 NYcX8r1+BVywL0fJBEmRHgDviFPi9K0tUbuoZ6kvySBMfurKwKAfx56BsN5433ud914QyxFN8
 EDSVbtu1WBGuFmCTfaR/PvtnAoiulhR8cJO4HGnE20EkWgq7oisRH+vIBg1I32wamgW3rFsYB
 ahJspRuqmIWiGvEg8RFaFNde7XH5peZHkCaZ+bKwqKX1v+Fu1Liex6twnqzKTcgm+6En4jD2a
 pVXhP0IULUhQcyfTAbsL0WgTLdn7ZhpkqnqdSvB5Hr+flC3aM8kSVchiWo8anoIRGSAXLVAEG
 8FFv4lXceHoCxD2wuDSYh07/Uja9THJ9fFGVSlzhl0YHlifJfhazS3cLUYiqRO9V+2uXhZY3M
 r2uUOp5AK27GKnKxCuJgwaozpKmLkfx9m9KttfSGvLVcmiQ1nT94cRjDz4Y6O2oIjkd9SB10C
 p/0nV5s3F+joxtwDej8ms3Mvv/XFeklp9VKeEX+L68/uFTTeVjDXA+VJ5YsLku8KEDJnDE07b
 188DZjfdCdluKRT2utk7zm7k1zkwJF6WWJ/hicPIfFgtoFZyjs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 3:16 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> > Am 27.04.2022 um 11:37 schrieb Arnd Bergmann <arnd@arndb.de>:
> > On Wed, Apr 27, 2022 at 10:38 AM Tony Lindgren <tony@atomide.com> wrote:
>
> > You said that it still crashes without the wl1251
> > driver, so I assume
> > there is at least one more related bug. If you get a different call
> > chain without the
> > driver, or with the kmalloc() call, can you post that as well?
>
> For some time it did disappear but reported  e.g.
>
> [   29.457946] omap_hsmmc 480ad000.mmc: found wl1251
> [   29.516174] wl1251: ERROR unsupported chip id: 0xdb0aea56

That does point to invalid DMA addresses.

> (value did change a little randomly), but just before sending out this mail I tried
> again (now with v5.18-rc4) and got this log (with wl1251 driver fixed as below):
>
> [   31.069580] 1ec0: 00000000 c11198c0 c103226c 0000001a 00000000 c017d654 c1032200 c37c0a40
> [   31.078155] 1ee0: 00000000 c1032200 c103226c c1032218 e0001f84 c0c77370 c37c0a40 c0def3c0
> [   31.086761] 1f00: c0d02080 c017d78c c1032200 c103226c c1032218 c017d7f0 c1032200 c103226c
> [   31.095336] 1f20: c1032218 c0181ee0 e0001f50 00000000 ffffffff c017cf6c e0001f50 c08b4d7c
> [   31.103942] 1f40: c01013c4 600f0113 ffffffff c0100bec c37c0a40 c0c7e6c0 00000000 1ed15000
> [   31.112548] 1f60: c0c7e6c0 c0c7e6c0 00000040 c0d02d00 c0c77370 c37c0a40 c0def3c0 c0d02080
> [   31.121154] 1f80: c0c7d850 e0001fa0 c0101390 c01013c4 600f0113 ffffffff 00000051 c0101390
> [   31.129730] 1fa0: e01b9e94 c37c0a40 c37c0a40 00400000 0000000a ffff96d9 c1037850 c0c7e6c0
> [   31.138336] 1fc0: c0d02d00 c0c7e6c0 c37c0a40 c37c0a40 600f0113 ffffffff e01b9e94 c37c0a40
> [   31.146911] 1fe0: c37c0a40 e01b9f60 e01b9e58 c0137314 c0158434 c013740c c0158434 c04c9c6c
> [   31.155517]  omap3_l3_app_irq from __handle_irq_event_percpu+0xb0/0x1dc
> [   31.162475]  __handle_irq_event_percpu from handle_irq_event_percpu+0xc/0x38
> [   31.169891]  handle_irq_event_percpu from handle_irq_event+0x38/0x5c
> [   31.176605]  handle_irq_event from handle_level_irq+0x7c/0xb4
> [   31.182647]  handle_level_irq from handle_irq_desc+0x1c/0x2c
> [   31.188629]  handle_irq_desc from generic_handle_arch_irq+0x28/0x3c
> [   31.195220]  generic_handle_arch_irq from __irq_svc+0x8c/0xcc
> [   31.201263] Exception stack(0xe0001f50 to 0xe0001f98)
> [   31.206604] 1f40:                                     c37c0a40 c0c7e6c0 00000000 1ed15000
> [   31.215179] 1f60: c0c7e6c0 c0c7e6c0 00000040 c0d02d00 c0c77370 c37c0a40 c0def3c0 c0d02080
> [   31.223785] 1f80: c0c7d850 e0001fa0 c0101390 c01013c4 600f0113 ffffffff
> [   31.230743]  __irq_svc from __do_softirq+0x84/0x304
> [   31.235870]  __do_softirq from __irq_exit_rcu+0x8c/0xd4
> [   31.241363]  __irq_exit_rcu from irq_exit+0x8/0x10
> [   31.246429]  irq_exit from call_with_stack+0x18/0x20
> [   31.251647]  call_with_stack from __irq_svc+0x98/0xcc
> [   31.256988] Exception stack(0xe01b9e60 to 0xe01b9ea8)
> [   31.262298] 9e60: df993a40 c37c0a40 00000000 00000001 df993a40 c3245000 c133c2c0 00000002
> [   31.270904] 9e80: c37c0a40 00000000 e01b9f60 e01b9edc e01b9ee0 e01b9eb0 c08ba55c c0158434
> [   31.279479] 9ea0: 600f0113 ffffffff
> [   31.283172]  __irq_svc from finish_task_switch+0x12c/0x1ec
> [   31.288940]  finish_task_switch from __schedule+0x3cc/0x558
> [   31.294799]  __schedule from schedule+0x70/0xc0
> [   31.299591]  schedule from do_work_pending+0x30/0x3dc
> [   31.304901]  do_work_pending from slow_work_pending+0xc/0x20
> [   31.310852] Exception stack(0xe01b9fb0 to 0xe01b9ff8)
> [   31.316192] 9fa0:                                     00002cf8 00000000 50000000 b6f99000
> [   31.324768] 9fc0: b6f9bcfc b6f9bcf8 00000000 00000000 00000010 00000000 00001e94 00000000
> [   31.333374] 9fe0: b6f9bcf8 bea66f80 b6f9bcfc 004bfc6a 40070030 ffffffff
> [   31.340332] Code: e0000002 e0011003 e1901001 0a000002 (e7f001f2)
> [   31.346740] ---[ end trace 0000000000000000 ]---


I suppose this could be anywhere then. The backtrace seems to point
to re-enabling interupts in do_work_pending, so something probably
accessed DMA memory asynchronously.


>
> rm -rf lib/modules/5.18.0-rc4-letux+/kernel/drivers/net/wireless/ti/wl1251
>
> done on the SD card makes the problems go away.

Good, so I guess that means there is another bug in wl1251 DMA handling,
while everything else is fine.

> diff --git a/drivers/net/wireless/ti/wl1251/io.c b/drivers/net/wireless/ti/wl1251/io.c
> index 5ebe7958ed5c7..76aceecc281fb 100644
> --- a/drivers/net/wireless/ti/wl1251/io.c
> +++ b/drivers/net/wireless/ti/wl1251/io.c
> @@ -121,7 +121,13 @@ void wl1251_set_partition(struct wl1251 *wl,
>                           u32 mem_start, u32 mem_size,
>                           u32 reg_start, u32 reg_size)
>  {
> -       struct wl1251_partition partition[2];
> +       struct wl1251_partition_set *partition;
> +
> +       partition = kmalloc(sizeof(*partition), GFP_KERNEL);
> +       if (!partition) {
> +               wl1251_error("can not set partition");
> +               return;
> +       }
>
>         wl1251_debug(DEBUG_SPI, "mem_start %08X mem_size %08X",
>                      mem_start, mem_size);
> @@ -164,10 +170,10 @@ void wl1251_set_partition(struct wl1251 *wl,
>                              reg_start, reg_size);
>         }
>
> -       partition[0].start = mem_start;
> -       partition[0].size  = mem_size;
> -       partition[1].start = reg_start;
> -       partition[1].size  = reg_size;
> +       partition->mem.start = mem_start;
> +       partition->mem.size  = mem_size;
> +       partition->reg.start = reg_start;
> +       partition->reg.size  = reg_size;
>
>         wl->physical_mem_addr = mem_start;
>         wl->physical_reg_addr = reg_start;
> @@ -176,5 +182,7 @@ void wl1251_set_partition(struct wl1251 *wl,
>         wl->virtual_reg_addr = mem_size;
>
>         wl->if_ops->write(wl, HW_ACCESS_PART0_SIZE_ADDR, partition,
> -               sizeof(partition));
> +               sizeof(*partition));
> +

Changing the type of the structure looks a bit odd, but it does seem
like a valid transformation otherwise.

I see more callers of wl1251_mem_write() or wl1251_mem_read() with
on-stack arguments in wl1251_tx_complete(), wl1251_event_wait(),
and wl1251_event_handle(). Those will need the same kmalloc()
change as your wl1251_set_partition() fix I think.

If that's not enough, try enabling CONFIG_DMA_API_DEBUG
to get an is_vmalloc_address() check on every DMA operation.

        Arnd
