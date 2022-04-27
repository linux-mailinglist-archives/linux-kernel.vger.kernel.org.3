Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAACD511600
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiD0LB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiD0LBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:01:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF12C8C2E;
        Wed, 27 Apr 2022 03:46:49 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOm9H-1nVh3d2eJr-00Q8kt; Wed, 27 Apr 2022 11:37:30 +0200
Received: by mail-yb1-f174.google.com with SMTP id m128so2318775ybm.5;
        Wed, 27 Apr 2022 02:37:30 -0700 (PDT)
X-Gm-Message-State: AOAM5300N9y4NIA3ZxiFB/HOsO0zUvGEV3wrP8+da6a7nms/KtAHgCig
        eswCwv7bdFeWygj5ZNOd704c5ck1zZROp7LNgwY=
X-Google-Smtp-Source: ABdhPJwMD5Lw3Bh3sc+tRxCDiyxDUA/bVOD95lZnoBKjAv6b5qPuX9adwocawLYlqU46kbpYQGayPpUktNNEeSX9iGg=
X-Received: by 2002:a25:d3c2:0:b0:645:74df:f43d with SMTP id
 e185-20020a25d3c2000000b0064574dff43dmr24429740ybf.394.1651052249361; Wed, 27
 Apr 2022 02:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com> <YmkBAsa+fKlp/GcV@atomide.com>
In-Reply-To: <YmkBAsa+fKlp/GcV@atomide.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 11:37:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
Message-ID: <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
To:     Tony Lindgren <tony@atomide.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3EX3mYX6KEXjhQgHkDZWS3QeX8xjxcCpdZo4zBbMrRE7iXkjm6H
 JTOhu01vRZPmjNAeyADH7vVynVZ4tq98tHTNlPIgZmvMdMI1mK1vZQToaK1kFybINhrUNA0
 wJyyiLZzm2DDDU2iZyFtb7X12UzqaH2U+yvLF116ouy2iU+E0M6eju9Y8YQBHL7kRMGkXEQ
 FxgV9rsIkBoxAuXlw8FPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fjivupKgZ08=:3In3UonnUB55Oqi5Tc3nXz
 XcTywYTLQ2S8ISSHeggOzNFcNYVHW6RNG36hUP78VkiJhvXj+S1zvDyC+WIxWpj/c/wrm0Bhq
 X73qSZkaRDR0PpOIkeEE03t0SeZehUG83OeKZetTRCf00UM40ft+K6DggXwwuL9YSiAXmHL7g
 uAumSa5RF06J374r530FGWOPIqq9sJKLq76Pl+F2+1vGsRKAeiN89zgaQYW9l/ThX/vI3jLBe
 riDlpNc400kyiF/o/1//hr+TRHoQok4aUrQbTDChdGVWbb51CKsO356UlLYCYDdCtDnuwG+4a
 Ei5knPERLepkZBYYgmGMqtSIpo+9CKo7S1XZP2UltQUizbUdBPJE6JyaTYLnovZoKawcf8okI
 LLdQWaBWIlxwRdFQ27HvxKlvidAzSQKL7TRzdVnOSKRO6EPzG4VhGYZEjOUp7Q8k7OKUY+6f+
 xE1kfrBPVrBNtzzvLQj35w6DJNGJs+zMoqPDdkmVlPHS1ybWgpkq/bHqkVzMkPedZF3FhS4PH
 3IJ19gEOBgud7kE0F1Pf+w3mmU88JllCytg++IIiE+Cb5jzNpFAtmuFDIA6b2fOKoh4dBkiFD
 7/kE1PmvEw6oWcVmbXZ45cNgJHCnRzpshr0JvAqhAX2qS1YkGD2T9xJ6JamvN1mwXO+UJ6UGX
 pcpUhxhA+tyoD4XAAy66BLnXkYhQw/w3gXBlMdNRCmiiPS3tCENZsOvqBpYP3t3AwLWE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:38 AM Tony Lindgren <tony@atomide.com> wrote:
> * H. Nikolaus Schaller <hns@goldelico.com> [220426 20:16]:
> > [   28.245727] [<c0100b60>] (__irq_svc) from [<c0905de0>] (_raw_spin_unlock_irq+0x20/0x4c)
> > [   28.254150] [<c0905de0>] (_raw_spin_unlock_irq) from [<c0902e94>] (do_wait_for_common+0xa8/0x138)
> > [   28.263488] [<c0902e94>] (do_wait_for_common) from [<c0902f54>] (wait_for_common+0x30/0x48)
> > [   28.272277] [<c0902f54>] (wait_for_common) from [<c074edf8>] (mmc_wait_for_req_done+0x1c/0x90)
> > [   28.281341] [<c074edf8>] (mmc_wait_for_req_done) from [<c075a72c>] (mmc_io_rw_extended+0x1c0/0x2f4)
> > [   28.290893] [<c075a72c>] (mmc_io_rw_extended) from [<c075bd00>] (sdio_io_rw_ext_helper+0x118/0x140)
> > [   28.300415] [<c075bd00>] (sdio_io_rw_ext_helper) from [<c075bdd0>] (sdio_memcpy_toio+0x18/0x20)
> > [   28.309570] [<c075bdd0>] (sdio_memcpy_toio) from [<bf3de1ec>] (wl1251_sdio_write+0x34/0x54 [wl1251_sdio])
> > [   28.319702] [<bf3de1ec>] (wl1251_sdio_write [wl1251_sdio]) from [<bf40fc8c>] (wl1251_set_partition+0x90/0x404 [wl1251])
> > [   28.331207] [<bf40fc8c>] (wl1251_set_partition [wl1251]) from [<bf4074ec>] (wl1251_init_ieee80211+0x1c0/0x3dc [wl1251])

I think the problem is here: wl1251_set_partition() passes a local
stack variable into
an SDIO API function that is given to the hardware. This was never
safe and could
cause a corrupted stack because of the cache management, but with vmap stacks
it turns into a reliable DMA error, which I guess is what the l3
interrupt is about.

Can you change wl1251_set_partition() to use kmalloc()/kfree() to allocate the
partitions[] array? You said that it still crashes without the wl1251
driver, so I assume
there is at least one more related bug. If you get a different call
chain without the
driver, or with the kmalloc() call, can you post that as well?

       Arnd
