Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5374BF6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiBVLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:04:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7F2CA9E3F;
        Tue, 22 Feb 2022 03:03:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C79139F;
        Tue, 22 Feb 2022 03:03:56 -0800 (PST)
Received: from [10.57.9.152] (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8CBC3F70D;
        Tue, 22 Feb 2022 03:03:53 -0800 (PST)
Message-ID: <e979397d-c522-e0da-b997-16609fe308c5@arm.com>
Date:   Tue, 22 Feb 2022 11:03:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220221225131.15836-1-lukasz.luba@arm.com>
 <20220221225131.15836-2-lukasz.luba@arm.com>
 <20220222030337.ijnfrh367illmidr@vireshk-i7>
 <147e48e5-e310-cd8f-ba8c-ff32e3094be3@arm.com>
 <20220222094547.tgj4bciq6rez62nk@vireshk-i7>
 <c83ae91b-6901-de2b-913e-b28af73c52fa@arm.com>
 <20220222101242.chwcxan2nyhczqth@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220222101242.chwcxan2nyhczqth@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 10:12, Viresh Kumar wrote:
> On 22-02-22, 10:03, Lukasz Luba wrote:
>>
>>
>> On 2/22/22 09:45, Viresh Kumar wrote:
>>> On 22-02-22, 08:06, Lukasz Luba wrote:
>>>> I'm not sure if that would be flexible enough to meet the requirement:
>>>> power for each OPP might be different in one board vs. other board.
>>>
>>> Don't DT files overload values from board files all the time ? Why wouldn't the
>>> same apply for OPP table as well ?
>>
>> In that SoC and family of the boards, there are no such examples.
> 
> Here is one I think.
> 
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
> 
>> It used to be popular in arm32 boards, but I'm not sure nowadays.
> 
> I think it is still common, not with OPPs though.
> 
>>>> AFAIK the OPP definition is more SoC specific.
>>>
>>> This isn't about OPP definition as well, but just that if DT allows you to
>>> override or not. I think it will.
>>>
>>
>> Redefining the whole OPP table, when the freq, voltage, interconnect,
>> and other old entries don't change isn't too messy?
> 
> I think you misunderstood what I said. The common part of the OPP table should
> stay in the central .dtsi file. The dts files though, should just add the power
> specific values to the existing OPP table.
> 

OK, I misunderstood that. If that is possible than it would
be great. I'm assuming you are taking about OPP v2. I can relax the
requirement that I need to provide this DT-EM for arm32, since they
have a legacy OPP v1.

So we might have an entry similar that interconnect for the
bandwidth, but for us it would be 'opp-power-uw'?

Let me have a look about some examples how that could be just
added/extended in the opp table but from board file.
If you have some handy link, I would be grateful.

