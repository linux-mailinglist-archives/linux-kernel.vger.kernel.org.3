Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA4589D31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbiHDOCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiHDOCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:02:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D022510;
        Thu,  4 Aug 2022 07:02:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3A5DB320084E;
        Thu,  4 Aug 2022 10:02:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Aug 2022 10:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1659621728; x=
        1659708128; bh=1eA4iGFdB1hSPhLdnXy+RIRq8L8CPiMUngiNCofOlf8=; b=e
        PhSfoyw6gHLVk7s8WM8IZDKmpUQjAzaNGawz3qdd8BFdQ6i0atrrsKoDNQrAMRt6
        iCCry5YCWJMfdbEbLzQV8kXcDr/lc8j3lcTQFiiTNQ1jGObu8vEGzkdQ38WmWUFY
        nwI2hVfVIdoShi1wGO8qmAmFBJmw0QBF0JaK4PUyDoofaBIHfZjc95x9gcd6ZaGf
        L0ZpG/QG788Ebq2L2ZZ/9bY/rEnQjAn67gIgmJU1flKYbL5uaQZdn23qtn0kiLPD
        Ef1xLZ7ePri+DfO+7A+PlbK1t4+YyDuxTb95AZll0vGHixwflVNXRX+v54+8D1zZ
        AZPRjHeFuCARLREjf8loA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659621728; x=
        1659708128; bh=1eA4iGFdB1hSPhLdnXy+RIRq8L8CPiMUngiNCofOlf8=; b=j
        Tr7QZcywzvL4mE21n0o2/hwDBh5RlzBVksUYdfwtNyVwn0EgMiK+CVlzXdc6FWzL
        EevCi131Rl/8qNR/oSYLUmHnprX9Ml+Vg8pMdQHyqmJ1x75pmR8LKzdEhYNYGwDm
        LYelmlmq3YiJFHRkKRm0viHdlCHrAy42V8AGt7j7T1jCARQ5BAJokwTVCPRlJ2CT
        NnZubfFZJin9XW+i7TbfRXFuveKFnM+N6FirXhdhDQX2ThOVMr/ATApPSLyAtbT+
        Qhc7fe50+AmB/tEN8A5ZMGBbtI0CoarT8pbOMqR6219YLwGPYVTEDDIqYURObfWq
        7ReVe1yBNrhAYF71C5+Iw==
X-ME-Sender: <xms:X9HrYjMuMsegJHJIa-Tpg76t4cVkbPMFbNnwXG7A5whPTccX_lwwKw>
    <xme:X9HrYt-Z2f7hFDpfNSYh0r90MhsLudvojK_c9syBVduyczPNG1LB5HkdWYd2gaPmO
    LwST8BLJ-4l2JiZgA>
X-ME-Received: <xmr:X9HrYiQ22TWTwzeELA4EJOGSNuvsjFbG2iJesG3iAXNoAjaFmyegeT2M6y_6LyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvledgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjfhfkgggtgfesthhqmhdttddtjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfekhfegffeigeegkedtudduueffkedufeffgffhleffgeelhedu
    veegfefftdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:X9HrYnvRM3oL-9qEnBTOaiCuRbiVk_N8oiZdzXLf-Dnz-j-JQEdQCg>
    <xmx:X9HrYrd37JkE-p3vorHhpXRC9wI6k-9etasuyJyKuLrb9qpNLTxA6A>
    <xmx:X9HrYj3_14zvUQIRf_KQzCimWyPNG_w2VCZuAx0C3a00n7qtp2pktw>
    <xmx:YNHrYv5GnJcsICndGOBcJDT2gpfWEHCTx2W8PhwmKbPLPoMCzkyKGw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Aug 2022 10:02:03 -0400 (EDT)
Date:   Thu, 04 Aug 2022 14:01:58 +0000
From:   Samuel Holland <samuel@sholland.org>
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: Add Allwinner D1 LDOs
In-Reply-To: <5588658.DvuYhMxLoT@jernej-laptop>
References: <20220802053213.3645-1-samuel@sholland.org> <20220802150452.GA86158-robh@kernel.org> <918a83a7-1b8d-04b1-4f7b-386fc800e653@sholland.org> <5588658.DvuYhMxLoT@jernej-laptop>
Message-ID: <3FDF728B-787D-481F-A807-A05DADA02198@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=samuel@sholland.org; prefer-encrypt=mutual;
 keydata= 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
 jQQElQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 4, 2022 5:11:39 AM UTC, "Jernej =C5=A0krabec" <jernej=2Eskrabec@g=
mail=2Ecom> wrote:
>> > 'simple-mfd' also means the child nodes have zero dependence on the
>> > parent node and its resources=2E
>>=20
>> That is correct=2E The regulators have zero dependencies on the audio c=
odec
>> resources (clocks/resets/etc=2E)=2E The _only_ relationship is the over=
lapping
>> address of the MMIO register=2E
>
>LDO registers are at the end of analogue codec MMIO space, right? We can=
=20
>easily split that to separate device, like it's been done for A20 timer &=
=20
>watchdog=2E

No, there are some audio-related registers after the LDO register ("POWER_=
REG" in the D1 and V853 manuals)=2E
So it is not possible to cleanly split the MMIO region=2E

Regards,
Samuel
