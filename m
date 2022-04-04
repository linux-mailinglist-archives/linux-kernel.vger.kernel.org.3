Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403374F167E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358744AbiDDNvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353627AbiDDNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:51:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502314002
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:49:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r7so5974560wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d8lIwh8tiIkMFx11fFktp0oGVk3nbpQUUWnZgWL5Jnc=;
        b=W+UEgv5UP7GXJYs7QCG6QtMn7aXfPo+PDkNKW5aMvKgZsee9uyRmczhK/6PCLslrKm
         tSzbF8FkOxo4jSezbxKMnPAHm/lARrn+xP0kN/gp6snbd9diecPFDLZmy5bU1lqRS+cQ
         iOFJp0xD4OiAfjWsb3KoT0vqhIyIwBq+QcdJjrIMveCI7SKroJ0jKwEXOFnLozRJWrf9
         7VVizkFvRzvR5UF/2b0g42XataFHeKD0pzFn+5W44xkDBWHaiOmNwtMW+K0/yjeAdZpZ
         8/J///8nE3oojWSxI1Kon5NFJP6beXJd57Zd8RrkepeKE/GgEdQaBrSmx3aDRP2wzM/X
         xKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d8lIwh8tiIkMFx11fFktp0oGVk3nbpQUUWnZgWL5Jnc=;
        b=c7kacvEpZ3KdrbYBTCA4eepdbkgkZvubbBVjOUmO9lTUvocN2bzoRkC9sNycbkerxA
         YTb499w2NkUmy5NNgipzxhWl8AW0Rp8x5d0ZN/M3lzMtaF0Emdy7/VwDhVRuHimqAZVD
         rFxAgK/qt652w6T/nnunCvL/VQose+RxaRf6wexx8Iwt46HRjq7+fewL5EGrCG230p8C
         YIPo7tKYIMli3AK1XBgN3a3r8TN8Xdkvq7Dq4Z/fAY7XRCkzBoSp2wogA9sRngD7ZZ2N
         SSC6cBNWbzHXznU9bybCPNKWWe0nA6BNMbaH5ubST5L5LiTiVAd4kV9Nq+YMUF3JhBPH
         u+Dw==
X-Gm-Message-State: AOAM533P4J4mwZ7CW/xBxc23FMQqtWirqB6QbViS5HDr0XnRTeiaMLw4
        pNkdHATyT8arnNeFt+iLOPOuMQ==
X-Google-Smtp-Source: ABdhPJx1C13/G0jo9mcTjjBok/lghKbqEZJvW3uyonaeOQWgDSX154xlSCC+Ip2L56ywjoSX1G9fSw==
X-Received: by 2002:a1c:7715:0:b0:380:ed9b:debd with SMTP id t21-20020a1c7715000000b00380ed9bdebdmr19498320wmi.54.1649080195394;
        Mon, 04 Apr 2022 06:49:55 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm9306837wrw.91.2022.04.04.06.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:49:54 -0700 (PDT)
Message-ID: <f86a0be9-ab40-9878-82f0-d892e674d165@linaro.org>
Date:   Mon, 4 Apr 2022 15:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
References: <20220404040153.1509966-1-gch981213@gmail.com>
 <20220404040153.1509966-5-gch981213@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220404040153.1509966-5-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 06:01, Chuanhong Guo wrote:
> Add device-tree binding documentation for Mediatek SPI-NAND Flash
> Interface.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> 
> Changes since v1:
>   1. add a blank line between properties in dt binding doc
>   2. rename ecc-engine to nand-ecc-engine for the generic properties
> 
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> new file mode 100644
> index 000000000000..7d57570ad617
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/mediatek,spi-mtk-snfi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI-NAND flash controller for MediaTek ARM SoCs
> +
> +maintainers:
> +  - Chuanhong Guo <gch981213@gmail.com>
> +
> +description: |
> +  The Mediatek SPI-NAND flash controller is an extended version of
> +  the Mediatek NAND flash controller. It can perform standard SPI
> +  instructions with one continuous write and one read for up-to 0xa0
> +  bytes. It also supports typical SPI-NAND page cache operations
> +  in single, dual or quad IO mode with piplined ECC encoding/decoding
> +  using the accompanying ECC engine. There should be only one spi
> +  slave device following generic spi bindings.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7622-snand
> +      - mediatek,mt7629-snand
> +
> +  reg:
> +    items:
> +      - description: core registers
> +
> +  interrupts:
> +    items:
> +      - description: NFI interrupt
> +
> +  clocks:
> +    items:
> +      - description: clock used for the controller
> +      - description: clock used for the SPI bus
> +
> +  clock-names:
> +    items:
> +      - const: nfi_clk
> +      - const: pad_clk
> +
> +  nand-ecc-engine:
> +    description: device-tree node of the accompanying ECC engine.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - ecc-engine

Wrong name.


Best regards,
Krzysztof
