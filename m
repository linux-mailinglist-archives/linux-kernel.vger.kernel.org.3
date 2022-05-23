Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D875312FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiEWN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiEWN66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:58:58 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46DE5712F;
        Mon, 23 May 2022 06:58:55 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id l1so12145540qvh.1;
        Mon, 23 May 2022 06:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYWALA3lJgoSN00lrVAVMkJgNm+QYBYbKEt1Mc7Ujl4=;
        b=cLcoPu+jy2A84xyELl+PC8QHKnEQom/uR+IZrlblq4jaAQdX5bwIx+YC+v8UuYkKbO
         euvE1owgn5zLGtmYzYKXgXzxoeWkhKISf0CnKf7QAE41WV4i9EfX0aMu8P1ObNUbTpJS
         Bfp3V0VEf7XvxdyFrIYwTVHaQa5GAv8h/v/MicPbw5w+mqNHeGRfpXMoK9a29mFBc6Z4
         WJRHy5d10mxvg+WlGgczVPvWGaCwMx3KxcpsN5rZJHKzCLOCyeb8ugHCiJRP9Ob4uGQW
         M56BlHBCN2Mjgdd5lrws+XYa42sgUDRCXkO0fMl0ddeHqdMkB6+UNj3dZpuf5qtRnjSf
         LRhQ==
X-Gm-Message-State: AOAM530F1GbidAqKZCIzTYHIgQ6K9C64jufU3iPVo6W+yrRev/4xSHJV
        YFS9Kjf5eYBHSkeisttj96rABJShdxRJzw==
X-Google-Smtp-Source: ABdhPJxn+zxXbkpHwy/aXTGgQgtstkKudNX1BtloONutSOmdlVuT2flBdrV+6ozu5wuVLi91JmXlCg==
X-Received: by 2002:ad4:5de6:0:b0:462:180d:7038 with SMTP id jn6-20020ad45de6000000b00462180d7038mr10559956qvb.16.1653314334747;
        Mon, 23 May 2022 06:58:54 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05620a318c00b006a370031c3esm3792652qkb.106.2022.05.23.06.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:58:54 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id q135so25551127ybg.10;
        Mon, 23 May 2022 06:58:53 -0700 (PDT)
X-Received: by 2002:a81:234b:0:b0:2f8:4082:bbd3 with SMTP id
 j72-20020a81234b000000b002f84082bbd3mr23570342ywj.47.1653314322494; Mon, 23
 May 2022 06:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-18-tmaimon77@gmail.com>
 <c1b86493-d82d-a639-07af-4c979d733786@linaro.org>
In-Reply-To: <c1b86493-d82d-a639-07af-4c979d733786@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 May 2022 15:58:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSccO3J5OYrFUn+azKyzYBP1wmuHZoRU2t3PUbkZx1wA@mail.gmail.com>
Message-ID: <CAMuHMdWSccO3J5OYrFUn+azKyzYBP1wmuHZoRU2t3PUbkZx1wA@mail.gmail.com>
Subject: Re: [PATCH v1 17/19] arm64: dts: nuvoton: Add initial NPCM8XX device tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod <vkoul@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, arm-soc <soc@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Krzysztof,

On Mon, May 23, 2022 at 11:08 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 22/05/2022 17:50, Tomer Maimon wrote:
> > This adds initial device tree support for the
> > Nuvoton NPCM845 Board Management controller (BMC) SoC family.
>
> Thank you for your patch. There is something to discuss/improve.
>
> > The NPCM845 based quad-core Cortex-A35 ARMv8 architecture and
> > have various peripheral IPs.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

> > +             l2: l2-cache {
> > +                     compatible = "cache";
>
> Is this a real compatible? What bindings are you using here?

The compatible value and related properties are defined in the
Devicetree Specification, v0.4-rc1, Section 3.9 ("Multi-level and
Shared Cache Nodes (/cpus/cpu*/l?-cache)").

The properties are handled by
dtschema/schemas/cache-controller.yaml, but the latter seems to lack
any checking on the compatible value?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
