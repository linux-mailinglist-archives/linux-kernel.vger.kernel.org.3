Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ABD4FEFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiDMGgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiDMGgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:36:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344DF3A8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:33:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id s18so1975692ejr.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B9VurXrzWDcHBP3YwtMgGNsuU+C/4Y9iM5TWxk/3L3M=;
        b=ycRBiD9wAE+M9Edv6Se/KC+bLDnd1iLsbmKfq46RV6Q+OuW/CSbm0/N4z4/qgO154b
         iQVJSp27zFiX16zXkdqKmolM8dkoRwZ71N9eHxvaQz0pl7JHC8A8u3J0dRL07eI9Nf5k
         EjnWWUJ3aMsaw7SzsWZE39KKwjd5/eQtsLheoEBRHslndbNfYc7ltq5KlB5H/p7kxjmg
         zDtxd8mt6KtbJfgsL9OEHGycl4LNMvtzJbDXbnY82NzzeuiM8yINxQ4h+t4LkfGAVlHm
         Y6m84zmRWLxkxsw2vbweZKCYprru2mKdOeTdxDRjkNL4PY0SJqUN/FHxFjfV+IfgFOS9
         R27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B9VurXrzWDcHBP3YwtMgGNsuU+C/4Y9iM5TWxk/3L3M=;
        b=Dik7cKC1ILqjOFWxqO05JFnONJPepTLEzICSE7YIQFQNP2ywBmZgyLzbn4Wp6gMNdC
         T0ZnuN15iuptgpjpcVe4O53ncb5345HJKYhgFWDhmmJqd+q2kGobST/XAje8KkZvkT5L
         yE1HoSAWkSZPdwUxYryXcvJAs3AWxhY+aee5X1Eh92DJFBsHwMLBeDxurCzkfEwNF46a
         A7m2NFinFvpMcL4mXHyffgrZ7c/UUN1tQoWgUBHl6DXwBGhnnL6rQ2Tc1jK9UI0mFQ6P
         PFiaX/IFKuRELChOvzW+FIG1Yx+UN2ZxnsE0C8VK1EmHzp/3PxSyH2l/oD/Jng+NEswP
         Qcog==
X-Gm-Message-State: AOAM5329WO7HggmIrDT3ahfsT0dBZRqj8lSP167aSUiNGiR/aux17vHX
        AFuFTuSYcon4m+5/625sEUQ9fg==
X-Google-Smtp-Source: ABdhPJwOnqt0JLVcT6WOM+GcWxpNTvgDJnvEMjc5YWYSL30QMfsE1pGVyFDUIiphoMfLJNLMGuskpQ==
X-Received: by 2002:a17:906:3042:b0:6cd:20ed:7c5c with SMTP id d2-20020a170906304200b006cd20ed7c5cmr36575407ejd.241.1649831629820;
        Tue, 12 Apr 2022 23:33:49 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm13968216ejb.179.2022.04.12.23.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 23:33:49 -0700 (PDT)
Message-ID: <89ad9e08-e0b2-d163-b089-c96ce70509b3@linaro.org>
Date:   Wed, 13 Apr 2022 08:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SDX65 DT
 bindings
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, djakov@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649740053-14507-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649740053-14507-2-git-send-email-quic_rohiagar@quicinc.com>
 <7e1e6c10-c02a-c8da-44c0-ba3abef1950e@linaro.org>
 <99e49c61-4a6a-69c6-810c-581ee0ce5008@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <99e49c61-4a6a-69c6-810c-581ee0ce5008@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 08:29, Rohit Agarwal wrote:
> On 4/12/2022 2:52 PM, Krzysztof Kozlowski wrote:
>> On 12/04/2022 07:07, Rohit Agarwal wrote:
>>> Add interconnect IDs for Qualcomm SDX65 platform.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> (...)
>>
>>> diff --git a/include/dt-bindings/interconnect/qcom,sdx65.h b/include/dt-bindings/interconnect/qcom,sdx65.h
>>> new file mode 100644
>>> index 0000000..8d02c79
>>> --- /dev/null
>>> +++ b/include/dt-bindings/interconnect/qcom,sdx65.h
>>> @@ -0,0 +1,67 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> Is it possible to license it the same as bindings (GPL-2.0 OR BSD-2-Clause)?
> 
> The qcom related code are marked as GPL 2.0 license

This I see here, unless you meant some other qcom related code?

Best regards,
Krzysztof
