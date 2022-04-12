Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993114FD923
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376517AbiDLItk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357791AbiDLHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:40:44 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281B13969F;
        Tue, 12 Apr 2022 00:16:56 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id j21so18588456qta.0;
        Tue, 12 Apr 2022 00:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxaeyf8gbGoNuQoaq4wl2Y+6pdc5/JQoS19NqHJuW/8=;
        b=iRvVNJemv7HdIvuRfYvUWK0WCNbRqTJJhvq/STsNeUg9tpISFov480jvE+GxLuP3kE
         Yyc/zjoRd5UDjdGJwh9rV0E8Er7Fr4xRgVAlD68t+19MtkP7V99WKJnAywX1MqURo5hN
         29Rfw4L393EXGBVDszFMECHNIMswd39SYkoAmEooyhadvgIeLMgM9P7+DEIHPJ6+yC7P
         i2DPWbitfn6WppzY27kE0loo7gtg3Nw3RZ9xyLJEJFwzsMzep2IBVGkLMkx0aJrhx2Z7
         szvB+8xCD21yhzTb0wX4WETt9w19p0q+Y4gEWfkJc4xSyimg6blnyNnrMvavnBpp+8lg
         VEmQ==
X-Gm-Message-State: AOAM531lgq+WfkGNy2Am1LBlxiqTxak2gVJu1rHUN8or1ju8qCwA93Pt
        dv+OHgWwZjMqTaiylZ0aChaFTE+tEFV13lJt
X-Google-Smtp-Source: ABdhPJxzUcqZ/MqWhFtJw2JLntJeRwr7dGif60jZt68cheskfjc+q1NcLgxFTZwKq9tzQC264NmA6Q==
X-Received: by 2002:a05:622a:64b:b0:2e1:cbc3:c9ff with SMTP id a11-20020a05622a064b00b002e1cbc3c9ffmr2300195qtb.226.1649747814528;
        Tue, 12 Apr 2022 00:16:54 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 203-20020a370ad4000000b0069bd97f4f1asm8014629qkk.77.2022.04.12.00.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:16:54 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ec04a2ebadso71624157b3.12;
        Tue, 12 Apr 2022 00:16:53 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr29212275ywb.132.1649747813680; Tue, 12
 Apr 2022 00:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211243.11121-1-javierm@redhat.com> <20220411211243.11121-3-javierm@redhat.com>
In-Reply-To: <20220411211243.11121-3-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:16:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuivPSRooR5CqTX6GQtxO6RQYwKUqfOK36zsiN8-v6kg@mail.gmail.com>
Message-ID: <CAMuHMdVuivPSRooR5CqTX6GQtxO6RQYwKUqfOK36zsiN8-v6kg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Extend schema for
 SPI controllers
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
> add to the schema the properties and examples for OLED devices under SPI.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>
> Changes in v2:
> - Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven).

Thanks for the update!

> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -39,9 +39,14 @@ properties:
>    reset-gpios:
>      maxItems: 1
>
> +  dc-gpios:
> +    maxItems: 1
> +

Perhaps add a description, and clarify this is for SPI only?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
