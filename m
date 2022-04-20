Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE4A508177
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357887AbiDTGvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiDTGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:51:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADFE6576
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:48:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s18so1585555ejr.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=9uzVgdbnNBXZaj+xly+bx359WI4zRoQI5FjtgADEBW0=;
        b=S1hEIoiDmJQ5F60K6iW2OrVRkegrcBBnOiVG/QccBRbUzlvLB7dozEncz0TnysxDv2
         FNqn0DTAOA4Q2I7V8GVKaw1i2NPEeQXKphyrqggpzxaDYUSClbIhcQp0+9i6iYSFu7bS
         3izRWeFlXNNCXQssXVTHnL4FoKkdgGPoQ2vQMrWlaKAobfQmVkpSXD8j7qGeGRSANGYD
         qSiNfQSnN7UgnguVZfXmP7KljNKkZ8YHOB98cA5LtbxLKR3AUqxhR2xNu8ZcjoeWHIOB
         keopxTJEGVgV6/z+1eDrgrEgVnXYMJyKfXrVB7Uyf5nlhLCH30oUjauesWLm7jKti+aS
         VafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=9uzVgdbnNBXZaj+xly+bx359WI4zRoQI5FjtgADEBW0=;
        b=EUUhw3eBf+SODTLzk/or0GBgj08F5l8tClq9nBW/YNpsRC+qGmMtt1GfC6c4H8lW/Y
         QZjIM3inzKkakFc9MalZetzwwW9rDQpVNRMoy5YKxL0vXeG44wNZ37Zqoj4Exv/KiNT4
         A5Oi2b+17Xbj8DDtGVFU3EdxH0o1+zzI/GqAbtYztJuKoov0psEj/wuxA1oQD47n5tIa
         XcAd712aEcAxdwO2lswJCaE34hvh/DxXuniPcnbkDew2uiD6vTSM+OGXLat1aOZit5Z5
         Wx6cpfRPMq5+kKdzyDNs1o3O7VdNQl7pgmW3+sq7RutLFyaMPeTXX9VgXEYLmqJhEelV
         btrg==
X-Gm-Message-State: AOAM5325O7sA/fZCGDpPPS50gcrnwzQoNlJ8AU8URkG15sq5KYlJqt97
        0F1jYLIsgAgrI3buGa3C5akoMw==
X-Google-Smtp-Source: ABdhPJwWVmNshJAW0tGWYuRLU9jbNedM/km5ShG0Ei7YXEVHAQ+JyhA9HCOy1DRMF98ygrtJdvPgvg==
X-Received: by 2002:a17:907:d16:b0:6d6:e3b6:9cd8 with SMTP id gn22-20020a1709070d1600b006d6e3b69cd8mr16733035ejc.94.1650437331372;
        Tue, 19 Apr 2022 23:48:51 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906304600b006ef5da1b1besm5171288ejd.221.2022.04.19.23.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 23:48:50 -0700 (PDT)
Message-ID: <df786c5c-f522-1b24-dc3e-b4dcf3049cbe@linaro.org>
Date:   Wed, 20 Apr 2022 08:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: mediatek: topckgen: Convert to DT
 schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220419180938.19397-1-y.oudjana@protonmail.com>
 <20220419180938.19397-2-y.oudjana@protonmail.com>
 <efc6d3ee-b060-b070-1471-af940428964a@linaro.org>
In-Reply-To: <efc6d3ee-b060-b070-1471-af940428964a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 08:47, Krzysztof Kozlowski wrote:
> On 19/04/2022 20:09, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Convert topckgen bindings to DT schema format. MT2701, MT7623 and
>> MT7629 device trees currently have the syscon compatible without
>> it being mentioned in the old DT bindings file which introduces
>> dtbs_check errors when converting to DT schema as-is, so
>> mediatek,mt2701-topckgen and mediatek,mt7629-topckgen are placed
>> in the last items list with the syscon compatible, and syscon is
>> added to the mediatek,mt7623-topckgen list.
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml
>> new file mode 100644
>> index 000000000000..9ce9cf673cbc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,topckgen.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: MediaTek Top Clock Generator Controller
>> +
>> +maintainers:
>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>> +
>> +description:
>> +  The Mediatek topckgen controller provides various clocks to the system.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
> 
> These are not a list, so skip items. Just enum. Rest looks good.

Actually one more through - this looks like clock-controller, so please
move the binding to ../bindings/clock/ directory.


Best regards,
Krzysztof
