Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345EA576B51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 04:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGPC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 22:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPC3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 22:29:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC621E27;
        Fri, 15 Jul 2022 19:29:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B01533200893;
        Fri, 15 Jul 2022 22:29:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Jul 2022 22:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657938540; x=
        1658024940; bh=5TcXxbyuLJbPJBG8uv34cCNJbJo0NJdkOGPzeyKQiYw=; b=r
        +fb9ajCFr5QtYpA/WV8H32XXHLOtFddXvDeHis5Z8rE5Cun4FaCZfuC9MfSXSwAp
        XacFanIVxR9PtV68QNrS1XMP1glnxSjrKy1HkdIG3a+fssPZPda3PaKgbU2ZqgAt
        yQKZnsMFdMQlaHteuEIXpCUO4zERwKc/TPn2hP+FPJPFQTGYURNE9gB3CObWRPi2
        t380YSwc0ot+UFfC22ooOUZ6zoZy2XuMVnokTHlInH4iuvPapSh6nbNovmjxJPNo
        G7Cf+1c0NDFObDtGXIwLGpr8hohxPTwGhlt8Jx9d3VY29T5dPYxN8gTUdzmoCTQN
        XsGq2nSpCQX5508NnC0Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657938540; x=
        1658024940; bh=5TcXxbyuLJbPJBG8uv34cCNJbJo0NJdkOGPzeyKQiYw=; b=n
        KTZtcHb5lNlVFNGHpesYSTly5C1sa9PHvz6ghX4eajorA+X3XbaVE92Sqm7Z4dcm
        f1jsxa0NL1hM9UvHsW7xmoe011wW4um/LdrzafunsrztuXdaQnU+QwMBJuphqy3p
        a6m65lWuW8kahQYdCju/A+X6mvbbyzD7zIih5ESV2LGpaiVdZNCkrpK/51sQQwF7
        aGxnuSKXX+fMcCiyKibLBr21kJ8zJCAwuejugQk1w0K0631x5bDPpEtMAxvxAbiK
        WtfwHCg9YIN30at8Rk0rZs56YERX1frDM8AvJryTHHd8OC0/m4O0FSzBJQ/kx/fU
        imY/ZjHzXruH+A+KpPrIg==
X-ME-Sender: <xms:aiLSYomFxKVDMfCf-KxIn2b32nH8RGlTHBevVbiiT7JEqo79bXFepw>
    <xme:aiLSYn0N6FR_m2YCogj2i0xujs1-UJijwaHAWkGpWFYBK1BEZz5zXKXHJATCBi9Su
    lROc-vpwvuXEO8Bsg>
X-ME-Received: <xmr:aiLSYmpkiG-gbbq9bIcXwdCHGpODZTEVKyT-NLxwDaHA-zkBvrASZI5QZTZOH0rXZunOb-CpfrAj9r8c6wc_gX4918F6CtPwI7dyVEglRgBOAL3Of5OJrxh0UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:aiLSYklp5cmQDFmLm67Xbu_kjrDsDFq4ZXP4EFKINVImGkbzwF_6Fw>
    <xmx:aiLSYm0u1axRJvnJXmLRtOxCTuGPm4uNpzYJ8Oa1vJR8xk85ukufNA>
    <xmx:aiLSYrtO3fEjM-B4OuaMg4DIIvKoQFfjT2Yhcx--kDEEXJH20UuyYA>
    <xmx:bCLSYh3DF_b_Et7fJyZ1rCiCYNyjH9ka1lnqpL4oaHNh5ooXoM2v2w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 22:28:58 -0400 (EDT)
Subject: Re: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not
 report an error
To:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Michael Walle <michael@walle.cc>, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
 <20220714205529.GE17705@kitsune.suse.cz>
 <33abf7b84860049c4a22605578303ff2@walle.cc>
 <20220714220744.GF17705@kitsune.suse.cz>
 <20220715132006.077c90f8@donnerap.cambridge.arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2d4f200c-1ce3-19c6-179f-8d8e0545adfe@sholland.org>
Date:   Fri, 15 Jul 2022 21:28:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220715132006.077c90f8@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 7:20 AM, Andre Przywara wrote:
>>>> However, when the board is designed for a specific kind of device which
>>>> is not always present, and the kernel can detect the device, it is
>>>> perfectly fine to describe it.
>>>>
>>>> The alternative is to not use the device at all, even when present,
>>>> which is kind of useless.  
>>>
>>> Or let the bootloader update your device tree and disable the device
>>> if it's not there?  
> 
> Yes, this is what I was suggesting already: U-Boot can do the job, because
> a U-Boot build is device specific, and we can take certain risks that the
> generic and single-image kernel wants to avoid.
> In this case we know that there is a SPI flash footprint, and it does no
> harm in trying to check on CS0. So I was thinking about introducing a
> U-Boot Kconfig variable to probe for and potentially disable the SPI flash
> DT node. We would set this variable in defconfigs of boards with optional
> SPI flash.

To support the "does no harm" assertion: the Allwinner Boot ROM will probe for
NOR flash (and possibly SPI NAND) on SPI0 + CS0 if no bootable MMC device is
found. So the board designer must already assume that JEDEC Read ID commands
will be sent over that bus.

>> But then it must be in the device tree?
> 
> However this indeed means that the SPI flash DT node must be in and enabled
> in the DT, because we (try hard to) only use original Linux DT files, and
> DTs must have been reviewed through the kernel ML first. The U-Boot driver
> relies on the DT as well, so the official kernel DT copy would need to come
> with that node enabled. Ideally U-Boot would disable it, if needed, and
> the kernel error message would never appear.

I don't think this works for newer SoCs where the Boot ROM supports both NOR and
SPI NAND. If the board is sold with the flash chip unpopulated, the user could
install either kind of chip. So we cannot statically assume which binding will
be used. We would need to add a node with the right compatible string after
probing for both in the bootloader.

Regards,
Samuel
