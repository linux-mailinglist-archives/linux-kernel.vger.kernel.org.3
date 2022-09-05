Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5950F5AD07C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiIEKpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIEKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:45:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED127CC2;
        Mon,  5 Sep 2022 03:45:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 29so5725381edv.2;
        Mon, 05 Sep 2022 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=M21+jCmVFeJg7ZwU6IkB+VCq8N1axzcwNdTJCfCqEy4=;
        b=lxTMxA1f2xL5bL1rKk3kLpJCzSoLtWWouqbsOKVj0/6/dKvUVmPZr1B0Aws6NnGHWp
         isopp3tJkM7lsXdUNvWgPDveouBjNnursTVYWmeZTbol7tg7k9N9Set9JNxCMgbwk1QV
         /rAoRpLzID9nZQcVcR575rue3d2qqjS/4b/eFMG53lT74rvjvssL0DCF92Z16vSpqeyj
         ymgeJFUA6v9r/Vhi7KVNYBLIJIlXWgg/2DCp7yy44Ua9hbnfPQ/seAssIOqS7MvO7Rlf
         aYj/RSdnPaH5RhTz5XT394+HQ3kvHBqqibU5UDEeBc1oYwLQNWMMT0dgNYMj8tlYgJ5m
         fqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M21+jCmVFeJg7ZwU6IkB+VCq8N1axzcwNdTJCfCqEy4=;
        b=TakUlxz/nG7/VSDSFzVvpe6y1nCwt8/rGXEfG1puMezgcfLaAzt/owsko7QMX7lyXV
         wQJzC6ulRkwmKNeW/zrTxG4V0hf9GWf+vm9ySkRBvyYO7eCOq4U5muuxEyGNkLc5Idz4
         nkGo5G38HTT1XnnYLnGtz8V3OZxLK7lzLj984RBpefGiYUCvyRZjstbuoxWzJy5fcFq8
         TmgHYs6KA3mG8PCGbza6/fRR2ioVQHB+nD4J6mfERVgoQ7XQeGo+FArahcN5FrycJ9m6
         aPO7ISqwLNoXlc8/LJC8hPCAF/MjEy6fxjMzpR7CWSseSas+/o+b1YiWNpfmW2t5wV0P
         gIOw==
X-Gm-Message-State: ACgBeo0MrxEWONxQHgsuzNc5O6Qef3lJaVtrvItGRyWoSUs7PPcckJJJ
        htBAbeFjxeCKu++dPYh/UF0=
X-Google-Smtp-Source: AA6agR5opDrOYgEPhzNuC46UZP59DVRHI0LgZ0plnsTygmmnCPykO4IFWgkcndprNTFRPx+ntdHLzg==
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr42422569edb.377.1662374734765;
        Mon, 05 Sep 2022 03:45:34 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id la17-20020a170907781100b0073cd7cc2c81sm4909772ejc.181.2022.09.05.03.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:45:34 -0700 (PDT)
Message-ID: <b6424212-75c1-4f42-da01-ae4ce5dc1b68@gmail.com>
Date:   Mon, 5 Sep 2022 13:45:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm6115: Add UFS nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <180f706d-3304-3a5a-82b7-f37948e5d100@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <180f706d-3304-3a5a-82b7-f37948e5d100@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/22 13:02, Krzysztof Kozlowski wrote:
> On 03/09/2022 19:04, Iskren Chernev wrote:
>>
>>
>> On 9/1/22 19:13, Krzysztof Kozlowski wrote:
>>> On 01/09/2022 10:24, Iskren Chernev wrote:
>>>> The SM6115 comes with UFS support, so add the related UFS and UFS PHY
>>>> nodes.
>>>>
>>>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 70 ++++++++++++++++++++++++++++
>>>>  1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> index cde963c56ac9..491fffff8aa1 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> @@ -620,6 +620,76 @@ opp-202000000 {
>>>>  			};
>>>>  		};
>>>>
>>>> +		ufs_mem_hc: ufshc@4804000 {
>>>> +			compatible = "qcom,sm6115-ufshc", "qcom,ufshc",
>>>> +				     "jedec,ufs-2.0";
>>>> +			reg = <0x4804000 0x3000>, <0x4810000 0x8000>;
>>>> +			reg-names = "std", "ice";
>>>
>>> I could imagine that testing DTS against existing bindings might miss a
>>> lot, because we have still a lot of errors. But at least I would expect
>>> you test your DTS against your own bindings, which you submit here (and
>>> previously).
>>>
>>> You just wrote that ice is not allowed.
>>
>> OK, I'm an idiot. I didn't run the bindings checks, not against existing
>> bindings or my bindings or whatever. It's my fault.
>>
>> Ice should be allowed, I fixed the bindings in v2.
>>
>> For the record, running dtbs_checks is a PITA, not only because of the
>> thousands of warnings in unrelated code, but because it takes forever.
>
> You can limit it per schema and/or limit it per target, which would
> speed up things. Of course it depends on computer you have, but I don't
> find it slow on my laptop and I run them a lot...

For one file it's great. For all files (i.e make dtbs_check) it takes more than
30mins on my 4c/8t intel laptop. About limiting by schema... not really
useful for me (except if I write the schema, but then I use it in one dtb, so
it's easier to limit by dtb).

>>
>> Maybe the docs should be updated with instructions on how to run it on a single
>> (or a small subset) of DTBs. I had to comment out a lot of Makefile lines to
>> focus it on mine. It would really help if the binding check works more like
>> a compiler, not some magic spell hidden in a bunch of Makefiles.
>
> crosc.... make -j8 DT_SCHEMA_FILES=exynos-srom.yaml CHECK_DTBS=y
> qcom/sm8450-hdk.dtb

Aaah, very nice! Thank you!

>>
>> I'll list all remaining issues with description/explanation in v2. The fact
>> that some bindings break on all DTBs present doesn't help either.
>
> We're working on this... It's quite a lot of effort, especially when new
> warnings are being added. :)

I understand. Is there an up-for-grabs list, or any schema fixes are welcome?

> Best regards,
> Krzysztof
