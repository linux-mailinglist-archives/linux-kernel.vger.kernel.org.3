Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C733853DC9F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345676AbiFEPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345656AbiFEPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:42:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4130B3BF8D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:42:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x5so10728473edi.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9B1ls8yxGR8zR2l3YzKPbZsH4BwBWVg6R1Ggw6EpK00=;
        b=hhjQr19dkEE4mggA5808Y6fgDAQLq+ga1n1mUxAle2NCtJU+zF8H7tAm46apPYHIzR
         Hd8o6Q2m+p4m/msMntyB9mvrlG8Xkm4PO5q6bdnyHQDSyKUHkaGrb8qbFUFLXaLgeZwO
         3NIZHxf1oJVF7navow3Ho6LMu9IjX7JA/38i7sjMDcP2vVOJwnkyccDxgTpN9SW7IvAJ
         VqL8XqQ/3aFT3EqAq4MTnIrSeQbKA0T+a2iSUxnrpRwytydFJg4PA0o69hEQnx2UGk2g
         csWnTlMPAu56EPLxquaefKiZ98/6yvJCp5g3ffeD2cFLYN3qIaARIKYZ693hULjmdeNN
         EX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9B1ls8yxGR8zR2l3YzKPbZsH4BwBWVg6R1Ggw6EpK00=;
        b=AQDqaR5f0Bz5U41VLlwu4AKpOP+PHX9M1Tcph0xsa+Wvs1l3ZZVM8kTdOJ/cJHC//N
         lu0xYEljL9bWkdJbEbrxFFYnPkB4V3QMBmBRX8eRNQv23nK8gh8Ht4ptR3fjW8prxTCa
         RSSq+Kqo84OIWcAQD/vXajPXTDrAYhTBVjnQ+5RpVDtjAYnn6XvWz8tR/2YGXcUr016b
         8LLBsG/Qyctx9wVdXLfIBFEEjU2yrfhXplUuMc8+WxHfN4l4YrXzUuv8XIU5qdfB1xaT
         4TR62DS03heLY+/chlAWt10KTKtMmoS1zMJEU5LWLOoVfsZq/itsQYuNIlAa3M7uyvLr
         o4Bg==
X-Gm-Message-State: AOAM5308kPgL0bvlncbCcQA9obfiLM92aGkq2SKWtStGmE2TxjXUj/Vn
        G4bTdy5BU6rOfl4v7ZLULslBvg==
X-Google-Smtp-Source: ABdhPJzYrCBob8WbVSGFXb2ZMYIBWQaNFllwDiFYYSjxcPKr8Kh4AZkpqz5U6Q0GOAn/Gyv0D0dynQ==
X-Received: by 2002:a05:6402:1341:b0:42a:f7cb:44dc with SMTP id y1-20020a056402134100b0042af7cb44dcmr22194785edw.165.1654443744851;
        Sun, 05 Jun 2022 08:42:24 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hz10-20020a1709072cea00b0070e01426360sm3252319ejc.91.2022.06.05.08.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 08:42:24 -0700 (PDT)
Message-ID: <ea5ffada-c3be-885d-6b10-30ac027a4d6f@linaro.org>
Date:   Sun, 5 Jun 2022 17:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sdm845-oneplus: split qcom,board-id
 into tuples
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
 <20220529202629.47588-5-krzysztof.kozlowski@linaro.org>
 <Yppatj7KuQLPdDW1@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yppatj7KuQLPdDW1@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 21:02, Stephan Gerhold wrote:
> +Cc Caleb Connolly <caleb@connolly.tech>
> 
> On Sun, May 29, 2022 at 10:26:29PM +0200, Krzysztof Kozlowski wrote:
>> The qcom,board-id is an uint32 matrix, so a list of tuples.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 2 +-
>>  arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
>> index bf2cf92e8976..8897a2f4cfe3 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
>> @@ -12,7 +12,7 @@ / {
>>  	compatible = "oneplus,enchilada", "qcom,sdm845";
>>  	chassis-type = "handset";
>>  	qcom,msm-id = <0x141 0x20001>;
>> -	qcom,board-id = <8 0 17819 22>;
>> +	qcom,board-id = <8 0>, <17819 22>;
> 
> FWIW: While it's just a cosmetic change this is a bit misleading in my
> opinion. Having two tuples suggests this should be interpreted as:
> 
> "This device tree is suitable for two different boards:
>  board-id = <8 0> (aka sdm845-mtp, a standard qcom reference board)
>  OR, alternatively: board-id = <17819 22>"
> 
> Since this device tree is clearly not meant for sdm845-mtp one could now
> argue that the <8 0> could be removed, and only the second tuple covers
> the actual device. It might be worth a try (maybe Caleb can try?), but
> I suspect the bootloader will not accept that...
> 
> I think the bootloader from OPPO/OnePlus is actually looking for
> quadruples instead of tuples on this board. I have seen similar hacks on
> several other OPPO devices as well. They usually add their project ID
> (here: 17819) somewhere and look for that in the bootloader.
> 
> In this case maybe adding a short comment would be sufficient, just to
> make it more obvious that this doesn't actually follow the binding
> documentation.

Thanks for bringing up this topic. I think we should include this
quadruple-set in the DT schema.

> But this kind of brings up the question if it's worth making any
> constraints in the DT schema at all, if some of the device trees
> can not follow it.
> 
> For example, older OPPO bootloaders actually look for triples instead,
> e.g.: (This is from a real device!)
> 	qcom,board-id = <8 0 15009>;
> 
> So maybe it's just a matter of time until someone tries to add a DT
> with a format that cannot be changed cosmetically to fit the DT schema...

Generic answer is: yes, we want constraints because we want to define
interface which is followed by bootloader. Following up answer is - in
practice this might not be possible...

I wish I could say that DTS abusing bindings will not be accepted, but
unfortunately vendor (OnePlus or whoever) simply does not care at all,
so this would affect only the community. Therefore rejecting such DTS is
not a viable option which leads me to first option - try to describe it
in schema, as much as possible.

Even if it means some "oneOf:" set for different vendors.


Best regards,
Krzysztof
