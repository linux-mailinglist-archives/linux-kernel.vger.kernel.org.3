Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2773F5ACCE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiIEHaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbiIEH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:29:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47101B9B;
        Mon,  5 Sep 2022 00:29:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w2so10228354edc.0;
        Mon, 05 Sep 2022 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=c8Fp7xbOBPiDPrMPRWEI6qZ2LdwuEUkMDG7mK0etL1w=;
        b=mBcg+E2QMt+vbq77hTaeEwZbI7isR5fFJ9AcKdE7PabR9iPEeB9pBvPZB6u5z1bPWt
         w6DGxEg/O3FFwZwb8Pr3PXeY1Ki+DilNKybSR6R310fAfiRF7xfW2mAlvLd0xPT3pHtx
         fUuQ1b5liC+HOaQIZM0rtXHW+pQ8ftZ+NBnIerhICHPvWpqQOJamHGQSMN1oXCzg/6Qg
         hnnqqQfkIGNeV+EQZj0BF1VtAt/j+BpXDxm8SpoTDwOBVhP4Spw/Lv5PbKm2PCxziDLw
         g0w3c21MdX1rZAB8pgxYNHabow58GHY2nW7Q6Zd8dFpur41d9xNs3YLswTZMw1Rt+VwV
         Z2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c8Fp7xbOBPiDPrMPRWEI6qZ2LdwuEUkMDG7mK0etL1w=;
        b=gJC9mRRnl2SB/XRTnM3IzlV7KyIK05MQVo7EloPYli2L9oiMHRILRRdk6tPcRrapfE
         pZUNxAFP80252bIc68AS+c+/i/a/HqgkaowGuyHF8+5hUwtyTk7rD4OSLBb+hQzffX2N
         jqJuTvk0SVhunXHiYzb+GgXC30uhWnubw5OgdWQwle21wWRtdlpuNsHbycWYgio2hlrB
         NecWzK6Nbt3iDl7seSanwD/iQ7u2uwGPuVDKEZeDJxWHJSFV2qm2T6pJVcPSfHfPSGZX
         Ot5RyeJRUdQIfOy6QyoWfo0b6VbCA/51pETwxoWn24YzquH/qTnj8OSvMH/O51FQWQlb
         2cbQ==
X-Gm-Message-State: ACgBeo0cS4O2Hd9qBiMChSUvN7Wpqqo0SAWASaymBBngUAiclJa0SVXo
        /IvQLcZWGPgAaw4Jk9V9juk=
X-Google-Smtp-Source: AA6agR5XhI9SkUjAGjQeiLowNt+ajuGy8A24Y72F/JDl54cU7/bjBhLmv6/V+HDiSvoY0YvXqWwgbA==
X-Received: by 2002:a05:6402:538b:b0:446:34f:2232 with SMTP id ew11-20020a056402538b00b00446034f2232mr40398081edb.4.1662362964700;
        Mon, 05 Sep 2022 00:29:24 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id e5-20020a50d4c5000000b0044e983132c3sm831915edj.60.2022.09.05.00.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 00:29:23 -0700 (PDT)
Message-ID: <72f86c4f-79fa-bff4-f14e-4cd7fa7ce41f@gmail.com>
Date:   Mon, 5 Sep 2022 10:29:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 08/14] dt-bindings: ufs: qcom: Add sm6115 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-9-iskren.chernev@gmail.com>
 <7804ffbe-4e27-d8bd-dbe2-75d1323da064@linaro.org>
 <89e6a200-d9af-7263-5e09-d7d824277a30@gmail.com>
 <199167f2-0420-8c56-5156-35005069549d@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <199167f2-0420-8c56-5156-35005069549d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/22 22:10, Krzysztof Kozlowski wrote:
> On 03/09/2022 19:54, Iskren Chernev wrote:
>>
>>
>> On 9/1/22 19:11, Krzysztof Kozlowski wrote:
>>> On 01/09/2022 10:24, Iskren Chernev wrote:
>>>> Add SM6115 UFS to DT schema.
>>>>
>>>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>>>> ---
>>>>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>>>>  1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>> index f2d6298d926c..7c5f6e2e6d4c 100644
>>>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>> @@ -28,6 +28,7 @@ properties:
>>>>            - qcom,msm8998-ufshc
>>>>            - qcom,sc8280xp-ufshc
>>>>            - qcom,sdm845-ufshc
>>>> +          - qcom,sm6115-ufshc
>>>>            - qcom,sm6350-ufshc
>>>>            - qcom,sm8150-ufshc
>>>>            - qcom,sm8250-ufshc
>>>> @@ -178,6 +179,31 @@ allOf:
>>>>            minItems: 1
>>>>            maxItems: 1
>>>>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,sm6115-ufshc
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 8
>>>> +          maxItems: 8
>>>> +        clock-names:
>>>> +          items:
>>>> +            - const: core_clk
>>>> +            - const: bus_aggr_clk
>>>> +            - const: iface_clk
>>>> +            - const: core_clk_unipro
>>>> +            - const: core_clk_ice
>>>
>>> Use existing name and put it in the same place as existing variant - sdm845:
>>> ice_core_clk
>>
>> The only problem with sdm845 bindings is the presence of rx_lane1_sync_clk
>> clock. I'm guessing I could pass zeros there, because it shouldn't be used. Or
>> it could be moved to last property and then min/maxItems to guard, but that is
>> a change to something more-or-less immutable.
>
> I don't understand - what is the problem here. How presence of some
> clock affects name of other clock and its place/location in list of clocks?

qcom,sdm845-ufshc has 9 clocks, one of which is rx_lane1_sync_clk.
qcom,sm6115-ufshc has 8 clocks (all of the ones in sdm845 without
rx_lane1_sync_clk). So if I'm understanding correctly, you want to put the
sm6115 with sdm845, which means re-use the clocks and reg specification from
sdm845, which means sm6115 will "inherit" this rx_lane1_sync_clk, and then
I have to put it in DT (otherwise the schema would complain), and I'm asking if
I can put an empty (i.e <0 0>) value, so schema is satisfied but clock is still
not really passed.

> Best regards,
> Krzysztof
