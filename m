Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21065446F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiFIJJp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jun 2022 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiFIJJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:09:42 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6115A34;
        Thu,  9 Jun 2022 02:09:40 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id z20so1757498qvv.3;
        Thu, 09 Jun 2022 02:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vcNcbXn7pen8qYNKzKfNZDPezgTFLJOA1+jKzy0m7VY=;
        b=t6PzbYf89Sk0M6RM6PyE1SLKU0SPPd61Mb/xBv8gPezXcigd6/znYtr71WOIREtZaK
         drUO/Rd4WnfztLJArF8ffYLYv/QoGVZGYho/irNqKpt4mkFPi+PTf6Av/O5jKNOV1Xc+
         49R8RXhZfktueF/yAXi2wMVNuZgY7/GVv9aUeIRAQvJANlesQ9dPd4SoofpjI02toKMq
         v257cyX5JSJBVIOhfpWacpk1bo5/imjA7mczAUeeelDbGxGjA/ETiqHBNQODgbVIaPEX
         jlSZq9ki57WcoYXU0fT7DYFr2gVSBwR5gLuqyvOgu89OD91KcF3U3Bd+cQqXlPgI8LCG
         TLUg==
X-Gm-Message-State: AOAM5321xnpOczBEuXhevHoNac/3Wuqy/jPMnqd2DG0HLpI96Fg+x9hV
        gBYSfD9+v8CkZ9tEzv75LYzQsakKiQEwKg==
X-Google-Smtp-Source: ABdhPJyx2oWeULEhMDYBX+8aprOKzHGS4UYTp8GFV4glC/vwveZHEw3nh7WD9i+8supyEQclp8RhTQ==
X-Received: by 2002:ad4:596b:0:b0:46b:cc90:5a87 with SMTP id eq11-20020ad4596b000000b0046bcc905a87mr6097794qvb.59.1654765779333;
        Thu, 09 Jun 2022 02:09:39 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id x2-20020a05620a01e200b006a7034b7efesm3498006qkn.25.2022.06.09.02.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:09:38 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-30ce6492a60so234320067b3.8;
        Thu, 09 Jun 2022 02:09:38 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr41768687ywa.47.1654765778409; Thu, 09
 Jun 2022 02:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151040.24024-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220525151040.24024-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 11:09:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2qAMaejyEFCSNA1aZrMYQgQuf6mp0o_smKmdXUPkzwA@mail.gmail.com>
Message-ID: <CAMuHMdX2qAMaejyEFCSNA1aZrMYQgQuf6mp0o_smKmdXUPkzwA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, May 25, 2022 at 5:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Add support for R-Car S4. The S4 IP differs a bit from its siblings in
> such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
> are not routed to the INTC-AP but to the ECM.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> @@ -8,9 +8,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Renesas R-Car Gen3 Thermal Sensor
>
>  description:
> -  On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal
> -  sensors (THS) which are the analog circuits for measuring temperature (Tj)
> -  inside the LSI.
> +
> +  On most R-Car Gen3 and later SoCs, the thermal sensor controllers (TSC)
> +  control the thermal sensors (THS) which are the analog circuits for
> +  measuring temperature (Tj) inside the LSI.
>
>  maintainers:
>    - Niklas Söderlund <niklas.soderlund@ragnatech.se>
> @@ -27,6 +28,7 @@ properties:
>        - renesas,r8a77965-thermal # R-Car M3-N
>        - renesas,r8a77980-thermal # R-Car V3H
>        - renesas,r8a779a0-thermal # R-Car V3U
> +      - renesas,r8a779f0-thermal # R-Car S4
>
>    reg: true

As the interrupt is routed to the ECM, like on R-Car V3U, the interrupts
property should not be required.  Else "make dtbs_check" complains:

    arch/arm64/boot/dts/renesas/r8a779f0-spider.dtb: thermal@e6198000:
'interrupts' is a required property

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
