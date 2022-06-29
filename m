Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F301A55FE66
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiF2LWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiF2LWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:22:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EDE2180A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:22:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mf9so32016887ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fGm6fqw2YW1uqWu3gi81JCdQoxsdScWmBsLg22T2BVU=;
        b=nJqcmK32rXmYDaxAu0A68rmBBx9rPABWwX9p2A7NZpP+ZLL6aKO4FIeLsCpECAKhjm
         25F8QrGZX9RFwhnxwJpL8T5R8iuTSdsaR6SDD1PAyEf4XhJQeJMENdVWOJgFiO33xTR7
         MNPdXJhYeB2vs+DdeRFI8QgnhMobWNLfgLLYWb6LsaP726rT4axAhNRh0GH1NUScjYc8
         2fyhnnEB7Xvzut0gaekMCTsgP+FSdmrdQcWnqolEa1S1GoDe91CzSklag/C+EYiD2FFT
         KVBQCTRg5+AQo6ke1aHUelccNEU6GwuDNFHA107QIJu3swMNNJrW618DIHi36xdLID08
         CNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fGm6fqw2YW1uqWu3gi81JCdQoxsdScWmBsLg22T2BVU=;
        b=lt65lEqeS28DXJny46PUASK5EaoUVZuqNxf6Fpuynd4A2QO49RUiA3Vct1TsHMpQI3
         J2IJGRLE4HApQwmrZ0/NIt4ekLrksVgN8W/KYaM9DWGSAG3rMk1a+/Hlxi8uY+yt4gPI
         6MiZTMej6212w/TQZFuJO2LsiTv9bFfkupCzUumCUztgszj5F+hWbiTadCwMdgy0Ppor
         1WmA2XKSYMsUMDeU4d9AwZ2LLq50Ck0lK73ytKJvlfbrMJWGOS1SHlt2JyQWDxrWwnsM
         Pv6APRtmv6kCU+Pe7mGaFDoiqybJNhMuBzA6P2F64MTHDQV6YHqVj4gcONhB2j+SzPpv
         qqmQ==
X-Gm-Message-State: AJIora+gHsSgxbkGA2ykW29AmZec3cKMbtghiDhcHTe5tb5vaG5feAFD
        +BJLsHLNPOdVw5vbBPDYdUP8Zg==
X-Google-Smtp-Source: AGRyM1tY4YFMRcOCf8Nca7bLLqAbv0rjL4zX4VO3jEHFlqgoQp29S45c23YShV+h6KgaTGg6XPE53A==
X-Received: by 2002:a17:906:58c6:b0:72a:3df5:813d with SMTP id e6-20020a17090658c600b0072a3df5813dmr1344460ejs.153.1656501735704;
        Wed, 29 Jun 2022 04:22:15 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906609700b006fed062c68esm7741787ejj.182.2022.06.29.04.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:22:15 -0700 (PDT)
Message-ID: <76b8819f-df55-8b81-7f80-90d0694400d4@linaro.org>
Date:   Wed, 29 Jun 2022 13:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/4] dt-bindings: interconnect: qcom,msm8998-cpu-bwmon:
 add BWMON device
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
 <20220629075250.17610-2-krzysztof.kozlowski@linaro.org>
 <7d1fe567-6dd7-a6e0-08bf-225e8d515931@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7d1fe567-6dd7-a6e0-08bf-225e8d515931@quicinc.com>
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

On 29/06/2022 13:21, Rajendra Nayak wrote:
> 
>> This BWMON device sits between
>> CPU and Last Level Cache Controller.
> 
> []...
> 
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - qcom,sdm845-cpu-bwmon
> 
> should this be qcom,sdm845-llcc-bwmon instead since it actually
> tells us the llcc bw values?
> That way perhaps the other one between llcc and DDR can be
> qcom,sdm845-ddr-bwmon.
> 

Good point, thanks. I'll change it.

Best regards,
Krzysztof
