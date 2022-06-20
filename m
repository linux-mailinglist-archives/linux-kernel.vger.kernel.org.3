Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C325515E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiFTKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiFTKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:32:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E014021
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:32:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z11so8318691edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ETIPZemBmoDbtlPM+HgfBkCh7bjs2P92YbyzQfZl3t0=;
        b=sPFGX2czl66w8o4KXvipXXmncVDcfceiwIjY85AVZ848DJUCH2Qg3VtAJ8x05m7Wrl
         dS9+fIhfPmR6vqBIRcMGybTFTX68euzO3iqH3XdDx0lvnh6M7EpHrnjtd0PJ31427S/5
         ZR4gx0k/S7NGd+CEBVVK6rKlQGYKGujURrgEDZnq9hle7ni67aA18vuT2ezJeVMwqeiY
         IEOhrwmn5zvL5kaI+T1jkEvF1xJ1oerVoWjybohxJDU6zrpFJBBDbtQHLwWAf6B8BuWs
         25wxAaOrn8aK2BwazNDaQkVw5cycTXkCF5ecTrektBkmPPPpjlwi4dg85l8+4bBpbHEy
         i/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ETIPZemBmoDbtlPM+HgfBkCh7bjs2P92YbyzQfZl3t0=;
        b=SI8Iw5ojBPOhYfhCOrlaDIpl89dWsl8NGIWc/7r9drF99teTjdH+QPF2ettA1XAqER
         BEE4ITikHLRnjjEebJ5SzX/Ps1ZQRNiZZqoA6BT6VCbPYoCgTyw3y9frpLdOl0zvTrSF
         MuKs7BnnTd2WCtxCjk5FQiUbWUWxHgefUhTfCQu9wLuzPOQPcvrwez412KAWflncr68k
         c+/KaAmk8dgObhkGLwIc/ND/kLFYaQuLhBa61w0D4zdK9H6W9r0GrHw7hGOYwouHbA9W
         Va1X+GrU5yjR8wL7I5DSdxDJi8DdDYu3SA02EgXpPrG1ieZqWcmipXQnGfK4mcdXWhyr
         3xHw==
X-Gm-Message-State: AJIora+fG+g9hUE+kgyCr3JKCYtwPSc1FH6oLqAIhY6CGePw7MbXXBbs
        bnbq1cQ212IOUUcalIF5QmRkzA==
X-Google-Smtp-Source: AGRyM1tencxz2odLb+UeBToKBIAxHK6d9z4ABVAEgKg0IP9q8l1+aJObe7VdBYm3jM0H4/4CL2Lx8A==
X-Received: by 2002:a05:6402:35ce:b0:430:cbae:d8d with SMTP id z14-20020a05640235ce00b00430cbae0d8dmr28877708edc.369.1655721162875;
        Mon, 20 Jun 2022 03:32:42 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906825700b0070ad296e4b0sm5675330ejx.186.2022.06.20.03.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 03:32:41 -0700 (PDT)
Message-ID: <ca5834ea-701f-2260-da2a-84b22d4033db@linaro.org>
Date:   Mon, 20 Jun 2022 12:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS
 PHY binding
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
References: <20220620034533.4108170-1-victor.liu@nxp.com>
 <20220620034533.4108170-3-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620034533.4108170-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 05:45, Liu Ying wrote:
> Add bindings for Mixel LVDS PHY found on Freescale i.MX8qm SoC.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * Set fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum. (Krzysztof)
> * Skip 'clock-names' property. (Krzysztof)
> * Drop 'This patch' from commit message. (Krzysztof)
> 
>  .../bindings/phy/mixel,lvds-phy.yaml          | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> new file mode 100644
> index 000000000000..4bfcc0dd987f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml

Name the file fsl,imx8qm-lvds-phy.yaml

> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mixel,lvds-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mixel LVDS PHY for Freescale i.MX8qm SoC
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The Mixel LVDS PHY IP block is found on Freescale i.MX8qm SoC.
> +  It converts two groups of four 7/10 bits of CMOS data into two
> +  groups of four data lanes of LVDS data streams. A phase-locked
> +  transmit clock is transmitted in parallel with each group of
> +  data streams over a fifth LVDS link. Every cycle of the transmit
> +  clock, 56/80 bits of input data are sampled and transmitted
> +  through the two groups of LVDS data streams. Together with the
> +  transmit clocks, the two groups of LVDS data streams form two
> +  LVDS channels.
> +
> +  The Mixel LVDS PHY found on Freescale i.MX8qm SoC is controlled
> +  by Control and Status Registers(CSR) module in the SoC. The CSR
> +  module, as a system controller, contains the PHY's registers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-lvds-phy
> +      - mixel,lvds-phy

This is not specific enough compatible.
> +
> +  "#phy-cells":
> +    const: 1
> +    description: |
> +      Cell allows setting the LVDS channel index of the PHY.
> +      Index 0 is for LVDS channel0 and index 1 is for LVDS channel1.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - clocks
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    phy {
> +        compatible = "fsl,imx8qm-lvds-phy";
> +        #phy-cells = <1>;
> +        clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_PHY>;
> +        power-domains = <&pd IMX_SC_R_LVDS_0>;
> +    };


Best regards,
Krzysztof
