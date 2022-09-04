Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249445AC7DB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiIDVyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiIDVxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:53:22 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3F399EF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:50:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BD5E2580A4A;
        Sun,  4 Sep 2022 17:47:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 04 Sep 2022 17:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662328073; x=1662331673; bh=A1vIHpQ/uv
        0Y+LxuTIxC7UEkROeYK8Vc85DQeUcS3Qg=; b=NCKYo1X7lst+08AwhTxpw8kQUO
        5V0ojWUrEfsclJO7IPca3gu90JyXacX3LSOlKwLAPNstv09dutcdBG5WX2nxAyYH
        cnmxf1irFweHN3YHijbtvl8PwXfavsqX4dXl0zCzge/FzpIaj7LqfJXBh6kX6QxU
        MfHNMkIIlm4Z6PQ+wvqWrM6MANnDHQDd15q8QvzRLARTYA88SmJu4jxaga4Um8L9
        kGio1VxUwdRdjp2Ed+9r41eb10or5Hhq+z9UmtdJ/uIg/3aJ9B9BXTaiJyi337LD
        vl4ZVy5tABX5hRVecrFHC7BkDxzniOIEKUQie24juI6I83xaCZVTUTuHTtPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662328073; x=1662331673; bh=A1vIHpQ/uv0Y+LxuTI
        xC7UEkROeYK8Vc85DQeUcS3Qg=; b=sEpkWmJb9qOlKT0lPywaPGcIE0+0LVSPzC
        FUChjKaJxMgpYkEhblwWafBpn3Rm+6iXDbH7rIl/VKpIt0ZsUd1SiHAiJEbtJ3GB
        H/X47rGChkY2EfGBoqj5Rt+7Kkb6hmynYQE3XC3wmnBt5pJHSQWUVM2E/1NwEKHO
        +sPtJwHtmzZac5UKx5cbMmtTR3jf6qNr3lXgLbcy8K48enQNUfH5UyR1B2r/ooVr
        jGb/8wTXaPXAyiJbgEuiUmr1aEOqxUZktQFBv4bLdA6VjdoKbmEIVrFfzHatNmJD
        pp3Ly4+rdx0i95N+OUUEr7oxiG+fOnCPfR+t25lg0fxiKlZsYVdQ==
X-ME-Sender: <xms:CB0VY75r-QrNbqfRy-b-wrrdLRDI68p97jzAt6f9A6-H6ZrxGXcPsg>
    <xme:CB0VYw6wHSKpBsLO_2Jivcq2ZSxAr1eKBglh1RMMn7d1uSFhdXR_co6DNPIhG7jkU
    el2JUD9Z3kdFeLTwEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:CB0VYyfiGJsdvF5KVUpuKj6WYGesU6eHgttjCzZQf2RhdhwsSlBLXg>
    <xmx:CB0VY8LAnveSdwRk0sAP6y5TtGo63EE9KzuuBnzZoKiBH3_tRNfm-w>
    <xmx:CB0VY_Ii4jpeecKgS2OiO-Te4IY7FE-3yhnVrVrDph-Js7WF6x0wtg>
    <xmx:CR0VY8FoDcAih4nKC_64x0Zga3-Ku36gTJz3nXUoXH_gsTdJJv7_jw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A149FB60083; Sun,  4 Sep 2022 17:47:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <17ef181d-0c4a-4dee-8d1e-87a8fa3199cb@www.fastmail.com>
In-Reply-To: <87v8q3unlv.wl-maz@kernel.org>
References: <20220818211550.3272321-1-arnd@kernel.org>
 <87wnajuzyj.wl-maz@kernel.org> <YxSVhsHVsqZiAUS0@shell.armlinux.org.uk>
 <87v8q3unlv.wl-maz@kernel.org>
Date:   Sun, 04 Sep 2022 23:47:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marc Zyngier" <maz@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Christoph Hellwig" <hch@lst.de>,
        "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/4] ARM: footbridge: cleanups
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022, at 6:10 PM, Marc Zyngier wrote:
> On Sun, 04 Sep 2022 13:09:42 +0100,
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>> > > Cc: Russell King <linux@armlinux.org.uk>
>> > > Cc: Christoph Hellwig <hch@lst.de>
>> > > Cc: Linus Walleij <linus.walleij@linaro.org>
>> > > Cc: Marc Zyngier <maz@kernel.org>
>> > 
>> > I finally managed to give this a go on my netwinder using v2 of patch
>> > 5/4 (!), and the box booted nicely.

Excellent, thanks for testing!

>> > Note that apart from the serial console, everything I'm using on this
>> > box is PCI (I tried to enable sound and failed, probably because I
>> > can't select CONFIG_ISA anymore on this machine).

There are a couple of ISA-style devices on the superIO chip,
and I had checked this one to see what actually uses the
ISA DMA. As far as I can tell, the ECP parallel port and floppy
should still fully work in DMA mode, but these don't depend on
CONFIG_ISA. Irda and waveartist are gone, and the keyboard/mouse,
RTC, uart etc are neither DMA capable not based on CONFIG_ISA.

>> That tends to mean, therefore, that the statement "CONFIG_ISA is for
>> add-in cards" is wrong, because it's caused a user-visible regression
>> by killing sound support on Netwinders!
>
> To some extent, yes. Adding this allows me to peek at some of the ISA
> soundcards:
>
> diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
> index f452663576d1..f4c4222fa7c0 100644
> --- a/arch/arm/mach-footbridge/Kconfig
> +++ b/arch/arm/mach-footbridge/Kconfig
> @@ -31,6 +31,7 @@ config ARCH_NETWINDER
>  	select CLKEVT_I8253
>  	select CLKSRC_I8253
>  	select FORCE_PCI
> +	select ISA
>  	help
>  	  Say Y here if you intend to run this kernel on the Rebel.COM
>  	  NetWinder.  Information about this machine can be found at:
>
> However, the Waveartist driver has gone the way of the dodo (together
> with the rest of the OSS support in 4.15), and it isn't obvious to me
> whether one of the several SoundBlaster drivers is appropriate on this
> machine.
>
> I also cannot say I deeply care, to be honest.

I already made sure that there are no devices in the defconfig
that get disabled when turning off CONFIG_ISA, so at least for
anyone using the defconfig, my change made no difference.

It's possible that the sb16 ISA driver works in non-PNP mode,
but it appears to look for the wrong IRQ number and mixer,
the other SB16 compatible drivers all assume ISAPNP or PCI.

My guess is that to use this properly, one would have
to turn take the mixer bits from the OSS waveartist
driver and turn that into an ALSA driver along with a
simple platform driver frontend for sb16-common.ko.

      Arnd
