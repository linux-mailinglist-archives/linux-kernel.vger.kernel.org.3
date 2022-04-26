Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58F850F169
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbiDZGsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbiDZGsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:48:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2510C2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:45:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dk23so10702393ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GCTUtskM/bUVNqoWwWzS0KAkms8zQjbR5nbiEfiWJ2M=;
        b=e6RCe4wt2jOhwCC7a30bZb0cYOCLxSqN0BwDORx1w117AoEHJxKvsRC99Pg9ZOkSxN
         BYbbcR9OpWXx0qHFBw4u6t/Jai9I4KQgMGO74PZpZUIe+pcLnQRE3/z+fXM+l45QoCP1
         cND1PJHq/47XhA1jrQEcymkMpd1c9HI0BfziHrW+NJ9q8zeIc4WPN8lJ2GSkgUJkeCh/
         a/HDA1Wa6ClvNJZEpmjELV8RxnZwsvTQdskkBSa3Cy19YKp2Yiz8FKwsm7ZCoOmLySed
         pImbO3a9qULVn6fsGyZNYDyhDvNq6ZfZRQeYoNk041ko9+gI2a3JWuPcgNjAs3Ta8jOI
         K8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GCTUtskM/bUVNqoWwWzS0KAkms8zQjbR5nbiEfiWJ2M=;
        b=TVDzG6nIzsyc06imBYzjaEnZLks7bfSoeDIKk0JS8lOr+IM+wvS8wPd5MJUmkg1Ffw
         Q7ncZT7g4FEcV3iOmz5tv/csLGRvVXir1E70y1173Q50cfiN/dNIBkuoniwt5c5YB3Px
         ypHMu3aN2DZPUyeu//o5xkDwE9zaPe3Z/ULi1w9FoYIDeUC1F2LqDpKg9zj8VPyM8WT/
         WgyToZKrOAwLjPW5v7nkEsFSJgdJxgkqgvOIWUwMIcy5YlvbT/EF/b5L5gl9XDcHTZc1
         mPGDeRnrAIJFRa+fu01BMcDR0TkXP8rht4VFfmRmwpAOkvqMvu38ghs/NSPlL2QN/6Sp
         FIgA==
X-Gm-Message-State: AOAM531JLA/OYrzhnti/T5sE3DrQlrjaUuPkNY4iX4xO4eE2GwEoC8+I
        YgiMK0RMaLUjMOD460gF2IuZl/bHg4EqRw==
X-Google-Smtp-Source: ABdhPJyKy2sT/kR3eWE34jx+Och5uYkRNfzgYx/gjSb2QtBiuG3W+E9beq63JAbRXNzJ/noyrm3sQw==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr12393047ejc.568.1650955506949;
        Mon, 25 Apr 2022 23:45:06 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090622c600b006f3876cd90csm2564511eja.198.2022.04.25.23.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 23:45:06 -0700 (PDT)
Message-ID: <3dcec64c-3e34-9bef-f71e-754135278968@linaro.org>
Date:   Tue, 26 Apr 2022 08:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: stm32: Add compatible strings
 for Protonic T1L boards
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220425132844.866743-1-o.rempel@pengutronix.de>
 <20220425132844.866743-2-o.rempel@pengutronix.de>
 <35648611-cfa9-1df4-7130-7cd1bcf1a69e@linaro.org>
 <5c6ce97d-e31a-6cf9-6da6-8d27f19a53cc@linaro.org>
 <20220426063517.GB3419@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426063517.GB3419@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 08:35, Oleksij Rempel wrote:
> On Mon, Apr 25, 2022 at 04:06:45PM +0200, Krzysztof Kozlowski wrote:
>> On 25/04/2022 15:53, Krzysztof Kozlowski wrote:
>>> On 25/04/2022 15:28, Oleksij Rempel wrote:
>>>> This boards are based on STM32MP151AAD3 and use 10BaseT1L for
>>>> communication.
>>>>
>>>> - PRTT1C - 10BaseT1L switch
>>>> - PRTT1S - 10BaseT1L CO2 sensor board
>>>> - PRTT1A - 10BaseT1L multi functional controller
>>>>
>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>> ---
>>>
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Although the order is still messed up. I through you will move the entry
>> just slightly up, not to the beginning, so maybe just rebase on top of:
>> https://lore.kernel.org/all/20220425140436.332467-1-krzysztof.kozlowski@linaro.org/
> 
> I put it according to the SoC version. st,stm32mp151 would be the first
> entry before stm32mp153. What order do you prefer, where should I put my
> boards?

153 is defined lower. The first entry in the file is a trap. :)


Best regards,
Krzysztof
