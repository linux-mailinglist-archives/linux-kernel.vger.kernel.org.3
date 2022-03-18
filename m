Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08174DDB0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiCRN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiCRN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:57:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E01E03E;
        Fri, 18 Mar 2022 06:56:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1F1091F46053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647611787;
        bh=WW2IaA9n9cAPDlRSBj0mOwH/eH4P6GAUHKgCpdJwtmk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cpq6UFB+YPJAAY2YBpwTmpzQvUCgl7GvqK1HuV1xf3r6N3v0ler0buDb+ai0A/jHg
         9Pv0tuip/gPib6cd74DG0i+AEYQlH0+7fZdItTRDaq/R53taqgnCWWf7X79s+PY+61
         Q6v6agGDq8DxEmY2bgHkLk3NOdmsSEqfMlmDCBHCbpoFVdKa3/e/FwBe1SFPWMdemY
         RAod8cX7rzlUeBXa8cAXMFY/11pDV3hND3U+x23NGF2g2mteaPDhoa/BGn+qf7JEWL
         ZTNtaqYeeOgaveAUNgAT3gdOWiADOgW50bNzrFPVJHuudZPlKsz8FADZ13rGlle6Xr
         mCl1Of2Malo7Q==
Message-ID: <e0adbb4d-aa87-49ea-d79f-11c5f4fc4bdd@collabora.com>
Date:   Fri, 18 Mar 2022 14:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220318095417.2016-1-jianjun.wang@mediatek.com>
 <20220318095417.2016-2-jianjun.wang@mediatek.com>
 <2e0989c3-7132-6091-5c9e-5dc8d9af22e8@collabora.com>
 <319cf016-55fb-dcd4-9157-ad795c8e68ff@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <319cf016-55fb-dcd4-9157-ad795c8e68ff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/22 14:51, Krzysztof Kozlowski ha scritto:
> On 18/03/2022 12:12, AngeloGioacchino Del Regno wrote:
>> Il 18/03/22 10:54, Jianjun Wang ha scritto:
>>> Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
>>>
>>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>>> ---
>>>    .../bindings/phy/mediatek,pcie-phy.yaml       | 75 +++++++++++++++++++
>>>    1 file changed, 75 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
>>> new file mode 100644
>>> index 000000000000..868bf976568b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek PCIe PHY
>>> +
>>> +maintainers:
>>> +  - Jianjun Wang <jianjun.wang@mediatek.com>
>>> +
>>> +description: |
>>> +  The PCIe PHY supports physical layer functionality for PCIe Gen3 port.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,mt8195-pcie-phy
>>
>> Since I don't expect this driver to be only for MT8195, but to be extended to
>> support some more future MediaTek SoCs and, depending on the number of differences
>> in the possible future Gen4 PHYs, even different gen's, I propose to add a generic
>> compatible as const.
>>
>> So you'll have something like:
>>
>> - enum:
>>       - mediatek,mt8195-pcie-phy
>> - const: mediatek,pcie-gen3-phy
> 
> I am not sure if this is a good idea. How sure are you that there will
> be no different PCIe Gen3 PHY not compatible with this one?
> 
> 

Thanks for pointing that out, I have underestimated this option.

Perhaps Jianjun may be more informed about whether my proposal is valid or not.

Cheers,
Angelo

> Best regards,
> Krzysztof


