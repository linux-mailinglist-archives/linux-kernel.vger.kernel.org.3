Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176DB53F682
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiFGGsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiFGGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:48:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35580B0D2C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:48:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so33200431ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9oONL/OIu1tsLLfjz8MWbADwzFR0KPOH6QzNxFIcw1A=;
        b=eHc01tNuGgQVe9JfPpB6GYMNwZK46sRHR3uDq807BB8RAkhtM9iR1guy6gYb+UKuJW
         g3yAm4q1CjZJ6Pp9OZfINnQzQ6SlfDARMFL44cz7rzQyewKJDz4DCw2s9a6+PUnsnsls
         kkbjZQKYC5uzVhSvIW60DvmNZwSNXhTnEDamP2tQK2CG6zybiBXQOP8biOwIXxqLd/lr
         xXp4GE/l02zl0EyPtU9/au8J7ZOL5nvjMry9t1lUMfnAAiEl5h/aERCGNL3NcZMtNr6W
         z9u/tnTpAuY5gaFcEPQ2vdavW7L3MZwzsFofi2wXD9QrtStZ8mfDytt2Wi/3dZ3/NivE
         FNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9oONL/OIu1tsLLfjz8MWbADwzFR0KPOH6QzNxFIcw1A=;
        b=oib0dwg6sMAU+G5xgmqnqtHcwJI9Iq3vVfVitwy3BXQUd5yD6j+AMrXXWRust/O/jl
         j/p9BrWoXukNZHciya1UjfTx6dggD7IwkC1d6ZEMmVHn4kvF6Kxtg1PseCcG/TyPngPK
         LtCnkyDTQwqNEaFdKizbQhKNaQNIexQzff+WWilEYU5QL2Un4KBNDJlUgo4T6fLrcXl3
         Y5c31lFtMPYlcoD6tkH9bkvpzqGmRkpKkqxCQdZFNbEfdkuprQEEV6Qti3gY+jSzJHkm
         HrKzhUfcwhffgn287XK9+lcWl7RrAnLvPkrLOzVeD66ysrIUkmzAKXDTHsfsOllJ1zHr
         NLdQ==
X-Gm-Message-State: AOAM531FrJVByyjaTQm9cD3iX+newVptyK6tpmdat3uA2QTby5swDM6y
        /zmdy0kmnuiahX2tJWcSlb1L5Q==
X-Google-Smtp-Source: ABdhPJwZ+u3wskAK8md9FAIw+OFZWkxhbfQb/zXoi4kIC5wHI/eBNsIRDkNmc9Xh8XtL7N+ZNnWZaw==
X-Received: by 2002:a17:907:3d89:b0:6f9:1fc:ebf3 with SMTP id he9-20020a1709073d8900b006f901fcebf3mr25319012ejc.403.1654584485575;
        Mon, 06 Jun 2022 23:48:05 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b0042dd4ccccf5sm9653874edv.82.2022.06.06.23.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 23:48:05 -0700 (PDT)
Message-ID: <e5029de5-2548-23a4-8dcf-101154e0be29@linaro.org>
Date:   Tue, 7 Jun 2022 08:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
 <058de46e-24cf-e25b-121c-3ff080702776@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <058de46e-24cf-e25b-121c-3ff080702776@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 22:39, Georgi Djakov wrote:
> On 1.06.22 13:11, Krzysztof Kozlowski wrote:
>> Add device node for CPU-memory BWMON device (bandwidth monitoring) on
>> SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
>> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
>> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
>> with lower CPU frequencies.
>>
>> Performance impact (SDM845-MTP RB3 board, linux next-20220422):
>> 1. No noticeable impact when running with schedutil or performance
>>     governors.
>>
>> 2. When comparing to customized kernel with synced interconnects and
>>     without bandwidth votes from CPU freq, the sysbench memory tests
>>     show significant improvement with bwmon for blocksizes past the L3
>>     cache.  The results for such superficial comparison:
>>
>> sysbench memory test, results in MB/s (higher is better)
>>   bs kB |  type |    V  | V+no bw votes | bwmon | benefit %
>>       1 | W/seq | 14795 |          4816 |  4985 |      3.5%
>>      64 | W/seq | 41987 |         10334 | 10433 |      1.0%
>>    4096 | W/seq | 29768 |          8728 | 32007 |    266.7%
>>   65536 | W/seq | 17711 |          4846 | 18399 |    279.6%
>> 262144 | W/seq | 16112 |          4538 | 17429 |    284.1%
>>      64 | R/seq | 61202 |         67092 | 66804 |     -0.4%
>>    4096 | R/seq | 23871 |          5458 | 24307 |    345.4%
>>   65536 | R/seq | 18554 |          4240 | 18685 |    340.7%
>> 262144 | R/seq | 17524 |          4207 | 17774 |    322.4%
>>      64 | W/rnd |  2663 |          1098 |  1119 |      1.9%
>>   65536 | W/rnd |   600 |           316 |   610 |     92.7%
>>      64 | R/rnd |  4915 |          4784 |  4594 |     -4.0%
>>   65536 | R/rnd |   664 |           281 |   678 |    140.7%
>>
>> Legend:
>> bs kB: block size in KB (small block size means only L1-3 caches are
>>        used
>> type: R - read, W - write, seq - sequential, rnd - random
>> V: vanilla (next-20220422)
>> V + no bw votes: vanilla without bandwidth votes from CPU freq
>> bwmon: bwmon without bandwidth votes from CPU freq
>> benefit %: difference between vanilla without bandwidth votes and bwmon
>>             (higher is better)
>>
> 
> Ok, now i see! So bwmon shows similar performance compared with the current
> cpufreq-based bandwidth scaling. And if you add bwmon on top of vanilla, are
> the results close/same? 

Vanilla + bwmon results in almost no difference.

> Is the plan to remove the cpufreq based bandwidth
> scaling and switch to bwmon? It might improve the power consumption in some
> scenarios.

The next plan would be to implement the second bwmon, one between CPU
and caches. With both of them, the cpufreq bandwidth votes can be
removed (I think Android might be interested in this).


Best regards,
Krzysztof
