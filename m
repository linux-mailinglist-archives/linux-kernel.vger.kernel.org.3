Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97534C700E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiB1Ovy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiB1Ovw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:51:52 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406D80926;
        Mon, 28 Feb 2022 06:51:13 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id i27so13165691vsr.10;
        Mon, 28 Feb 2022 06:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0bDkx+pDmCFcIFIjnwbjmWEdCGXPTLvMWhZp/2Pct0=;
        b=BnhKBZHRblCsZw11e/HoSIQTzpFoWSuPwCBf7hxv+ZHauSfiFgT3ao2JFHXr8LCwKG
         jqnnN6zpMu65obooKiAZ45vGKyiZmV7CoqtV9CwIEdJ6J22sQtKBA29LDO2i/CYmuaop
         nBGPj0Wh8LjK2kCNZu9BY6GwGhsfpZs4Oz020hpwOe7Dr+PCZ/bWYG9LXu9FAudgzzgq
         ggqIgNDubdgHfiv35VsnfRdaZtgt2XwayzTF7Cp0amCe9kPcHCsoZBGHrgWaXVDwHDva
         s3xXGKwtLTpNUx8+b+kXEP5kJ/IHtIJNuSeJC165PbxxYB9zddjn1wwcCCZR/cxPeowb
         RQAg==
X-Gm-Message-State: AOAM533Vtu0gHV4l1aZMs0h/1f06OCSQwOPGxo1xG62HaX4fxiJ2RGHL
        vHRbk5XRlMCfKgnv759M11Nt6V2ujxVl5Q==
X-Google-Smtp-Source: ABdhPJwpYyl7kS9QJRypMWwQ175w15s7TsYWoQeuD6LlOHnuaCubgcyrJ/ls1tP8lQUTCxz0YpiL0A==
X-Received: by 2002:a67:6c81:0:b0:31b:9192:878a with SMTP id h123-20020a676c81000000b0031b9192878amr7208775vsc.35.1646059872435;
        Mon, 28 Feb 2022 06:51:12 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id u27-20020a056122061b00b0032d93970a98sm1659984vkp.53.2022.02.28.06.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:51:12 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id k15so5238512vkn.13;
        Mon, 28 Feb 2022 06:51:11 -0800 (PST)
X-Received: by 2002:a05:6122:130d:b0:333:33a4:52a9 with SMTP id
 e13-20020a056122130d00b0033333a452a9mr2154956vkp.33.1646059871678; Mon, 28
 Feb 2022 06:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:51:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQonLA73FeHaz5xR2q0qTHVwSACD2Hk4_b5i6vnFxx8Q@mail.gmail.com>
Message-ID: <CAMuHMdUQonLA73FeHaz5xR2q0qTHVwSACD2Hk4_b5i6vnFxx8Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] Renesas RZ/V2L add support for SDHI/CANFD/I2C/OSTM/USB2/SBC/RSPI/WDT/SSI
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
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

Hi Prabhakar,

CC Wolfram

On Sun, Feb 27, 2022 at 9:38 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> This patch series adds support for below IP blocks to Renesas RZ/V2L SoC:
> * SDHI
> * CANFD
> * I2C
> * OSTM
> * WDT
> * SSI
> * USB2
> * RPC-IF (SBC)
> * RSPI
>
> The above peripherals can now be operational on Renesas RZ/V2L SMARC EVK
> with this series.

Thanks for your series!

> Note:
> * Im just sending the DTS/I changes as separate series and shall post the
> binding doc changes individually to the corresponding subsystems.
> * Patch 05/12 depends on [0]

Good to know. So I think it would be great if that patch would make
v5.18-rc1, through the i2c tree.

> * For OSTM/SSI/USB to work on RZ/V2L SoC ARCH_R9A07G044 needs to be
> enabled as the corresponding drivers have ARCH_R9A07G044 as dependency
> which I intend to change it to ARCH_RZG2L. This will be updated once patch
> [1] is part of -rc* cycle.
> * Patch series applies on top of [2].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220209232232.18461-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220224092114.25737-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> [2] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20220224125843.29733-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (12):
>   arm64: dts: renesas: r9a07g054: Fillup the SDHI{0,1} stub nodes
>   arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting gpio-hog pins
>     related to SDHI
>   arm64: dts: renesas: r9a07g054: Fillup the CANFD stub node
>   arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting can{0,1}-stb-hog
>     nodes
>   arm64: dts: renesas: r9a07g054: Fillup the I2C{0,1,2,3} stub nodes
>   arm64: dts: renesas: r9a07g054: Fillup the sbc stub node
>   arm64: dts: renesas: r9a07g054: Fillup the OSTM{0,1,2} stub nodes
>   arm64: dts: renesas: r9a07g054: Fillup the WDT{0,1,2} stub nodes
>   arm64: dts: renesas: r9a07g054: Add SSI{1,2,3} nodes and fillup the
>     SSI0 stub node
>   arm64: dts: renesas: r9a07g054: Add USB2.0 phy and host support
>   arm64: dts: renesas: r9a07g054: Add USB2.0 device support
>   arm64: dts: renesas: r9a07g054: Add SPI{0,2} nodes and fillup SPI1
>     stub node
>
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 413 +++++++++++++++++-
>  .../boot/dts/renesas/r9a07g054l2-smarc.dts    |   8 -
>  2 files changed, 390 insertions(+), 31 deletions(-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
