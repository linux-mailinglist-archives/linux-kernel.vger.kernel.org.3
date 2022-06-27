Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77255C4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiF0IpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiF0IpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:45:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430806320
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:45:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ge10so17584733ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=NGASEu1UuSCF/KBZiD+Xxr1++0cQqP/bZ9atPVdxcAE=;
        b=zwOiD2QKTBHyIkb8zfy5wq7S5Mww4LyKRvCXX8L0AZh2gXCJhELBJ8f0A/XkDSVso8
         L7FBqCQ1oH/jJ7cFNnDxOLM/sxfKCUrrkCofLhaw/momIYZMHhEHZpJOHEGUvzLRPMh4
         rqABqqzgmYQTAm8yw7R/n9Gp1l3nYBMiMTmNfrZEKRXHZTTnQcnweoEk611FTXs1sScD
         bvalF3SeBbnDxo1XZ1qikeONNl6gzZMDT5bG46uL+RNIiPovs1XXqW+jtfcH05Uy5ReG
         T8MCvFHPt4EpHEJr1g0CDlWrQK1ioh748xirTzj8Kbs2i655NcUaO0jeW/cPQxhpyMJi
         brBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=NGASEu1UuSCF/KBZiD+Xxr1++0cQqP/bZ9atPVdxcAE=;
        b=bZFeB3VVZSSYECaTxtT1xwInr8MscI+UQgiD/dg8DPp57s/hdjAUICIo0MPxP0g0OQ
         ZMb/1q17YYTeO0P82QQX9o3ABQNtbs4DJmpvfDvE2w8iqW4ellVx5Z+0UJzanN2WoHtL
         i85cJ9e1F67QFGwQFu0OOKt4YkJLhJJt8+4oNXuoHo4rQGkzCeq2gSckPnQqAiJfT1My
         dSElONJ1Ko+8sllL56V4JS0IrACvn24d44FGW4yB9B22rLzV1iOq724Qz8FE7ry+LmVq
         VPBAffG3W5XsBDkhrNWFDyStlg9m5USazhMiKfLVomFNN334VFvwpizXHyOeEm/o8dsX
         o7YA==
X-Gm-Message-State: AJIora9/tQfR0yVg14krYCeE/nSLzD+KSJScpxfQpWfR/a+CqNFZErj/
        qMQW5sUbdU8JU58RzvUmJ4x4BQ==
X-Google-Smtp-Source: AGRyM1v5eWfRK0YQoqHluU652Yu0VL9rjqD1R4mOxvp/6i3wbLE6ekpCxsFI+Ofij4URWX6raZwyEA==
X-Received: by 2002:a17:906:8315:b0:726:38da:f0f with SMTP id j21-20020a170906831500b0072638da0f0fmr11685646ejx.462.1656319505768;
        Mon, 27 Jun 2022 01:45:05 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906595200b006f3ef214e20sm4685683ejr.134.2022.06.27.01.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:45:05 -0700 (PDT)
Message-ID: <724bca0f-2474-0aba-35df-6733bb5597d3@linaro.org>
Date:   Mon, 27 Jun 2022 10:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 19/40] arm64: dts: tegra: align gpio-key node names
 with dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-19-krzysztof.kozlowski@linaro.org>
 <YrXhb5izGPNXEmMK@orome> <dcd4be85-21ab-beb9-e6dc-bd7f570459fd@linaro.org>
In-Reply-To: <dcd4be85-21ab-beb9-e6dc-bd7f570459fd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 18:09, Krzysztof Kozlowski wrote:
> On 24/06/2022 18:08, Thierry Reding wrote:
>> On Wed, Jun 15, 2022 at 05:53:12PM -0700, Krzysztof Kozlowski wrote:
>> [...]
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
>>> index f16acb4cabaa..62d58221ad3c 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
>>> @@ -1030,7 +1030,7 @@ clk32k_in: clock-32k {
>>>  	gpio-keys {
>>>  		compatible = "gpio-keys";
>>>  
>>> -		lid {
>>> +		switch-lid {
>>>  			label = "Lid";
>>>  			gpios = <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_LOW>;
>>>  			linux,input-type = <5>;
>>> @@ -1039,7 +1039,7 @@ lid {
>>>  			wakeup-source;
>>>  		};
>>>  
>>> -		power {
>>> +		switch-power {
>>
>> This one is actually a key.
>>
>> [...]
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>>> index a263d51882ee..8494c7b2961b 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> [...]
>>> @@ -1772,7 +1772,7 @@ lid {
>>>  			wakeup-source;
>>>  		};
>>>  
>>> -		tablet_mode {
>>> +		key-tablet-mode {
>>>  			label = "Tablet Mode";
>>>  			gpios = <&gpio TEGRA_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
>>>  			linux,input-type = <EV_SW>;
>>
>> And this one more like a switch since it's triggered by a magnet, as far
>> as I understand.
>>
>> No need to resend, I can fix these up when I apply. Just let me know if
>> you have any objections to me making those changes.
> 
> Sounds good, thanks for catching these.


Hi Thierry,

To be more explicit - no objects for taking these, please apply.

Best regards,
Krzysztof
