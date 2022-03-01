Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945234C856C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiCAHp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiCAHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:45:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0C56760;
        Mon, 28 Feb 2022 23:44:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v21so18993932wrv.5;
        Mon, 28 Feb 2022 23:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9N9OiuGebRhfkNZJOLbrZK8yGd1uJ/RwgoMHb8+66t8=;
        b=Bd+fGZjkwpi83khB3kaCW3TE7uA/n0ymRuN9QLFQQG4LrHj5rvdwgc1wEwX1Xxn6sq
         DksXh6oU6CV9jSuMHBZvENgFiZud2pXFODfMSYUY6B24NNYWtSbHdkbY1C1b2koSfK8N
         cWfgc47rnHia0nC6rcp7kmcPM2WaJBcMweTZJ73ldxsU5WkDvzbrwXdejlkplE1RXDrb
         Ko3Ss7B4j3V6l0gIMXvvjcLhgknSGYPU0QV5Rry0O2dIp09EgT16VTg1/HM404dVNBJH
         UGYDpiS8V3stQQI9uPZeejn4KCymYULGHOZDo4EB+H/EsNQxSDITLDXHNHEgD4ct5EnX
         SkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9N9OiuGebRhfkNZJOLbrZK8yGd1uJ/RwgoMHb8+66t8=;
        b=JIxfXZCA52AIZ6+hRPo/40ZO8Gy3VFXOGaEi/Vz02wi4IiaQ6yUUnTGWl/z8tk+K5x
         /a2cQ08EWbJ9lTundmx2oFVScjl9vmk4WWycfTPBsMML2FCEooAZqciQj4V8IId34dtK
         Ds6gAc6Vl14bblBinblxYilUOVgNOIyn5C8I6ELovC2OXMr+Ok0U/3HhKn2rLBP+Ut+J
         lyd+XOi3YbieheVgZnKza2RJ7AS/2/YWKZAnvTIhdfjZ2q5ZIIeGlcyxgSeOhKP9Zj69
         YYNRLVW1zAjWcG1Z6Cf14LcH7lx9uWGQdJcrPX38YY5tvpftkSa85K3eaLU2sZSvu4Zf
         3+yA==
X-Gm-Message-State: AOAM532cc/v1ncTtATk9hCcHPLDs34Lk8WOEWxtq408ACTmt1lkKS/Zv
        0tBfwlrhEj2tDYebamYtRDU=
X-Google-Smtp-Source: ABdhPJxBUb5/MBYpZP4ycan/j5lwLp+Y/Q02GVioXh44+q0ranawE0HXM7MhI3mcgC5A8bu7SuyoOw==
X-Received: by 2002:a5d:62c9:0:b0:1ea:940f:d929 with SMTP id o9-20020a5d62c9000000b001ea940fd929mr18519621wrv.164.1646120680070;
        Mon, 28 Feb 2022 23:44:40 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00380e3225af9sm1717859wms.0.2022.02.28.23.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:44:39 -0800 (PST)
Message-ID: <ecb43ffc-48ff-97ab-c411-0597f356dd1a@gmail.com>
Date:   Tue, 1 Mar 2022 08:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/4] arm64: dts: mt6358: add mt6358-keys node
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
 <20220121140323.4080640-5-mkorpershoek@baylibre.com>
 <87v8xps705.fsf@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <87v8xps705.fsf@baylibre.com>
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



On 08/02/2022 16:38, Mattijs Korpershoek wrote:
> Hi Matthias,
> 
> On ven., janv. 21, 2022 at 15:03, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
> 
>> This enables the power,home keys on MediaTek boards with a mt6358 pmic.
>>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Since the driver change has been merged [1], can we queue up the DT change?
> Or should I resubmit this separately?
> 
> Thanks

Applied, thanks!

> 
> [1] https://lore.kernel.org/all/YgIE%2F806gDmRJYCn@google.com/
>> ---
>>   arch/arm64/boot/dts/mediatek/mt6358.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
>> index 95145076b7e6..98f3b0e0c9f6 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
>> @@ -2,6 +2,7 @@
>>   /*
>>    * Copyright (c) 2020 MediaTek Inc.
>>    */
>> +#include <dt-bindings/input/input.h>
>>   
>>   &pwrap {
>>   	pmic: mt6358 {
>> @@ -357,5 +358,16 @@ mt6358_vsim2_reg: ldo_vsim2 {
>>   		mt6358rtc: mt6358rtc {
>>   			compatible = "mediatek,mt6358-rtc";
>>   		};
>> +
>> +		mt6358keys: mt6358keys {
>> +			compatible = "mediatek,mt6358-keys";
>> +			power {
>> +				linux,keycodes = <KEY_POWER>;
>> +				wakeup-source;
>> +			};
>> +			home {
>> +				linux,keycodes = <KEY_HOME>;
>> +			};
>> +		};
>>   	};
>>   };
>> -- 
>> 2.32.0
