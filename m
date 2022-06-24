Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBE559474
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiFXH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiFXH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:59:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DEC6B8C3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:59:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so2249685edm.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=df4hTcrZotnifvBHPZxAZdqUw93jw7Dt3467JJNB40g=;
        b=oLSnu9e94vKdRXjQHDnvIcjxIN/kvSvWyBfbx/YeRiWoNNvvqp3IZYU/2xklU+PlD/
         EMjM10q6UU2bK/VxLvvOrrzekSpXNyFq1B7TD2SX5twDhg/X86z8OJ9Ype+idW0/EhUM
         fQrq6Xkp1zMs1EmCTaJeUpsPTavWW9wSQb8u9HzrPfKlRgAs7JsUbKvFuOotXtcOSumz
         a7wD9l4UI1Bq6vlWf1hqUIH+BuS9twZqomrRIHmT8+WlV+dDeXC/0ast1KS6KVTdcTLQ
         cE32tb2ZpWpDf8lrpeMmamyrPrbPwGZ7zHtpoDCDhoVSdlEVhOFV0opBfkyw027GkqXy
         CPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=df4hTcrZotnifvBHPZxAZdqUw93jw7Dt3467JJNB40g=;
        b=jQxofjiFLdxpBNSXRSn7UJo+IqhYS4vkJ7Cv1Jg52JUO6l8lt47CS6sdSKnV6ElING
         OvDkyQsE/nGetkREN5+Mfoy5r6mGyciER+7pyajqoW3qUhnO2ov4z3ouZsYwFX6BBt/f
         YxkhKyTKRECPkEmlDUnopyCGfSINkY6cHt6NbUsCxCvlP5s08H/kBTXSSrg23UkZP5tF
         UFSGRllVcpUtSDw/rCaAD6Z9rntGzXbImINFDmVj6pE38dVkPMi+knpHuJNj/wpkZFUl
         NHIgFcIJ3W7evBznkD0D2Ik3gmer7nU5V9IGB1qwMoC+tc24P9qkmrAi0jhP7yh6zwhR
         8T/w==
X-Gm-Message-State: AJIora9DuWjrOCgAmncDi4IFTGAwXXs5uKRD13rLvwpd7lZNdgZhhFFs
        zOf+9tCUrA8fKcuBqACBN7HE2A==
X-Google-Smtp-Source: AGRyM1svgmJ/GTyyqp4Dc5HIRGri5HppdA20rfEgzWNE9Vzoxh6xPtdys+apubLBTZCgcTVIifqS6g==
X-Received: by 2002:a05:6402:280b:b0:434:efd8:d9ae with SMTP id h11-20020a056402280b00b00434efd8d9aemr15633804ede.120.1656057584335;
        Fri, 24 Jun 2022 00:59:44 -0700 (PDT)
Received: from [192.168.0.233] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b21-20020a1709063f9500b006f3ef214dd9sm671371ejj.63.2022.06.24.00.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 00:59:43 -0700 (PDT)
Message-ID: <033af024-8acd-e536-0c24-ff30b12a581b@linaro.org>
Date:   Fri, 24 Jun 2022 09:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] clk: samsung: exynos7885: Correct "div4" clock
 parents
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Virag <virag.david003@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220526055840.45209-1-virag.david003@gmail.com>
 <20220526055840.45209-2-virag.david003@gmail.com>
 <2eda61c1-a076-3467-91bc-8c2e14f4f516@linaro.org>
In-Reply-To: <2eda61c1-a076-3467-91bc-8c2e14f4f516@linaro.org>
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

On 26/05/2022 09:21, Krzysztof Kozlowski wrote:
> On 26/05/2022 07:58, David Virag wrote:
>> "div4" DIVs which divide PLLs by 4 are actually dividing "div2" DIVs by
>> 2 to achieve a by 4 division, thus their parents are the respective
>> "div2" DIVs. These DIVs were mistakenly set to have the PLLs as parents.
>> This leads to the kernel thinking "div4"s and everything under them run
>> at 2x the clock speed. Fix this.
>>
>> Fixes: 45bd8166a1d8 ("clk: samsung: Add initial Exynos7885 clock driver")
>> Signed-off-by: David Virag <virag.david003@gmail.com>
>> ---
>>  drivers/clk/samsung/clk-exynos7885.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)

Sylwester,

This goes to v5.20?

Best regards,
Krzysztof
