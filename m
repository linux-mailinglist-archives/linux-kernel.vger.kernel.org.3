Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5644FD3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiDLJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384578AbiDLImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:42:03 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B931535;
        Tue, 12 Apr 2022 01:07:38 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id n11so4743820qvl.0;
        Tue, 12 Apr 2022 01:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3kIM+vDEOWvwfE796xa+4bsmSumR9WhkTFX0uGGX6Y=;
        b=fBWj5YWSMFQnZBTUYp54FFejJ+IhpzQf6ezPhuxIE1NutpQM20mZKRGuYdZatjiot7
         jlO8KF5a6VasAc7RUheIGG6EemPe0WadcjdOTtkjpzsScWK2s+CuvYvMj//4kG1PXAcM
         l+RgdD6eusiFOeJ0fhHrni1HgcxpofUJ78eN/+jvbVZhIrPGfPB9fhQg280HBMVQxR/E
         OBz5/PSCxZGEHHTwGNFlykza9DNUMsu3UQTgiemND7rEYjPdvpPF5QVwZ052dFCW9rJa
         xtmugRIeaEaf6yvlemtP9Nv09V08CxxutlYYGMLbg1/X0Nt8fWXEGZe7+AhVPMEUoQji
         tzdA==
X-Gm-Message-State: AOAM532IerohS7Xyx38i40Eb7WMixVZKoNqRd/oMdvlr1rL5l6EWvAhF
        Oc2QhVk+/JbK0L2eXm8A78AM57wy1IFVtYyU
X-Google-Smtp-Source: ABdhPJzc0khSaFQdyMCKOxNyN6GGAkNL69WoBEeWMFMJwVT22yEtHyIRKzwvKk3kxo+s87C2F4Adsw==
X-Received: by 2002:a05:6214:23c8:b0:432:e69f:5d77 with SMTP id hr8-20020a05621423c800b00432e69f5d77mr29821869qvb.7.1649750857214;
        Tue, 12 Apr 2022 01:07:37 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id d199-20020ae9efd0000000b0069bfae33230sm5707380qkg.53.2022.04.12.01.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:07:36 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ebf4b91212so94128987b3.8;
        Tue, 12 Apr 2022 01:07:36 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr29324182ywb.132.1649750856326; Tue, 12
 Apr 2022 01:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211243.11121-1-javierm@redhat.com> <20220411211243.11121-3-javierm@redhat.com>
 <CAMuHMdVuivPSRooR5CqTX6GQtxO6RQYwKUqfOK36zsiN8-v6kg@mail.gmail.com> <d37de4b1-55f7-ff4d-6230-6f0b6e65799c@redhat.com>
In-Reply-To: <d37de4b1-55f7-ff4d-6230-6f0b6e65799c@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 10:07:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_4Gp2fqfCTeUigVxK=J4NF=SqJVd1hKAWpyuUv0Pnzw@mail.gmail.com>
Message-ID: <CAMuHMdV_4Gp2fqfCTeUigVxK=J4NF=SqJVd1hKAWpyuUv0Pnzw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Apr 12, 2022 at 10:01 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 4/12/22 09:16, Geert Uytterhoeven wrote:
> > On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
> >> add to the schema the properties and examples for OLED devices under SPI.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

> >> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> >> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> >> @@ -39,9 +39,14 @@ properties:
> >>    reset-gpios:
> >>      maxItems: 1
> >>
> >> +  dc-gpios:
> >> +    maxItems: 1
> >> +
> >
> > Perhaps add a description, and clarify this is for SPI only?
>
> I wondered how to make it required for SPI but couldn't find another binding
> that did the same and I'm not that familiar with DT schemas to figure it out.
>
> Before, when I had compatible strings just for SPI I could do the following:
>
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - sinowealth,sh1106-spi
>               - solomon,ssd1305-spi
>               - solomon,ssd1306-spi
>               - solomon,ssd1307-spi
>               - solomon,ssd1309-spi
>     then:
>       required:
>         - spi-max-frequency
>         - dc-gpios
>
> but now that we are using the same compatible strings for I2C and SPI, the
> compatible string can't be used anymore as an indication to make required.
>
> Do you have any hints here on how I should enforce this in the schema ?
>
> Or if you think that a comment is enough, then I will add it in v3.

I don't know how to make it required for SPI, if possible at all.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
