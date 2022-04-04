Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC34F168B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359717AbiDDNyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346907AbiDDNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:54:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABFF3EAA9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:52:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so5668886wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=orXe1JLKj3eWkUs/vG6CQ9PlkRdOEKGc+GDPsHVwVSQ=;
        b=WyC0hsymaV9UJHv9CIIXVy5p7WAbo4Q2u4e/nQE8HTIvyVX+5wdSM80i3/YtDNM3dA
         nFxLwmjCRR4j+YdelKwwidGUkes+I7rlhDtqLa3IKaZNsVPlTlDq/QO0BQ6qVP0je9OT
         1KQWXQYyhRucsEQVJGeqI/1oag6jR6qJ+cpdIBQP61sV6fJrMSJdJNDvAWu7ipDaovrk
         jaFOfrKqq+R7VrCp0uRUIN43Uty6xJJp+LO/trJziABkk5vpAwDRXNfUNDUkNiYdTG4w
         fMycIQYXPOwR68torwpWP58A1znnlOrwUM69KoiR6aDC7bxjiCIH4ZcT3MZx21MsXAXX
         uvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=orXe1JLKj3eWkUs/vG6CQ9PlkRdOEKGc+GDPsHVwVSQ=;
        b=WZcQy2+tpC2x6fYJNYcBzO7YUp3k3QK/Oiz0oi1W4e/n49wT/bXXVUtliLCa9RBk4v
         ugK3lUT/qC55PI9nclWAuMFHhLpYsh/+o0PckP+2zUXGK2uzhm8esyYyRBAZfEvDZJ1C
         0tsnQHn3VEm7/h+I6eeIrcIbIgodPFSwqSvOtOgjXDLeqvRj9XQF5g3kmzPeLL1+PgV9
         aPtOuNSHQ2R0DG97gJFFrXKhfO7QTBh9wDTbZZH6R99qRqFJM5lGKCdq4+it2AMcPyPa
         RpD1QOLUGZaSqV8dr4xpwcdLs9b6r5sSnJ/3Iu6qO61mI2hHwo/+pKkiNJvHhlN0pGS2
         K6FQ==
X-Gm-Message-State: AOAM533ltmEwwwISSeqgoogl8IDBHGp5xHvBr9fnzU/HYjYLZgHlnjTT
        AyFcFf7WzsO9RT/DmnnsgTCwMQ==
X-Google-Smtp-Source: ABdhPJw89vFXoJ5SBTppIPxaGW7RRNdgP5jNO3Xa+1KintPNh7R1vx4e+9D+kd9JBLe3HI5yTVSsVQ==
X-Received: by 2002:a1c:e908:0:b0:38c:782c:2a62 with SMTP id q8-20020a1ce908000000b0038c782c2a62mr19502739wmc.135.1649080340874;
        Mon, 04 Apr 2022 06:52:20 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e5ca446bcsm8269468wmp.5.2022.04.04.06.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:52:20 -0700 (PDT)
Message-ID: <14c921b5-4240-a026-252a-d5fb60836b34@linaro.org>
Date:   Mon, 4 Apr 2022 15:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
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
References: <20220404131818.1817794-1-gch981213@gmail.com>
 <20220404131818.1817794-5-gch981213@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220404131818.1817794-5-gch981213@gmail.com>
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

On 04/04/2022 15:18, Chuanhong Guo wrote:
> Add device-tree binding documentation for Mediatek SPI-NAND Flash
> Interface.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Changes since v1:
>   1. add a blank line between properties in dt binding doc
>   2. rename ecc-engine to nand-ecc-engine for the generic properties
> 
> Change since v2: none
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

Slightly slow down resends (max 1 per day). You sent v3 without giving a
chance to review this.

Wrong name here.


Best regards,
Krzysztof
