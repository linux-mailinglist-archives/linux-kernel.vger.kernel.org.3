Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9B53A3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352827AbiFALYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352810AbiFALX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:23:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736B35E774
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:23:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o10so1732106edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EmX78kZDbpi7zDJcl5NRBNnxEqWkEcLfuWB3zLytvQ4=;
        b=r55wWxDb8gLLLDShPuOiJjmUz1D5Xgin/ldr6b/Tnulo5/FyaoiTrGCFmJK10iRxpl
         /b5twD1DES3+6TJftiXJLlEH5MTxw6tzyqTXWS49/e4fUXACwFeWmyPUdl79bB1ZMm28
         1EQZtIGbcpDoxuCn3othqQWKg+D6efafEyLZYTIBuSeyngpnqUPZSWp0zb/eRJWQMD+4
         W6q5xcRyZJBNbHcwT564fW1iOCfBexrbxseQQNfQI9zG+QVQGtdYMM8Iugx4ALnbLNtu
         EfIQzbvmIUrpisGyxuU8pS95ihIaVEMR2VjCfh69jDHQWuXdYfHfC7+QL1vDtMre9YvW
         WOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EmX78kZDbpi7zDJcl5NRBNnxEqWkEcLfuWB3zLytvQ4=;
        b=x/X63ZGh+0J12h0o7fKSoZXZrmlq6igG8mgUsvAddBKqTlPCXHBZmT6rkvTq/pV0+A
         KhXOlaUc94GqrrHzFmLBvVtAqj5Gw8qpf8ZVinOHH62NLpN2AMiStsG6f0Rfc87Up2/E
         w2XRAemaT4arRd6dPHNNEL9LUlDD5Yro9rfC3tsL75J28zhsy6n/DfurdA0bTWZLIHRm
         5qcM+mQ59GZmustgP7OQwRqWSM/LKxcCmT2JnYHSTjNaIh7fPIN2UXiAWjprwHqNJfj0
         5lkgenmsKNKtkmk108w+SkH2zWGxByGHOTKH6FBUSNOEsdO7+jzKmgmOBmaBn/gCmrGk
         Ygiw==
X-Gm-Message-State: AOAM532iUvNglLHAkryApfjXty/+h5tMO0QsUS+QUx7OQQU1I/D2Yz6r
        yve4quqP6LJW3hg7rTFZ+uIKYg==
X-Google-Smtp-Source: ABdhPJzOJxGalCbiJf1Q2Q8zI2vrTUHr2z0fwXYzl5tTyez6dQrB/mI0xzVPeI2IOWLC/p/Lwqsvsw==
X-Received: by 2002:a05:6402:1907:b0:42d:e90e:337 with SMTP id e7-20020a056402190700b0042de90e0337mr7327648edz.405.1654082589971;
        Wed, 01 Jun 2022 04:23:09 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p19-20020a056402155300b0042617ba638esm823008edx.24.2022.06.01.04.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:23:09 -0700 (PDT)
Message-ID: <7a66f2e2-1a2a-a262-138c-f535499984ae@linaro.org>
Date:   Wed, 1 Jun 2022 13:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
 <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
 <dea39b1f-0091-2690-7f07-108d07ef9f3c@linaro.org>
 <20220510044053.ykn6ygnbeokhzrsa@vireshk-i7>
 <1e533194-7047-8342-b426-f607fddbfaa3@linaro.org>
 <20220511050643.hd5tcrojb3wkbg7t@vireshk-i7>
 <20220518235708.1A04CC385A9@smtp.kernel.org>
 <65a4c28d-6702-3a9f-f837-1ea69a428777@linaro.org>
 <20220531103029.ntoypaafnd6447ag@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531103029.ntoypaafnd6447ag@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 12:30, Viresh Kumar wrote:
> On 19-05-22, 10:03, Krzysztof Kozlowski wrote:
>> Yes, true. The clock frequencies are still changed with each gear, but
>> in general the UFS indeed operates on gear concept.
> 
> Hi Krzysztof,
> 
> I have redesigned the OPP core a bit (two patchsets until now) to make
> it easier to add multiple clock support going forward. I need some
> inputs from you before moving forward with it now. Will this work for
> your use case:
> 
> - Add support for multiple clocks, where none of them is primary.
> 
> - Which means you won't be able to use dev_pm_opp_set_rate() but will
>   need something like dev_pm_opp_set_level(), will add it.
> 
> - That is, your OPP table will need to implement levels (I think of
>   them as UFS gears) and then call dev_pm_opp_set_level() instead.
> 
> - This new API will work just like dev_pm_opp_set_rate(), except that
>   it will find the target OPP based on level instead of freq and
>   support configuration of multiple clock frequencies.
> 
> - Of course both these APIs will share most of the code.

Hi Viresh,

In general this looks reasonable and matches how the UFS gears should be
modeled. It does not match how UFS drivers implemented the clock
scaling, but that's the internal problem of UFS drivers. They scale the
clocks only max or min, even though there are multiple gears in between.
The new approach looks therefore appropriate.

Best regards,
Krzysztof
