Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10783559E47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiFXQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFXQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:09:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397DA419B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:09:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lw20so5677644ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6gvRufNhBM/xZmT8OAxBWgGHDBASE7DNVJwEcxuAfPE=;
        b=Cx89vn52ESGCQtTlL29RVi/XgLFvM8XFlt/SV26by6aXieczn+IDzFnSz+x/zBzUs4
         k4EcbfFFZectmSD7JHVjV7CciPu1YJpsG86QnPY5mkKoV9jOMgifYVe+iz1jU3C5sYMu
         td/R3lhGwizYszf1fpW2U3f3Xr8aoBaa63juyzjbJWA5A4g/m2GKvoH842Fs45mXj9o9
         Pq9t7p9dzSDl80bqodZpA/ndegN8ch1FwwPH+huColD8WyTwK63N2eRxj+8Oa38/pLwK
         hGgzK76csb7DvRGrqczRVYQJoYNeM0Eb6kt3xhCNKhWV1MMhgcm9i3/XYtFJILinYTH/
         dZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6gvRufNhBM/xZmT8OAxBWgGHDBASE7DNVJwEcxuAfPE=;
        b=WYLIuvtDhz+oNTh8r38v9V/5cMNr8T/sterKhjOA03nIfsLfGY+U2Z17MPnYuXYLoT
         WQ7jZlGXUzXPjpl08VGU5A0njS9rokLOYxe8gPvZ3F7Itf8Ba1aD+xhF2Bdeb/vnBQNM
         yibXWfuZYtXkqb5mBbDMuPzQY5qFGlQEvdAMm3qVPOJqHY0JyLdRP06WkD6zLMyfqsvc
         XOuBx6JGAFQRxH806DsDqskg4mdTQskYV2kX8IrZwsYoOhRk7Ko62KUiAbGZrr5g8XJB
         pnWrtlnYoIiE9qfFEq7Rn35ROayONQH8+EiKpXx+VRvc4dp6OT4syekl5i5FbzX8hIq4
         QoDw==
X-Gm-Message-State: AJIora/nMRcRxTqp93cen9XYUd1M2DWPgw/AeeS5H/xMbqVnGpz9FgXd
        vlgGCID8J9aiSr7Aie13MOmFEg==
X-Google-Smtp-Source: AGRyM1uDTyymsbqvcpqw+G1IN3KBCRl9t4C7Oh/bLTsQdKflpW3kLavW6JRGTF7d3TRyu/L5i0y9MA==
X-Received: by 2002:a17:906:2dd:b0:712:1293:3dd8 with SMTP id 29-20020a17090602dd00b0071212933dd8mr14164439ejk.448.1656086985840;
        Fri, 24 Jun 2022 09:09:45 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y26-20020a50ce1a000000b004357cec7e48sm2455312edi.13.2022.06.24.09.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:09:45 -0700 (PDT)
Message-ID: <dcd4be85-21ab-beb9-e6dc-bd7f570459fd@linaro.org>
Date:   Fri, 24 Jun 2022 18:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 19/40] arm64: dts: tegra: align gpio-key node names
 with dtschema
Content-Language: en-US
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
 <YrXhb5izGPNXEmMK@orome>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YrXhb5izGPNXEmMK@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 18:08, Thierry Reding wrote:
> On Wed, Jun 15, 2022 at 05:53:12PM -0700, Krzysztof Kozlowski wrote:
> [...]
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
>> index f16acb4cabaa..62d58221ad3c 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
>> @@ -1030,7 +1030,7 @@ clk32k_in: clock-32k {
>>  	gpio-keys {
>>  		compatible = "gpio-keys";
>>  
>> -		lid {
>> +		switch-lid {
>>  			label = "Lid";
>>  			gpios = <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_LOW>;
>>  			linux,input-type = <5>;
>> @@ -1039,7 +1039,7 @@ lid {
>>  			wakeup-source;
>>  		};
>>  
>> -		power {
>> +		switch-power {
> 
> This one is actually a key.
> 
> [...]
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> index a263d51882ee..8494c7b2961b 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> [...]
>> @@ -1772,7 +1772,7 @@ lid {
>>  			wakeup-source;
>>  		};
>>  
>> -		tablet_mode {
>> +		key-tablet-mode {
>>  			label = "Tablet Mode";
>>  			gpios = <&gpio TEGRA_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
>>  			linux,input-type = <EV_SW>;
> 
> And this one more like a switch since it's triggered by a magnet, as far
> as I understand.
> 
> No need to resend, I can fix these up when I apply. Just let me know if
> you have any objections to me making those changes.

Sounds good, thanks for catching these.


Best regards,
Krzysztof
