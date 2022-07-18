Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3F577DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiGRIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiGRIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:47:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64205B7C5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:47:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so17533422pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FnjKmRGcyN6SQxFQfQMi9kWsozd9GYU/V3IK6nob9jw=;
        b=B+5GWhkWxIf3F9bMI8PIibp6jFj77l/Z2p/ukHSezKag1lZtPLSEUljFcT9nVYNUoj
         ryTrertbhw8lccT8BCF3jggw3x+S1TVZkavu8G0diNWJkLnnsHdORx3KkKJpKb1L+EUl
         C2mvmPC/tOWK14OM7+zPwtjf6DOzvakqvR8ezM6c8361PXfO74umq5/4TIq67lwAwKi6
         /pwwOCnv0yEKpgn1lY4Y8BacEjsgxvYJeM2qGh4+4yj6FWLg51yzwtEJZN5hgijcRR0y
         HWTuwPJiM97dvxiWgf5+I303EW7FMmRvuq25MqZDcs635i1NeOKde5C9NuGaiW011itu
         tpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FnjKmRGcyN6SQxFQfQMi9kWsozd9GYU/V3IK6nob9jw=;
        b=ndrPW5Y+DCDfnIHt0UfpbpG/Qj8YUciTNc9qnvz9zTnWtIANqoyKZFrMC1cFeTwfRQ
         PkZoGN04TN6BOuLfN8A2WRYm0FQXOOo5XusNhoT4Ms9BOUxwUiP1Qt+t+PAEqDGuJ7nQ
         9aoaeOShnblXhxVlFyI0WrMIiIsBQckfNKmU5tIMTjWspHY0FngYVNY+YFZA7hYmFnlu
         y47PTncCCmqfkCA+Q2PtuAPO0QAO9GrNe1Ucaq0/venj0pFATlHoTr/8r2rryXq8XSUm
         ZdGwCd4xfOB3GHufMBYdaSGUHVFg+1LxQ5c8oRgzc3LEq1e35ifYKZIDt96z/ToG3q6F
         r3nQ==
X-Gm-Message-State: AJIora9VBQYccWtOzF6BWqNrCYqyM2Bw2ld8uNSfIbGGI0dX2tmYcN79
        88qmip/fHKPT1UnDs+T22A0BBbTSzUA/mg==
X-Google-Smtp-Source: AGRyM1vo7ZrMlv2ZhYyY45/7CaIl9P26sWsDp4Gr093653+5YoXkOMQiDmeWCBOXpAkpiFJ4Pvyxzg==
X-Received: by 2002:a17:903:2284:b0:16c:500f:b791 with SMTP id b4-20020a170903228400b0016c500fb791mr26535484plh.78.1658134057810;
        Mon, 18 Jul 2022 01:47:37 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b0016cf8f0bdd5sm777460plk.108.2022.07.18.01.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 01:47:37 -0700 (PDT)
Message-ID: <772dc5d2-c3b2-685b-3a38-b86e8877424a@linaro.org>
Date:   Mon, 18 Jul 2022 14:17:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: ipq8074: Fix 'max-frequency'
 value for sdhci node
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh@kernel.org
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
 <20220514215424.1007718-7-bhupesh.sharma@linaro.org>
 <Yr4psYiCCbi15RMe@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <Yr4psYiCCbi15RMe@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 4:24 AM, Bjorn Andersson wrote:
> On Sat 14 May 16:54 CDT 2022, Bhupesh Sharma wrote:
>
>> Since the Qualcomm sdhci-msm device-tree binding has been converted
>> to yaml format, 'make dtbs_check' reports issues with
>> 'max-frequency' value for ipq8074 sdhci node:
>>
>>   arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
>>    max-frequency:0:0: 384000000 is greater than the maximum of 200000000
>>
>> Fix the same.
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> index ab2a1e7955b5..b2d71af9b419 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>> @@ -388,7 +388,7 @@ sdhc_1: mmc@7824900 {
>>   				 <&gcc GCC_SDCC1_APPS_CLK>,
>>   				 <&xo>;
>>   			clock-names = "iface", "core", "xo";
>> -			max-frequency = <384000000>;
>> +			max-frequency = <200000000>;
> This might match the binding, but someone put 384000000 there for a
> reason. Perhaps the binding needs to be updated instead?

I was waiting for getting access to ipq8074 reference manual / documentation.
I double-checked and it seems SDCC1 on this SoC does support a max frequency
of 384 MHz which is strange as the SDCC2 supports 200 MHz as max frequency
instead.

Also the eMMC and MMC controllers on other SoCs (i.MX etx( usually support only
a max frequency of 200 MHz, so may be we need an exceptional addition to the
binding documentation here.

@Ulf - what's your view on updating the binding documentation here? I can
send a v3 accordingly.

Thanks,
Bhupesh

>>   			mmc-ddr-1_8v;
>>   			mmc-hs200-1_8v;
>>   			mmc-hs400-1_8v;
>> -- 
>> 2.35.3
>>
