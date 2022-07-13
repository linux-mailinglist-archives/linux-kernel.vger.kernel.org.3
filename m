Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56EC572B97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGMC4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGMC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:56:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EDD65E8;
        Tue, 12 Jul 2022 19:56:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B882F5C00E1;
        Tue, 12 Jul 2022 22:56:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 12 Jul 2022 22:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657680996; x=
        1657767396; bh=K/cj+gRS3RhE670rnCrMr2lhCalMsbp97ysqO+RlgnI=; b=E
        7Sn8IFON6Zrl4Ob6F1aytfkRmGHTKz957uZaOClRwJ57glVCfyKG55qYn0JUOwLD
        Gqf5AF8QUVJNF4HKVmwFIxzASlL0WHFn8LM8P7oqTYRDYO6zVeEQOCO1P16N2+KX
        7dWLhzzDKJZ/JsCvZBA1SxLiajj0QvYQOCLsC4vcZ2ls6cNokHEq67VSTG06xWNm
        xGpCWHtWTIxsj+cNiYE77XH5siNZwXd2N24aPldGtPGeVPm75W3twZMe3Bet1Zru
        Yzx0n9owsovqB4E33A7ldDpYEOOosle3ZP6+djLeA7nIfFS05y574hL94K4bo5VL
        NwtxwXEvaiwbiHg2oV+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657680996; x=
        1657767396; bh=K/cj+gRS3RhE670rnCrMr2lhCalMsbp97ysqO+RlgnI=; b=S
        fjMWjpxcw/u7t+a5sUBFj93BsL+Noa5Y04fImJT49vl8+h6zpuPd2Nakp0Qhsuv1
        dFxcuZMUXGptJBr7r6siDElNuzg6ZxGqMPsKQFfAcTDP6A3nNb24CwKLJzg1My9B
        lX+3pD0mbo8z0KGOYm1Sx01L9qvAzK0er2g68ols89dEknIfqp2+t9z9vtQqGcfP
        0wFmyoH+lCpHqtqxgnnjt2FopGW6q1uHaN+zbWNUfa+KyBz/SU9IuZ/gUdhVtkCG
        qGhvGX07afP7Gj/ugrgrQHpYtJisQh8RbQWelJm6DF/A6KUetrPIia7rJbxqEEGD
        +NImoIohgdDF2qlJncIHw==
X-ME-Sender: <xms:ZDTOYkKG1xM3VRQTo_3c5qBJVUGiVFWOWqGUNCms86Pj_kQePlq9cg>
    <xme:ZDTOYkKSMV451J2o9ivexatzTvHZsu7Kcki7s_9Fh7NLL0ZrCmT0WdbFoCkshMHui
    Ae-bSp0AJPzG4kkuA>
X-ME-Received: <xmr:ZDTOYkvquqz0Qz4reIALRH8asmOzLF1RmKvR4tY_-Ad0eTHqmGcRAcVzahccwIj38wSDGRg99x1g2SPAR2s5q_a0pIn9dRIIcjxW3ShnYMpuwD_lgPJ-ziGwJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffhvfevfhfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfdtffeiheduuefggeehkefhlefghedvheekheduueffudel
    vedvtdelveevieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:ZDTOYhaQHMaH_41kEYG7Ic8GfrPpLH5ybJXrv5bsRYkFZLBP-2jx-g>
    <xmx:ZDTOYrbhKChr2TYwYXjG5sy5sJSojTouB17B9YYRIoAUgxsF0zPsyg>
    <xmx:ZDTOYtA64DxTtoPaV_nvrkAB4pN4lWDp3pVfLMbBGjJPlPM1ZO2OAA>
    <xmx:ZDTOYpChOhounWK14SmvvDFlWrSTVwivI4VvRLxqNGcPXbDSZnAB8Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 22:56:35 -0400 (EDT)
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add compatibles for Allwinner
 D1/D1s
From:   Samuel Holland <samuel@sholland.org>
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
 <879fb3b2-4bcb-82d6-e186-e845d62c9843@sholland.org>
Message-ID: <3418c509-c54a-484a-cb2e-c4705bc829a6@sholland.org>
Date:   Tue, 12 Jul 2022 21:56:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <879fb3b2-4bcb-82d6-e186-e845d62c9843@sholland.org>
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

On 7/12/22 5:14 AM, Samuel Holland wrote:
> Hi Linus,
> 
> On 7/11/22 3:58 AM, Linus Walleij wrote:
>> On Sun, Jun 26, 2022 at 4:11 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>>> D1 contains a pin controller similar to previous SoCs, but with some
>>> register layout changes. It includes 6 interrupt-capable pin banks.
>>>
>>> D1s is a low pin count version of the D1 SoC, with some pins omitted.
>>> The remaining pins have the same function assignments as D1.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>
>> All 6 patches applied to the pinctrl tree, the last patch 6/6
>> required some fuzzing so please check the result!

I do not see anything in patch 6 that would have required a 3-way merge, so I
don't understand what the issue was here.

> Somehow the version of patch 6 applied to the pinctrl tree did not include the
> new driver source file. It only applied changes to existing files (including the
> Makefile reference to the new file).
> 
> I also needed to make some minor changes to patch 6 to resolve comments from Andre.
> 
> Is it okay if I send a v2 of just patch 6? Or do I need to send a follow-up
> based on what was already applied?

I sent a v2 of the whole series:

https://lore.kernel.org/linux-gpio/20220713025233.27248-1-samuel@sholland.org/

Please let me know if you want something different.

Regards,
Samuel
