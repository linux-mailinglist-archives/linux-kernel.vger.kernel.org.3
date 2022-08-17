Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8A596B80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiHQIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiHQIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:39:28 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91051474ED;
        Wed, 17 Aug 2022 01:39:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F40A85C015C;
        Wed, 17 Aug 2022 04:39:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 17 Aug 2022 04:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660725566; x=
        1660811966; bh=1XgksyqqOpjmG5LRrLM6xA1+iwp2OMLWZWBQsySSgeI=; b=s
        Xx2BlpjDk+EXCp1fpwwAcWPw0H6ob4T8XOP1COeMB7VEi4LH30S7gj6lxZn69oHo
        p88YfKLxTYFU+S+bogQUDV0Ko/efYev4g1RnuDXwY0rdC1ubkgb0zTKihwnFMdw5
        7prlhqwTbRooLsksUfZpXU44jjJdq63EhwSRE6psISFn2fIsJFlfe8cd51J9rO2G
        NNHICZNlSwlAadCjOYDKz8nFLJIM3hnuWgiCcDCoIVxDIO+y2ATaHnmPXGL01Lv5
        0D8pKJNzAdTAiHwpNkVuEbYA1q1ojf5qJqH5PdrLZU1yLJlN4B/m0vgNTcs2Zkhr
        nvBnrIWIfi3YWujqwG2WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660725566; x=
        1660811966; bh=1XgksyqqOpjmG5LRrLM6xA1+iwp2OMLWZWBQsySSgeI=; b=b
        ntu4LsVEXqMEwtw6BIeHooL5R5nY/EuiUxc5IUfzHyYkMq0S+mdvIUl4cvdadMqx
        +YNdCx7eQOHidWKUdu1brtHqZSyjgbXmGm600L3qUXkrqORV0owMLYXgCgc4C9GY
        v/WxZAQ0PUi657cS3ACtxO0McTKvPq4pB2u+qRV4FQ8+r/+51gq5/YvcUN4ynNkT
        yoODzCvigK1yktb/6/OcvRwLRQm2ZeB0sH8+CzY7Nx1K7446ianxY7PQrsklCmlD
        9oEdvnuewbN9qqp1Dr1X8TXZw4S4/Xrm7nsoaVqZMi7TFK+JGb8XOQC+jmIV5stw
        w9ul19O4NQVfs2NnvfsQg==
X-ME-Sender: <xms:Pqn8YjaP96pYv6lFuj9BxBI42QgQdoy8t1P3Ajsetz7I5FeG55jz4w>
    <xme:Pqn8Yiaa0Feayn7fYyfbm44esgJv65Qt_bzqV6bDVAadu_6g2gNOKqXncnIflyXDx
    cw2lG8TkUpzSMYHhA>
X-ME-Received: <xmr:Pqn8Yl8euNQV8Mm6x3iNhB5bgtt6Hw7mfUNnvDRAPp6h2Cy_gS9gB4H3kagD1qCBuvfPaDiKsK7XRd0eW1NjS4a3iCMi8LF3FcceovT_U40Juvyrab4w_qyWcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Pqn8Ypq0JaRWQt_ZEKVTpbp-vyoxI60yQ9r3sKWwF3ZhMrZk9bqu3w>
    <xmx:Pqn8YuoFjAqb_Vtlr96lPWRIlxkjaA1ZISMN7kkWYdc4k2xoPht84w>
    <xmx:Pqn8YvRcjSsA8TKNFHXSGLhLBJjqtanS7dAYy5Y39ppKBjW-a_c1Kw>
    <xmx:Pqn8YrjmB8RTyj2eyz-VsORgR-Y3KH8x54IISIIt9Eh2T6OlkqTmKA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 04:39:25 -0400 (EDT)
Subject: Re: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-2-samuel@sholland.org>
 <c4ec080a-b8b1-e3a9-c9d7-063e138c9bb8@linaro.org>
 <03de0f7b-9251-a5c0-91a1-5f2b5d41d8a0@sholland.org>
 <29e6a293-29c4-a9ab-0767-9adfa982226b@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8f133166-dff8-e376-3ac4-a464724d5421@sholland.org>
Date:   Wed, 17 Aug 2022 03:39:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <29e6a293-29c4-a9ab-0767-9adfa982226b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 3:27 AM, Krzysztof Kozlowski wrote:
> On 17/08/2022 11:15, Samuel Holland wrote:
>>>> +examples:
>>>> +  - |
>>>> +    audio-codec@2030000 {
>>>> +        compatible = "simple-mfd", "syscon";
>>>
>>> This cannot be on its own. Both require device specific compatible.
>>
>> Again, the device-specific compatible does not exist, because the binding for
>> the audio codec has not been written (and it will be quite nontrivial).
>>
>> So I can:
>>   1) Leave the example as-is until the audio codec binding gets written,
>>      and fill in the specific compatible at that time.
>>   2) Remove the example, with the reasoning that the example really
>>      belongs with the MFD parent (like for the other regulator). Then
>>      there will be no example until the audio codec binding is written.
>>   3) Drop the analog LDOs from this series entirely, and some parts
>>      of the SoC (like thermal monitoring) cannot be added to the DTSI
>>      until the audio codec binding is written.
>>
>> What do you think?
> 
> How about just removing the audio-codec node? The schema is about
> regulators, not audio-codec.

That works for me. I put the extra node there to signify that this is a MFD
child and requires some parent node to work, but I suppose it is not that
helpful to have.

> OTOH, if you have parent device schema, you could put the example only
> there. But as I understand, you don't have, right?

Right.

>> The same question applies for the D1 SoC DTSI, where I use this same construct.
> 
> This is not correct and should be fixed. Either you add the schema with
> compatible or please drop the device node from the DTSI.

That's what I was afraid of.

Regards,
Samuel

>> (And technically this does validate with the current schema.)
