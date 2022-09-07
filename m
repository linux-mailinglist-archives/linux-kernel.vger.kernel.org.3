Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACEB5B05A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIGNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIGNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:48:15 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A2B48C;
        Wed,  7 Sep 2022 06:48:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A507B580392;
        Wed,  7 Sep 2022 09:48:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 09:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662558491; x=
        1662562091; bh=x8FEmyd46Ech5SbUlxrK+zLn7yS/pATtQbRStypEsQk=; b=R
        98+L5TR/6KxWm9Rz3/V2adnKa0kBcUdCYyi8h7CcO3sM2Z057GdgQ5FU5v2B7n6/
        Dw003SC1kdbbbzv9O5IAQsJRyHXXo5T432pCE+Rl05dk7UJLo9nQwKn4csyxyJ4N
        uX7EzPHwsH9lvB2zdu5o1PUMg6bwv2oJNZTpiLCS4EOkHsN23hOMXUiWYkf/wHYA
        SzkuM/o78nIBG7VMY27LVTufzB8KvclMHDzKt0by8FvrMf15fOpVGd+WTQIsAwHe
        Gy8ygWPsnnln6veJ3EWCxP+VbwZkBuzUKY7XrOMz9dtML4htjEgA0kUEVUV9HO+k
        x+ws+j/JVJGDfdkEt5eXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662558491; x=
        1662562091; bh=x8FEmyd46Ech5SbUlxrK+zLn7yS/pATtQbRStypEsQk=; b=Z
        1Oz5b5imBIqKK8mQc+QM2nx6VJZBc+1wP36WSriFxKeRKlBDK/+rce9sjnb9ZNLp
        o9XUK2YDCPfGkV8QWHsf80IpaTvY3ygbGK1lM8lHUkSYqtKPA/OGxWWIhdhK1GCG
        f/Y99HUH5anBPFdlovtHZ40m+N6tBvJj9zIXUM0T/CIsIiyPXtHCVYzZl/m3ehUT
        EzpWVzz4145kDKjyZtdM34BSmT0VBr30BP8GnZ+pqd0oaPVX0gaHeBtr6Bi4W0L/
        6KSW3Pq6dbKmgx9+DsOunxftgk6oarQIGhYeCTG4OS5YIg7uWBbfVxFNx3M/4s0V
        yDVYK4PPi/a25+VqpYBOQ==
X-ME-Sender: <xms:GqEYYxDWCvU49c4G2SuzitU-q-EGGFo0TD8uGIsB3MWQb43uKcPR7g>
    <xme:GqEYY_igpZDCTaDriY57FfvGXZJG6FWkEQA_KR5A793oXMyKNGMAL0GKpE32rANPH
    NiKR8lSclevzgwJtRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeelfefgueeviefgudduueefueffkeelleeijeelkefgudfgueelledtuddu
    ieegvdenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GqEYY8mxJNEzXYNyW6UmoHK2gyScOl0FHrhxgeBVlej95LCwK_bLzQ>
    <xmx:GqEYY7y0iXybYPVs746Zu0fooqvnpq8lY3njZYNthIw4v5nqnMZRFQ>
    <xmx:GqEYY2SglqA4OkjXC_q6hG1amHEgkXwVVCVoRTT52i5tM5nYLM0S4w>
    <xmx:G6EYY9_URdg-CZRU8m7pUfehO-rRGyrQ3Lxj-edmZcTaXJxCyYCQbQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E14FB60083; Wed,  7 Sep 2022 09:48:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <af980df4-a308-4aab-8628-ca02b55de43f@www.fastmail.com>
In-Reply-To: <e5f1ac97-e67f-bb68-d89a-f6f246ff6388@linux.intel.com>
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
 <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
 <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
 <715b40ba-1bcc-4582-bed1-ef41126c7b94@www.fastmail.com>
 <cfd16d53-6aa0-e848-91d0-dce8ff72bb4d@linux.intel.com>
 <YxiONiDgGYp8MGQA@kroah.com>
 <c66f9c98-dcef-27c-d74a-ea826f6a799@linux.intel.com>
 <YxiQVTN/jX8AfO4L@kroah.com>
 <e5f1ac97-e67f-bb68-d89a-f6f246ff6388@linux.intel.com>
Date:   Wed, 07 Sep 2022 15:47:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Johan Hovold" <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Tobias Klauser" <tklauser@distanz.ch>,
        "Richard Genoud" <richard.genoud@gmail.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        "Liviu Dudau" <liviu.dudau@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang7@gmail.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
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

On Wed, Sep 7, 2022, at 2:56 PM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 7 Sep 2022, Greg Kroah-Hartman wrote:
>> Ok, no, I don't understand what Arnd meant here then :(
>
> I think he did just 2 things (compared with 2/4 of this series):
>
> - __DEFINE_UART_PORT_TX_HELPER() doesn't create a function but just wr=
aps=20
> the macro body with ({ }). Therefore, a driver must use it inside=20
> a function rather than the macro creating a new function with name.
> - Use lowercase instead of uppercase (this is a trivial change)
>
> When a driver is using these "function" that are just made look functi=
ons=20
> but are macros for real, it will not add function-pointer-indirection-=
call=20
> per character but pulls the whole loop from the macro into the functio=
n=20
> in the driver and injects those putchar, etc. directly into that loop.=20
> ...It is just like read_poll_timeout() constructs the loop.

Right, the example I was thinking of was wait_event(), which is
another common macro that takes expressions as arguments but gets
used like a function call. Same thing really.

Note that even with an always_inline function that takes a
function pointer argument, anything from gcc-4.7 up has no=20
problem inlining through that, so it should not be any less
efficient though it might not help readability either.
See https://godbolt.org/z/o8GGG8TzM for an example of that.

     Arnd
