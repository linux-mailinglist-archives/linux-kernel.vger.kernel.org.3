Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA35689BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiGFNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiGFNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:41:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C3324BE4;
        Wed,  6 Jul 2022 06:41:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so9197507wme.0;
        Wed, 06 Jul 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J37bnxv35AKNMkkxULLkWayVHEaMjv0zIAo9khsK/xs=;
        b=Jlle0rhzTTAnWZ/MNh25r/iMQIdPg+Nu4CyuUQnEB3+XRfZWe+9CZwdtvObPWmIv6g
         d913Ju/S7mnMovkMbGewR/EJ+C5hKF2jryill+Reaw1pTWmgv8OAkwAghmrTDutguk4Q
         SDRosAPaNN+hGVT71HuA/B9Esxx0cYVXiQjFvXDsdTGo7ASRZIONNC4+54ApG9tqpPi8
         dAp/BlYJDauy6Cy12yvpidH/bodG8wQQhyC1J0YUuQOVTwNttLSB8AvN8+SX88WjcVbl
         b+DKOSfFHI1jNA6LLUabbhounPawG5AlMa6HNpwSyCeqBqtN+6gRteWmi1fx+JReOXzf
         dCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J37bnxv35AKNMkkxULLkWayVHEaMjv0zIAo9khsK/xs=;
        b=uj5GSzqN3K6buano1Woj+R6wCARO1hqx5b2NyxD//ZyxP481bZRFakKDAHTAnQnmhb
         6bBRnLhAmbBgeQ9Fa6nHk/clrQmugVgO8uf/MrwFfrjVGFKR3mN0GuxV56PvSGX8gPSw
         BZNEdYpaPKFC+Mc/HxiYYkARltDdIbUBt9f9DETUGtcYXTDpoKqSKJxO+UiFwyG+papd
         02yE337vg3EN9N1+MW7CWBWuAMyjpjqIHZzGs+rHWjGQj7p2PAbFLgONukIAe5kOWEMb
         btwh8QYPx+hY1IJIfsnuINOyEtDfig7bgeb02MmhSV40EpDGjedVPoUnzyjWU7RcW17U
         eFVg==
X-Gm-Message-State: AJIora+zZ7whJxJuCHgN/ihCkdbbMe0li6h1aZCBlWf738jN9CUNsT/J
        RFKu6zOZPaTXG9ZC3g76zxc=
X-Google-Smtp-Source: AGRyM1uzrUL3jgHl7v16xkNIYUGr+iA0aegNeob2FrKF9QFhYl/5MRV7Rool8Fm50IsaKRG6foS/1A==
X-Received: by 2002:a05:600c:274b:b0:3a0:47e8:ca85 with SMTP id 11-20020a05600c274b00b003a047e8ca85mr45800324wmw.156.1657114898287;
        Wed, 06 Jul 2022 06:41:38 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d4310000000b0021d7b41255esm2225662wrq.98.2022.07.06.06.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:41:37 -0700 (PDT)
Message-ID: <17203a8a-407e-30cf-79de-352716c3ebce@gmail.com>
Date:   Wed, 6 Jul 2022 15:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
 <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
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



On 04/07/2022 14:38, Krzysztof Kozlowski wrote:
> On 04/07/2022 12:00, Tinghan Shen wrote:
>> Add power domains controller node for mt8195.
>>
>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>   1 file changed, 327 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> index 8d59a7da3271..d52e140d9271 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> @@ -10,6 +10,7 @@
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/phy/phy.h>
>>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>> +#include <dt-bindings/power/mt8195-power.h>
>>   
>>   / {
>>   	compatible = "mediatek,mt8195";
>> @@ -338,6 +339,332 @@
>>   			#interrupt-cells = <2>;
>>   		};
>>   
>> +		scpsys: syscon@10006000 {
>> +			compatible = "syscon", "simple-mfd";
> 
> These compatibles cannot be alone.
> 

You mean we would need something like "mediatek,scpsys" as dummy compatible 
that's not bound to any driver?

>> +			reg = <0 0x10006000 0 0x1000>;
>> +			#power-domain-cells = <1>;
> 
> If it is simple MFD, then probably it is not a power domain provider.
> Decide.

The SCPSYS IP block of MediaTek SoCs group several functionality, one is the 
power domain controller. Others are not yet implemented, but defining the scpsys 
as a MFD will give us the possibility to do so in the future.

Regards,
Matthias

> 
> Best regards,
> Krzysztof
