Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4F4CB22B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbiCBWVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiCBWVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:21:37 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C1D21E7;
        Wed,  2 Mar 2022 14:20:52 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id f21so2513849qke.13;
        Wed, 02 Mar 2022 14:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IwOBwMpi2OwEzG0VtigJWsM6dutoMlGx5jRzY5Yz/Vc=;
        b=MtnSgvQxlGt5TGIFQMfRkRf4KK1L85s9MA4ZXLuK105X6YoXUOfkr173xoepXU0fiu
         UuhHi/gN1IKGbUa02Oi4DiEVaJZ/yqhWE6k0hILSueUBtPjBk8tj7hvZICj1J1mOVdmZ
         oUIkmayyOSwIO+lHl6kgMI1DLJJXj1VZG2GzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IwOBwMpi2OwEzG0VtigJWsM6dutoMlGx5jRzY5Yz/Vc=;
        b=e1Oi98LtqavbdZN9J/P/BBEVEuhKCC3x9KXZn/7/8jciqZZ3iikr86U/CIFo80Tm+3
         DLTANobBbBDwzmGMOiAHNzDcTvyExDpdmfth4IKVYLdnOMkbUl+9yW2hFzLLM8X/5ryu
         1qXho148uVBPtMlIEGh1trkE/4NQQf4L9Waqc3LTvtGgHdqoodakIUeSN7ieMFQtMKJm
         A+UNvftx7ugznortQszmn1dBwUCPUn8maPoPajRo50+hR110ygt9rDBaT6wSYF2S8QFB
         m5qgqlYQYHOik1W1FDSE/3xUwCzLINtkgCy3XrEuHOCtopQytNxvUBYxgV+bdAe6FiRc
         JwpA==
X-Gm-Message-State: AOAM533Y6zJPoTccfdMiNtSNmCpBODAOdPTyky86bAYwtbAv0CCLQblb
        wqodjceF4DPv7W9kOAYI52UG6qtFMyPYjcgQr88=
X-Google-Smtp-Source: ABdhPJxvmmE3gaxqf1AN8AAcq15J2+/3h1dIbI7rXUBxAE1ecVlQbf15Jy/H6IC8/REhnKs2t2BL89C3wdGw7Mg0B6A=
X-Received: by 2002:a05:620a:2fc:b0:649:a4e:c430 with SMTP id
 a28-20020a05620a02fc00b006490a4ec430mr17818002qko.347.1646259651990; Wed, 02
 Mar 2022 14:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-4-clg@kaod.org>
In-Reply-To: <20220302173114.927476-4-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:20:40 +0000
Message-ID: <CACPK8XcWZ6jQEo4-78fMrSxqZW5Cc8ecsNf+j5X7av-HbJwMKg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The "interrupt" property is optional because it is only necessary for
> controllers supporting DMAs (Not implemented yet in the new driver).
>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      | 90 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-=
fmc.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yam=
l b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> new file mode 100644
> index 000000000000..0289a4f52196
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed SMC controllers bindings
> +
> +maintainers:
> +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> +  - C=C3=A9dric Le Goater <clg@kaod.org>
> +
> +description: |
> +  This binding describes the Aspeed Static Memory Controllers (FMC and
> +  SPI) of the AST2400, AST2500 and AST2600 SOCs.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-fmc
> +      - aspeed,ast2600-spi
> +      - aspeed,ast2500-fmc
> +      - aspeed,ast2500-spi
> +      - aspeed,ast2400-fmc
> +      - aspeed,ast2400-spi
> +
> +  reg:
> +    items:
> +      - description: registers
> +      - description: memory mapping
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +patternProperties:
> +  "@[0-9a-f]+":
> +    type: object
> +
> +    properties:
> +      spi-rx-bus-width:
> +        enum: [1, 2, 4]
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    spi@1e620000 {
> +        reg =3D <0x1e620000 0xc4>, <0x20000000 0x10000000>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        compatible =3D "aspeed,ast2600-fmc";
> +        clocks =3D <&syscon ASPEED_CLK_AHB>;
> +        interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +        flash@0 {
> +                reg =3D < 0 >;
> +                compatible =3D "jedec,spi-nor";
> +                spi-max-frequency =3D <50000000>;
> +                spi-rx-bus-width =3D <2>;
> +        };
> +        flash@1 {
> +                reg =3D < 1 >;
> +                compatible =3D "jedec,spi-nor";
> +                spi-max-frequency =3D <50000000>;
> +                spi-rx-bus-width =3D <2>;
> +        };
> +        flash@2 {
> +                reg =3D < 2 >;
> +                compatible =3D "jedec,spi-nor";
> +                spi-max-frequency =3D <50000000>;
> +                spi-rx-bus-width =3D <2>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4175103e928d..f5ab77548ef6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2925,6 +2925,15 @@ S:       Maintained
>  F:     Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>  F:     drivers/mmc/host/sdhci-of-aspeed*
>
> +ASPEED SMC SPI DRIVER
> +M:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> +M:     C=C3=A9dric Le Goater <clg@kaod.org>
> +L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
> +L:     linux-spi@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> +
>  ASPEED VIDEO ENGINE DRIVER
>  M:     Eddie James <eajames@linux.ibm.com>
>  L:     linux-media@vger.kernel.org
> --
> 2.34.1
>
