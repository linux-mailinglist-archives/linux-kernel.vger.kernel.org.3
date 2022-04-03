Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E34F0AAE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359180AbiDCPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiDCPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:39:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1B33E18
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:37:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so10886748wrc.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eDFMs7EElGjgVXSi1G28DbTYKExJESQOSQxzUR+xKqM=;
        b=lnbGEtlamweYbPt09LLUZZmY1OEhSHyThX/GrCcNl6El493Cx8SaCgtQqMkE17prcX
         J4LfZqyU7meN7ZKBqPiiaqhEz48OQnHqLhAsz6amdsKGeWKgN2kgs5yDi1GqwrBu1PqX
         Gbm4GlMU9jc9lgq2KPbfHuzHqtBonIWl+PqeIdB1b5Cpz4H5t624nAEKk4q2tOus8EbX
         ze51geAwftRiFo4VVmbrccFnbRQ7WwQvc/jJ302DDtrGiVE1dmAAG1WFhfGrfBVVPuXt
         MzsCJc8qaT8+5p98TbBnT842jG/MYim7LYqY2m7SIu/Lrq4rx6om8VKeS5BRzJaTTgMA
         j12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eDFMs7EElGjgVXSi1G28DbTYKExJESQOSQxzUR+xKqM=;
        b=N2GtSbEIAEc9TgtmtcY87SMRuidfJ+d9RPrzpKE5QCOs9G8Q7tmGqSpC6CvP4pD8dL
         Qq1Rd618EZUqUwIBw35Lnb2p+bH7i68mdz0Dx/Zx8fb5ZXiShmiwikIphD4QobeCF6zf
         KPIWuKYM/0zfVLFeVZOXTVj0Bo/ZKLAoJzhDBQd69wOuVFm5RrAZpXdQQyP3bNwnwXwy
         b767ZJlCiLmo2kDevMXWtRnUP+RJ88wJj7u0AxpJe08TNGjhskEV2Gmzzod2puozC0di
         jLgWILccGCN7jvbN8Cu6dFHI8KF3sJumpdGHYoS3vxiAW2rPDpZCm/cUJ0S2HNFWGf5E
         A31A==
X-Gm-Message-State: AOAM530fU0gKgmVGPvGeioMekolPtI/rdFNkjjUObdgDGblqltg96PZ8
        gXvVpWl+1txVxGQ1on5LzR1VcQ==
X-Google-Smtp-Source: ABdhPJzno6MvWVjCp8ZyExCrnTXODZzrLF1ozU8hgn7hmy1XaDLiOBxe1FQc2Cu1D2oZQReX5TZNZw==
X-Received: by 2002:a5d:47c3:0:b0:204:5b8:225c with SMTP id o3-20020a5d47c3000000b0020405b8225cmr14059127wrc.474.1649000259960;
        Sun, 03 Apr 2022 08:37:39 -0700 (PDT)
Received: from [192.168.0.172] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m63-20020a1c2642000000b0038e5fa06b50sm4607976wmm.31.2022.04.03.08.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 08:37:39 -0700 (PDT)
Message-ID: <817dda10-39db-adfc-376d-a3d5e037937e@linaro.org>
Date:   Sun, 3 Apr 2022 17:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] dt-bindings: spi: add binding doc for spi-mtk-snfi
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@lists.infradead.org
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
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
References: <20220403131154.1267887-1-gch981213@gmail.com>
 <20220403131154.1267887-4-gch981213@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220403131154.1267887-4-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2022 15:11, Chuanhong Guo wrote:
> Add device-tree binding documentation for Mediatek SPI-NAND Flash
> Interface.

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> new file mode 100644
> index 000000000000..166c6b50b9d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> @@ -0,0 +1,87 @@
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

One blank line, please.

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
> +  ecc-engine:

The nand-chip.yaml defines a nand-ecc-engine, so how about using that
one? I know mtk-nand.txt uses ecc-engine, but for new schema better to
use properties from existing YAML.

> +    description: device-tree node of the accompanying ECC engine.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +

Rest looks good, thank you!


Best regards,
Krzysztof
