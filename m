Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFBA47650A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhLOV6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:58:47 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38401 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230116AbhLOV6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:58:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 675BB3200B23;
        Wed, 15 Dec 2021 16:58:42 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Wed, 15 Dec 2021 16:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=X4Mjz1gSwctzS5BqbmLnHFsBnm1B/10
        sggy8KjqskWk=; b=UTMHkvJKfYL3boy2Zb/XROQDALb8tpmPcCzI2vckncPpz8n
        3aMD3d0cYXVMPpr1U0u7DwU2P9PrPP0GGl+ss45FDgoxCXDxW8sGC1WFgqZNivc0
        Tdto0pcAE772biGs/Qju6VB2xGGyk85zCxDbzT3jCRxT2iMK0vYwiVLxNTuF6lao
        Y16TUcx7N9giVRqjL8VuuX1H4wyZhfB+hniy6CGm4PxB8hjs/V2BwAVRh73Vckpz
        wl9yojO1tA7zMKfof+OU3oZYUXBl9/Pbrs7j11iKLBp7q09xeavrGXpVqx3VOkrK
        a2b9NH9gJGw0J6iv3OwXy/9B8urFcKl3C1FDB/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=X4Mjz1
        gSwctzS5BqbmLnHFsBnm1B/10sggy8KjqskWk=; b=V7R38EvDn/4qcJsqKbiCQt
        3TwCeujb5SbMkkNQMjQZW4lDJ82rxdcfIXHgYoxCYeukMeR/W4cJ1N79MJtCdrm4
        821BtzlH8U1UK1qjWg4ToJmfmLP3a8VMlOmzVBTqT6uhRzH3FWjyp9jWvadsDt6T
        dMcMqIo07sIx6vGuvVR2YD9eEA8pF1dQBtdyy0BqsCVY10xJW/E0UOT5f1gQcbOb
        Ji+MRi7mCtVAYdZFVXEzedxvU5ebMAmEAIxc8VMvX/8llMh/cNXnpc7utGn2KXu5
        UTfkafObVt0Xo4I4JUvDmacQbOyV9NRut80gfnyyORZGe8MAaVFJ9CikYi5H2vCQ
        ==
X-ME-Sender: <xms:EWW6Yb0prKNAE7wES0yXr--3npTfNq6LLL-KEXYNwzOb-Ps6t7aN-w>
    <xme:EWW6YaGv_wWjopLw9ItH2eJdj9o5Ob6bwdU7U9_nRBfnEyAzFfwk1HyyYoRcOoKAL
    gex70hZvLW4fW6eUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:EWW6Yb7FdMNHuD0UfUiAjvoH6yAsZDweHNtNaVsAR4nfReG2VgY9pw>
    <xmx:EWW6YQ1SbHbfNRbfKbFgXedaiclyeUlhL1HvQvBkKNAcvDM8KdGMYg>
    <xmx:EWW6YeFhFuTZFbdPG4-_hkNTt3qwh98mZxzzUBWVPiDncDZvV7lJ_Q>
    <xmx:EWW6YT54G1zO4o4wGZBnY6wqKO5nharSRNEPA3RYa16V8qnyDJc0tg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E9C0AC03DB; Wed, 15 Dec 2021 16:58:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <05d64453-09a3-4399-bd8c-595efd185ade@www.fastmail.com>
In-Reply-To: <20211215214022.146391-1-julianbraha@gmail.com>
References: <20211215214022.146391-1-julianbraha@gmail.com>
Date:   Thu, 16 Dec 2021 08:28:21 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Julian Braha" <julianbraha@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: Re: [PATCH v1] pinctrl: aspeed: fix unmet dependencies on MFD_SYSCON for
 PINCTRL_ASPEED
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Dec 2021, at 08:10, Julian Braha wrote:
> When PINCTRL_ASPEED_G* is selected,
> and MFD_SYSCON is not selected,
> Kbuild gives the following warnings:
>
> WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
>   Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST 
> [=y]) && OF [=y] && MFD_SYSCON [=n]
>   Selected by [y]:
>   - PINCTRL_ASPEED_G4 [=y] && PINCTRL [=y] && (MACH_ASPEED_G4 [=n] || 
> COMPILE_TEST [=y]) && OF [=y]
>
> WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
>   Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST 
> [=y]) && OF [=y] && MFD_S>
>   Selected by [y]:
>   - PINCTRL_ASPEED_G5 [=y] && PINCTRL [=y] && (MACH_ASPEED_G5 [=n] || 
> COMPILE_TEST [=y]) && O>
>
> WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
>   Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST 
> [=y]) && OF [=y] && MFD_S>
>   Selected by [y]:
>   - PINCTRL_ASPEED_G6 [=y] && PINCTRL [=y] && (MACH_ASPEED_G6 [=n] || 
> COMPILE_TEST [=y]) && O>
>
> This is because MACH_ASPEED_G* depend on (ARCH_ASPEED || COMPILE_TEST).
> ARCH_ASPEED enables the MFD_SYSCON dependency, but COMPILE_TEST doesn't.
>
> These unmet dependency bugs were detected by Kismet,
> a static analysis tool for Kconfig. Please advise
> if this is not the appropriate solution.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks.
