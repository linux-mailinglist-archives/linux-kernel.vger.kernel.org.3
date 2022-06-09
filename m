Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2EE5447AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiFIJga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jun 2022 05:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiFIJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:36:27 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF52F664;
        Thu,  9 Jun 2022 02:36:26 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id 68so8880071qkk.9;
        Thu, 09 Jun 2022 02:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mjax5gcHpDCOdlHkRO1oWqhUAzsN643izB/R7ubf5Zg=;
        b=GROSR0qY7htLnU/CvxIvntRBFqMA8mh2r1A5xvco8n0xwUyHh7HbWwpW7OSx7tQq1b
         PPaFaJZhTOCcrICQNzmLVPGm7vRYnRmXMVpjts2PVQLzbjvKlprKReyXJ6xZCKsq38xt
         m06HDYn5ODOxFN3ReGIowYxIi9IBZNKn6VOhvM6qrMxvafUsjNZkAW3Z1rxEYo90eDN0
         8saQdtAuNyKwURlbw8jDXhAheNCTEvr8H1367VRQiB1U0AtZ/i9+8OVWx0/GfmykDb3X
         lbwBmUMnrkyitTBZ1I1nBsvIiA30LBeb536oDaA6rwtlgfAsABza84qsaLjv58GXoZTE
         wQ2g==
X-Gm-Message-State: AOAM5326o9c0RVH04byjbwCMBJQmxQMYEsogr1U+xaKGmjBR2SxUY4bE
        vFfGzUa/06xbujv+2WFYVmz9OGctHFrDxA==
X-Google-Smtp-Source: ABdhPJx/ca9U/coJuHsLM/PJtLIRaxpk/GnhEK4le13Re5pQvQjUFaap27v0eGGt8/CTK4GRYQtOkQ==
X-Received: by 2002:a37:9e08:0:b0:6a6:a23b:9bbd with SMTP id h8-20020a379e08000000b006a6a23b9bbdmr21126085qke.596.1654767385413;
        Thu, 09 Jun 2022 02:36:25 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id r23-20020ac85e97000000b00304f98ad3c1sm5146062qtx.29.2022.06.09.02.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:36:25 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-313a8a8b95aso987037b3.5;
        Thu, 09 Jun 2022 02:36:24 -0700 (PDT)
X-Received: by 2002:a0d:d481:0:b0:30c:44f1:2721 with SMTP id
 w123-20020a0dd481000000b0030c44f12721mr42235528ywd.283.1654767384522; Thu, 09
 Jun 2022 02:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220608090850.92735-1-clement.leger@bootlin.com>
In-Reply-To: <20220608090850.92735-1-clement.leger@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 11:36:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXACzs8aLgry0ughT4zcU6ZQhL5+SaLPGshXGqNKL88-Q@mail.gmail.com>
Message-ID: <CAMuHMdXACzs8aLgry0ughT4zcU6ZQhL5+SaLPGshXGqNKL88-Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: r9a06g032-rzn1d400-db: enable rtc0
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Wed, Jun 8, 2022 at 11:10 AM Clément Léger <clement.leger@bootlin.com> wrote:
> The RZ/N1D-DB board does have a battery to power the RTC. Enable the
> RTC device on this board.
>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> @@ -31,3 +31,7 @@ &wdt0 {
>         timeout-sec = <60>;
>         status = "okay";
>  };
> +
> +&rtc0 {
> +       status = "okay";
> +};

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20, with rtc0 moved up to
preserve sort order (no need to resend).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
