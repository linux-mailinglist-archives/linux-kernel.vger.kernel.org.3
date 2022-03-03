Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0C24CB3ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiCCAgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiCCAgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:36:52 -0500
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 16:36:05 PST
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6614667E;
        Wed,  2 Mar 2022 16:36:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 2A8542B00248;
        Wed,  2 Mar 2022 19:30:34 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute3.internal (MEProxy); Wed, 02 Mar 2022 19:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=eiWLYfA4t1gGk/
        mdor81f7EceQWpUlzsDTwnD33Z67w=; b=yQDCr14Q8vFd8Vhl2mpgM/1hWafyyc
        ZnMCn0SfsF+PTDm74K1cEXva4K6RLAEPRM4ylBbgIYHO88HYJA3N3D8SpJFMaUYu
        Ey4ZvPi9EAi3BlxWTcSCKL0R/dsPChEZ9UZkeTQbutnY8G3eMls+P59QIngpwwY5
        TiTMprrDj2LRpXIyXntMIFT6spzAFRn+B56UoSoiDaFYCJ+ybkT2/7GtJGjfuQVk
        +tjqFKihAfKNA5kLdWoJ4rVpWW5sDZF1PSYv3aS9Qj19Tz4d5aA79MhI1UDjQv7z
        R+9DMFTStMw87Xhs7VY6o99jtEvh/FGwcOolOUAd7cbDr5FzBkoHeTpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=eiWLYfA4t1gGk/mdor81f7EceQWpUlzsDTwnD33Z6
        7w=; b=EI7+GdstVl79yq9Fm3hvRTD1YZ66On6ZvCyB53SB/KQSa9RXa3DBnRbCb
        PTei6GReqFjZ1/vOUq4R9aOzx1rr5XsGHiNRZtYr31ZkZwnwGmSomkFDW/60vxcr
        BH/tVQixKpfHx+vwSob7ciWRp2AuACf7dl85tYxnXp/qt40xOg5bup2ZOWxjvhXb
        UVJbPfRbKTgnZqTgqQKw5DSkC6qJHsfjOfZSy7Olt7aUaF3c7KQE0KaIQvyNPCYI
        lConQVqasVzznECBA2PE4dE/0kRbz64BKUVBu4jzdzjpBcqiaVJBAO0kAD+QMd4Y
        W/5KOkb1B+WAO9mLkjxTfC+8jGP6w==
X-ME-Sender: <xms:KAwgYiXUVobGGbgnfnTqlkjK2bFjiR41JDSh9efIYb7Kr86RhKUoJQ>
    <xme:KAwgYumtoyVlM_S-4LeNPryd2PF452B0XmPHD4G5OFe-P2ZvwnK2Cp1KpCWWTpVIo
    JUAqi23R0jcmXlUWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddthedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekheejieeigfefvdffheevveekfeejgffgvdeuueegjeeghfffhffg
    ieelffdvfeenucffohhmrghinhepudekrdhithenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:KAwgYma6HG35WC5hESTOpwPiuqjPmuoeIo7ZXNUwlQL_Oo1HTjUQOA>
    <xmx:KAwgYpVtntNyqwhaBKeH11g6GTYa_udNOtqrc4m6AQ4FARFF33PWeQ>
    <xmx:KAwgYslKiOhNMqSehKqeVgwB8x53TCLR5MgrimauAeyTWb9y6fNGHw>
    <xmx:KQwgYpgdrpzcgPjU1XtxQD_qfXwN0QMsqpgqF1xhU09yJYgyZbgT4T92eDo>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8700FF6007E; Wed,  2 Mar 2022 19:30:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <a42db25f-33af-4232-9acd-815f7b116c71@www.fastmail.com>
In-Reply-To: <20220302085432.GA11054@duo.ucw.cz>
References: <20210921043936.468001-1-andrew@aj.id.au>
 <d2b85ad7-aef7-6088-03f5-cbd6e0bcab5d@kaod.org>
 <CACPK8Xdvns7PK9t1ZutAbkJqhb5eRcoWCDySQGsfbtLv+XMvqQ@mail.gmail.com>
 <20220302085432.GA11054@duo.ucw.cz>
Date:   Thu, 03 Mar 2022 11:00:11 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Pavel Machek" <pavel@ucw.cz>, "Joel Stanley" <joel@jms.id.au>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        linux-leds@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/2] leds: pca955x: Expose GPIOs for all pins
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2022, at 19:24, Pavel Machek wrote:
> Hi!
>
>> > > Without these patches the driver limits the number of pins expose=
d on
>> > > the gpiochip to the number of pins specified as GPIO in the devic=
etree,
>> > > but doesn't map between the GPIO and pin number spaces. The resul=
t is
>> > > that specifying offset or interleaved GPIOs in the devicetree giv=
es
>> > > unexpected behaviour in userspace.
>> > >
>> > > By always exposing all pins as GPIOs the patches resolve the lack=
 of
>> > > mapping between GPIO offsets and pins on the package in the drive=
r by
>> > > ensuring we always have a 1-to-1 mapping.
>> > >
>> > > The issue is primarily addressed by patch 1/2. Patch 2/2 makes it
>> > > possible to not expose any pins as LEDs (and therefore make them =
all
>> > > accessible as GPIOs). This has a follow-on effect of allowing the=
 driver
>> > > to bind to a device instantiated at runtime without requiring a
>> > > description in the devicetree.
>> > >
>> > > I've tested the series under qemu to inspect the various interact=
ions
>> > > between LEDs vs GPIOs as well as conflicting GPIO requests.
>>=20
>> > > Please review!
>> >
>> > This is simpler than the 'ngpio' business we had before.
>> >
>> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>=20
>> I saw that you recently merged some LED patches. I was wondering if
>> you could consider this series for v5.18. It still applies cleanly,
>> and we've been running it for a while now, so it's very well tested.
>
> Thanks, applied. I must say this is really ninja-mutant driver, but I
> see no better way.
>
> +++ b/drivers/leds/leds-pca955x.c
> @@ -429,7 +429,7 @@ pca955x_get_pdata(struct i2c_client *client, struc=
t=20
> pca955x_chipdef *chip)
>         int count;
>
> This really should be unsigned. Care to fix/submit a patch?

I'll send a fix.

Andrew
