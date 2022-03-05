Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770D4CE754
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 23:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiCEWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 17:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCEWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 17:04:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D425EDEB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 14:03:51 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAD3E3F614
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 22:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646517829;
        bh=kcOebttsrbGDsv+l6IIiJwH3C8wz7II7oFbthNyR+Kg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Lc0Yhkp+LwOoodKeDhvX4EyeK7NbR3rFJ0SafJKFJ1Pv6z18+qrzkpcvVTxsWi0k4
         uwIpeaHpUo/sEzI/cjnsxdf9HB+Doy4qXY7PxlKEyNvF4inGB1lkthiBNlwYISNwEG
         A91l86tFbRnZdEM404rQQs1P771XS0VE0WpxM3QuXualqyI5F0KXHrOF2Ni71psHPx
         op4yQUzu9oshMdFHj2zHU28ary3jf8OSm6b307YHGyVWjmLdcisgZEm4DmjKQ6U726
         CzNZF2XVMdk0TDlkj9QKMzYRXjyroB2ko+zsgqK8BECTSlYjtjb6BCm8jHyz31yLI8
         x2Gcpafkr/lNg==
Received: by mail-ej1-f71.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso2288236eje.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 14:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kcOebttsrbGDsv+l6IIiJwH3C8wz7II7oFbthNyR+Kg=;
        b=BM62OI7W3lmoSSUV2juQC+9VPUOwRze5GSyN10IyMJxE1inMOEYeD66LX4bPCYRCqg
         msgGiZwDR9kHxlQmgB7Mcumi5B7NctWw9eGXB8ZI8MRSMTKp82/OIsWmvx9YyM01ojKL
         CQwvIY4lw759G517kwPmCMWMdhDEyPnILuKL2N387zM9wYAfzfbVCtMR51/4lbkgdFtq
         +1/8WiUIGkUxWrO1yUEfcLJFG5JO2PU5GK7K8oW6+4ejSQUAwCDrS5E4JaoiWX3/HqaV
         FOWhjOKvau5nPcGH9IS7Vihc2m7KhecWkRb1xPpN+2NeNzLuCMNjobGG4dB5WqwrNRNl
         2muQ==
X-Gm-Message-State: AOAM530gAxrIQw9l4e4w624yrMaB8Jy5a8H0Dm8mo5QuJ0D3nek4o80d
        MhFQN6Z0cjlujKhUF40ZlDpoq6rsjMA8GhXHiv/+/7DMqBXCIrrjAAzhSC1Lfm2FxkiLfrT6+Fg
        /yucGIJ4eCWaxcYZkO1OrD1HK1H7VM0yOjEM250IT/w==
X-Received: by 2002:a17:907:60d0:b0:6da:b397:42b0 with SMTP id hv16-20020a17090760d000b006dab39742b0mr4006789ejc.664.1646517829193;
        Sat, 05 Mar 2022 14:03:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzu568kMEdY9mBB4SY3WtLiN2hC+mxjkPHjcxldg6hya+nNfdxz0DF7WRdYiLsTXUxBLcTs7Q==
X-Received: by 2002:a17:907:60d0:b0:6da:b397:42b0 with SMTP id hv16-20020a17090760d000b006dab39742b0mr4006780ejc.664.1646517828964;
        Sat, 05 Mar 2022 14:03:48 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm3974492edt.3.2022.03.05.14.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 14:03:48 -0800 (PST)
Message-ID: <9e6bfc9b-63d0-d4b3-90af-4bf06cdb27f2@canonical.com>
Date:   Sat, 5 Mar 2022 23:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/6] ASoC: add DT bindings for Microchip PDMC
Content-Language: en-US
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lars@metafoo.de, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, nicolas.ferre@microchip.com
References: <20220304181756.1894561-1-codrin.ciubotariu@microchip.com>
 <20220304181756.1894561-3-codrin.ciubotariu@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220304181756.1894561-3-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 19:17, Codrin Ciubotariu wrote:
> This patch adds DT bindings for the new Microchip PDMC embedded in
> sama7g5 SoCs.

Do not use "this patch" but simple imperative mode. See submitting patches.

> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  .../devicetree/bindings/sound/mchp,pdmc.yaml  | 99 +++++++++++++++++++
>  include/dt-bindings/sound/mchp,pdmc.h         | 13 +++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mchp,pdmc.yaml
>  create mode 100644 include/dt-bindings/sound/mchp,pdmc.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/mchp,pdmc.yaml b/Documentation/devicetree/bindings/sound/mchp,pdmc.yaml
> new file mode 100644
> index 000000000000..bdf5c52c29d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mchp,pdmc.yaml

mchp is not a proper Microchip vendor prefix. You wanted "microchip"
probably.

> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mchp,pdmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PDMC Device Tree Bindings

s/PDMC/Pulse Density Microphone Controller/
s/Device Tree Bindings//
(title is about hardware)

> +
> +maintainers:
> +  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> +
> +description:
> +  The Microchip Pulse Density Microphone Controller (PDMC) interfaces up to 4 digital microphones
> +  having Pulse Density Modulated (PDM) outputs.
> +
> +properties:
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  compatible:
> +    const: microchip,sama7g5-pdmc

Compatible goes first (and also keep such order in "required").

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral Bus Clock
> +      - description: Generic Clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: gclk
> +
> +  dmas:
> +    description: RX DMA Channel
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
> +
> +  microchip,mic-pos:
> +    description: |
> +      Position of PDM microphones on the DS line and the sampling edge (rising or falling) of the
> +      CLK line. A microphone is represented as a pair of DS line and the sampling edge. The first
> +      microhpone is mapped to channel 0, the second to channel 1, etc.

Lang typo (microphone).

> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: value for DS line
> +        - description: value for sampling edge
> +      anyOf:
> +        - enum:
> +            - [0, 0]
> +            - [0, 1]
> +            - [1, 0]
> +            - [1, 1]
> +    minItems: 1
> +    maxItems: 4
> +    uniqueItems: true
> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - microchip,mic-pos
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/sound/mchp,pdmc.h>
> +
> +    pdmc: pdmc@e1608000 {

Generic node name, so microphone? microphone-controller? sound? audio-codec?

> +        #sound-dai-cells = <0>;
> +        compatible = "microchip,sama7g5-pdmc";

Compatible goes first, then reg.

> +        reg = <0xe1608000 0x4000>;
> +        interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas = <&dma0 AT91_XDMAC_DT_PERID(37)>;
> +        dma-names = "rx";
> +        clocks = <&pmc PMC_TYPE_PERIPHERAL 68>, <&pmc PMC_TYPE_GCK 68>;
> +        clock-names = "pclk", "gclk";
> +        microchip,mic-pos = <MCHP_PDMC_DS0 MCHP_PDMC_CLK_POSITIVE>,
> +                            <MCHP_PDMC_DS0 MCHP_PDMC_CLK_NEGATIVE>,
> +                            <MCHP_PDMC_DS1 MCHP_PDMC_CLK_POSITIVE>,
> +                            <MCHP_PDMC_DS1 MCHP_PDMC_CLK_NEGATIVE>;
> +    };
> diff --git a/include/dt-bindings/sound/mchp,pdmc.h b/include/dt-bindings/sound/mchp,pdmc.h
> new file mode 100644
> index 000000000000..543c424a5a6f
> --- /dev/null
> +++ b/include/dt-bindings/sound/mchp,pdmc.h

Proper vendor prefix.

> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_BINDINGS_MCHP_PDMC_H__
> +#define __DT_BINDINGS_MCHP_PDMC_H__
> +
> +/* PDM microphone's pin placement */
> +#define MCHP_PDMC_DS0 0
> +#define MCHP_PDMC_DS1 1
> +
> +/* PDM microphone clock edge sampling */
> +#define MCHP_PDMC_CLK_POSITIVE 0
> +#define MCHP_PDMC_CLK_NEGATIVE 1
> +
> +#endif /* __DT_BINDINGS_MCHP_PDMC_H__ */


Best regards,
Krzysztof
