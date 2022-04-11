Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41224FBDBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiDKNto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiDKNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:49:40 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A86C12090;
        Mon, 11 Apr 2022 06:47:26 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id j6so10617243qkp.9;
        Mon, 11 Apr 2022 06:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCnkeyoKwqeX0JN+o8L5AX58NLvdx+Oy98J9n9irz2I=;
        b=QsVLZhstsbtqMWAt1NlGRARQ+RZOSXCHb/O1auvUcrzaapQ3Saig1NckFJsTSxuiH1
         ELayZrTpkO9f7Gm85athQjc0jKGdS8eRAtWq9Yxz7++0jlorRG6q4tmWwPrvknqZ8w7P
         uqf2Woifk/Xc8qkmPLqYT7/91YKx8Pb/gIItGXqtK/+aCpkS7bK3M66epXLmT6FPGWgc
         oOM7++jylqUC2HF32ajb/30YPmEg2S06gXHGI7l9m4rhyJT4ecVkox2CAcOzD4vmV8ir
         ldKtBd9WVXDcyWihgydhychncmS67Vn1UXyHSSE2BRyBaKJsOrvW0lib4E66E+oDWPvO
         TDaA==
X-Gm-Message-State: AOAM532qtX7tcyKDcZcp7GNLKIBaINU6T5IdZw+wawZs5m941pHp29BC
        NgWpyE/yw0BCHYr2ZgfatdNZp/3t4F1x8w==
X-Google-Smtp-Source: ABdhPJwSgjjIb1LGvAWUwyssIO5dX9zuTvPIMgcCKNCDgMB4ayCF+GdyosCA7XeSglqIP0Ln4BqYqQ==
X-Received: by 2002:a37:aec7:0:b0:69b:f27b:8784 with SMTP id x190-20020a37aec7000000b0069bf27b8784mr8783717qke.464.1649684845151;
        Mon, 11 Apr 2022 06:47:25 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id y20-20020a05622a121400b002eefd7bf5basm1519967qtx.63.2022.04.11.06.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:47:24 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id g34so7639127ybj.1;
        Mon, 11 Apr 2022 06:47:24 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr11998194ybq.393.1649684844325; Mon, 11
 Apr 2022 06:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220407200205.28838-1-javierm@redhat.com> <20220407200205.28838-2-javierm@redhat.com>
In-Reply-To: <20220407200205.28838-2-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 15:47:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGQ6qabs_xD6kQeDruQLG-OX17UEVrgeGu3Eo6C2dEgw@mail.gmail.com>
Message-ID: <CAMuHMdUGQ6qabs_xD6kQeDruQLG-OX17UEVrgeGu3Eo6C2dEgw@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: display: ssd1307fb: Deprecate fbdev
 compatible strings
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Mark Brown <broonie@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Thu, Apr 7, 2022 at 10:03 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The current compatible strings for SSD130x I2C controllers contain an -fb
> suffix, this seems to indicate that are for a fbdev driver. But the DT is
> supposed to describe the hardware and not Linux implementation details.
>
> Let's deprecate those compatible strings and add a new enum that contains
> compatible strings that don't have a -fb suffix. These will be matched by
> the ssd130x-i2c DRM driver.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -12,12 +12,24 @@ maintainers:
>
>  properties:
>    compatible:
> -    enum:
> -      - sinowealth,sh1106-i2c
> -      - solomon,ssd1305fb-i2c
> -      - solomon,ssd1306fb-i2c
> -      - solomon,ssd1307fb-i2c
> -      - solomon,ssd1309fb-i2c
> +    oneOf:
> +      # Deprecated compatible strings
> +      - items:
> +          - enum:
> +              - solomon,ssd1305fb-i2c
> +              - solomon,ssd1306fb-i2c
> +              - solomon,ssd1307fb-i2c
> +              - solomon,ssd1309fb-i2c

Please drop the "-i2c" suffixes, too.
We already have plenty of IIO sensors and audio codecs using the
same compatible value for spi and i2c, cfr.
'git grep compatible -- "*-[si][p2][ic].c"'

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
