Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C95ACF74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiIEKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiIEKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:02:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E94055E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:02:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r27so8273247ljn.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kv+9RhK6Phq32sz2Yl+XWwSP6NnSDQP/fc+4aYg9QaQ=;
        b=ZWJDH3e423PJDPRLzmSyD3kH4yLHsRKkoZAQg7qEEKZ9RNXzxE9cUZG3NHAy2XzPxM
         tS0KsQyYPss6M2fB4G9t8bPvkBnKM52Ym++N2/cWgauaUTDzmH3Kd7U48yjz0JCIGBrg
         YglWSQ76yhFjdkjsiiJCiTNUM70lc52cm3gSA/MprgGR3j8kgYNVP5NtQLbiEXYi/YdH
         98ktB88CPskOD1+V9eFbuGb5qeq4ZFEeiVgNZPB90X6Cr+X8fprBd26Smt+a5hDopDY1
         hN5wpcMz1qvSwothFQqo15Dy+9QetABLnP3pE36OQ/jF71TmUlSefaSaXKmQw27C0KQx
         lLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kv+9RhK6Phq32sz2Yl+XWwSP6NnSDQP/fc+4aYg9QaQ=;
        b=65pYr5wY+Wdu2YEWrLYhhXDI9qa/q992gwYYpe3NChDcAeb5GUxtQnBcgE/gPX1CsZ
         g27LVYhDtJmhzj1zSdMvo+UzLy2EV3bARXhgRRMEB747e/4gvyghmfzoR0C50W6URG6r
         Igy26hNNX67UriqouWTqxGGZsG5lwuqyrTUbbDhax05exxJnWiq9duOye4gdEuw1LAnt
         I0+OsRbUwxTSVDJDs3H5k4fxp2s+XEj2qmxXnpTf+2WJ0I1ZTSP2fJsvMAwRAunwuUje
         gahXSkgZf+2iPzpbk+BbG3PD/dhhHVCJ0XTs98jhkpg3sJnjBlIcngBHyVXdWnuhjJ7O
         XCKQ==
X-Gm-Message-State: ACgBeo31pfFhqy3GM6aCpwb49dpp17Mckgp7AN2f3k4f20GjfQ34cTlT
        7xu83+moIi/ouEgKruwOR+JHmg==
X-Google-Smtp-Source: AA6agR7OB5Exv3WD5wTyvP9jb8gQY+3szQ3dx1oxNUhvpIRU05qPWHnuzZVps5Q7ha3Ji3sgyVsUmA==
X-Received: by 2002:a05:651c:1507:b0:268:d775:4e52 with SMTP id e7-20020a05651c150700b00268d7754e52mr4761186ljf.258.1662372122738;
        Mon, 05 Sep 2022 03:02:02 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24e96000000b00494a2a0f6cfsm1140371lfr.183.2022.09.05.03.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:02:02 -0700 (PDT)
Message-ID: <180f706d-3304-3a5a-82b7-f37948e5d100@linaro.org>
Date:   Mon, 5 Sep 2022 12:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm6115: Add UFS nodes
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-10-iskren.chernev@gmail.com>
 <a0204dc3-af13-6b0b-d779-0f207d1aff7e@linaro.org>
 <488be3d3-d4c4-6200-be99-b85e6ac72c34@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <488be3d3-d4c4-6200-be99-b85e6ac72c34@gmail.com>
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

On 03/09/2022 19:04, Iskren Chernev wrote:
> 
> 
> On 9/1/22 19:13, Krzysztof Kozlowski wrote:
>> On 01/09/2022 10:24, Iskren Chernev wrote:
>>> The SM6115 comes with UFS support, so add the related UFS and UFS PHY
>>> nodes.
>>>
>>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 70 ++++++++++++++++++++++++++++
>>>  1 file changed, 70 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>> index cde963c56ac9..491fffff8aa1 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>> @@ -620,6 +620,76 @@ opp-202000000 {
>>>  			};
>>>  		};
>>>
>>> +		ufs_mem_hc: ufshc@4804000 {
>>> +			compatible = "qcom,sm6115-ufshc", "qcom,ufshc",
>>> +				     "jedec,ufs-2.0";
>>> +			reg = <0x4804000 0x3000>, <0x4810000 0x8000>;
>>> +			reg-names = "std", "ice";
>>
>> I could imagine that testing DTS against existing bindings might miss a
>> lot, because we have still a lot of errors. But at least I would expect
>> you test your DTS against your own bindings, which you submit here (and
>> previously).
>>
>> You just wrote that ice is not allowed.
> 
> OK, I'm an idiot. I didn't run the bindings checks, not against existing
> bindings or my bindings or whatever. It's my fault.
> 
> Ice should be allowed, I fixed the bindings in v2.
> 
> For the record, running dtbs_checks is a PITA, not only because of the
> thousands of warnings in unrelated code, but because it takes forever.

You can limit it per schema and/or limit it per target, which would
speed up things. Of course it depends on computer you have, but I don't
find it slow on my laptop and I run them a lot...

> 
> Maybe the docs should be updated with instructions on how to run it on a single
> (or a small subset) of DTBs. I had to comment out a lot of Makefile lines to
> focus it on mine. It would really help if the binding check works more like
> a compiler, not some magic spell hidden in a bunch of Makefiles.

crosc.... make -j8 DT_SCHEMA_FILES=exynos-srom.yaml CHECK_DTBS=y
qcom/sm8450-hdk.dtb


> 
> I'll list all remaining issues with description/explanation in v2. The fact
> that some bindings break on all DTBs present doesn't help either.

We're working on this... It's quite a lot of effort, especially when new
warnings are being added. :)


Best regards,
Krzysztof
