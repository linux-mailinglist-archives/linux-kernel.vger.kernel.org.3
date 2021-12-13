Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2787473103
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhLMP7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhLMP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:59:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780FC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:59:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so27829079wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5pPBxZrrQ6W95JVTxPzLnQOGpXC5pyOgCp0Nth/Wz7o=;
        b=V1JOxT7Cp4Zu7rfJkpsAx0KyW+0K6mZGHKhSgyR1zHNER719J6FZYNjZGMxy8zf0Q9
         zhsZ3pNwHwezgUmrpy+mlSXPKT8oNcUuXwC2IihKFdzhh27O9ELtwl1Tfr1tneB0Zoqt
         Q1gGSFFmnAJsmcDrxsVqEy+hVUksupa6JP+IWVmIje2sF9aMqJIbcZSkHoAnG828Czl7
         7BQQkQ5m6mEUFYjtBZgt5tilFRZFORg5XqU8Jl2rYazo2daMJxGqYlBuXaVQ+76YY62R
         /5I8wWpmNGOpZrqemyUPEJNc80PlYB2gYGd3sgVBnUSfLOppoC74BMT/4FzNftYMTE6u
         c8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5pPBxZrrQ6W95JVTxPzLnQOGpXC5pyOgCp0Nth/Wz7o=;
        b=ccoM+RPxJl71WEQIr7TmoVvSHaCDW3NnmQCjYHFKbtNZ24C4UBA79ODAXSBDLS1SlO
         vcjBpo9RM9EN98VmT+gS9K/4hJCoj533r6P+rbtQ+93Veh/N8mGon9x91PzegN5+b4tI
         mspYhaE0uv4AO6vJTFIogU49irXNkCLb4FSfPyS+NS6YK/oFHDuy2qRTG9P5V3LmmIUn
         Eo5pTlKcogr65yLVqhY2fv+rMCOxMWDXwpwDGPZBHNHIXiQ0uk7UTfIxGIuQLmlpWYPy
         5DzHLLmSrbA5dGvXLjlY4Gk4gASpRJFgSITgxhio9XgtCRmJFVjRjmGpV/a6zQMuYCBX
         sY8w==
X-Gm-Message-State: AOAM532cOTWYykm6CtLT14o6DlXkfFk/4WUjeSE4N9NYol1Z64tUeYTr
        NpTxSKwDvswkBUba5LcQsT8wfQ==
X-Google-Smtp-Source: ABdhPJzSh0zsLjjAJ0ERx2rMEGrX1iDIJIEq0N1C7/X1MQ0ENpiu60VayMkE44iJEuH2Lcc23HbTcA==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr32595484wrp.209.1639411189739;
        Mon, 13 Dec 2021 07:59:49 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id u10sm8208390wrs.99.2021.12.13.07.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:59:49 -0800 (PST)
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: add non-secure domain property
 to fastrpc nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
 <20211209120626.26373-9-srinivas.kandagatla@linaro.org>
 <YbdoY9PgvZO7AX1T@ripper>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3eb6c60e-8fad-444e-5a36-9a39f33e5887@linaro.org>
Date:   Mon, 13 Dec 2021 15:59:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbdoY9PgvZO7AX1T@ripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2021 15:36, Bjorn Andersson wrote:
> On Thu 09 Dec 04:06 PST 2021, Srinivas Kandagatla wrote:
> 
>> From: Jeya R <jeyr@codeaurora.org>
>>
>> FastRPC DSP domain would be set as secure if non-secure dsp property is not
>> added to the fastrpc DT node. Add this property to DT files of msm8916,
>> sdm845, sm8150, sm8250 and sm8350 so that nothing is broken after secure
>> domain patchset.
>>
>> This patch is purely for backward compatibility reasons.
>>
>> Signed-off-by: Jeya R <jeyr@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 ++
>>   arch/arm64/boot/dts/qcom/sm8150.dtsi  | 3 +++
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi  | 3 +++
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi  | 3 +++
>>   5 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> index c1c42f26b61e..137a479449d4 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> @@ -1365,6 +1365,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,smd-channels = "fastrpcsmd-apps-dsp";
>>   					label = "adsp";
>> +					qcom,non-secure-domain;
> 
> I was under the impression that the support for loading unsigned fastrpc
> applications was introduced in SM8150 or SM8250, can you confirm that
> this has been possible all along?


Ekansh did confirm that this was introduced from sm8150.


--srini
> 
> Regards,
> Bjorn
> 
>>   
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 526087586ba4..4aebfed4ec00 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -838,6 +838,7 @@
>>   				compatible = "qcom,fastrpc";
>>   				qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   				label = "adsp";
>> +				qcom,non-secure-domain;
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>>   
>> @@ -888,6 +889,7 @@
>>   				compatible = "qcom,fastrpc";
>>   				qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   				label = "cdsp";
>> +				qcom,non-secure-domain;
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> index 81b4ff2cc4cd..9ac213bb96b7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> @@ -1751,6 +1751,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "sdsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> @@ -2994,6 +2995,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "cdsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> @@ -3439,6 +3441,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "adsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index f0d342aa662d..06be221ad5b6 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -2265,6 +2265,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "sdsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> @@ -2330,6 +2331,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "cdsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> @@ -4100,6 +4102,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "adsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> index d134280e2939..80f753cbe91c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> @@ -1278,6 +1278,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "sdsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> @@ -1347,6 +1348,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "cdsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> @@ -1643,6 +1645,7 @@
>>   					compatible = "qcom,fastrpc";
>>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
>>   					label = "adsp";
>> +					qcom,non-secure-domain;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> -- 
>> 2.21.0
>>
