Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3536B4BF72C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiBVLXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiBVLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:23:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8524812E15E;
        Tue, 22 Feb 2022 03:23:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E953106F;
        Tue, 22 Feb 2022 03:23:07 -0800 (PST)
Received: from [10.57.9.152] (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54DAA3F70D;
        Tue, 22 Feb 2022 03:23:05 -0800 (PST)
Message-ID: <8e594ef8-1a50-4b74-9bd7-f848593588a7@arm.com>
Date:   Tue, 22 Feb 2022 11:23:03 +0000
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
 <e979397d-c522-e0da-b997-16609fe308c5@arm.com>
 <20220222111519.rd5m4fxd7rvkuqqf@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220222111519.rd5m4fxd7rvkuqqf@vireshk-i7>
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



On 2/22/22 11:15, Viresh Kumar wrote:
> On 22-02-22, 11:03, Lukasz Luba wrote:
>> OK, I misunderstood that. If that is possible than it would
>> be great. I'm assuming you are taking about OPP v2.
> 
> Yes.
> 
>> I can relax the
>> requirement that I need to provide this DT-EM for arm32, since they
>> have a legacy OPP v1.
> 
> OPP V2 or V1 doesn't have anything to do with arm32/64. Anyone can implement the
> newer V2 version (basically whoever wants something more than a simple freq/volt
> pair). So arm32 SoC's that want to use the DT-EM thing, should migrate to
> opp-v2, we can't support that with opp-v1.
> 
>> So we might have an entry similar that interconnect for the
>> bandwidth, but for us it would be 'opp-power-uw'?
> 
> I will rather say similar to opp-microvolt or opp-microamp, so it better be
> opp-microwatt.
> 
>> Let me have a look about some examples how that could be just
>> added/extended in the opp table but from board file.
>> If you have some handy link, I would be grateful.
> 
> The file I provided earlier:
> 
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
> 
> This is updating opp-microvolt property of a single OPP node in the whole table.
> Pretty much like this only.
> 

Thanks, I'll use that example for the v2
