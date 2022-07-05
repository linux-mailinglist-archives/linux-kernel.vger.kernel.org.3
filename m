Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6899A56621D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiGEEFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiGEEFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:05:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BB13CD6;
        Mon,  4 Jul 2022 21:05:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EB76C5C007A;
        Tue,  5 Jul 2022 00:05:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 05 Jul 2022 00:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656993933; x=
        1657080333; bh=qhjLmKoG8hTiptIGjmMn/wFrRLHB9qodKyUm0n1oZog=; b=S
        Pz2MI7ZjHtpd4TStxeQDoUcITpTFrMRN3QFNZrPFZLrGJYwCHnbqe6WsoqVXJ8/o
        +iIEf92Dkuk8TqOkvZ29UcYYn+QDyxXyHgLZMorkveEdAttq94asK8zboUQCsSNJ
        /uNBgl3MkZYckqDtMbXUMc8edQmGqjnhbyqZt8CVp8lJ47fX3fP+xavBGm4znTcY
        r3lPGYfcKgIRr92NK5pzfGIZIr/G9iTGcijyAb5hrPiV1SzvCfkwSWSg/MlXBVaI
        AxGLsbZLcog3tQ1thyqzJMZ+J1mQjcQ3yFrYUnJ/dPfdjT1ZPR9Pbv5kzSbTa9BU
        lFPFuvW2mGp809QkBIIcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656993933; x=
        1657080333; bh=qhjLmKoG8hTiptIGjmMn/wFrRLHB9qodKyUm0n1oZog=; b=u
        aszrMytuhV3J9vLkPVQExTkpZuD81j8LSEaxUjLuuHGcBgrodPNtH/qKgbPxERm/
        deaTB3QziIXKEgOzxDjZ4mRHYjbU5jlghE2hUyniRUPCwyuBtNyM4awqR4I/Llwa
        HCoLzqapI4GRQgqJ4DhNhF+l/Bt7KXvpXrhr1paMj3apP4fQzEndjCeZOAIFIDlj
        jDJ/grkaEz9f4BAKkGD+WNTQ8aEXZdKl4b0uIQbomt+1pLdXrkoNXT6Qatxx0noV
        4vX0yufnBrJz4nS9I4I0cpc3jg4aAoaywIVGPsC3/VTOrIXgAGUmoKQPgcr/UvF0
        vALLrcdQgW8/stYzdnMiw==
X-ME-Sender: <xms:jbjDYrwPbz8dgyOZmZxWNkBVw59a9WYPAZV6_0Pxn4z-mSxv-U4MZw>
    <xme:jbjDYjS3spsjJ6YwLi04DBsUFLKfR1jyO1FELCts98cKonh10DTS-AHcElFZGY-6j
    e9_ErMXBisaatVehg>
X-ME-Received: <xmr:jbjDYlURAc_qHbmIO0PIPJHYxjzEgIVbIb3iTpz4SEFesLLno9BG0I5EO-SiEUWBiAc2RNIzMNGVrp6Tta5DE9SVpB1N3P0UO1CcH4cgk8y5yzz6RsetwDmsgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvddvudelveeuleegveduiefggeegheffgefhjeduhfeigfei
    vedthfduleegueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:jbjDYlgrRg7KS4tfU7fmODDmytf0xygjI2xTjd8EPcy6_Es6KJe53w>
    <xmx:jbjDYtBINaBzB5wCWfUkNNk0C-aDmcTUw5EB4Cehg532BKFYpxTqqg>
    <xmx:jbjDYuJ8wRavw-nV016LMwHQ105dFXoVNaw2Tz5O83A0O5C-oPGfCw>
    <xmx:jbjDYhvSHO30_1RdLWwkRLmSaR61XcExcIVpR76ZFq92Q10HUNY_Ew>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 00:05:32 -0400 (EDT)
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
To:     Evgeny Boger <boger@wirenboard.com>,
        qianfan <qianfanguijin@163.com>
Cc:     andre.przywara@arm.com, devicetree@vger.kernel.org,
        jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, robh+dt@kernel.org, wens@csie.org
References: <264cb004-677a-13df-cc68-676ef3c2e7d8@163.com>
 <ec5f7fe8-d47d-ce7f-0e0a-2bdf41a88ba2@wirenboard.com>
 <0936de49-a349-8fd4-2598-2a8995b01c86@163.com>
 <21a659db-f64c-fbea-b3e7-ccc27aec29a0@wirenboard.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <d7059a5c-ba44-2d4d-b594-d7fa37fe0959@sholland.org>
Date:   Mon, 4 Jul 2022 23:05:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <21a659db-f64c-fbea-b3e7-ccc27aec29a0@wirenboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeny, Qianfan,

On 5/21/22 6:10 AM, Evgeny Boger wrote:
> my point is not that your patch is good enough.
> 
> My point is that it would be very difficult to maintain backward compatibility
> with this device tree once proper driver support is implemented.

Any solution to the problems below will have to maintain backward compatibility
with the current bindings anyway, for all of the other SoCs that are affected.
It is no more difficult to apply that same solution to R40. So I do not see a
benefit to delaying this series.

> On 5/21/22 07:26, qianfan wrote:
>>
>>
>> 在 2022/5/20 4:54, Evgeny Boger 写道:
>>> Hi qianfan,
>>>
>>> As Allwinner A40i user, let me first thank you for your effort for making
>>> better upstream support for R40!
>>>
>>> However, I would strongly suggest *not* to add USB support to one more
>>> Allwinner SoC in this particular way.
>>> The problem is, this approach consists of a number of carefully crafted hacks
>>> in device tree to make current drivers work on Allwinner hardware without
>>> modification to the drivers.
>>>
>>> a few examples:
>>>
>>> 1) please notice how ohci0 and ehci0 nodes do not contain reference to usb
>>> phy. It is done intentionally, otherwise EHCI will reset musb mode.
>>> Of course omitting phy reference here is also completely breaking power
>>> cycling in case of usb error and otherwise messes with a power management.
>>>
>>> 2) one must always enable ohci, ehci and usb_otg nodes at the same time. If
>>> one forgets to enable ohci/ehci nodes while enabling usb_otg node, the system
>>> will silently fail to work as USB host.
>>>
>>> 3) For host-only mode we still have to enable usb_otg node despite no role
>>> switching is needed. That's because phy reference is missing in ehci/ohci, so
>>> the ehci/ohci driver won't enable the PHY.
>>> Also I might be wrong, but I think phy won't be routed to ehci/ohci
>>> controllers is this case.
>>>
>>> 4) musb host controller is initialized and present to hardware though never
>>> actually used
>>>
>>> To summarize, not only the resulting device tree is not describing the
>>> hardware properly, it is creating device tree configuration which will be
>>> very hard to support in future, once proper driver support is in place.

All of these issues can be fixed either with no DT changes, or with only
backward-compatible changes like adding PHY references.

>> PHY setting is did in MUSB driver, so we need enable MUSB regardless of host
>> mode.
>>
>> I know your's point, OHCI/EHCI need do more works to init USBPHY, it shoule be
>> able to work
>> in dependently, but I don't have the ability to deal with these things right
>> now, I need
>> learn more things about OHCI/EHCI, that's a long-term goal.
>>
>> So now I need to make the whole usb work and do some tests as much as possible,
>> hoping to merge this patch into master. Some other optimizations can be made
>> later.

I am fine with merging this series, with the existing binding, and without
increasing the scope of the changes. It is still an improvement over the current
situation.

Regards,
Samuel

>> Thanks for yours guide.
>>>
>>>
>>> At Wiren Board kernel tree we tried to untangle this issue [1-6].
>>> Unfortunately I didn't have time to prepare it for kernel submission yet, but
>>> I think I better submit it as RFC to get a feedback from you and others.
>>>
>>>
>>> [1]
>>> https://github.com/wirenboard/linux/commit/359abbbd86ddff4d3c61179c882c286de32bb089
>>>
>>> [2]
>>> https://github.com/wirenboard/linux/commit/6327f9d7972c21b229fb83457fdde643b31553f9
>>>
>>> [3]
>>> https://github.com/wirenboard/linux/commit/f01f4c66758bde460a4d8c5b54ecee3b585c0232
>>>
>>> [4]
>>> https://github.com/wirenboard/linux/commit/c27598ad601e5a46f624b73412a531d6f1f63d37
>>>
>>> [5]
>>> https://github.com/wirenboard/linux/commit/5796d6eebb86b32a3751b2038b63af46f94954b3
>>>
>>> [6]
>>> https://github.com/wirenboard/linux/commit/0928a675d875f9c2849fd3a9888f718bbb673bda
>>>
>>>
>>>
>>
> 
> 

