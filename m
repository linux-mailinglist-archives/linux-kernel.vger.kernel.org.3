Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0C584770
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiG1VAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiG1U7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:59:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D77AB26;
        Thu, 28 Jul 2022 13:59:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss3so5127248ejc.11;
        Thu, 28 Jul 2022 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cTaMCQwpSrtdi7kW0M1ObUjAfSc8pNr4gQyJRqSpFl4=;
        b=kpKKacC40qMuQUpvsIFs6oANGwkHDPvvNZQpVVqdITXbN8C+nLBHDGoafNKs2rISM4
         9jc8eBju8cpfZE6EpW5ev7g0P8hN5nf2S4Q23Z7zdMYEcuVuxX01sOru1WYEO0mbEfck
         30euJzB/E834x3o6X/YUMgNKpcKHsDiuJZFRmlXFFYzwJMhmuFGJLjoeud/iEM1Nz64d
         iOATJW8eVIQgbFFSD3w1H2fa7ewIUDqDHcDDnwr6oEOdYhUuTVP2K4VvpFPNwGFPc+As
         SfWiIjde8HB3Vq+HnMivNQTi/VMREhMrvCbzEumogZgNFuhByxjmEzBVwKqjjYdqFhdR
         PGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cTaMCQwpSrtdi7kW0M1ObUjAfSc8pNr4gQyJRqSpFl4=;
        b=KBRfIoCLEmOZd35w930I8ASJsONnBcCyPh8+4Yt/NNwHfchfPObs3bsyjsrEbT65Db
         2aoYTNa5vd+DY48W7jVkl1qpPray2FpvG/kx6s0W91wQaEQKHPFU94nKOGy4CpDF8ClX
         HOEAkzmbqX2jX9CkHys2mAeAcxM3t39UPqX7ZY7zsQg9uMgN33PL6YcHOoYk6NSDRs5o
         9xG5aLKsxHBlNmj/zsObkekZcVoMO1/dvJ//spTXeTyNV7IOOZ99VFFtCZlr98I4GC3Z
         cB33auOJM53UEz2ltukzRwmIoT/E/EuBO+AoqMAjixICy4JrYrC04Bl07pfFxNsD5uDy
         ur6g==
X-Gm-Message-State: AJIora+DfkSFLPWnwqBW7d51pRwgDBBBnqJVTdIbmqGqZtSh2lxy/AkL
        A0nf2HEywpZFRBGb9923OsQ=
X-Google-Smtp-Source: AGRyM1uo7z0DcylW4Dm7ZKRpLLSbZoJasPZGsUSzrWutHAiZ/R9JB6mnO1q7imgksVulSfKaQiYrPg==
X-Received: by 2002:a17:907:3d89:b0:72b:4d89:9c7a with SMTP id he9-20020a1709073d8900b0072b4d899c7amr540756ejc.50.1659041946649;
        Thu, 28 Jul 2022 13:59:06 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090632d500b0072af102e65csm790191ejk.152.2022.07.28.13.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 13:59:05 -0700 (PDT)
Message-ID: <245f6090-9f92-8091-d8e6-735ab078c6c8@gmail.com>
Date:   Thu, 28 Jul 2022 23:59:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/5] regulator: qcom_spmi: Add support for new
 regulator types
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-4-iskren.chernev@gmail.com>
 <YuEoLteLBgd+b8sg@sirena.org.uk>
 <79077e08-4bd8-6967-748d-876589ef978e@gmail.com>
 <YuJuzNiQczaYi1og@sirena.org.uk>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <YuJuzNiQczaYi1og@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/22 14:11, Mark Brown wrote:
> On Thu, Jul 28, 2022 at 02:14:10AM +0300, Iskren Chernev wrote:
>> On 7/27/22 14:57, Mark Brown wrote:
>>> On Tue, Jul 26, 2022 at 09:11:31PM +0300, Iskren Chernev wrote:
>
>>>> Add support for some regulator types that are missing in this driver, all
>>>> belonging to the FTSMPS426 register layout.  This is done in preparation
>>>> for adding support for the PM6125 PMIC.
>
>>>> +	.set_mode		= spmi_regulator_ftsmps3_set_mode,
>>>> +	.get_mode		= spmi_regulator_ftsmps426_get_mode,
>
>>> Why are set and get asymmetric?
>
>> Because the get method, only uses AUTO and HPM, which have the same value
>> for ftsmps3 and ftsmps426 (so there is no need for a new function).
>
> This needs at least a comment.

I agree, I think to add the function with the right macros, and comment
that it is the same now but might change in the future if support for mode
modes is added.

>>>> @@ -1473,7 +1557,7 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
>>>>  	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
>>>>  	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
>>>>  	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
>>>> -	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
>>>> +	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),
>
>>> The changelog said we were adding support for new types but this looks
>>> like changing an existing type.
>
>> The code, as written now does a different thing for BUCK, HFS430 (on
>> mainline (ML) and downstream (DS) linked in the commit message). Since DS
>> only supports newer stuff, to be on safe side, I kept existing behavior for
>> rev 0-3 on BUCK(3)+HFS430(10), so at least DS and ML agree on pm6125
>> completely.
>
> This needs describing in the changelog, probably you need multiple
> paches here since you are making a number of different changes each of
> which needs some explanation.
>
>> The commit [1] that adds support for BUCK+HFS430 might be wrong, or it
>> might be right for the time being (i.e initial revisions had different
>> behavior). I'm CC-ing Jorge.
>
> If that's the case perhaps part of this needs to be sent as a fix.

The Downstream patch is adding 3 logical types:
- LDO_510 -- these have new subtypes, so no existing PMICs are affected
- FTSMPS3 -- this has a new subtype (0xb), so no existing PMICs are
  affected
- HFSMPS -- this has the same type and subtype (BUCK+HFS430) as an existing
  mainline logical type (HFS430), both declaring 0-INF revisions.

So if we fully trust the downstream patch, I can make a fix for the
existing BUCK+HFS430+0-INF, so it uses the slighly modified mode values.

Currently the set mode fn differs in LPM mode (5 in the common2 case and
4 in the common3 case), so if indeed downstream is correct it would mean
this regulator (when turned off) was set to an invalid mode (5 has
undefined meaning in common3 map) from 2019 onward.

On the other hand, if we assume downstream is wrong, then their code sets
4, which actually means RETENTION (not LPM). I really don't know how this
could cause trouble. In fact downstream does a bunch of weird stuff, it
doesn't "just" set to LPM (like mainline), instead there is complex logic
per logical type and "initial mode". Or they're just masking this mistake
;-)

TL;DR Jorge's mail is gone, so we can't get info from the original author.

Another issue is I can't really test any other PMIC (and even my PMIC
I can't turn off most of the regs without loosing critical functionality,
and the BUCKs are kinda important :)).

So we can:
1. politely ask for somebody with access to the secret sauce to say what is
   correct, at least according to the docs (with a timeout)
2. assume downstream patch is right, and fix the existing HFS430 regulator
3. maintain the current (patch) behavior, which likely won't affect older
   PMICs, but is still adhering to DS patch, because it adds support for
   this particular PMIC, so presumably it was tested and works with it
4. drop the pmic patch and rely on SMD

Please advice.

In any case if we go with 2 or 3, I can split out this particular (BUCK)
part in a separate patch with more information/comments.
