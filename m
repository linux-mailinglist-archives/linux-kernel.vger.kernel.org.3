Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A095657F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiGDN4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiGDN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:56:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0986BCE32
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:56:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a4so16022122lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y8tf/kMFYwfWY6Q9DD4JUxR8ogCCSX7lOhzrzkly/+E=;
        b=eraqwl5pKrfGcSwpyEi/PH7EnjWcsUGqNVP3O0kENPxHo/1vcWL1yR3Sxp6+Cu0KMC
         +uxtZJMDv4f96ABwguszkQcf/nrrYRd/Yd4bdQrh/EcE8C6dqloVoNUWUfSDsJsoVeJb
         fZE/ip1mj67Jn/El6hZg8aLa+QZfwWlDnVJFp6ZJh7lWng3HaN7pk4+G/JEl/tzRm30b
         ToAgaSHsup6I+VLHElFl0k2l3IahkSUaosIDB9XLcrsJb5FhIbaGwJ+LdIEpvGaQkTv0
         0NkymntNXi21OQZcFkymlOcDjVR2btGigsokpu1yZTF06g4klXaiISWcKN3OdhaRscZx
         J40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y8tf/kMFYwfWY6Q9DD4JUxR8ogCCSX7lOhzrzkly/+E=;
        b=xBZBmq4+u5b6v+XXIcXhLb8/xVKqzPOcgTLPSoY6rYYQ3ulEp22cTSg9Rrlsk5rmLj
         4ukuxaKmV+gZaEQujcFH8luSbnM8D3HEGvff+eZFIxoIad0996rSVb+uh6fzSE23Y5Jm
         hrAcY3WSgAqgysVCnh8JSYQivQMYpTMDlIY2HhZjNo8hRkpZin+Ae5DVAXp0T7opEUb+
         jdQpSJeq8SeN6Zlmz+wi9flqxJAhO8bOaXbJGUPKzH2s5sB90zv7qjETx0bD9IjwJ4h1
         EdGxzJfrGQzRBvIUT7A4vfbkf7P9kXJ2Tq4n2ISLqe8y8P2drEfV9WB8escfnOcJxdsk
         jNDw==
X-Gm-Message-State: AJIora+LE6wH0o1UV44C0jtoPKgJkrdPjU9plndabssx74by2iQqRlfC
        xi1ds7YLGRGlfnrDac45pHEQaw==
X-Google-Smtp-Source: AGRyM1uiwmRvU31oLYiU1ECksd5NSlXwVDiXq8hQlLzcKKda91nB+pfaCbxy81niZoP6dlKPrekXPw==
X-Received: by 2002:a05:6512:b1c:b0:481:618f:ec9 with SMTP id w28-20020a0565120b1c00b00481618f0ec9mr11690964lfu.217.1656942973396;
        Mon, 04 Jul 2022 06:56:13 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id q17-20020ac246f1000000b00478ee191091sm5139288lfo.153.2022.07.04.06.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:56:12 -0700 (PDT)
Message-ID: <181a5cc7-c274-06c0-908b-874d48e24913@linaro.org>
Date:   Mon, 4 Jul 2022 15:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: ipq8074: add reset to SDHCI
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220704114430.625365-1-robimarko@gmail.com>
 <7cb6fd46-ac80-fbc5-67f7-920934bb801c@linaro.org>
 <CAOX2RU5UeeAh0hzYjANd5w+Y4NfxWN0uVtbjQLGOcTzT7ZRkQA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOX2RU5UeeAh0hzYjANd5w+Y4NfxWN0uVtbjQLGOcTzT7ZRkQA@mail.gmail.com>
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

On 04/07/2022 14:34, Robert Marko wrote:
> On Mon, 4 Jul 2022 at 14:29, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/07/2022 13:44, Robert Marko wrote:
>>> Add reset to SDHCI controller so it can be reset to avoid timeout issues
>>> after software reset due to bootloader set configuration.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>> index ddafc7de6c5f..d685ca1969a3 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
>>> @@ -482,6 +482,7 @@ sdhc_1: mmc@7824900 {
>>>                                <&gcc GCC_SDCC1_APPS_CLK>,
>>>                                <&xo>;
>>>                       clock-names = "iface", "core", "xo";
>>> +                     resets = <&gcc GCC_SDCC1_BCR>;
>>
>> I looked at the bindings and they do not allow reset property, so does
>> it depend on anything?
> 
> Hi Krzysztof,
> It seems like the driver changes [1] were merged at the same time as
> when bindings
> were being converted and nobody ever follow up with documenting the property.
> 
> I can document the property and send a v2 if that's OK?

Yes, please. Otherwise DTS change will fail checks so basically should
not be accepted.

Best regards,
Krzysztof
