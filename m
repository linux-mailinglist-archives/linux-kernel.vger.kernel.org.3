Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678715B234F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiIHQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiIHQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:14:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AFE900A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:13:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y29so7905620ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VGZLHz/DjSRVcLx6zUosYKxPYPae57PloyXxh6yBjFE=;
        b=dsFVeRa1bSoDF3YlyFpkO0lUc4GxEkNbkxSgLKPZSQ7ZHTqR+W5InuYk65I3E2AmMB
         JUZThfrZ7O1XQMWK+UTdm7WVCI/SEO7pL2wWtVGYrmbxwDcTUduzMASmwh1gV58Hlf3p
         YbeY2EQkGkZaT0R40q8NOTTGjPzjvnT9nAz9H9NryVyLR3m8w6KL9MHEQk4/kSE0dHEG
         TMTrfFIIb9BmsHmnG71qLRtuUpg1yBOHqdzrL9DoPSjbyqjGtS1CcHyIbQklqL/3ta29
         9rVrdXk4VorUaSjYwrt84b+ffPKmsH1L2czLQV9VVRqzx2EBcLzbjkppdG2XJR5phRcD
         lh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VGZLHz/DjSRVcLx6zUosYKxPYPae57PloyXxh6yBjFE=;
        b=s6xXRkDnDq7zX/3T4T5PxgANz71ulKGDfGPxZZ+3xZf0Q1NgaHUKFdT2g5rlxRvesR
         XRZuZAtGKG4Yh92eMrWeEIRk1Ev7TKLFmiP/UCTMYTOXes4RsS2iAFCEtW7F2/V9qdGS
         rJUL/F8lGSK08Uyw3imdpYBPO6Z/asvVhvvFTwHB6TnjZQAY5THvLK58X7tTU5bJIlAS
         A4A7+UhtxonkCeiMZMVUoOdlvAL/E+Sj17pnqy1lCvDI3punWAdx2VoOtPz76aKAtBdP
         GzYty6vZaRClsuO4Ehx4vVTu+xR6bdqPt7/r0bewFHOwtPZnt982O7kyuwm9/3dv/0Gr
         qznw==
X-Gm-Message-State: ACgBeo2QYJhZc4FMRvHDFJOa6Rr/RsbYU3ZlVGCeLCOz4tZakscExQIV
        hmghYV7AGuNVJ/KDY24Xqi6mTQ==
X-Google-Smtp-Source: AA6agR5euMPFHV8tq4RX29WSwoo6iMXfa2emLRM698nFMAI6coSP8baP1dOf8aabxmfysCJGeKnvPw==
X-Received: by 2002:a2e:a7cc:0:b0:269:18c5:4ded with SMTP id x12-20020a2ea7cc000000b0026918c54dedmr2760227ljp.476.1662653624162;
        Thu, 08 Sep 2022 09:13:44 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b0048a7c162bbesm3082779lfr.279.2022.09.08.09.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:13:43 -0700 (PDT)
Message-ID: <ab80670a-267a-45d8-92d0-750e7dce5682@linaro.org>
Date:   Thu, 8 Sep 2022 19:13:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: msm8953: add MDSS
Content-Language: en-GB
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220906183334.203787-1-luca@z3ntu.xyz>
 <20220906183334.203787-4-luca@z3ntu.xyz>
 <CAA8EJpqjnafKyUrd1ntYFeGTDtRxgEUSu0Mg9wNGxObJ3wF0Kw@mail.gmail.com>
 <12049260.O9o76ZdvQC@g550jk>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <12049260.O9o76ZdvQC@g550jk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 18:30, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Dienstag, 6. September 2022 21:41:11 CEST Dmitry Baryshkov wrote:
>> On Tue, 6 Sept 2022 at 21:36, Luca Weiss <luca@z3ntu.xyz> wrote:
>>> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>>>
>>> Add the MDSS, MDP and DSI nodes that are found on msm8953 SoC.
>>>
>>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>> Changes since v2:
>>> - add "core" clock for mdss as suggested by Dmitry Baryshkov
>>>
>>>   arch/arm64/boot/dts/qcom/msm8953.dtsi | 210 ++++++++++++++++++++++++++
>>>   1 file changed, 210 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> b/arch/arm64/boot/dts/qcom/msm8953.dtsi index 3d11331e78d2..580333141a66
>>> 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> @@ -726,6 +726,216 @@ tcsr_phy_clk_scheme_sel: syscon@193f044 {
>>>
>>>                          reg = <0x193f044 0x4>;
>>>                  
>>>                  };
>>>
>>> +               mdss: mdss@1a00000 {
>>> +                       compatible = "qcom,mdss";
>>> +
>>> +                       reg = <0x1a00000 0x1000>,
>>> +                             <0x1ab0000 0x1040>;
>>> +                       reg-names = "mdss_phys",
>>> +                                   "vbif_phys";
>>> +
>>> +                       power-domains = <&gcc MDSS_GDSC>;
>>> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +                       interrupt-controller;
>>> +                       #interrupt-cells = <1>;
>>> +
>>> +                       clocks = <&gcc GCC_MDSS_AHB_CLK>,
>>> +                                <&gcc GCC_MDSS_AXI_CLK>,
>>> +                                <&gcc GCC_MDSS_VSYNC_CLK>,
>>> +                                <&gcc GCC_MDSS_MDP_CLK>;
>>> +                       clock-names = "iface",
>>> +                                     "bus",
>>> +                                     "vsync",
>>> +                                     "core";
>>> +
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <1>;
>>> +                       ranges;
>>> +
>>> +                       status = "disabled";
>>> +
>>> +                       mdp: mdp@1a01000 {
>>> +                               compatible = "qcom,mdp5";
>>
>> Could you please change this to "qcom,msm8953-mdp5", "qcom,mdp5".
> 
> This would be the first dtsi using the two compatibles then, correct? Are there
> any plans to adjust other SoCs?

Yes, this is a long-going plan. Having just "qcom,mdp5" doesn't allow 
switching between mdp5 and dpu1 drivers. Thus I'd ask to add per-SoC 
compat strings.

It's up to you (and Rob/Krzysztof) whether to leave just one compat 
string or have both of them: a per-soc one and a generic one.

> 
>>
>>> +                               reg = <0x1a01000 0x89000>;
>>> +                               reg-names = "mdp_phys";
>>> +
>>
>> [skipped]
>>
>>> +
>>> +                       dsi0_phy: dsi-phy@1a94400 {
>>
>> Let's probably use a generic name 'phy' here and for dsi1_phy.
> 
> Here also, the bindings examples all use dsi-phy@, are there any plans to
> change that and adjust other dtsi files?

Yes, sc7280 already uses phy@ for both DSI and eDP PHYs.

> 
>>
>> The rest looks good to me.
> 
> Thanks!
-- 
With best wishes
Dmitry

