Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C354DDAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiCRNw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiCRNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:52:58 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13B914003;
        Fri, 18 Mar 2022 06:51:39 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w27so14214540lfa.5;
        Fri, 18 Mar 2022 06:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b9OLIL3FU7iqHaTzdpvx9tQ2K5mp7MDYbZXYpsTAN0g=;
        b=6sPVF8feYiio5yO03/5gLoyx7CmPsUvcUiO0etZ/0n4kqZ/6HjCpaiamBzuyXc8LBg
         kQSfgZ0eXeqjujkFepLgGGY1WrpSNgmJD11H0ZsT08M5s5efoHgaEUbDz+3eakYUB1DL
         9TFSfjsncKneAsEVrKJKzit0NTrXWtvirjAZex59ZQkIwbRysx6aO6aSKO8aaOlEYZwp
         xyCWfIfn4PswklpvHzMv4nrZxDRwX4TG/Qg65W0VBJSkvPbcM/kloJlWgLqHCP98GjPG
         DqBtl3CKYG0HYZFBz9R03foZxtJ8CY6oxRFnRaAm/R0TOhGOaVBznDGVv2eUDIHiDQHB
         4fpQ==
X-Gm-Message-State: AOAM532Ba6OaPlatfJR9ElgxYBD/q55rtQHu2fb58rEo9i+cWIUvi4q4
        RPxRuZ/uYdbNAHQsOD12Ni4=
X-Google-Smtp-Source: ABdhPJx7X5h60uL0s5bvwhRfCRBZftSK7GqJvL9XYD9AW6eJxvInfetEBomo2GlVtSq5cQ5G2u2Xag==
X-Received: by 2002:a05:6512:1513:b0:448:39c0:def0 with SMTP id bq19-20020a056512151300b0044839c0def0mr5961595lfb.469.1647611497912;
        Fri, 18 Mar 2022 06:51:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l26-20020a2e701a000000b002463f024de9sm967013ljc.110.2022.03.18.06.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:51:37 -0700 (PDT)
Message-ID: <319cf016-55fb-dcd4-9157-ad795c8e68ff@kernel.org>
Date:   Fri, 18 Mar 2022 14:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2e0989c3-7132-6091-5c9e-5dc8d9af22e8@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 12:12, AngeloGioacchino Del Regno wrote:
> Il 18/03/22 10:54, Jianjun Wang ha scritto:
>> Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
>>
>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>> ---
>>   .../bindings/phy/mediatek,pcie-phy.yaml       | 75 +++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
>> new file mode 100644
>> index 000000000000..868bf976568b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek PCIe PHY
>> +
>> +maintainers:
>> +  - Jianjun Wang <jianjun.wang@mediatek.com>
>> +
>> +description: |
>> +  The PCIe PHY supports physical layer functionality for PCIe Gen3 port.
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt8195-pcie-phy
> 
> Since I don't expect this driver to be only for MT8195, but to be extended to
> support some more future MediaTek SoCs and, depending on the number of differences
> in the possible future Gen4 PHYs, even different gen's, I propose to add a generic
> compatible as const.
> 
> So you'll have something like:
> 
> - enum:
>      - mediatek,mt8195-pcie-phy
> - const: mediatek,pcie-gen3-phy

I am not sure if this is a good idea. How sure are you that there will
be no different PCIe Gen3 PHY not compatible with this one?


Best regards,
Krzysztof
