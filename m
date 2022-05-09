Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56FD51F5C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiEIHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiEIHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:35:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3E91271A0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:31:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p18so15188482edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A8pj1+wMsIZD+HTmycpfJEnCkNCLx0gmUucobTkIYaQ=;
        b=h+/nQjrNWIm/+IzgiaU+RfjfBcP8yy2to76CRpsCWL6uieGrlrTVnxYL/R3JFfiWsX
         t36+98kYMes6YSrsZXJHznPejjDhLdU8rj4MzXY25aYYGWxSBIwGyIVHaU+MQg6qOBFX
         IHYx8i81PL33awO2cbqEztnQLnP4l8bSlOkqK0ubcIA4qsyRF3i2e9UAwvDEdZqb7jvP
         bAG8fIpRCNDY93VHZePYN2AhuJmwMwsXjVexhwkufB3noX7N9Y8nCZJWXVs/1cMxrK4L
         OjfDbonWgvZWhkG5T/Vp1uJ0q/JuzdPGEmgQWP4Te2W/zAbO63kENVphxeqV+g7H+69H
         mPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A8pj1+wMsIZD+HTmycpfJEnCkNCLx0gmUucobTkIYaQ=;
        b=NKZ7Qzi1N66+DG7/N+Q8XUzxxZSX6prr78AA3RBkI0LzQunZIPmMw5GYK0rh+DaVH+
         LfX6zQRV5DmDkCeSBRSgOjAHtTqH9v00A9X00NflSsDbRh4uKJVs/XEMNQxPkya+6Jsu
         FZuKTgaqI4M12iPw/FVL5IlUTYjbPDUHyEKyE1MrzNUVO3ox5J4NsYGtN/G1z+ZoLCKi
         T0MGvfyxQjJLHwjz7aOZsg9Sn+HFIQ9qxPj3vJkiXNyqwqS5gjbpo2RNZSiKJiJScGY9
         8YK+d0g2/Hrhhj7FTQrGPkTH2iDYQyHmzC6TZ4XFPC+Evto0uAS2vgOFmjgHFIXQ/bKj
         UYaQ==
X-Gm-Message-State: AOAM530YE9wvtgMS8gcHzPgNIB3BnogySmV0+tWnya+kDk4VyvB8UW4T
        Vv7nxWq5tZw1pP6xhOUMquZRnA==
X-Google-Smtp-Source: ABdhPJxlWjAFIEPsqpoSUm5gzanVawOJDQfbWbKqKN8sD/EsEk+84GEF8xhbJ/wD76HV8JoK4Xlh4Q==
X-Received: by 2002:a05:6402:5243:b0:427:caa4:f75 with SMTP id t3-20020a056402524300b00427caa40f75mr16216381edd.153.1652081508151;
        Mon, 09 May 2022 00:31:48 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yl26-20020a17090693fa00b006f3ef214de2sm4753139ejb.72.2022.05.09.00.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:31:47 -0700 (PDT)
Message-ID: <a5c9e7ad-c4b5-e757-cd6d-f79de47d1ff3@linaro.org>
Date:   Mon, 9 May 2022 09:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de
Cc:     airlied@linux.ie, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220509044302.27878-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 06:43, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> new file mode 100644
> index 000000000000..ca31accb0a95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mdp-rdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MDP RDMA
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description:
> +  The MediaTek MDP RDMA stands for Read Direct Memory Access.
> +  It provides real time data to the back-end panel driver, such as DSI,
> +  DPI and DP_INTF.
> +  It contains one line buffer to store the sufficient pixel data.
> +  RDMA device node must be siblings to the central MMSYS_CONFIG node.
> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml for details.
> +
> +properties:
> +  compatible:
> +    oneOf:

oneOf is not needed

> +      - items:

items not needed, you have only one item.

> +          - const: mediatek,mt8195-vdo1-rdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    description: A phandle and PM domain specifier as defined by bindings of
> +      the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for details.

Skip description, it's obvious. Instead maxItems.

> +
> +  clocks:
> +    items:
> +      - description: RDMA Clock
> +
> +  iommus:
> +    description:
> +      This property should point to the respective IOMMU block with master port as argument,
> +      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.

Skip description, it's obvious. Instead maxItems.

> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of display function block to be set by gce. There are 4 arguments,
> +      such as gce node, subsys id, offset and register size. The subsys id that is
> +      mapping to the register of display function blocks is defined in the gce header
> +      include/include/dt-bindings/gce/<chip>-gce.h of each chips.

Double "include" in the path.

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - iommus
> +  - mediatek,gce-client-reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +    #include <dt-bindings/gce/mt8195-gce.h>
> +    #include <dt-bindings/memory/mt8195-memory-port.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        vdo1_rdma0: mdp-rdma@1c104000 {

Generic node name. dma-controller (if it does not conflict with
dma-common.yaml schema)?

> +            compatible = "mediatek,mt8195-vdo1-rdma";
> +            reg = <0 0x1c104000 0 0x1000>;
> +            interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
> +            clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
> +            power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +            iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
> +            mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x4000 0x1000>;
> +        };
> +    };


Best regards,
Krzysztof
