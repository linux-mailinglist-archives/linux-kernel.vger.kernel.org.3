Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD165AC225
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 05:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiIDDYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 23:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDDYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 23:24:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E2E020;
        Sat,  3 Sep 2022 20:24:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 003895C00B3;
        Sat,  3 Sep 2022 23:24:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 03 Sep 2022 23:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662261880; x=
        1662348280; bh=0XXu/7DvRXDjmgtdk2so2BnsRSmyqUu6JOo0IYyP3A0=; b=x
        uCAiKHP6q6NKkjf6wYDENnaVnPJQhuiCqIjpGEYBY5HTUgHCFZkwmIk8dKwdhtGA
        OM4ibytOqLASxjKlYVu11EbyRe+v7h3TMUzgqA36gMFGsPLPASncx7j1NY4ndu+A
        B2qlflsNUZE5oMcgjW3DvloYAkka8xYa+iD8Z+tBYOFpGP2dzD05pk/caCdfKqwj
        B0SwuOFxUCYP6ES64Kt994ibldA82n5qE7MP+ESoLqt8Pqsckcy7ySgy8LAlSTud
        RZMl790hanLPJdVl5jI2K7qguEPmyjQxmq3WBttavsqet1qtRcmXxlzGTiwVZcNy
        lGiaUDxRaTwWOSvoknyaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662261880; x=
        1662348280; bh=0XXu/7DvRXDjmgtdk2so2BnsRSmyqUu6JOo0IYyP3A0=; b=B
        Vl0MxPGF0gpLofnYY0JShxJKIuMVf/s0o/152ScCPuDzR7LRTGoMUnm7MJticb8t
        Z9/U1s0oKNPuBKc/CemlngEIRvC9mCa7EtblEavItvW514mdu51ZzFhfhCdxEBRy
        QmpyVfZIQpsUza/cc18bJ/GAD+7VdCrjXdu45+BDoiAz5YT+qY/I+SJmJantJpl4
        JKV7Vq0g8zHQjYYFEzKRcoesz5BHzVLBlhm5ECLJHfysUDWx/yac4SiyVAGhpK3k
        sW2CpyTQrWiwTtmcKVLZddJX1AkgU6wpOgoK5iTw+JdRrIdyZrtfjEbTW3ACysgD
        GQiyezu80+q5oO/kVQmuA==
X-ME-Sender: <xms:eBoUY4he11Ld-BQDoQ7l7B6C1vzFi0r30vsSrJ1pPHYGCYif0jR2Dg>
    <xme:eBoUYxCM9yE483ixyQNyeT6w0YCyJi_nF94hXBjpjmosqyNzAgGUcb2op2ZY2M0Ec
    e-b-LHnI4_a59MVOg>
X-ME-Received: <xmr:eBoUYwFbXdTAuFU68_gvFlB9PIQHZ8Sh-JlRf5W30xTR_7H2eZv7JlK0SQy50r2Qi9EhmGxU5cXVWQCopjdSonPLDeOEGeHJL9YECV5Aun_EyhN-ZbVqeNtbrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvddvudelveeuleegveduiefggeegheffgefhjeduhfeigfei
    vedthfduleegueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:eBoUY5QRUlMOfIQFOq0D8VDSJZMdboKohX-bf_oVmNeQN29p_2O87Q>
    <xmx:eBoUY1w4cP59bwd7Lc5YvUzbgdz2XqrtdJpa4-Vf2q9F1_ETP5bOwQ>
    <xmx:eBoUY35DIWZixjQXi9QYT9rvMME0dGlizYMicdG3KRfzBYFdMgRXDA>
    <xmx:eBoUY0w6nPh945XJOAnymstvCukZfy8WocK4O5-vpjMK57AY_Ntg4g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 23:24:39 -0400 (EDT)
Subject: Re: [PATCH v2 2/4] arm64: dts: allwinner: h6: Add cooling map for GPU
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220821173051.155038-1-peron.clem@gmail.com>
 <20220821173051.155038-3-peron.clem@gmail.com>
 <72f901e6-f646-336b-70e6-2747363944ab@sholland.org>
 <CAJiuCcfF=1Ob1oGABtHhM88m0LST727h88fXqCKYBiWRsYmtnA@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <a45abb3d-b765-c87b-df2c-85a03b5634cd@sholland.org>
Date:   Sat, 3 Sep 2022 22:24:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcfF=1Ob1oGABtHhM88m0LST727h88fXqCKYBiWRsYmtnA@mail.gmail.com>
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

On 8/27/22 11:49 AM, Clément Péron wrote:
> Hi Samuel,
> 
> On Tue, 23 Aug 2022 at 05:16, Samuel Holland <samuel@sholland.org> wrote:
>>
>> On 8/21/22 12:30 PM, Clément Péron wrote:
>>> Add a simple cooling map for the GPU.
>>
>> It would be good to document where the trip point temperatures came from.
> 
> If I remember correctly, I got those when getting the dtb from my
> Beelink GS1 when it was running vendor Android with the oldest
> Allwinner kernel.
> 
> But now that you ask I double check with the "new" vendor kernel source:
> https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L2034-L2053
> 
> And It's different from what I got in the past.
> The throttling starts when the GPU is already very hot (95, 100 and
> 105°C) and seems to only disable the highest frequency (756, 624 and
> 576MHz).
> Which let the GPU running at 0.91V @ 540MHz.
> 
> Which is far to be the lowest possible consumption for the GPU (0.81V
> @ 336MHz would be better in the hottest situation)
> 
> I'm not an expert but either I could just try to copy/paste the same
> behavior or try to have a more smooth cooling map (70, 85, 100°C).
> 
> What do you think?

I would generally prefer something conservative, to be appropriate for most
boards. But I do not have any strong opinion on the exact trip points used; I am
fine with adjusting them.

Mostly I want to know the source of the cooling map -- where the numbers came
from, and what changes were made. That provides context if we want to change the
map in the future, or if we run in to issues on some other board.

Regards,
Samuel
