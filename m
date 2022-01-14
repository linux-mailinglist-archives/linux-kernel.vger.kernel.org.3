Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631FE48EA16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbiANMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiANMtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:49:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D99C061574;
        Fri, 14 Jan 2022 04:49:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h10so15460151wrb.1;
        Fri, 14 Jan 2022 04:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Abw46UALerxLsOmPP7C+wt8VRbuUvbjsYrXsJ3w0t5c=;
        b=MeKHaejy0QtUUqCztMf3ob7n3XvMH/3w+xXtQmf02LV7ZaNDwigUfJWPzL4qwGdle1
         8tkQBWlfE3fN/aTqlFxcA5KM6qlh6Zwbxg2jdiKrSQ22OA7xUkCC96cX1+qfg2Qg3djr
         +Y7LLdPNkCRswSc1M6zVTBBcRBTzZl738w4IYUmzDPI+8yGrqUMyLG14KoEHx728JSGI
         9Wi8hYiELCgZWiv9p17KMgCJmNUrCUFRIvpHilaR1E0b4jwA+US+PA+UMCMfPY2HtPOM
         hb570ojMTpFgox2Z9ZdnL8GgGUM8sPFrxZDerxkVqMzWLwwQV7HL0wnfAzTfoHBKtV9S
         yLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Abw46UALerxLsOmPP7C+wt8VRbuUvbjsYrXsJ3w0t5c=;
        b=U6mBp6iG8qOFN8LblEG24rcRT9HVrjZ17yMq64RYhVTaYpSyCQ43lCzJOdpLju1Paa
         ttwThm/7Kpx+f/fVLt84MCIEAxDQUv9w39KmOvxQqU9zcBgEKQfUKknCn1gargbM47Us
         IRlpdrOOqBLinPhC7YfYxMNDM487afCP3oyfA+WYdugnPI9ncZdr5UG4bZ7fO4HMwv/c
         pYNmEe26+g3n0yjRXZs4YSTCQatwR3mp+eBlAGaUrrFwZGaKo5optQTr/WIvHBgVMfvD
         2hfxDWq25lt2CEyiMwFSQBRhOHBZDaLZJo4zRo+gd/HIAoutwa0kMz3kYi3/p4pgmEyn
         /AMA==
X-Gm-Message-State: AOAM530bmKggaaxhfiYf+q5FgX/EDKF2H3N55CzjpGpKb2B9vJzDtkO3
        9R6b2oY4y+7twO0zHtasV7t0JyGm7pc=
X-Google-Smtp-Source: ABdhPJzN1iStMrlaWrjW6Yw96OxXnti/SKJXgawksZJN6YpUIg0QPKmcFSJe8rRFAgN4+ke5fGtnxg==
X-Received: by 2002:a05:6000:1a87:: with SMTP id f7mr8504210wry.150.1642164545786;
        Fri, 14 Jan 2022 04:49:05 -0800 (PST)
Received: from [192.168.0.22] ([37.223.145.74])
        by smtp.gmail.com with ESMTPSA id ay39sm5203745wmb.29.2022.01.14.04.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 04:49:05 -0800 (PST)
Message-ID: <ae307028-979b-7e58-dd6f-f1d52520859b@gmail.com>
Date:   Fri, 14 Jan 2022 13:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [v1 1/2] dt-bindings: power: Add MT8186 power domains
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220108131953.16744-1-chun-jie.chen@mediatek.com>
 <20220108131953.16744-2-chun-jie.chen@mediatek.com>
 <Yd43V1woRMAcXOfS@robh.at.kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <Yd43V1woRMAcXOfS@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2022 03:05, Rob Herring wrote:
> On Sat, Jan 08, 2022 at 09:19:52PM +0800, Chun-Jie Chen wrote:
>> Add power domains dt-bindings for MT8186.
>>
>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>> ---
>>   .../power/mediatek,power-controller.yaml      |  1 +
>>   include/dt-bindings/power/mt8186-power.h      | 32 +++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>>   create mode 100644 include/dt-bindings/power/mt8186-power.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> index d6ebd77d28a7..135c6f722091 100644
>> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> @@ -26,6 +26,7 @@ properties:
>>         - mediatek,mt8167-power-controller
>>         - mediatek,mt8173-power-controller
>>         - mediatek,mt8183-power-controller
>> +      - mediatek,mt8186-power-controller
>>         - mediatek,mt8192-power-controller
>>         - mediatek,mt8195-power-controller
>>   
>> diff --git a/include/dt-bindings/power/mt8186-power.h b/include/dt-bindings/power/mt8186-power.h
>> new file mode 100644
>> index 000000000000..ca8ea2d24801
>> --- /dev/null
>> +++ b/include/dt-bindings/power/mt8186-power.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> Dual license please.
> 

Other then that series looks good.

Regards,
Matthias

>> +/*
>> + * Copyright (c) 2022 MediaTek Inc.
>> + * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_POWER_MT8186_POWER_H
>> +#define _DT_BINDINGS_POWER_MT8186_POWER_H
>> +
>> +#define MT8186_POWER_DOMAIN_MFG0			0
>> +#define MT8186_POWER_DOMAIN_MFG1			1
>> +#define MT8186_POWER_DOMAIN_MFG2			2
>> +#define MT8186_POWER_DOMAIN_MFG3			3
>> +#define MT8186_POWER_DOMAIN_SSUSB			4
>> +#define MT8186_POWER_DOMAIN_SSUSB_P1			5
>> +#define MT8186_POWER_DOMAIN_DIS				6
>> +#define MT8186_POWER_DOMAIN_IMG				7
>> +#define MT8186_POWER_DOMAIN_IMG2			8
>> +#define MT8186_POWER_DOMAIN_IPE				9
>> +#define MT8186_POWER_DOMAIN_CAM				10
>> +#define MT8186_POWER_DOMAIN_CAM_RAWA			11
>> +#define MT8186_POWER_DOMAIN_CAM_RAWB			12
>> +#define MT8186_POWER_DOMAIN_VENC			13
>> +#define MT8186_POWER_DOMAIN_VDEC			14
>> +#define MT8186_POWER_DOMAIN_WPE				15
>> +#define MT8186_POWER_DOMAIN_CONN_ON			16
>> +#define MT8186_POWER_DOMAIN_CSIRX_TOP			17
>> +#define MT8186_POWER_DOMAIN_ADSP_AO			18
>> +#define MT8186_POWER_DOMAIN_ADSP_INFRA			19
>> +#define MT8186_POWER_DOMAIN_ADSP_TOP			20
>> +
>> +#endif /* _DT_BINDINGS_POWER_MT8186_POWER_H */
>> -- 
>> 2.18.0
>>
>>
