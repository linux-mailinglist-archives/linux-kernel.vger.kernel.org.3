Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D800E59C1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiHVOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiHVOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:32:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D496625591;
        Mon, 22 Aug 2022 07:32:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k9so13483803wri.0;
        Mon, 22 Aug 2022 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7W0NtRs1a+HnAZF8WxCP/7uaE2NAZOPRvf7+mKgpA6I=;
        b=B0DsZruWeU84g1O0GjJrHrLVDnDWh8To44CdJW6TtZ23Eq0wpaq0OKg7ytELSq2Tpe
         5F0K9mhGHr0AHrRwjEhp5FFKRgVGh7EPg1wL1fD95nX3DAQmnIP49n6IpWpmn3qDpqah
         pZmFi2fuZptnfQ2ph/r11xKqJfbT5VSK7xXYKXIeRhdx89hrLPw9G9+/KcTlvThCzrX5
         FnPVeAuyZdE0JR6aNN7ydX3K88bq/TMq45ezYoq1mmqA+QAeHeAnIsDqoO2sg7vMM3h3
         8I3XMKZKVDlEk4SECdB9UUmWvHLt1Z1k64OzUBJBC1XGJ4rAIy398GkkzkdWEhSxfdqg
         tnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7W0NtRs1a+HnAZF8WxCP/7uaE2NAZOPRvf7+mKgpA6I=;
        b=aoCVfwhbqLAu54PRjKIdjKwBfBadGAqUS0FjFGSEw+gZFeb4qei6TJqlJ+Abru4sqa
         1qwPbSYoXKGHNCpWnxDs6836blqtcxFB2IQWs8/uujcYvk22kfbx6U5WCow+FlqafEjm
         j4Y2KuPP1nyDBuujlDAe9E9D59hG6iXVKAyS5DIBDfmJmcUOmkokEbU3B+otoOkr/MPI
         +yzxKB1BJQimYv5T29fhctyNCNaDh2HAwtmEXCp/BmD8kQDJw9jEa+NDQ1tsGymGJH4s
         2QMn5V4wMyvLlUh3o7JisYMqVQ28D5DRLZ/y+q1+gbjPyPwMqt2dJJsekLRIGEI7F6ik
         QhsA==
X-Gm-Message-State: ACgBeo3BAuX9MNpB3EC8MjGItuEXRcajm5LmF1I13AzOD8KT35mpXOUh
        xFdKUmlkvnBs4CPicXQbtgE=
X-Google-Smtp-Source: AA6agR5e3o2Blq3xaLoXA2xkP2NLcjopdXuk3V4hdRXw3W7yZMKDtnp45qJoeA1LqsS+QKS11mgsNA==
X-Received: by 2002:a05:6000:108b:b0:225:23d4:b2bd with SMTP id y11-20020a056000108b00b0022523d4b2bdmr11392999wrw.497.1661178735355;
        Mon, 22 Aug 2022 07:32:15 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600c4e0a00b003a603fbad5bsm15413845wmq.45.2022.08.22.07.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 07:32:14 -0700 (PDT)
Message-ID: <19c4e6ec-8252-1b25-6999-a0b24bbf7dbb@gmail.com>
Date:   Mon, 22 Aug 2022 16:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v25 2/4] dt-binding: mediatek: add bindings for MediaTek
 CCORR and WDMA
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com
References: <20220817095629.29911-1-moudy.ho@mediatek.com>
 <20220817095629.29911-3-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220817095629.29911-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2022 11:56, Moudy Ho wrote:
> This patch adds DT binding documentation for MediaTek's CCORR and
> WDMA components.
> These components exist in both MediaTek's Media Data Path 3(MDP3) and DRM,
> and the bindings are placed under the folder "./soc/mediatek" to prevent
> duplicate builds.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../bindings/soc/mediatek/mediatek,ccorr.yaml | 68 ++++++++++++++++
>   .../bindings/soc/mediatek/mediatek,wdma.yaml  | 81 +++++++++++++++++++
>   2 files changed, 149 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> new file mode 100644
> index 000000000000..10786d769750
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,ccorr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek color correction
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>

Same here.

Regards,
Matthias

> +
> +description: |
> +  MediaTek color correction with 3X3 matrix.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-ccorr
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +
> +  mediatek,gce-events:
> +    description:
> +      The event id which is mapping to the specific hardware event signal
> +      to gce. The event id is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  clocks:
> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - mediatek,gce-events
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/gce/mt8183-gce.h>
> +
> +    mdp3_ccorr: mdp3-ccorr@1401c000 {
> +      compatible = "mediatek,mt8183-mdp3-ccorr";
> +      reg = <0x1401c000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xc000 0x1000>;
> +      mediatek,gce-events = <CMDQ_EVENT_MDP_CCORR_SOF>,
> +                            <CMDQ_EVENT_MDP_CCORR_EOF>;
> +      clocks = <&mmsys CLK_MM_MDP_CCORR>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> new file mode 100644
> index 000000000000..95ec19543945
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,wdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Write Direct Memory Access
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> +
> +description: |
> +  MediaTek Write Direct Memory Access(WDMA) component used to write
> +  the data into DMA.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-wdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +
> +  mediatek,gce-events:
> +    description:
> +      The event id which is mapping to the specific hardware event signal
> +      to gce. The event id is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - mediatek,gce-events
> +  - power-domains
> +  - clocks
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/gce/mt8183-gce.h>
> +    #include <dt-bindings/power/mt8183-power.h>
> +    #include <dt-bindings/memory/mt8183-larb-port.h>
> +
> +    mdp3_wdma: mdp3-wdma@14006000 {
> +      compatible = "mediatek,mt8183-mdp3-wdma";
> +      reg = <0x14006000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
> +      mediatek,gce-events = <CMDQ_EVENT_MDP_WDMA0_SOF>,
> +                            <CMDQ_EVENT_MDP_WDMA0_EOF>;
> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +      clocks = <&mmsys CLK_MM_MDP_WDMA0>;
> +      iommus = <&iommu>;
> +    };
