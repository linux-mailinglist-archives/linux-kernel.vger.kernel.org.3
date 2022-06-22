Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA74554A04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiFVMUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiFVMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:20:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5863B37001
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:20:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g26so12440739ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YqZl55YlnzKJuZvnAvOYUqgqzVWeklNXo8K4BWb79NY=;
        b=K+vUm9h4zeZ2BY+AkhsLxdTYyhJwqnMXqQq77ZRQfWdtzXQwazdV7BvakFNKvQJxGb
         YbZqFHNUdhLZ5rkfeG9GzWzmy0i05jF+yiQg8vU/hKgJvaCCmROqzo1ePUT0nW3nKGUb
         awSUdhmwMFCXKWFnTe0GlnC6o/TV/UIx84e8QJEZjXf+qSo/JH9yEfluwL4JpjwyP6lJ
         C3v6aS4CbXAKHBZ3u0eWXDUTiz5mZLZLDle3Ex5Cr41wSJ3Ouze7STBZxmb+C++WIMaz
         YkGxZucrMsZHESuItdlF4xdJ5T7GkNi5dtvrDtaLfu+1DR9q6wJLUUJbdkozGT3mKCLX
         mILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YqZl55YlnzKJuZvnAvOYUqgqzVWeklNXo8K4BWb79NY=;
        b=JRkQB5urj1Cyo5slx/0q1g1N6QlxHmzRFbFQWsEkeRRKpIlL20KgWQ3z23gnx8N6FH
         mMR3fsRSuUSR8vXTxqaavnRdagSFGJX899aPiYg1jbGS1jzFWKquCTOYI0Phng3nM+ZB
         6mwoIjxftRhcNh3Nx5MKRh5aloGn18gQQAF0mZQZe6l0zR6hqCwi0IURqzGGumpddFeY
         zEQ6B7yaGTjj/kqbSVGztIdVp0hGnW170PgKKsSJvX9KJpHk6whtoVTHqsiHLGBsZA9Y
         BY71aBCdv0eGPMGyj3FgQDjsb50nXCyyXieyXzsg8ijacd//0A29Wbtv04ZdZb20ktTg
         hK/A==
X-Gm-Message-State: AJIora8mHVkjWVu2yI6r9ZzenqrA6ylB0GhlGjw2mk63vN3Qb26roGcu
        2FAQygwAVzHbHgD1uhlsGcL7MQ==
X-Google-Smtp-Source: AGRyM1tRaVprGVLQKE51VKBB6prua/fQyAH18plkrLguHseuDTTg9AZY0HC40TSxd49AsE/GzfvZTQ==
X-Received: by 2002:a17:907:d0d:b0:711:d554:1c8f with SMTP id gn13-20020a1709070d0d00b00711d5541c8fmr2878279ejc.223.1655900426586;
        Wed, 22 Jun 2022 05:20:26 -0700 (PDT)
Received: from [192.168.0.224] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm3077762ejo.164.2022.06.22.05.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 05:20:25 -0700 (PDT)
Message-ID: <be7fafdb-5553-1b64-e7f1-5909aced3ba5@linaro.org>
Date:   Wed, 22 Jun 2022 14:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/4] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon:
 add BWMON device
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-2-krzysztof.kozlowski@linaro.org>
 <Yp5tjUICIEUptKSx@ripper> <3e4e504c-5a38-43cd-ea8d-afbbb72eacad@linaro.org>
 <dbfe1e7c-19dc-2d20-700a-c26f0bf721e5@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dbfe1e7c-19dc-2d20-700a-c26f0bf721e5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 13:58, Rajendra Nayak wrote:
> 
> 
> On 6/7/2022 12:20 PM, Krzysztof Kozlowski wrote:
>> On 06/06/2022 23:11, Bjorn Andersson wrote:
>>> On Wed 01 Jun 03:11 PDT 2022, Krzysztof Kozlowski wrote:
>>>
>>>> Add bindings for the Qualcomm Bandwidth Monitor device providing
>>>> performance data on interconnects.  The bindings describe only BWMON
>>>> version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
>>>> Controller.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>> Acked-by: Georgi Djakov <djakov@kernel.org>
>>>> ---
>>>>   .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 97 +++++++++++++++++++
>>>>   1 file changed, 97 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
>>>> new file mode 100644
>>>> index 000000000000..8c82e06ee432
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
>>>> @@ -0,0 +1,97 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/interconnect/qcom,sdm845-cpu-bwmon.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Interconnect Bandwidth Monitor
>>>> +
>>>> +maintainers:
>>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> +
>>>> +description:
>>>> +  Bandwidth Monitor measures current throughput on buses between various NoC
>>>> +  fabrics and provides information when it crosses configured thresholds.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - qcom,sdm845-cpu-bwmon       # BWMON v4
>>>
>>> It seems the thing that's called bwmon v4 is compatible with a number of
>>> different platforms, should we add a generic compatible to the binding
>>> as well, to avoid having to update the implementation for each SoC?
>>>
>>> (I.e. "qcom,sdm845-cpu-bwmon", "qcom,bwmon-v4")
> 
> it seems pretty useful to have the "qcom,bwmon-v4" and "qcom,bwmon-v5"
> compatibles, I tried these patches on a sc7280 device which has a bwmon4
> between the cpu and caches (and also has a bwmon5 between the caches and DDR)
> and the driver works with zero changes.

The trouble with naming it v4 is that such versioning does not exist in
documentation. At least I failed to find it. Neither there is clear
mapping between SoC and block version.

The only indication about BWMON versioning comes from downstream
sources, which I find not enough to justify usage of versions for blocks.

Therefore as per DT recommendation (which I am enforcing on others) I am
not planning put there bwmon-v4.

Best regards,
Krzysztof
