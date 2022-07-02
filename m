Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08B5641BF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGBRDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 13:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:03:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB190B49A;
        Sat,  2 Jul 2022 10:03:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 854275C0163;
        Sat,  2 Jul 2022 13:03:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 02 Jul 2022 13:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656781418; x=
        1656867818; bh=Qw0g3C0GCDs1Krht9RCgkXeovny/SwSqNa/Sv0Q8bjY=; b=r
        VBmpVASF3jGoNCF0i3CEx9TlVgGKj0OIneOTRlhXTcUF1aH8xwkouQul4YGZyo9N
        38t3tff/NNFZ02/gKboaO750iZXP+xjqHHvh9rb4oidrqjAc1Mg5WEEOLX3A7718
        1xK5grx9rr7PB/ANdUtcvKIx7GCzVtR3JMyoKCm7cKrxvG2C8KVAUx4SKM+7HwlZ
        WqAWv4bI6hLkgi6DszVYYQjGTDTIbrpOKJbKXyfP8IxC7hjo41Wg8Z44QWpGEMcA
        sbfY0dnYXGmKNdb4pXv+8Nf4VLg6cC7yx2iSJpO0xhdyzqyOQSk6rlN9TZm3BNck
        S+1pMMU6a5bFZaNqqH0pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656781418; x=
        1656867818; bh=Qw0g3C0GCDs1Krht9RCgkXeovny/SwSqNa/Sv0Q8bjY=; b=T
        ppaHG4SJqXpXhMgJtsJGffsPppzujMcVklJ3+5w9qgoLM6dqxncKPUNeaMJ5Culi
        ptGAq03MhAyCjDrli2HPZcglwmUgCH6rb/ZoDP74QlOEPG2gQ2yRXW39nDq8MY0C
        hok1XMR9kclnYF4DiQKS6ed22hJhO5aoCNh8frNhmsURfb4aMQ34ifPeYFyTkDjr
        bo69tLzhx6mT1cL6etOgdIGXEZCY6iwLnrz9O9KFU+eDxgPRl9DCRT9fgZZLGyt9
        +8VtWqWYHdY9L9GsP3iMMrShgaKwUwsec8L3RCmLpf8ATVQtYVhTcpI9jOdI7pVR
        HYHjkfUaXvlFm4rrylFdQ==
X-ME-Sender: <xms:aXrAYtJBfCwcoLHxzIR-JgbhSU4eaizYBIRq0ERcnQNYwGuC3GhKVw>
    <xme:aXrAYpLOmKVutZb6yu3HYCeiVQFWvcN4V4d87F4pKW_dFnwZgvBmxR-j07ccPuLby
    0B7ai-f0ZSncDkz_w>
X-ME-Received: <xmr:aXrAYlt4n80duRIcxG3KRfPyEvfC6rMAfsSOgbI79ObjyKRJFfbGHYIPQePRKXlvz9dkAtu1m9tjCP_QLVJheTpN_ROTUq-6CxE3AxqgddDcVUuFXkVVHWWs1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepjeelfedutdeggeevvdekheefjeefvefgfeeiffefgeduieeu
    tdehkeejleegueejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:aXrAYuZsz_UhmxI7CZwIMhHnE7Ru2l2YpXe0FML3IXw21_Z6miFdLg>
    <xmx:aXrAYkbGcxlj6Wr6DVO-pJyxY8wGCkVp1_guGuIIrjnkxXV0QHY6UA>
    <xmx:aXrAYiDs3Nfgdt2Yi9_IFnu52i2FkaI1oHEo-_L5-QzfBEcLN7tnMw>
    <xmx:anrAYkqyaJmGZ7Dom7nJNRuGR-A8SCLakorPvruP0KUk4hSVZtFXUg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 13:03:36 -0400 (EDT)
Subject: Re: [PATCH 0/3] ARM: sunxi: Remove A31 and A23/A33 platform SMP code
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Emilio_L=c3=b3pez?= <emilio@elopez.com.ar>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220531045038.42230-1-samuel@sholland.org>
 <2833034.e9J7NaK4W3@kista>
 <20220613121729.46233a75@donnerap.cambridge.arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <87fd9c7a-69be-e846-45ae-de3d773ba33a@sholland.org>
Date:   Sat, 2 Jul 2022 12:03:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220613121729.46233a75@donnerap.cambridge.arm.com>
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

[+ clock maintainers]

On 6/13/22 6:17 AM, Andre Przywara wrote:
> On Sun, 12 Jun 2022 23:09:07 +0200
> Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
> 
> Hi Samuel,
> 
>> Dne torek, 31. maj 2022 ob 06:50:35 CEST je Samuel Holland napisal(a):
>>> This series is preparation for converting the PRCM MFD and legacy clock
>>> drivers to a CCU clock driver.
> 
> May I ask what the purpose of this exercise is? So if I understand
> correctly, then it's about to convert the sun8i-a23-prcm MFD driver and
> its children to a single "modern style" CCU clock driver, with its opaque
> DT node?

Yes, the purpose is to finish the conversion that was started six years
ago[1][2], and eventually delete drivers/clk/sunxi.

[1]: https://git.kernel.org/torvalds/c/78a9f0dbcd60
[2]: https://git.kernel.org/torvalds/c/2c89ce4f4b19

> If that changes the compatible strings or the references to the clock
> providers (and I guess it would need to?), then this would mean an
> incompatible change. Which also means we would need to keep the old code
> around, to maintain compatibility with "old" DTs? So what is the win then?
> Now we have *two* clock drivers, for the same device, which need
> maintenance and testing.

We already have two drivers for the PRCM. ccu-sun8i-r, which is already built in
to all MACH_SUN8I kernels, was originally intended to support A31/A23/A33, but
nobody ever implemented it. See the comment in the binding header:

    /* 8 is reserved for CLK_APB0_W1 on A31 */

The benefits of conversion are:
 - U-Boot does not have to add support for an already-deprecated clock framework.
 - Users who know they have a recent devicetree can disable CLK_SUNXI.
 - Eventually we can disable CLK_SUNXI and delete drivers/clk/sunxi.

Yes, we need to keep the old code for several years to support existing
devicetrees. That is exactly why I want to do the conversion as soon as
possible: to get that clock started now.

> So can you confirm that this will be a breaking change?

Yes, just like the other half of the CCU conversion was.

>> The platform SMP code references the PRCM
>>> node to map its MMIO space, which will break when the PRCM node is
>>> removed/replaced.  
>>
>> Why can't we just leave old platform code? If older dtb file is used, it would 
>> still work. Actually, isn't trivial to support new CCU binding too, just by 
>> including new CCU compatible string? IIUC new CCU node will have same address 
>> as current PRCM node.

Yes, I could add the new compatible. I was trying to avoid adding more code and
more complexity to code that appeared to be unused in the first place.

> This aims for a similar direction, though in this case the alternative
> (PSCI) predates the sunxi specific method in the kernel support. Can we
> just deprecate this code, maybe issue a warning, with the hint to update
> the bootloader (which might not be possible for some devices)?

Since mainline U-Boot provides PSCI, I assume the purpose of this code was to
support the vendor bootloader blob. And the threads adding this code[3][4]
confirm that. In that case, users would have to be using a DTB shipped with the
kernel, not the one provided by the bootloader. So if we change the devicetree,
we have to change the code, too.

Regards,
Samuel

[3]: https://lore.kernel.org/lkml/20131110100312.GI26440@lukather/
[4]: https://lore.kernel.org/lkml/1426649042-30547-1-git-send-email-wens@csie.org/

> Cheers,
> Andre
> 
>> Best regards,
>> Jernej
>>
>>>
>>> Since PSCI has been available for 7+ years, instead of trying to deal
>>> with the migration, I think it's safe to just delete this code.
>>>
>>>
>>> Samuel Holland (3):
>>>   ARM: sunxi: Remove A31 and A23/A33 platform SMP code
>>>   ARM: dts: sunxi: Remove obsolete CPU enable methods
>>>   dt-bindings: arm: Remove obsolete CPU enable methods
>>>
>>>  .../devicetree/bindings/arm/cpus.yaml         |   2 -
>>>  arch/arm/boot/dts/sun6i-a31.dtsi              |   1 -
>>>  arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   1 -
>>>  arch/arm/mach-sunxi/Makefile                  |   1 -
>>>  arch/arm/mach-sunxi/platsmp.c                 | 194 ------------------
>>>  5 files changed, 199 deletions(-)
>>>  delete mode 100644 arch/arm/mach-sunxi/platsmp.c
>>>
>>> -- 
>>> 2.35.1
