Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463C6582610
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiG0MEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiG0MEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:04:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D374B0ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:04:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q23so13561633lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2dUZ4AGI+yDI99uFVBIAkMIhm5YNlifPEZHjyoEMmko=;
        b=w6c+7gFc5bptabl2jpva60XhxykGU+F8kjr9idGrGrRTCUZQS4rGwI4tcucHGdLeOs
         DUC763HNsyLc7uKz/mGXDbbicgE6tzoj93cfCWUNUnWyHpC3ATvj20W9G5rqQOS1emFC
         gRiRCycZgA3ucoDHQD6Oy2P5UMpgYdid5MyYaAnud9EYdISYD4O/5+KXsg5NbJPzB7a4
         5sl+2oAKeHjUCM8W3g373ZLPI4Dp6nu6Ak6yK7ZhAzi43z9g93p3waNKP1x0NLmjkyFM
         B5TKLarYBWUPcrkHgPPlkfrfZSlnNsZZ5itwSyNVTp75Z72Cg35WzhoEqrSzLMy/mXTe
         QhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2dUZ4AGI+yDI99uFVBIAkMIhm5YNlifPEZHjyoEMmko=;
        b=zN8M0QEkJFEAmy4AMdLo/laD59JJncrTcelfhmnt8CzkVfTrCToGZo7IHUFiZXmwiK
         +mK7ut790JFZrrKTADw1GJ+cbGTM1Km6zangyZMWRIZGD1Sxu4m5GuofpFPX3K18P/nG
         eAqgSx9Ain/+7rKST6eZ03kwQaandBE/wg/FI7f+0463u5SW4zxMs+i9623q89QAD2e8
         prtGIixwx9cy4QRv+YmNnIiXv+UgsZaOMzx1T3MaIQV80OV/TjEhDlXLxxj1ZzfiqoBd
         6bX0ZJDHj8sgjhV8LpyZQfTKVHnQDnv00hIwBn1SKMnZtp5jeXca0+5oushuSpY5ekjC
         JTCQ==
X-Gm-Message-State: AJIora9i4pSmToJOQtFH76W4aS0V4DYV5PQBeTvMo7NVxpNC+tSzlkns
        YTleD/N7F82ER2nZK7HyBVR6YQ==
X-Google-Smtp-Source: AGRyM1use5uqI8LWDKweipAVSirfmTrNH9lmQFY27iWI4XCfhQb86Ab0tNP7LerX+Ep4k+DAUtcnkw==
X-Received: by 2002:ac2:4e0d:0:b0:48a:bc83:7fb8 with SMTP id e13-20020ac24e0d000000b0048abc837fb8mr508616lfr.623.1658923474154;
        Wed, 27 Jul 2022 05:04:34 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b0048a27abcc34sm1681187lfo.202.2022.07.27.05.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 05:04:33 -0700 (PDT)
Message-ID: <028091af-b1a1-efc6-b404-dcb5b6f3589e@linaro.org>
Date:   Wed, 27 Jul 2022 14:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/5] dt-bindings: regulator: Document the PM6125 RPM
 regulators
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-3-iskren.chernev@gmail.com>
 <7e742415-d93f-83d9-bf01-6f023a4d1a34@linaro.org>
 <73a82790-52c4-b777-b4ff-f8d361f0bd29@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <73a82790-52c4-b777-b4ff-f8d361f0bd29@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 12:32, Iskren Chernev wrote:
> 
>>> ---
>>>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>>> index c233461cc980..1122a3a17f56 100644
>>> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>>> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>>> @@ -57,6 +57,9 @@ description:
>>>
>>>    For pm660l s1, s2, s3, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, bob
>>>
>>> +  For pm6125 s1, s2, s3, s4, s5, s6, s7, s8, l1, l2, l3, l5, l6, l7, l8, l9,
>>> +  l10, l22, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24
>>> +
>>>    For pma8084, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3,
>>>    l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
>>>    l20, l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
>>> @@ -90,6 +93,7 @@ properties:
>>>        - qcom,rpm-pm8998-regulators
>>>        - qcom,rpm-pm660-regulators
>>>        - qcom,rpm-pm660l-regulators
>>> +      - qcom,rpm-pm6125-regulators
>>
>> Put new entry in alphabetical order.
> 
> Will sort first (they are currently not sorted), 

Arh, indeed, they are not sorted.

> then add pm6125. Should I also
> sort the driver code?

You can, but don't have to.

Best regards,
Krzysztof
