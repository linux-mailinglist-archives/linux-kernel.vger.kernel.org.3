Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFC569A94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiGGGgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiGGGgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:36:33 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422427163;
        Wed,  6 Jul 2022 23:36:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 671DA5C009F;
        Thu,  7 Jul 2022 02:36:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Jul 2022 02:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657175792; x=
        1657262192; bh=omzO4IBIszkvfzOM5YHSGqttWGEM0+zARu1BSItsPIQ=; b=a
        nKQm3EVZ4f0mLKPcpaelfdrMwoZzCNFaZwGO1gnIxnS0+iVa7do3vB2U23odhNMv
        4Sba5Zl71wh86+knjDh5bCXF+s58V2+FBHCQ3g9agKOi5mmia/ts7TPcYgM/JalA
        V7Xenw/HnS1eXq5YYfqGy5V5pqFjS5phg1PgyqwW0QZkslpxxjeaS28mtZDd81PI
        78a7irUh+z9jWArJLOqBPm4kAiWsdUwwFpewoWntUXzq+lPvRZvV89vowBIWLcsQ
        kNTv1xK5EEKX6oRv0t7r+zmT/5+0uBLmIbQVsrFLbcnaxx+Pe0r9bqW6q74ke3fB
        TFX3cuR9GVvETz4Hd29oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657175792; x=
        1657262192; bh=omzO4IBIszkvfzOM5YHSGqttWGEM0+zARu1BSItsPIQ=; b=O
        JyMSBE0+YaUWcrWbqc1SiV47Caf6WrlRnh+HME/mwpo/EX0oTp+3hLpk0qVu5cJj
        tQvTtPVBHe9kKGcKcU2fbhO/KkYXr5bnu9c37c6ANzzhFZNnGtPdOtkcoG4Rmn1F
        Vh8WiYNs2SL7cryd4Bf64+K6HAKDni1EL6pJcFnul90sqoWIuVyMIM8A62ksmrbl
        hh3IT9R9U8Tye8WnQ4HWQ/nlu3GrjjLHhAsLiWDwlBh/FQPqp5ZJoeDK8uFrKp4L
        Q/+GDyUwJtpN7o6Mooey/L5GpY1AIHyvkVkYhNZwpHnvbj6e9REHw/nufjl9kHKp
        KYjQDijTASLcksMZGAzMw==
X-ME-Sender: <xms:8H7GYmIcBeMZgyDPBKBFp73EM2e-KEv-K3Bw6J_RuftibSHqbfS-Qw>
    <xme:8H7GYuI9-65ClbkTJyhwxVGLfMHcuQtPwOKftLKSyf-8UIxkGxWTAvRlcAu_zDugU
    eLkyfRBhpA1KvOcrQ>
X-ME-Received: <xmr:8H7GYmu9Sjq_Q9Hm1IxQTrnFaowsvcrMw_zADlgn9rFeUvmEXxK2oq-vZJ1__s74K-AlN08El5dX-6aNnOjGpFgBITRc2K6RORGYQ9BKtZTWxL-lljyhdcvPTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepleetjeffvdegheektdekveeuueetffetffehudefueejvddu
    feduteeiieejveelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8H7GYrY0iKUyc-iXv6An3L50sUiW96oUjfxtBJ8ZWUle0vjmIne8iQ>
    <xmx:8H7GYta5ZYIvbK_DC2UzgK1jEp63NfQjHBg887ZoO3dE4hA0doQ64g>
    <xmx:8H7GYnAAdVDomucA9JoPZXrWkRDrZhyXa_GiZaZ7_ZBdTx9U6Yp8Ug>
    <xmx:8H7GYrPWn47SG2h-NxueDRNXphquKL6mM3FzwG8h2SB6nVBDSNWxog>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Jul 2022 02:36:31 -0400 (EDT)
Subject: Re: [PATCH v12 3/7] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-4-andre.przywara@arm.com>
 <2056c471-39d7-6d8e-c4b2-5a83f13d831a@sholland.org>
 <20220705114250.5136ede4@donnerap.cambridge.arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <506f5ba8-434e-d740-0d14-fa0e129ac0e0@sholland.org>
Date:   Thu, 7 Jul 2022 01:36:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220705114250.5136ede4@donnerap.cambridge.arm.com>
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

Hi Andre,

On 7/5/22 5:42 AM, Andre Przywara wrote:
> On Mon, 4 Jul 2022 20:16:50 -0500
> Samuel Holland <samuel@sholland.org> wrote:
>>> +		i2c0: i2c@5002000 {
>>> +			compatible = "allwinner,sun50i-h616-i2c",
>>> +				     "allwinner,sun6i-a31-i2c";  
>>
>> Future note: this will be affected by [1] which adds a fallback compatible for
>> variants with offload support. That way we don't have to support them all
>> individually in the driver if/when we implement that.
>>
>> [1]: https://lore.kernel.org/lkml/20220702052544.31443-1-samuel@sholland.org/
> 
> I saw (and liked) that. Shall I insert the compatible string already? Or
> is it too early for that, because dtbs_checks would fail without the
> amended binding in the tree?

The updated binding is in linux-next, so please add the new compatible.

Regards,
Samuel
