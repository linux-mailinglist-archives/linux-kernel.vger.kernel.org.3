Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7BF506919
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350811AbiDSKvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350826AbiDSKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:51:45 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58DD82A251;
        Tue, 19 Apr 2022 03:49:03 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 8BA9F1C8111A;
        Tue, 19 Apr 2022 18:49:02 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 19 Apr
 2022 18:49:02 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 19 Apr
 2022 18:49:02 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 19 Apr 2022 18:49:01 +0800
Message-ID: <c59686fe-a9dd-9835-2ccb-e574ea01d7a2@nuvoton.com>
Date:   Tue, 19 Apr 2022 18:49:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: Document MA35D1 clock
 controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <will@kernel.org>,
        <soc@kernel.org>, <cfli0@nuvoton.com>
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-3-ychuang3@nuvoton.com>
 <2f8d2f6a-32dc-15cc-321c-f75721edf8a2@linaro.org>
 <29b00c24-681a-7f6f-f27d-b7525c5b8485@nuvoton.com>
 <b2e32685-73a6-98be-50be-5121c67431ed@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <b2e32685-73a6-98be-50be-5121c67431ed@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/19 下午 06:39, Krzysztof Kozlowski wrote:
> On 19/04/2022 12:12, Jacky Huang wrote:
>>>> +
>>>> +  assigned-clock-rates:
>>>> +    minItems: 5
>>>> +    maxItems: 5
>>>> +
>>>> +  nuvoton,clk-pll-mode:
>>>> +    A list of PLL operation mode corresponding to DDRPLL, APLL, EPLL,
>>>> +    and VPLL in sequential.
>>> This does not look like a binding which was tested. Read
>>> "writing-schema" and test your bindings.
>> "nuvoton,clk-pll-mode" is a nonstandard property used to describe the
>> operation mode of
>> corresponding PLLs.
>>
>> (According to Device tree Specification section "2.2.4 Properties"
>> Nonstandard property names should specify a unique string prefix, such
>> as a stock ticker symbol, identifying the name of
>> the company or organization that defined the property. Examples:
> I am not saying about property name. I replied under some description
> below which fails to build.
>
> Instead please test your bindings.
>
> Best regards,
> Krzysztof

OK, I got it. I found the error by dt_binding_check.
I will fix them in the next version.

Thank you very much.

Jacky Huang



