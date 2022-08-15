Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44757592979
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbiHOGR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbiHOGRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:17:16 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440D193F9;
        Sun, 14 Aug 2022 23:17:14 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 15 Aug
 2022 14:17:11 +0800
Message-ID: <edc9b0bd-6c69-0562-05ca-db0496897cf1@amlogic.com>
Date:   Mon, 15 Aug 2022 14:17:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 2/6] arm64: dts: meson: add S4 Soc PLL clock controller
 in DT
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-3-yu.tu@amlogic.com>
 <19654574-bdc0-9fa5-6465-fc88b20e20c5@linaro.org>
 <c223a85a-b76e-0e82-9a8c-6b60588dc03a@amlogic.com>
 <1jmtccz0f4.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jmtccz0f4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome，

On 2022/8/10 21:32, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Fri 05 Aug 2022 at 17:39, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Hi Krzysztof,
>>      Thank you for your reply.
>>
>> On 2022/8/5 17:16, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>> On 05/08/2022 10:57, Yu Tu wrote:
>>>> Added information about the S4 SOC PLL Clock controller in DT.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> index ff213618a598..a816b1f7694b 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> @@ -92,6 +92,14 @@ apb4: apb4@fe000000 {
>>>>    			#size-cells = <2>;
>>>>    			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>>>    +			clkc_pll: pll-clock-controller@8000 {
>>> Node names should be generic - clock-controller.
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>>
>> I will change to clkc_pll: clock-controller@8000, in next version.
> 
> Same comment applies to the binding doc.
OKay.
> 
> Also it would be nice to split this in two series.
> Bindings and drivers in one, arm64 dt in the other. These changes goes
> in through different trees.
At present, Bindings, DTS and drivers are three series. Do you mean to 
put Bindings and drivers together? If so, checkpatch.pl will report a 
warning.

> 
>>> Best regards,
>>> Krzysztof
>>> .
> 
> .
