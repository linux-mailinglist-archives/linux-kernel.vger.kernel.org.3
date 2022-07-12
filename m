Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E849B5716F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiGLKPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiGLKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:15:03 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25756AAB0F;
        Tue, 12 Jul 2022 03:15:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B67325C0223;
        Tue, 12 Jul 2022 06:14:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Jul 2022 06:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657620899; x=
        1657707299; bh=v0+CmKWP2loTCoFQCysnsurtV75oEd9q2EXIWMHg5G8=; b=o
        WEp3IO5JG0BJyeXFFtLCdU98eQKJ8c2mFFnkxAVVl5wnbzNZUYwSos4nIBajtUKw
        HyfKD/0yEdmn536AkVyAAiB569drM0c5GHk/pqN8AggbVehaLizP9mRwq99S1DB2
        SLgU3NW8kYvWf9TWSFnN4O0eAZAeySVq+IXZwxtBpgCbQ8mlaihhvwROiwx07tn3
        TV/whk9JkujdyM90LVP+OrL2AG8gRQXOeLxVSIxPLomjcin3mFvF0XWHTLfNXLu8
        X5wUxtUJExMYhkDyVJJngQwzdfiexguZReFJRUYFul2xwt2TCLGeGEsjogfHBJto
        /z8aQ5OfyywJeIu2dpzvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657620899; x=
        1657707299; bh=v0+CmKWP2loTCoFQCysnsurtV75oEd9q2EXIWMHg5G8=; b=a
        jE3Sw1L2U+FQzaAjg7GzxHpYJ69GRATwL0/nWdjVHlMdVZPWFoUbehNIioHuM5r9
        wB3Q7KzRuWVqRCItA3jS4iUQZbvpfB0YIUN6PgJQjVcTnKg2vP6/RldytpHlS0GQ
        rIt/YgITu7DTqA6Y9l1jIRuBxYlN6pNoRYv/m9Ts5lnvvKOXtaiBZX5Q5m0gRSl3
        uIJLi3ubR539EpNz/Txi7qO+lG7tLbdB8GgKzNC4VTCFXQjk9IvYwvAIjImBafDK
        EfQ0n+Rb9y1BGD96yqoP7eSBwCBaEVntgDOpod7IKenQg0NxoPhbl8h359+SveEt
        VUpA7Vfe8PRW1Fn96/Xtg==
X-ME-Sender: <xms:oknNYvuz4lsXsLEmy0KQIoSCiwdrJpRKQyBNOVDeU7ZrNvK2NeOLTQ>
    <xme:oknNYgdAlKrhMPCRlOVjBAThFjb7FsCJ5Xc1flP1ixejHef-Qwk4DNrwcMaSwfwZf
    7w32LVS6wsSstY_lQ>
X-ME-Received: <xmr:oknNYizleeJvReSYmDtL4qj73KfaS-FAQ-E8mHAuG1plPLJISsJvDnfuArxfY4t-QB7Lrwat83OAmmt8-JwJ4cbXB0AMmKd3ebW7AKKQuesorx2ETijB8E3XIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejhedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:oknNYuOHP6O5r1KRG-24Sr9ateMDvk6aeVG4kqg1THqLTrtwwn-m5g>
    <xmx:oknNYv-RqvFyYUbiCxD5iwlDiLquLYeuLXcJYMTzyuU6X6-u5xa7uQ>
    <xmx:oknNYuXfxV5hmusWWxOCkeOvJ9oaZr3ufcXj0kQd0Avov0hQ6bhkfg>
    <xmx:o0nNYuW1Vy4mq7_mZ1PaUMuYu3V2G3QBjeQ3a8-qT-0b1bc26ieFag>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 06:14:58 -0400 (EDT)
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add compatibles for Allwinner
 D1/D1s
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>
References: <20220626021148.56740-1-samuel@sholland.org>
 <20220626021148.56740-2-samuel@sholland.org>
 <CACRpkdY65q12sjDwH0UOOAa8GkBO--EDTsKrnEwn8NoTYTgtPQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <879fb3b2-4bcb-82d6-e186-e845d62c9843@sholland.org>
Date:   Tue, 12 Jul 2022 05:14:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdY65q12sjDwH0UOOAa8GkBO--EDTsKrnEwn8NoTYTgtPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 7/11/22 3:58 AM, Linus Walleij wrote:
> On Sun, Jun 26, 2022 at 4:11 AM Samuel Holland <samuel@sholland.org> wrote:
> 
>> D1 contains a pin controller similar to previous SoCs, but with some
>> register layout changes. It includes 6 interrupt-capable pin banks.
>>
>> D1s is a low pin count version of the D1 SoC, with some pins omitted.
>> The remaining pins have the same function assignments as D1.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> All 6 patches applied to the pinctrl tree, the last patch 6/6
> required some fuzzing so please check the result!

Somehow the version of patch 6 applied to the pinctrl tree did not include the
new driver source file. It only applied changes to existing files (including the
Makefile reference to the new file).

I also needed to make some minor changes to patch 6 to resolve comments from Andre.

Is it okay if I send a v2 of just patch 6? Or do I need to send a follow-up
based on what was already applied?

Regards,
Samuel
