Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF34C6F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbiB1Oa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiB1Oa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:30:27 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C60205E4;
        Mon, 28 Feb 2022 06:29:48 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id j3so13132730vsi.7;
        Mon, 28 Feb 2022 06:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIZGnNuIjRVnOMCIxCe09/h7+TXA28klhRieWOlvBIw=;
        b=uApTsUYgSdAflevYV88oAavFgTGBb9YEmM1a7OvStMVDe4/NA/oturbqzQyFbyOA0x
         oDus6x0rwj2H7xTuKJQnOezJc70c7FbBnOaOAIf/b3ezhH2NTmz0sRWKEsqOi4qz75MW
         NwRur36hVmyBPs2U/fTnrEv3UE93EL9RpDPv3OA+7v6AG+eSmv9LsWMLyLHsLY1UK4u1
         VBsiLXoUOXzXNGn9D1QJ7Uk5TuJlOL892si0PigeVozbuz9duzaYNStcVoL8nxCrzKlf
         0zUK4KhCP1IWjxkcpRrz1IN1zLPU0MTXqdogYsPN0ZI4Rwr+Bfiy47eSDC8yV4h2/H3z
         VgHw==
X-Gm-Message-State: AOAM532JctsPPiyUXhp6amSyWAPzIU55F5ssSpqJ1xdY45vF+wSmddVY
        tCAX3Q+VFKHr1apP55iWyKZTvu9W6m3b7A==
X-Google-Smtp-Source: ABdhPJy9AS0ikznuTIZ3qOuexN0/jlnKiS+bmfv4mVabM0Q2l5TmU1Lkr/+cIqrrvl3462PtiX2xww==
X-Received: by 2002:a05:6102:a12:b0:31b:fc56:c7c4 with SMTP id t18-20020a0561020a1200b0031bfc56c7c4mr6606277vsa.49.1646058587529;
        Mon, 28 Feb 2022 06:29:47 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id y20-20020a67bd14000000b0031b7f381562sm1347554vsq.7.2022.02.28.06.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:29:46 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id k15so5202900vkn.13;
        Mon, 28 Feb 2022 06:29:46 -0800 (PST)
X-Received: by 2002:a05:6122:130d:b0:333:33a4:52a9 with SMTP id
 e13-20020a056122130d00b0033333a452a9mr2110022vkp.33.1646058586351; Mon, 28
 Feb 2022 06:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:29:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1J=S+LczVXy3cmWEkRV4U_WffAuxTTReeLAJ8rpacjQ@mail.gmail.com>
Message-ID: <CAMuHMdX1J=S+LczVXy3cmWEkRV4U_WffAuxTTReeLAJ8rpacjQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
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

On Sun, Feb 27, 2022 at 11:53 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L WDT bindings. RZ/V2L WDT is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-wdt" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSI changes have been posted as part of series [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-9-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index 91a98ccd4226..26c7a152ff98 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -22,6 +22,7 @@ properties:
>        - items:
>            - enum:
>                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
> +              - renesas,r9a07g054-wdt    # RZ/V2L
>            - const: renesas,rzg2l-wdt     # RZ/G2L

Please drop the comment on the previous line.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
