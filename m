Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB44AC526
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381070AbiBGQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiBGQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:10:00 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01EFC0401E4;
        Mon,  7 Feb 2022 08:09:49 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id v5so12490976uam.3;
        Mon, 07 Feb 2022 08:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LwQeVOnQCWNpFLdo7pqlk7xaw1LpJP48h0uOFcXbfc=;
        b=VzZP4Mdb3FGOa4Hfy6vTcrIQdbXzvLMd3jiy5F+41UVvUPJrUvmY16Ya5LguYUkRfv
         35Hk60iGjFsC78tQn4VFPxu/rYkB9u2jECJWlyI4vnwKRVcz+WxRQ75i3EQ1O7IwJ7tJ
         2ntgBDJ4HlYsSbl+px3xBSbCNKyE/gFyP6Vd60lOlaE6mqs1B7Y+o6aWg4RUQ479PyXp
         NEsdP+Ll9tRL06jI8jUQyNARKiLexfBgR42Ax1rI6ldIXH+Ko+FS7QJsnsjpCrK+xgok
         t5fh5GMG9vJ17JmKIrSh6klSPgx/Dv8YWUCUgXIauGRpo9AwOsaYbFnOpaph84oMvJIr
         mvtg==
X-Gm-Message-State: AOAM532kPYISmIP9JyKkEm2MmGFVCHYGGdloenY2QLlrJkGy9x5C0AKE
        SEdIcThVWIZeUb86noZi9K2x9+N3ukSXFw==
X-Google-Smtp-Source: ABdhPJwI7bkbhXaqE1tEo833VGDq+q3xVaz5GnddKM124z5UNJJiTC6lCJIq1PxSEsC4KrQFWsLKOA==
X-Received: by 2002:ab0:2317:: with SMTP id a23mr130088uao.0.1644250189066;
        Mon, 07 Feb 2022 08:09:49 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id q69sm2372697vka.21.2022.02.07.08.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:09:48 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id v62so146019vsv.4;
        Mon, 07 Feb 2022 08:09:48 -0800 (PST)
X-Received: by 2002:a67:fd63:: with SMTP id h3mr40171vsa.77.1644250188406;
 Mon, 07 Feb 2022 08:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20220204161806.3126321-1-jjhiblot@traphandler.com> <20220204161806.3126321-4-jjhiblot@traphandler.com>
In-Reply-To: <20220204161806.3126321-4-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 17:09:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMtYtJB7Kix7+-a0tsoyhbL6Cby7cMLLr8rpH_ZTza-w@mail.gmail.com>
Message-ID: <CAMuHMdWMtYtJB7Kix7+-a0tsoyhbL6Cby7cMLLr8rpH_ZTza-w@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: watchdog: renesas,wdt: Add support for RZ/N1
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Jean-Jacques,

On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> Describe the WDT hardware in the RZ/N1 series.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -19,6 +19,9 @@ properties:
>                - renesas,r7s9210-wdt      # RZ/A2
>            - const: renesas,rza-wdt       # RZ/A
>
> +      - items:
> +          - const: renesas,rzn1-wdt # RZ/N1

I think it would be good to have an SoC-specific compatible value
("renesas,r9a06g032-wdt") in addition to the family-specific one.

> +
>        - items:
>            - enum:
>                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
