Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C273F4C6FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiB1Oph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiB1Opg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:45:36 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD07EDBD;
        Mon, 28 Feb 2022 06:44:57 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id j12so5295021vkr.0;
        Mon, 28 Feb 2022 06:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZf1H7GYaeLjTRdSqHGS1EgfqY4ooJ9YGpVnJ607bP4=;
        b=4pd4EC0pHZx4YDLJsNveLKDmHsLZaL4JKTQ4HVUNLjz+MhfZoQDefnx+JdzLxdLu6O
         EjuBCUxEnOqPBdSWLoieOp0n6SUkkonPgA9sS0lbRNYtncYzhfpEuntiUzSanQx/gi/O
         K49ZSSkneVbgQMuQAOzEKJxrj9Q0Sm+gTIMQ2PoC489/OH7qW1DfCvb0mxoFhlC/zqRW
         SN1q6DyVf35QGKQrO+++TwmtLuyU72LXva7tTPV1Z4EA//n+ac13ojl8awccmvCL3dv3
         TABBXNFJ8FuK+/y/eKsjDuRoUe5JdsyJv7yW5I3D5JU1uRQv3ddoCQpv2yL4IFIEwWOi
         MBQw==
X-Gm-Message-State: AOAM533CMjQfqsu89Oawpl2ucqWnBzWb8ITk52u4exgw8TgvmdyDNNRV
        vrHAJG5FrJ7QUf0YciZnnPY6io9DgOjlpg==
X-Google-Smtp-Source: ABdhPJy4O6PbWoUlc8He8CnUjvvqosfQ4RTUW5Pxt2hppOULNzJvLBQ/eOygyLkTV3NVvxwPhsm3Xw==
X-Received: by 2002:a05:6122:1350:b0:32d:831a:f0db with SMTP id f16-20020a056122135000b0032d831af0dbmr8059940vkp.2.1646059496914;
        Mon, 28 Feb 2022 06:44:56 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id b13-20020a67b34d000000b0031b582439e3sm1325345vsm.5.2022.02.28.06.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:44:56 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id e26so13210596vso.3;
        Mon, 28 Feb 2022 06:44:56 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr7654839vsl.68.1646059496160; Mon, 28 Feb
 2022 06:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:44:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKtaCzPN-z6S01nLgYoTZKpXC6422ZsZd6=7++Tez_8A@mail.gmail.com>
Message-ID: <CAMuHMdXKtaCzPN-z6S01nLgYoTZKpXC6422ZsZd6=7++Tez_8A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
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

On Sun, Feb 27, 2022 at 11:56 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L SSI bindings. RZ/V2L SSI is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-ssi" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
