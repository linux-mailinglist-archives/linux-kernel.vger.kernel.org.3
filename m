Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7A5407D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347735AbiFGRwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347782AbiFGRfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:35:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1BF1059DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:31:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y19so36618910ejq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OZRPVWzaQMgbVoviEAuvw5THWHpQk40QUpB065iwJlU=;
        b=BoIPLJL5GB9NCpFZFdyH7VkNWJCUk3msnt1PR9Z1mZzhXDJBucu9fZfsM3DYX3htDI
         /FqdXs576e7blLmRvKorHvixVKr/96HsvZIGuF/PhbTeg6XOpdHC6M2tpE8KNVTsWwBe
         USSE/XZHe5hXKXklKrmLGy6l2vgPzcRf8FOgVNyWXuKbuFNRSULAUZCEtpyIhmRgPDar
         2+ME7g9Z1RthKYkP/aByLwfv1sRQzKnoPBG3apge4x51KyKsu3jLsp+PlZrkYRxUokCr
         BVFuiaCryWv76dwnobKtqeUyr2/K+lNFqyhLxFLZoGfkIYUc4dyimld3p0+H6zshVs9N
         3HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OZRPVWzaQMgbVoviEAuvw5THWHpQk40QUpB065iwJlU=;
        b=vJbZsdnvX/m1m5sbUhGcpttmIFNozdtdd0KUIZrh5nqpyciaK0BPDb1dCaWmR3paOB
         fE957mnjaHiG0Y8qrWuz8VH+BhFtfgJxqcnxc2p8qBHlAwxczRAfiqc98ccH5VBVNblT
         TTnW86lBUcr1g/FgYJySszl+h3F25A9YWLEpGcYEor68LzyXxazdaHSK1mdiIJ7w6rAE
         yZeeposHtqQBBu3w5FE05hVmY3WCJUXbItkOT50WEP4zwm0/4TLybqLYyFa77G/nV7mS
         4Kk9HR8x6SFzXs19dYIY4uEM8gQj7o7Q3yHFtkHsQmQCmdzqhTFpFk0H7ytmlUVrFK22
         WjtA==
X-Gm-Message-State: AOAM533YIR7soMnStDwOfw+hiEB0g4O7oZ72Za7ydQNAarzjnKpyw9yo
        /XMk8Md2OJrRw1Co8A3IZLlRkhXrLgNMPA==
X-Google-Smtp-Source: ABdhPJwD7Q2eTkyoUdQ0/IhH7OWF5BIIgX9/48//zhgYw3ugXugmQPzZ+SVbrauoCDHEs8Cx0rfwTg==
X-Received: by 2002:a17:906:d8b8:b0:711:c73e:906b with SMTP id qc24-20020a170906d8b800b00711c73e906bmr13417707ejb.225.1654623085786;
        Tue, 07 Jun 2022 10:31:25 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v3-20020aa7cd43000000b0043153c9f4d0sm4425820edw.11.2022.06.07.10.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 10:31:25 -0700 (PDT)
Message-ID: <1bd31c96-52c9-af27-7093-2ed025022eef@linaro.org>
Date:   Tue, 7 Jun 2022 19:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 09/10] dt-bindings: arm: freescale: Add fsl,scu-wdt yaml
 file
Content-Language: en-US
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-10-abel.vesa@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607105951.1821519-10-abel.vesa@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 12:59, Abel Vesa wrote:
> This documents separately the watchdog child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu-wdt.yaml   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
> new file mode 100644
> index 000000000000..c5d71ca83963
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,imx8qxp-sc-wdt
> +          - const: fsl,imx-sc-wdt
> +      - items:
> +          - const: fsl,imx-sc-wdt

No need for second items, it is just one item with const (same issue in
few other patches).


Best regards,
Krzysztof
