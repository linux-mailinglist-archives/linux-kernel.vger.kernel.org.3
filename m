Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3490C570189
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiGKMCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiGKMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:02:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F75C3B974
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:02:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bf9so8254577lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QVqxg0dp3wEYOZpL9v9ilM2FSVRUoonO6i41pxiTzI8=;
        b=hFlw6gC8Q7phUNCtcoZ+mnhDG3DT2Icr9ctPW9MH8XjMtD29CbFUV/+EqObdE85V3+
         84TFY8D/cPCLDmxM+Yjze8C5OqepE/+Jks3xTPjY8bvxWBK6PIcNzNssTM1CFhs9LtEk
         jwd7bOEnaXnycO0NG4YXMJQxd0/Iydvchv52ywJ4QVSlfLFKenAy31lHszz6+D8Fiwtu
         0PxvFQZMrFg2Ig2iOO7St7bU6PIywmAR7oIdOA8wSFtGZNMLW2Wx+fOS0U4T/Sc9xrDA
         yiqr7V7dxkxre7p2jDbyB8gkHTM4L7MGLh1bGnShicdj+usImIZHWFNsR4CLEWZT0lgl
         /CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QVqxg0dp3wEYOZpL9v9ilM2FSVRUoonO6i41pxiTzI8=;
        b=lioXDo8271tJCaSEpgs1B9ObN2UBgXqIox1vIqhGJLBTUUkXIOHrAe/7pVxgk3JWP6
         E84YgB8FjuuJt/bx1nQKoLI2a6RvD4XWaCT79Plr936Wj5O49ACpTCk09s0MN6E1rBQy
         0c2duIJPnF0zemwGdMmpRUBKAkkuDyWXIrbUUI66COAO/oLlW+H8J5Ae9uZTckA75UQc
         v/o7Bcr8394U4YsmyQoUR/Oss81qSUDfPoy40pAF1KXqxku0GfaxvtrBLXbG4Lt9Y8cR
         GwxpRZvZqWQ4qNDDqUGv/OWFvmBcbrvC7dn0TLIkmap1IPBpjMbzQaJLWRpGmhLr3Ond
         R5GQ==
X-Gm-Message-State: AJIora8Up6Ja1af65P/j2heqDaKfFAGXbdKerxH5l1jqJhqMw75RejZl
        6gyboDTP6zsY5nFs1M96Qa7Z8Q==
X-Google-Smtp-Source: AGRyM1tPFsxY/xB1ICxsLpx4b0d9lJislbMty935ePwpSxLaNm08XHOXHHUPjHR/WWsfjwVIeBOlQg==
X-Received: by 2002:a05:6512:398c:b0:488:f524:b7e9 with SMTP id j12-20020a056512398c00b00488f524b7e9mr10868068lfu.259.1657540924386;
        Mon, 11 Jul 2022 05:02:04 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id d28-20020ac25edc000000b00489c719b809sm1492196lfq.284.2022.07.11.05.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:02:03 -0700 (PDT)
Message-ID: <9e1ff864-3952-6442-13db-a3d8e18f86c3@linaro.org>
Date:   Mon, 11 Jul 2022 14:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] clk: qcom: apss-ipq6018: add MODULE_ALIAS
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220711104719.40939-1-robimarko@gmail.com>
 <20220711104719.40939-4-robimarko@gmail.com>
 <4de38d90-0020-c2db-b283-319b4a0e2ce5@linaro.org>
 <CAOX2RU6X=JiV1As+_N6c_=VaHfVYpke_deQmmNPMMDxfnz5i8g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOX2RU6X=JiV1As+_N6c_=VaHfVYpke_deQmmNPMMDxfnz5i8g@mail.gmail.com>
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

On 11/07/2022 13:46, Robert Marko wrote:
> On Mon, 11 Jul 2022 at 13:05, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 11/07/2022 12:47, Robert Marko wrote:
>>> Add MODULE_ALIAS so that driver will be autoloaded if built as a module.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>  drivers/clk/qcom/apss-ipq6018.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
>>> index f2f502e2d5a4..963c69f2c0c2 100644
>>> --- a/drivers/clk/qcom/apss-ipq6018.c
>>> +++ b/drivers/clk/qcom/apss-ipq6018.c
>>> @@ -101,5 +101,6 @@ static struct platform_driver apss_ipq6018_driver = {
>>>
>>>  module_platform_driver(apss_ipq6018_driver);
>>>
>>> +MODULE_ALIAS("platform:qcom,apss-ipq6018-clk");
>>
>> That's not correct alias (no commas) and usually alias is not needed at
>> all. If you need one, please explain why it is needed. Module
>> autoloading works fine without aliases...
> 
> Hi Krzysztof,
> alias is required here as the driver does not use a DT compatible but
> is registered
> by the APCS driver, if built as a module, it won't get autoloaded
> without an alias.

Instead you need device ID table. Aliases are not a workaround for
missing core driver elements.

> 
> I can only fix up the driver name here and in APCS first to have an
> alias without commas.

I see that the comma is used in driver name, so this is an independent
issue. Maybe change it to '-' in separate commit?


Best regards,
Krzysztof
