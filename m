Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05D50CD54
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiDWT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiDWT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:59:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBD819A48F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:56:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id el3so9379441edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yNSMjzR/UC7gAKQriiodIhNkqmmIvXbfjZZmbtmDsBI=;
        b=yzdnRPgskGVSMi8zv4oBko9lVeYwVJkxDSR6MCkGUoXeTAK/4NDODNNgZ26KgG/mOU
         CoB2QmI5FRJiOq51uIk68eCareFVrvmvpKA6fadl6vN+B9T5RdthGC51nk1UKkl+rI8V
         bjJ2huIzejbSjE72D4g4LFxCCdRX9/IA+qfbvCDwAyYtGJd+1W1YKHpSRD6XJtD/NGTi
         CpaqFGoxA5vUA+GgVLLCa5jP0gs2G4OvNlibifucQX9N1C8ExbobxZ9RxTWEg1kPm5Q4
         cw1AHrC+4rdOM3XxOEVWQzz9UEH9NMK1rgPaPN7MQiMNTT4/+pOMEGnmTuWdtFC0C1b1
         hT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yNSMjzR/UC7gAKQriiodIhNkqmmIvXbfjZZmbtmDsBI=;
        b=XXKDGwibc7fqiBCze+YFn4MezbcCVPHo68g4ly7AT/DtzP8dDInXCg/AcESizLV7HN
         aE+CnQ5aspaCzqkIf+WtxDt5oE3Z4EN74xqrJfpRd5nTGkzszvaDIGosw2feEgn1OFOs
         TY08MCRGTEkbBrUpiOJbWoitoZBV/S+vgzrziY7tL6qxyqVJ0hDbScRUxqNFdA+0wb4P
         pYVMEZ8JbSgQP/DfoIRuDaE2Vk3NuLPjXnGCVyF7u34aoc9Bir03NC5WqyT90I4FwL4y
         i3DGqrRHXxNgUhwOqPuRbFVjvcw8iBhZwYcQby3BW12qzYGRHisj/KSy1GWSQBUlN3+w
         EDRg==
X-Gm-Message-State: AOAM533i+mV7vHbf9/xNTgutXVfnqmi+MEyLGR8diNvvW9IsdrwAcjYA
        +Xa8k3LAE1M9lpkwzoW6a1s8DA==
X-Google-Smtp-Source: ABdhPJzP7TI1ViD5VGn0KNvewzYBqWM6Mjpp1qDDQ0uaLL/LxQa1J8/5UFBb/Hc1PCg1kUb/MRd8iw==
X-Received: by 2002:a05:6402:331c:b0:41d:9354:97c2 with SMTP id e28-20020a056402331c00b0041d935497c2mr11442391eda.300.1650743805113;
        Sat, 23 Apr 2022 12:56:45 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402045800b0041614c8f79asm2518327edw.88.2022.04.23.12.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 12:56:44 -0700 (PDT)
Message-ID: <af3d5b2f-b245-6c10-1e2c-0f8f5a979fc0@linaro.org>
Date:   Sat, 23 Apr 2022 21:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] dt-bindings: remoteproc: qcom: pas: Add MSM8226 adsp
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220423155059.660387-1-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220423155059.660387-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2022 17:50, Luca Weiss wrote:
> Add the compatible for the adsp found in MSM8226.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
