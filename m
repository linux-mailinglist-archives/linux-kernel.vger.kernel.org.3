Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB244EBF19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbiC3KqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiC3KqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:46:16 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44426DEB8;
        Wed, 30 Mar 2022 03:44:30 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id b18so17640083qtk.13;
        Wed, 30 Mar 2022 03:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AR9u+pkgZAvJ0f4YWG7QhXL5v6/FitjOX/6TTdYJWU=;
        b=Ebs9GThq/OoMRcfcmYwIEjuPSuGf6c2iOQWfOHZuAWXeM695DWV2T40/a/tujDYvyu
         wqGOBQeJofA5yHV8EE8gaYI14HNO5/V7Qtl9bD0Y5hpLPkx+we/TTdiMYeDgqI1jCO6W
         EXvfghGmozeR0LT8V3VW07z5tjmtvv8flCHgMdJ3xDyXIQm5ToEBqoowlyXRo2WEOzGh
         ZiUucSUubkJe4USI5X2CNpS3H3X12VLAu8jjlrSrqwmQa3OIwHyaQKQuKTP5CymXvdhp
         CJ49D3dGFgsllX6sDn1REQMTOBfIAdGzSk6eP5X4S5dCGt9KFQw6E83BYFJI++O/UEWu
         aSeQ==
X-Gm-Message-State: AOAM531Rt2wR4HbpPnQx7nMxPYL09U8Qg7mcn7mQ5gA5/DlGNo+Po+uW
        iifFHKgecfNst78LGZ9fEiHZgtMUn5P9gw==
X-Google-Smtp-Source: ABdhPJzlPWC3Rzu98McfeEXB5vlOOYlUhACctwFeQPt2K0C+pn/AaLsQtFg32iltLEjqYUhXVXf3pw==
X-Received: by 2002:a05:622a:1013:b0:2e1:c9c0:9831 with SMTP id d19-20020a05622a101300b002e1c9c09831mr31821152qte.245.1648637068908;
        Wed, 30 Mar 2022 03:44:28 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id de26-20020a05620a371a00b0067dc7923b14sm10673823qkb.132.2022.03.30.03.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 03:44:28 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f38so36118078ybi.3;
        Wed, 30 Mar 2022 03:44:28 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr32711003yba.393.1648637068193;
 Wed, 30 Mar 2022 03:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 12:44:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU10FL8-F1y8rrO4dUtKJ_NvenxcBD3VWB7=5rf-vf-yg@mail.gmail.com>
Message-ID: <CAMuHMdU10FL8-F1y8rrO4dUtKJ_NvenxcBD3VWB7=5rf-vf-yg@mail.gmail.com>
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8997: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Krzysztof,

On Fri, Oct 1, 2021 at 3:18 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> Convert the Maxim MAX8997 PMIC bindings to DT schema format.  Extend the
> examples with additional one copied from kernel's exynos4210-origen.dts.
> Also the binding descriptions are copied from old file, so license
> entire work under GPL-2.0.
>
> This also adds previously undocumented 32 kHz clock output modelled as
> regulators.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks for your patch, which is now commit 1d2104f21618a4ce
("regulator: dt-bindings: maxim,max8997: convert to dtschema").

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml

> +if:
> +  anyOf:
> +    - required:
> +        - max8997,pmic-buck1-uses-gpio-dvs
> +    - required:
> +        - max8997,pmic-buck2-uses-gpio-dvs
> +    - required:
> +        - max8997,pmic-buck5-uses-gpio-dvs
> +then:
> +  properties:
> +    max8997,pmic-buck1-dvs-voltage:
> +      minItems: 8
> +      maxItems: 8
> +    max8997,pmic-buck2-dvs-voltage:
> +      minItems: 8
> +      maxItems: 8
> +    max8997,pmic-buck5-dvs-voltage:
> +      minItems: 8
> +      maxItems: 8

The above doesn't seem to work as expected...

> +        pmic@66 {
> +            compatible = "maxim,max8997-pmic";
> +            reg = <0x66>;
> +
> +            interrupts-extended = <&gpx0 7 IRQ_TYPE_LEVEL_LOW>,
> +                                  <&gpx2 3 IRQ_TYPE_EDGE_FALLING>;
> +
> +            max8997,pmic-buck1-uses-gpio-dvs;
> +            max8997,pmic-buck2-uses-gpio-dvs;
> +            max8997,pmic-buck5-uses-gpio-dvs;
> +
> +            max8997,pmic-ignore-gpiodvs-side-effect;
> +            max8997,pmic-buck125-default-dvs-idx = <0>;
> +
> +            max8997,pmic-buck125-dvs-gpios = <&gpx0 5 GPIO_ACTIVE_HIGH>,
> +                                             <&gpx0 6 GPIO_ACTIVE_HIGH>,
> +                                             <&gpl0 0 GPIO_ACTIVE_HIGH>;
> +
> +            max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
> +                                             <1250000>, <1200000>,
> +                                             <1150000>, <1100000>,
> +                                             <1000000>, <950000>;
> +
> +            max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
> +                                             <950000>,  <900000>,
> +                                             <1100000>, <1000000>,
> +                                             <950000>,  <900000>;
> +
> +            max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
> +                                             <1200000>, <1200000>,
> +                                             <1200000>, <1200000>,
> +                                             <1200000>, <1200000>;

Documentation/devicetree/bindings/regulator/maxim,max8997.example.dtb:
pmic@66: max8997,pmic-buck1-dvs-voltage: [[1350000, 1300000, 1250000,
1200000, 1150000, 1100000, 1000000, 950000]] is too short
From schema: Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
Documentation/devicetree/bindings/regulator/maxim,max8997.example.dtb:
pmic@66: max8997,pmic-buck2-dvs-voltage: [[1100000, 1000000, 950000,
900000, 1100000, 1000000, 950000, 900000]] is too short
From schema: Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
Documentation/devicetree/bindings/regulator/maxim,max8997.example.dtb:
pmic@66: max8997,pmic-buck5-dvs-voltage: [[1200000, 1200000, 1200000,
1200000, 1200000, 1200000, 1200000, 1200000]] is too short
From schema: Documentation/devicetree/bindings/regulator/maxim,max8997.yaml

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
