Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6E58C602
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiHHKC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiHHKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:02:23 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446A247;
        Mon,  8 Aug 2022 03:02:21 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 8 Aug 2022
 18:02:18 +0800
Message-ID: <39736082-b9a1-4916-c0c3-c633c93c8741@amlogic.com>
Date:   Mon, 8 Aug 2022 18:02:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 5/6] arm64: dts: meson: add S4 Soc Peripheral clock
 controller in DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-6-yu.tu@amlogic.com>
 <60f30470-ca14-1e12-3ed2-7b34c7a93f8a@linaro.org>
 <759c681e-ec03-4230-b34e-0b2ee67ac870@amlogic.com>
 <fe04e8ab-f8de-2c03-17e8-8960e5b460af@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <fe04e8ab-f8de-2c03-17e8-8960e5b460af@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/8 14:17, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 05/08/2022 11:36, Yu Tu wrote:
>>>> @@ -100,6 +102,30 @@ clkc_pll: pll-clock-controller@8000 {
>>>>    				#clock-cells = <1>;
>>>>    			};
>>>>    
>>>> +			clkc_periphs: periphs-clock-controller {
>>>
>>> Node names should be generic, so "clock-controller"
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>>
>>> You miss here unit address. Test your DTS with dtbs check and with
>>> regular compile with W=1.
>> I will change to clkc_periphs: clock-controller@0 {.
>> Is that okay?
> 
> I cut the context, so if "0" was the value in reg, then it is OK.
Ok, I got it.I will change in next version.
> Best regards,
> Krzysztof
> 
> .
