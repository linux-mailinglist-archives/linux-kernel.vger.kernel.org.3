Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2265ACF88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiIEKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiIEKGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:06:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319C95721A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:05:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bt10so12444784lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mDe4HrG4uEg41My7bBkuCl5g5S/VZFrKNQ+TfpERTIw=;
        b=pL6KsdPpGN8vx+guoN/9sDI2fTIQYSRQ23XeO0oBUWNoMDlQ8GeQ1wymljXpoV6Kyk
         Vzq8VRGfRiAp79OtTlei++CwoC8o6Wgl4Icw6YfMqa16e4Gk9bT1qqp8564T169qoqSH
         Sqqe5Kktsi5SowVpwmZzCHoJSKq1U1YkqM0sxJS+yb8NPbHM0eNx/44ilva8DW+JcYFI
         IZA3qGFV6WhuIKZANEVLyTRIlJFpJcR6P8JMG0J4WuI++NHESawBZAYHxd9vm7muCZRN
         an6QxoREoWZaAS3+tZpYlk4VFOMHTKZAIz5CQfvh+SuDuaI14hlQYiy38rORIaEe2tdl
         1/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mDe4HrG4uEg41My7bBkuCl5g5S/VZFrKNQ+TfpERTIw=;
        b=P4NoLNXYtbuTiWv8rKy/7Un3VwYdFa+njRq6SSqpxC4WxUWYiE4rTWeKYPNGSNrR8y
         AhdO+rGP3Du7cJHMkgKsH7K6FxGT6KXiWMkX2pMrSbwfDvPUqQOhTxgeFewUqDC6Dqtx
         jL9bnlgwxBRjexX2WpALWjSG3S5nu0b1miFPLu/5FxpfJiAlUnlJhv0IJXUqmPgwd0wN
         HXKWJYP4luYrSJJUrE+yZLuaOpCiW3K4cUT4WiNktRxZKSqCh/vXi8ro2fsyX6yBpkOX
         yzp8NOvDq+L1k9rIfhuU41xaNsaYzw16Tke/w1GMqRMolXy1B1uG2wP2KykVmanpz6U/
         +apw==
X-Gm-Message-State: ACgBeo3f80hbtO8DetZj8FGueJ+D+zLDF93z+kwTeTO2iZEcx9QyhNwx
        bkrYwM1gKsRjDEgSSwZ0ALst4g==
X-Google-Smtp-Source: AA6agR65NVdbjPjaLtr2xdntMfgD7vsI/O+8yP6SsfEIl9dauBVNVcbWLhOuH+KrIP9k3b9ouwRtaA==
X-Received: by 2002:a05:6512:1329:b0:492:e050:b0dc with SMTP id x41-20020a056512132900b00492e050b0dcmr17408365lfu.136.1662372351009;
        Mon, 05 Sep 2022 03:05:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b004949f7cbb6esm1144703lfn.79.2022.09.05.03.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:05:50 -0700 (PDT)
Message-ID: <4e5d2fc2-5816-ba31-6a75-da669eddc5cf@linaro.org>
Date:   Mon, 5 Sep 2022 12:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
 <20220831124850.7748-3-johnson.wang@mediatek.com>
 <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
 <67237f85d1c4bc72906848d811988209d0112c06.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <67237f85d1c4bc72906848d811988209d0112c06.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 08:39, Johnson Wang wrote:
> On Wed, 2022-08-31 at 16:19 +0300, Krzysztof Kozlowski wrote:
>> On 31/08/2022 15:48, Johnson Wang wrote:
>>> Add the new binding documentation for MediaTek frequency hopping
>>> and spread spectrum clocking control.
>>>
>>> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>>> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>> ---
>>>  .../bindings/arm/mediatek/mediatek,fhctl.yaml | 49
>>> +++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
>>> l
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
>>> l
>>> new file mode 100644
>>> index 000000000000..c5d76410538b
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
>>> l
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml*__;Iw!!CTRNKA9wMg0ARbw!ysl-bMp7yP9Ym70o6EVB8A36MBxcXGap8doEKR_SbaAQSy8-_RU5jvrWTjzETut_6eXNGut4j-3dY0q7xJdpQbmaOw$
>>>  
>>> +$schema: 
>>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!ysl-bMp7yP9Ym70o6EVB8A36MBxcXGap8doEKR_SbaAQSy8-_RU5jvrWTjzETut_6eXNGut4j-3dY0q7xJezt7_RBw$
>>>  
>>> +
>>> +title: MediaTek frequency hopping and spread spectrum clocking
>>> control
>>> +
>>> +maintainers:
>>> +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
>>> +
>>> +description: |
>>> +  Frequency hopping control (FHCTL) is a piece of hardware that
>>> control
>>> +  some PLLs to adopt "hopping" mechanism to adjust their
>>> frequency.
>>> +  Spread spectrum clocking (SSC) is another function provided by
>>> this hardware.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,fhctl
>>
>> You need SoC/device specific compatibles. Preferably only SoC
>> specific,
>> without generic fallback, unless you can guarantee (while
>> representing
>> MediaTek), that generic fallback will cover all of their SoCs?
>>
> 
> Hi Krzysztof,
> 
> At this moment, we plan to support FHCTL feature for MT8186 only.
> 
> If you prefer SoC-specific compatble, we will improve that in the next
> version.

Then make it only for mt8186.

Best regards,
Krzysztof
