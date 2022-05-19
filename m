Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9282052D194
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiESLfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiESLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:35:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BBCB0A66
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:35:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u23so8633993lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TCjmGPy0SDboBVIutYmABeJhjmy/yNmOBhY70ZJKm34=;
        b=u2wKZJYFwKripn4BJEh9JTJClCrPMxeeVAUY/FR2Rp6+zlFZZCfCDf6Wo561rrqIu4
         P8dDLkJPXHJVZuNYIXmUpYpE+2EM8wusyCcOgFTImIjGzXi3+lv0e5iZHgEZ6Wb0tUvB
         PCKfOJMAS6SHwuF+evavImIceRY1EPIfJPMfGaEDH7qHXoj4xmgeN8nLql8xfHUbXEO1
         5pBk+wQlbz8IYX18XZgImAr2t+PpuBYZ340ecUmpDJ1RBnY57g6OAiMlp9naS3z3CtzE
         Ld/p2RiDERai9j/4wdDec4setIuDv8ZelvbXvT7M6icKCqeDJhyY+s1BGwMaMxrV8I6Z
         M1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TCjmGPy0SDboBVIutYmABeJhjmy/yNmOBhY70ZJKm34=;
        b=F+qr3qgf3mlzAvogjy+grFlhyL29nIg9dGhHH15EbUWk3FVTzEgR4sDtji4EhRILmW
         CHTZ1iFcBJ8q73w28XQOCpVEIm1c5hB8CJ9MBFAXmJ3wpzmPQyUN8PrbPuCCjwZm9LLt
         rb4i52jM12iJfPT57fyU2EcF/YIh749qTe91KYfSb9y+SkqLd4INMIoEuwOG9GHqRFLV
         98xmY3yrFTCNCp2+5adBclc/09wpIVtwjg58H2wGTHZZY3Jw8ke7/zrLeOXBDpCBHlYx
         zSnlw8Ntm99bSBd11gXk7EyX59HAX5qrs/AJr0MElU0hElpzA7Sp+KUu63s4hEmUdYfO
         0/5Q==
X-Gm-Message-State: AOAM532XK9oUR8ZY7gPhYDyMm3Q9rOcrA7vo7u3iwmrFJy2EPaPYHCUr
        2T2rgJ9Dmb5vIzHiDnr0A0MFWA==
X-Google-Smtp-Source: ABdhPJzLH+q3cnn1YgCQYp6QlL4DRa+F5w1aD7hiBWy/faJbh3DSsLSkr1yk1PC6lRxWhrXO47eXSQ==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr3034085lfa.210.1652960132258;
        Thu, 19 May 2022 04:35:32 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n18-20020a2e9052000000b00253d8962fffsm99317ljg.18.2022.05.19.04.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 04:35:31 -0700 (PDT)
Message-ID: <4d9b29e8-b171-e181-e2a7-2c8c80107ab1@linaro.org>
Date:   Thu, 19 May 2022 13:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: Add PMP8074 DTSI
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20220518184825.1034976-1-robimarko@gmail.com>
 <20220518184825.1034976-6-robimarko@gmail.com>
 <015c60e9-78f6-f0f0-5af0-733a78fbdf65@linaro.org>
 <CAOX2RU4--VULzvc9NGc4zWV4jpD+riM+9Ff8mqU834a6vQFc5Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOX2RU4--VULzvc9NGc4zWV4jpD+riM+9Ff8mqU834a6vQFc5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 13:21, Robert Marko wrote:
> On Thu, 19 May 2022 at 13:07, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/05/2022 20:48, Robert Marko wrote:
>>> PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
>>> controlled via SPMI.
>>>
>>> Since we now have support for the regulators inside of it add DTSI
>>> for it.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/pmp8074.dtsi | 38 +++++++++++++++++++++++++++
>>
>> This file is not referenced by anything, thus not possible to compile
>> nor verify.
> 
> That is correct, I can include it on HK01 which has an SDHCI controller
> and thus can consume L11 for VQMMC so that HS200 and higher work.

Yes, otherwise this does not have any effect.

> 
> I wanted to include the nodes directly in the SoC DTSI and set L11 as VQMMC
> for SDHCI there as this is a companion PMIC and always present, but
> the established
> procedure is for the PMIC to have its own DTSI and then be included per board.

Which was correct suggestion but it is not relevant here. In your
previous approach your PMIC would be included on every board via SoC
DTSI. Now your PMIC is not included at all.


Best regards,
Krzysztof
