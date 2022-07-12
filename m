Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5084257128F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiGLGyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGLGyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:54:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623817589
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:54:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r9so4353617lfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NE5DifUufxxjJStpUUwi3w02nZ87Fe1eRpENnObacD4=;
        b=ASwsWNviNK/+Vl2rC/IwRIMQt2142cJyJVBT+fQWpfzaTYP1RCZhbBWXVnnQWBQfFI
         gkMzbHLCEFMaFR3RRjAELkNwo3sN40A1V3+KTWFrO6B8IBBJV5epmD79LqxH2hP00prG
         nrG2SxcJCKWDdPtYhWIMIE3ax+bXVnv6RFAcvIBsG+TeAFv7WEOwBF9Pz57pFkba8xt7
         mtvTkIBwy+Fni2JIBzDuYGXLjZf4p6wFfeeY1DfLA+eQTaILoQv0PZmk+aSaHBgLJK0X
         oBSX688ZDSQNkYYB+ZTaXtLSb3/pElJfqHEl0ysUnZfMow3ACPjauO3WqAVMStCSJaWO
         Dkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NE5DifUufxxjJStpUUwi3w02nZ87Fe1eRpENnObacD4=;
        b=VhC4O7eibBSJqUAPVFvS6IkyoLZznXsqGVg9z/atvfWMpXfUxMca8Rs4kzwdKb4X7t
         jfnXaTOxo2ecMwLqMuyPx/5iD1VbS1Wgmcw3pnd3VoXfen+VHkvSj/cAqQqLdatnSNvd
         RwpW/fKZF2mUkRoiYVPe4+hYHCMHxDnCDFHEshmt3ky1V3mdO3bBfO+pIB1YxDhz42YW
         GxvcGoCCfXlfyV2svyxgX2mFPN7MMTzylsr0XzRc3+LSfZgcANbckFYTySifM9H9WpTs
         PbetFu/l7ZXwkeuLvYe1HWK3Su/c6CsFn8J393PJ90HCAQ2lvG+ah26232GpyuApHYuU
         NZ+A==
X-Gm-Message-State: AJIora8c7mxmLOnRk0uVtL8qSpSqNQE6jIEFKv5ySXqgaIwGUwsJA6Pa
        bcqUHedvFM235Oo6mtFLZpFCQK4efsI8ZdOB
X-Google-Smtp-Source: AGRyM1sQCvT/DEL8W10OJPxgCdo4/+cU3BwL4V/dSUB1scb2vrHR6Uzbw7NKlIkMimSWjzFdZG2lmA==
X-Received: by 2002:a05:6512:2803:b0:481:126b:7eaf with SMTP id cf3-20020a056512280300b00481126b7eafmr13385403lfb.286.1657608838444;
        Mon, 11 Jul 2022 23:53:58 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id bu19-20020a056512169300b004786eb19049sm2012711lfb.24.2022.07.11.23.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 23:53:57 -0700 (PDT)
Message-ID: <ab0e97a3-ec83-78f2-921a-813a647855f5@linaro.org>
Date:   Tue, 12 Jul 2022 08:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFT] arm64: dts: qcom: sm6125: fix SDHCI CQE reg names
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20220711082648.38987-1-krzysztof.kozlowski@linaro.org>
 <CAD=FV=WMJ1BX-uA4eavocbAGjpSsEYhoYGSha9gBYsqAXhHX-g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WMJ1BX-uA4eavocbAGjpSsEYhoYGSha9gBYsqAXhHX-g@mail.gmail.com>
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

On 11/07/2022 16:57, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 11, 2022 at 1:26 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> SM6125 comes with SDCC (SDHCI controller) v5, so the second range of
>> registers is cqhci, not core.
>>
>> Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Not tested on hardware, but no practical impact is expected, because
>> supports-cqe is not defined.
> 
> Maybe the schema should enforce this? If "cqhci" is in reg-names then
> you must have supports-cqe and vice versa?

I have mixed feelings about this. First, I don't know why support-cqe
was not enabled on all devices but only in some DTS (this does not look
like a property of a board but SoC). Second, cqhci address space might
be present in all devices, even if they do not use CQE.
> 
> 
>> ---
>>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> index 77bff81af433..7664ef7e4da9 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>> @@ -438,7 +438,7 @@ rpm_msg_ram: sram@45f0000 {
>>                 sdhc_1: mmc@4744000 {
>>                         compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
>>                         reg = <0x04744000 0x1000>, <0x04745000 0x1000>;
>> -                       reg-names = "hc", "core";
>> +                       reg-names = "hc", "cqhci";
> 
> Another possible fix would be to just delete the second register
> range. Then it could be added back in once "supports-cqe" was added.

True, but I assume that second address range is there for complete
hardware description.


Best regards,
Krzysztof
