Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412452B242
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiERGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiERGSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:18:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A796C0F6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:18:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so1282354pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUOQzQyLSHKVQOfQejrKZ7S+QnrjtQ35FqsfQcAvXog=;
        b=WsGeYJfMcSxk4MYbJFe2TMgOQzdkL4z8XDiQDGcluOyGJa8J/YvBAc/vaA9YPkaZy3
         tbEaMb73C+bMB87ftWp+y81QWZMLI8Klz3MLGf2PIHC8eGZxz7oBscOqKsyD7orXuPgw
         ZbsuY9CBwSFOg0eLFK/1+b8pvMqeE/bYFjbmfOVg8IjbXna2qU6HjhqTWOhUilE3rAKy
         s7DQ9IbMdMHWEMMDUDkQFmxcQgIgbegid5YgCE0ipMC/HKvV4jICkygWtZ6iArt+K3Cr
         3T00j0lI8AOHUtAejyMLyAvUSb84eq24cNJqrOAPzu6gE4QPCMVO6sfNzV33X+5QcSEW
         dNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUOQzQyLSHKVQOfQejrKZ7S+QnrjtQ35FqsfQcAvXog=;
        b=a0ykL4bXMgEQHsKT16bLd7aDkgV7jCwDvWe3EYYvwGFTmNf3H4eox0LZcULv9iOs8e
         h6hCdo8BcIOZt0aqtTbh+vTyg+BMm6XIhXAORB3Fn6N3qIS2rJR2q3bwZbnGKLAfhzcX
         RZ0h1E5pvL8cTVP7xScA9H/Y7RrBImKRT/EXWyVmvl3CVAQ6vVCx6jYLYVlBYBotSicR
         QfZDJqfWlHNuDAv53/2KBJLcVDhO2X39ysJfrlhdK3IfhuTzlSqsQiooOueu2wxapxMT
         MZoqFd0m8Mqq8ScyTlegzs0ASHFXr/zYNh3ZKuoTCy0YX16LfrKsr3HD6Q8657sOLNF2
         ujTg==
X-Gm-Message-State: AOAM533WkFpuZPJ7M9Zkw0uBKH6NeK1RVcKTHypZKGw6/sqONa1HaBch
        ZeYbU4H6vPilZGmfC6/hfo8FQ0mU4XtdrcEZEMKOUg==
X-Google-Smtp-Source: ABdhPJxjiKwSU9gCwVfFIUmqgLbgZrBYEKGKkYGn+85rlJIdtYzmFtJMxk5NUCc7B7OTS4buwPcTZSWZLilb97hrmrQ=
X-Received: by 2002:a63:693:0:b0:3f5:ef4e:d359 with SMTP id
 141-20020a630693000000b003f5ef4ed359mr3001601pgg.540.1652854701461; Tue, 17
 May 2022 23:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220516005412.4844-1-chiawei_wang@aspeedtech.com> <20220516005412.4844-2-chiawei_wang@aspeedtech.com>
In-Reply-To: <20220516005412.4844-2-chiawei_wang@aspeedtech.com>
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Wed, 18 May 2022 08:18:10 +0200
Message-ID: <CALNFmy1pM4ZQ0BLDwHykxDCpR=Dv3sVaYq5QLLA_w0L+mzq7iQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: aspeed: Add eSPI controller
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        jk@codeconstruct.com.au, a.kartashev@yadro.com,
        dphadke@linux.microsoft.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ryan_chen@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 2:55 AM Chia-Wei Wang
<chiawei_wang@aspeedtech.com> wrote:
>
> Add dt-bindings for Aspeed eSPI controller
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml  | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> new file mode 100644
> index 000000000000..aa91ec8caf6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2021 Aspeed Technology Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Aspeed eSPI Controller
> +
> +maintainers:
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +description:
> +  Aspeed eSPI controller implements a slave side eSPI endpoint device
> +  supporting the four eSPI channels, namely peripheral, virtual wire,
> +  out-of-band, and flash.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2500-espi
> +          - aspeed,ast2600-espi
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^espi-ctrl@[0-9a-f]+$":
> +    type: object
> +
> +    description: Control of the four basic eSPI channels
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - aspeed,ast2500-espi-ctrl
> +              - aspeed,ast2600-espi-ctrl
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      perif,memcyc-enable:
> +        type: boolean
> +        description: Enable memory cycle over eSPI peripheral channel
> +
> +      perif,memcyc-src-addr:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The Host side address to be decoded into the memory cycle over eSPI peripheral channel
> +
> +      perif,memcyc-size:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The size of the memory region allocated for the memory cycle over eSPI peripheral channel
> +        minimum: 65536
> +
> +      perif,dma-mode:
> +        type: boolean
> +        description: Enable DMA support for eSPI peripheral channel
> +
> +      oob,dma-mode:
> +        type: boolean
> +        description: Enable DMA support for eSPI out-of-band channel
> +
> +      oob,dma-tx-desc-num:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 2
> +        maximum: 1023
> +        description: The number of TX descriptors available for eSPI OOB DMA engine
> +
> +      oob,dma-rx-desc-num:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 2
> +        maximum: 1023
> +        description: The number of RX descriptors available for eSPI OOB DMA engine
> +
> +      flash,dma-mode:
> +        type: boolean
> +        description: Enable DMA support for eSPI flash channel
> +
In my tests using this driver the FIFO mode didn't work, but the DMA
mode worked fine.
IMHO you should always use DMA mode to reduce CPU load and get rid of
this property.

> +      flash,safs-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1, 2 ]
> +        default: 0
> +        description: Slave-Attached-Sharing-Flash mode, 0->Mix, 1->SW, 2->HW
> +
On the AST2500 the HW mode is not supported, is it?

> +    dependencies:
> +      perif,memcyc-src-addr: [ "perif,memcyc-enable" ]
> +      perif,memcyc-size: [ "perif,memcyc-enable" ]
> +      oob,dma-tx-desc-num: [ "oob,dma-mode" ]
> +      oob,dma-rx-desc-num: [ "oob,dma-mode" ]
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - clocks
> +
> +  "^espi-mmbi@[0-9a-f]+$":
> +    type: object
> +
> +    description: Control of the PCH-BMC data exchange over eSPI peripheral memory cycle
> +
> +    properties:
> +      compatible:
> +        const: aspeed,ast2600-espi-mmbi
> +
> +      interrupts:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - interrupts
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    espi: espi@1e6ee000 {
> +        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
> +        reg = <0x1e6ee000 0x1000>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x1e6ee000 0x1000>;
> +
> +        espi_ctrl: espi-ctrl@0 {
> +            compatible = "aspeed,ast2600-espi-ctrl";
> +            reg = <0x0 0x800>;
> +            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
> +        };
> +
> +        espi_mmbi: espi-mmbi@800 {
> +            compatible = "aspeed,ast2600-espi-mmbi";
> +            reg = <0x800 0x50>;
> +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> --
> 2.25.1
>

Regards,
Patrick
