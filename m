Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F067D57C785
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiGUJZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiGUJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:25:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE61834D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:25:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so1850536lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n96RspemHv4TX65Onfw5EgIeU668Xeh3IJ491ButWDA=;
        b=aGUJ8Wwql3nBndT7r92NSLtZoQUn0/fNuBuA222WSsO2c8VIx5qTqRivY9R6SoTnHY
         fwJ5Rh9ppUze5NxxfJ1rElwXXc2nSbzr3Mj7jcpBgfDCMFlZF5YkrREmzZzs9IzWSFzA
         1UZ0tfryvJwlBgwY5O0Nw+O+HwlNlsmAhw9PWZ44SP6Zkvqe4wihFgJIuvp3Nph1e7Ix
         AcMbF9PHYxzq75P89IlZT5UMaGq8rNjQ/guySEc2s4cmEoFe0aydwOnJrqJj8pZnMoL5
         wODjhAxsNJBmqzlIIHvKCWwF5dmM6zLNrJADeGU08F8ntkUmVHz36ZfzN+UGhF1HnQYj
         SzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n96RspemHv4TX65Onfw5EgIeU668Xeh3IJ491ButWDA=;
        b=zg1hRjM/ErVAnuFk8EAXnITMV+95W+sNGxVXETfAxDWW4Ovh291iGgHq3xSjyo5ea8
         aemGqYTXH7WHmMn1WJGtINUZBA0HbrDSycjwZvTcffNvxzllhesORnIOU7Wel/OadkNo
         la24z9AiHN1h8XWL/W7F9mwV5wQbYUUt9EvosQ+BUHKqS+372QMTYGAyXNAXR/70WchB
         AYaMI87oXkTzzq4swpni6rIlFjUe3x0cYljCWSmBGEmHnPl9qW3M1OZteBVfFMgjgrFq
         CyDxex1B3iKNwMpuM/Ty45/hRERdbbtgNbaKvtSHoZoW5SC1CAycTnHRwGztEdXQmN6n
         KPnA==
X-Gm-Message-State: AJIora/UcyIKMGvTkjZbvvjJx2IJEFSZUjxn+aVCTvSZLav4K+ER/fOj
        a31AgBTy3UjTP/sIJFkkw699UA==
X-Google-Smtp-Source: AGRyM1sQnHRfTHcPmZmra8mx6Bo0N5OMSaNYFB8TJDTyOp/6lIJ4d9p50U6fT4RliWE31XApjfyHYA==
X-Received: by 2002:a05:6512:10c4:b0:489:de26:cef7 with SMTP id k4-20020a05651210c400b00489de26cef7mr23654431lfg.216.1658395530472;
        Thu, 21 Jul 2022 02:25:30 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id q8-20020a056512210800b00488e50527e0sm323037lfr.112.2022.07.21.02.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:25:29 -0700 (PDT)
Message-ID: <995c7d48-68d1-6c61-4f86-cdd2968b5156@linaro.org>
Date:   Thu, 21 Jul 2022 11:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4
 10.1 (SM-T530)
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
 <20220717213432.134486-4-matti.lehtimaki@gmail.com>
 <dc19c084-633d-9777-6dfd-b9633ac9c4ae@linaro.org>
 <YtWiMP2O9BymNG7/@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YtWiMP2O9BymNG7/@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 20:10, Stephan Gerhold wrote:
> On Mon, Jul 18, 2022 at 03:51:54PM +0200, Krzysztof Kozlowski wrote:
>> On 17/07/2022 23:34, Matti Lehtimäki wrote:
>>> Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T530) wifi tablet
>>> based on the apq8026 platform.
>>>
>>> Currently supported are accelerometer sensor, hall sensor, internal storage, physical
>>> buttons (power & volume), screen (based on simple-framebuffer set up by
>>> the bootloader) sdcard, touchscreen and USB.
>>>
>>> Signed-off-by: Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> ---
>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>  .../dts/qcom-apq8026-samsung-matissewifi.dts  | 475 ++++++++++++++++++
>>>  2 files changed, 476 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 5112f493f494..4d02a1740079 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -1010,6 +1010,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>>  	qcom-apq8016-sbc.dtb \
>>>  	qcom-apq8026-asus-sparrow.dtb \
>>>  	qcom-apq8026-lg-lenok.dtb \
>>> +	qcom-apq8026-samsung-matissewifi.dtb \
>>>  	qcom-apq8060-dragonboard.dtb \
>>>  	qcom-apq8064-cm-qs600.dtb \
>>>  	qcom-apq8064-ifc6410.dtb \
>>> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts
>>> new file mode 100644
>>> index 000000000000..f4c5eb9db11c
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matissewifi.dts
>>> @@ -0,0 +1,475 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022, Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "qcom-msm8226.dtsi"
>>> +#include "qcom-pm8226.dtsi"
>>> +#include <dt-bindings/input/input.h>
>>> +
>>> +/delete-node/ &smem_region;
>>> +
>>> +/ {
>>> +	model = "Samsung Galaxy Tab 4 10.1";
>>> +	compatible = "samsung,matissewifi", "qcom,apq8026";
>>> +	chassis-type = "tablet";
>>> +
>>> +	qcom,msm-id = <0xC708FF01 0 0x20000>,
>>> +		      <0xC708FF01 1 0x20000>,
>>> +		      <0xC708FF01 2 0x20000>,
>>> +		      <0xC708FF01 3 0x20000>;
>>
>> Lower case hex and does not match bindings.
>> https://lore.kernel.org/all/20220705130300.100882-2-krzysztof.kozlowski@linaro.org/
>>
>> This would need detailed explanation because it really does not look
>> correct.
>>
> 
> Just to give the explanation for reference: In general, qcom,msm-id with
> three elements is something Qualcomm used for some old platforms before
> introducing qcom,board-id.
> 
> qcom,msm-id = <X Y Z> should be equivalent to:
>   qcom,msm-id = <X Z>;
>   qcom,board-id = <Y 0>;
> 
> e.g. for apq8026-v2-mtp.dts Qualcomm used:
>    qcom,msm-id = <199 8 0x20000>;
>  = qcom,msm-id = <QCOM_ID_MSM8026 QCOM_BOARD_ID_MTP 0x20000>;
>  = qcom,msm-id = <QCOM_ID_MSM8026 0x20000>;
>    qcom,board-id = <QCOM_BOARD_ID_MTP 0>;
> 
> I guess old bootloaders may or may not accept the new form, depending on
> the age of their code base.
> 
> Then Samsung took this and made it a lot worse, by replacing the SoC ID
> with some random magic number (the 0xC708FF01). And what's even worse is
> that all devices with the same SoC from Samsung use the same magic number
> there. It is completely useless for dynamically matching the device.
> 
> In this case, I suggest just dropping the property because the device is
> supported by lk2nd [1] which can be loaded as intermediary bootloader to
> have a more standard boot process for mainline Linux. When booting
> through lk2nd no qcom,msm-id/qcom,board-id is required, and it also adds
> MAC addresses for WiFi/Bluetooth etc etc. :-)
> 
> [1]: https://github.com/msm8916-mainline/lk2nd
> 
>> [...]
>>> +	reserved-memory {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges;
>>> +
>>> +		framebuffer@3200000 {
>>
>> Generic node names, so memory@
>>
> 
> Rob specifically mentioned at some point that memory@ should not be used
> in reserved-memory [1]. The device tree specification actually recommends
> doing it like it is done here (at least for "framebuffer"):
> 
>> 3.5.2 /reserved-memory/ child nodes
>> Following the generic-names recommended practice, node names should
>> reflect the purpose of the node (ie. “framebuffer” or “dma-pool”).
> 
> [1]: https://lore.kernel.org/linux-arm-msm/CAL_Jsq+66j8Y5y+PQ+mezkaxN1pfHFKz524YUF4Lz_OU5E-mZQ@mail.gmail.com/

Thanks, makes sense a lot!

Best regards,
Krzysztof
