Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BA5A5F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiH3JTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiH3JT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:19:27 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85286D9D7A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:19:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id F21625802D9;
        Tue, 30 Aug 2022 05:19:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 30 Aug 2022 05:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661851159; x=1661851759; bh=BfVVTqANl6
        VcnVUkLHgR9myKBGF2gDkzyQACK0g8F4Q=; b=i6lx62PYavWO9iFsFTgnWjjA4I
        5ec0ld4jtR1grA8CIhaD8dZexz71baEJIhtpa/kkhYa7iEzoyJRVOv0tMKN/GfFq
        Bs6S0JGWSZbY7T63boCVO+LtyqGukgkWxy9IiEQxsAGIxa0Ja47utzgWuVvN77rh
        wr4ZC7ghb3HlFIreAGIARlx+O6thnSBuwnxzBQe9W6MFib9Bj/+iogS5Fih8KBsh
        b2ffghMcfYRzwQlKirA4PllE8xXg8v7xVmD4X1fclnIpCKQVVzWEXiCGxP49M1iP
        r8C3NWoixXCbFQyuX/xGNbOoeB2cqWLIYp/NSnLUV5uikDaNmFDhJlRp4llQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1661851159; x=1661851759; bh=BfVVTqANl6VcnVUkLH
        gR9myKBGF2gDkzyQACK0g8F4Q=; b=VJGvRx1/eQmn2c4iOuGtRoWxHVEv29Xk2G
        WFOcNNjiXW/yv57T8JTRWnDmbwSnnuu3DbfHs1B1HF7xDPB650z1yVjFLPQKNS+v
        gm9qvlNJ5sC0gxGkF5vlgVup3VF3FEHjLi2l1fRVT66y5ClkRDqaKS9TckdPysON
        CQsnCNooPl1biJlg9wyJ65AAYVXnpnj/K+OgVwhSVp3GSPDh7M5dZaijP7QMtDt0
        R1iRsiD0+zOl4hF0p5On2U2Sirxzsbib6V5px5evjtJB5zec6Ot8oEtxFajNlQvY
        jSXi9lFf1JF3lGkHPqf2T57Lybh2U87mXPTZvHvwY0RYxagIHIgw==
X-ME-Sender: <xms:F9YNY0alaex1K_F7meYwTyhDKtcKpEWZefv83R2z4jzMwSIo68Jj5Q>
    <xme:F9YNY_Ze9uvkLdO4gAbiSi8ZlXarwxSoiiAwzfjYKThg19fqLvzW3FYW6mhfRlXCG
    d56Y9A4tqcHAKZ2Pxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekfedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:F9YNY-_KX6fPQg2Irk_-T5Y8m7ze4aRky6fDmHgpfu2hvCWuDej8Uw>
    <xmx:F9YNY-qNU--8T5_5Yei804LHKB46QTOphKIjnPxtur5tf6_c1WbcPQ>
    <xmx:F9YNY_psD_RKJtFjvTguoZoBwJuF7xMb1b9RJrLXl_Yz2S4eLFtLLA>
    <xmx:F9YNY4449dkx9bZr5DWvRRjHgz8vHT2cskXdqFu37CZCYFOjkmb1HaW3H24>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA30BB60083; Tue, 30 Aug 2022 05:19:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <3ef107b1-d4a7-4f12-8a26-1c5e357cec8c@www.fastmail.com>
In-Reply-To: <CAMuHMdXqzOTDkbC7NXXQ32dLfO+JfkEMijxepEA=FfThSE9Xow@mail.gmail.com>
References: <20220818145616.3156379-1-arnd@kernel.org>
 <20220818145616.3156379-5-arnd@kernel.org>
 <CACRpkdbFkV1T+K9wKDyODkcwu=nhbV+4_JF=YTaA5ad_w4ggbw@mail.gmail.com>
 <CAK8P3a1PQjR2sv2rar6mFY9g4PkteAC+zgRUvnr04DETJX3K9w@mail.gmail.com>
 <63a630b7-9068-40f9-b7f7-d9a08f74ed13@www.fastmail.com>
 <CAMuHMdXqzOTDkbC7NXXQ32dLfO+JfkEMijxepEA=FfThSE9Xow@mail.gmail.com>
Date:   Tue, 30 Aug 2022 11:18:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, "Sekhar Nori" <nsekhar@ti.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] ARM: fix XIP_KERNEL dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022, at 9:41 AM, Geert Uytterhoeven wrote:
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1619,6 +1619,7 @@ endchoice
>>  config XIP_KERNEL
>>         bool "Kernel Execute-In-Place from ROM"
>>         depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
>> +       depends on !SMP_ON_UP && !ARM_PATCH_IDIV && !ARM_PATCH_PHYS_VIRT
>
> You may want to keep the list sorted.

Done

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks,

       Arnd
