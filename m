Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEF94FF156
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiDMIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiDMIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:06:34 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377AA20BC1;
        Wed, 13 Apr 2022 01:04:14 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id ay4so813455qtb.11;
        Wed, 13 Apr 2022 01:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SQtFKwvmFkbGQ+l9yQziQCJESUKXjbWruyGdBT8yb8=;
        b=Alt6fDp5zuUFy59dHH0cpL0kLvpCiVd6EB9mpXn+pCKlwphhwWM9it1/8ejgvtiSLh
         tS98OzUjXuukBS7IATr7e7+qWIav0wBtL5Jtzg26IU9vQgScf4vfqWbO1qV71LMAWj+Y
         sERrPQ8w2JrdYVRpdJ+yRSSTeAk0dgbPoxfzdeZHRFNV9qf+G/LyASlhLooEKuFkuYA+
         0UWIHWVsS3E5bpIk44gAneqexasYb6D91iCPCirAmUSynQg4zpTRgYpuEuEg0IkhYev1
         lic1SoQm1P5EClnYIdW1ZTdCqFrxnsBGTbNnV3Te8/ffcVir5V7uV7oCmbheNMmqk9n/
         jyCA==
X-Gm-Message-State: AOAM531Da1znrvr6jeIIWL61cjKgRqjw3f0hyU8hsfxFK87Og/mJlU37
        EeKHE75QVm0vruZ7X0rzivBn+yadqQrV8Q==
X-Google-Smtp-Source: ABdhPJw39m4mwWMfkdTwkUaqfE0sF2gAW9ujZC7ptKpijrXzyAt2pB7Vt79cd/DKGYPmcK8ia1TSMQ==
X-Received: by 2002:a05:622a:1926:b0:2ef:fe22:8aec with SMTP id w38-20020a05622a192600b002effe228aecmr6413882qtc.446.1649837053045;
        Wed, 13 Apr 2022 01:04:13 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id q125-20020a378e83000000b0069bf8409e6fsm7778160qkd.28.2022.04.13.01.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:04:12 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2edbd522c21so13087407b3.13;
        Wed, 13 Apr 2022 01:04:11 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr33617003ywb.132.1649837051663; Wed, 13
 Apr 2022 01:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220412162729.184783-1-javierm@redhat.com> <20220412162729.184783-3-javierm@redhat.com>
In-Reply-To: <20220412162729.184783-3-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 10:04:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDxexqsGjb3B37jW_xZU1TBLq8gK5hctA+PKjL+LhQGQ@mail.gmail.com>
Message-ID: <CAMuHMdUDxexqsGjb3B37jW_xZU1TBLq8gK5hctA+PKjL+LhQGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: display: ssd1307fb: Extend schema for
 SPI controllers
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

On Tue, Apr 12, 2022 at 6:27 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
> add to the schema the properties and examples for OLED devices under SPI.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v3:
> - Add a comment to the properties required for SPI (Geert Uytterhoeven)

Thanks for the update!

> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -38,9 +38,16 @@ properties:
>    reset-gpios:
>      maxItems: 1
>
> +  # Only required for SPI
> +  dc-gpios:
> +    maxItems: 1

Actually I meant to also add a description, like for vbat-supply below,
to explain the meaning of "dc".

> +
>    vbat-supply:
>      description: The supply for VBAT

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
