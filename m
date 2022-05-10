Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B60520B24
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiEJC1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiEJC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:27:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5C2A7C08;
        Mon,  9 May 2022 19:23:35 -0700 (PDT)
X-UUID: 6c3449fd3a5643298e045fc5dac444db-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0edc4465-f77d-4529-85e9-4aca71546ff5,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:d5a1d116-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 6c3449fd3a5643298e045fc5dac444db-20220510
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1814271490; Tue, 10 May 2022 10:23:26 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 10:23:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 May 2022 10:23:24 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 10 May 2022 10:23:24 +0800
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-2-rex-bc.chen@mediatek.com>
 <a5c9e7ad-c4b5-e757-cd6d-f79de47d1ff3@linaro.org>
 <fbbbc7e6a951bdde648ddd896f1fa163dafa16f1.camel@mediatek.com>
Message-ID: <8273e75d-2a8b-ad6c-2246-ad33e435c733@mediatek.com>
Date:   Tue, 10 May 2022 10:23:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fbbbc7e6a951bdde648ddd896f1fa163dafa16f1.camel@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/9/22 4:45 PM, Rex-BC Chen wrote:
> On Mon, 2022-05-09 at 15:31 +0800, Krzysztof Kozlowski wrote:
>> On 09/05/2022 06:43, Rex-BC Chen wrote:
>>> From: "Nancy.Lin" <nancy.lin@mediatek.com>
>>>
>>> Add vdosys1 RDMA definition.
>>>
>>> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>> ---
>>>   .../display/mediatek/mediatek,mdp-rdma.yaml   | 94
>>> +++++++++++++++++++
>>>   1 file changed, 94 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>>> rdma.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>>> rdma.yaml
>>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>>> rdma.yaml
>>> new file mode 100644
>>> index 000000000000..ca31accb0a95
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>>> rdma.yaml
>>> @@ -0,0 +1,94 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:
>>> https://urldefense.com/v3/__http://devicetree.org/schemas/display/mediatek/mediatek,mdp-rdma.yaml*__;Iw!!CTRNKA9wMg0ARbw!x6pqRSLbN1fx6j57PKXCTTp8n7bulgpLzXS8uUh5vAIxkRKD8K6EqOopnFrXvT54LQXmIEDFFvPQzC4ldr1TddEeTw$
>>>   
>>> +$schema:
>>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!x6pqRSLbN1fx6j57PKXCTTp8n7bulgpLzXS8uUh5vAIxkRKD8K6EqOopnFrXvT54LQXmIEDFFvPQzC4ldr3y-9sW3w$
>>>   
>>> +
>>> +title: MediaTek MDP RDMA
>>> +
>>> +maintainers:
>>> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>> +  - Philipp Zabel <p.zabel@pengutronix.de>
>>> +
>>> +description:
>>> +  The MediaTek MDP RDMA stands for Read Direct Memory Access.
>>> +  It provides real time data to the back-end panel driver, such as
>>> DSI,
>>> +  DPI and DP_INTF.
>>> +  It contains one line buffer to store the sufficient pixel data.
>>> +  RDMA device node must be siblings to the central MMSYS_CONFIG
>>> node.
>>> +  For a description of the MMSYS_CONFIG binding, see
>>> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya
>>> ml for details.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>> oneOf is not needed
>>
>>> +      - items:
>> items not needed, you have only one item.
>>
> Hello Krzysztof,
>
> Thanks for your review.
> ok, we will drop them.
>
>>> +          - const: mediatek,mt8195-vdo1-rdma
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  power-domains:
>>> +    description: A phandle and PM domain specifier as defined by
>>> bindings of
>>> +      the power controller specified by phandle. See
>>> +      Documentation/devicetree/bindings/power/power-domain.yaml
>>> for details.
>> Skip description, it's obvious. Instead maxItems.
>>
> ok, we will fix it.
>
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: RDMA Clock
>>> +
>>> +  iommus:
>>> +    description:
>>> +      This property should point to the respective IOMMU block
>>> with master port as argument,
>>> +      see
>>> Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for
>>> details.
>> Skip description, it's obvious. Instead maxItems.
>>
> ok, we will fix it.
>
>>> +
>>> +  mediatek,gce-client-reg:
>>> +    description:
>>> +      The register of display function block to be set by gce.
>>> There are 4 arguments,
>>> +      such as gce node, subsys id, offset and register size. The
>>> subsys id that is
>>> +      mapping to the register of display function blocks is
>>> defined in the gce header
>>> +      include/include/dt-bindings/gce/<chip>-gce.h of each chips.
>> Double "include" in the path.
> ok, we will fix it.
>
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    items:
>>> +      items:
>>> +        - description: phandle of GCE
>>> +        - description: GCE subsys id
>>> +        - description: register offset
>>> +        - description: register size
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - power-domains
>>> +  - clocks
>>> +  - iommus
>>> +  - mediatek,gce-client-reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/clock/mt8195-clk.h>
>>> +    #include <dt-bindings/power/mt8195-power.h>
>>> +    #include <dt-bindings/gce/mt8195-gce.h>
>>> +    #include <dt-bindings/memory/mt8195-memory-port.h>
>>> +
>>> +    soc {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        vdo1_rdma0: mdp-rdma@1c104000 {
>> Generic node name. dma-controller (if it does not conflict with
>> dma-common.yaml schema)?
> We don't understand what dma-controller you are referring to? Can you
> help explain more? Thanks!
>
> BRs,
> Rex
Hello Krzysztof,


Could you also help us to explain what do you mean here?

Thanks!


BRs,

Rex
>>> +            compatible = "mediatek,mt8195-vdo1-rdma";
>>> +            reg = <0 0x1c104000 0 0x1000>;
>>> +            interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +            clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
>>> +            power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
>>> +            iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
>>> +            mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX
>>> 0x4000 0x1000>;
>>> +        };
>>> +    };
>>
>> Best regards,
>> Krzysztof
