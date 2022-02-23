Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838BB4C0F42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiBWJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiBWJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:32:18 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D23BA68
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:31:49 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BB3792000E;
        Wed, 23 Feb 2022 09:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645608707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBNCa6LJR3iljPGhnCMO65uktZ/FI+V/R8qYAtWXZCA=;
        b=kduRsPe0KaAjqDMlxNBf8Az9ugD/YuvtCMOiyKqiWPNTypp6bkfQvYUbm34g4pXoBINWfM
        qvFC7tHqGXU0UEBAmZsRcdeUuM6CMPAD3o9njbZJZer34h41dZnVHeVXkwsPmZzYjhPlf+
        hk6eM1qgpyjNLtdJsbp2VDWP3zVChdmxiZ4dEeIYZQOyUbWpC8oKTLdlpZOwm3mDD1FpC7
        KlX/1Ob1x/y0GuixPS4PIFENtYKqPbOoL9VnoIFNjZNg8DdguzF6CcxBQbY9I6i+SgAenv
        8tgqUBFNi6xvBCd8EnODUroCtNtg0AUOqH/frrxDCuCoQa2Lym6NjknZHO0Heg==
Date:   Wed, 23 Feb 2022 10:30:27 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] ARM: at91: pm: add support for sama5d2 secure
 suspend
Message-ID: <20220223103027.6b4ac892@fixe.home>
In-Reply-To: <202202231708.CAFCHZIn-lkp@intel.com>
References: <20220222150846.255307-4-clement.leger@bootlin.com>
        <202202231708.CAFCHZIn-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 23 Feb 2022 17:15:44 +0800,
kernel test robot <lkp@intel.com> a =C3=A9crit :

>    arm-linux-gnueabi-ld: arch/arm/mach-at91/pm_secure.o: in function `sam=
a5_pm_init':
> >> (.init.text+0x10c): multiple definition of `sama5_pm_init'; arch/arm/m=
ach-at91/pm.o:(.init.text+0x1b58): first defined here =20
>    arm-linux-gnueabi-ld: arch/arm/mach-at91/pm_secure.o: in function `sam=
a5d2_pm_init':
> >> (.init.text+0x160): multiple definition of `sama5d2_pm_init'; arch/arm=
/mach-at91/pm.o:(.init.text+0x1c0c): first defined here =20
>    arm-linux-gnueabi-ld: arch/arm/mach-at91/pm_secure.o: in function `at9=
1_suspend_entering_slow_clock':
> >> (.text+0x0): multiple definition of `at91_suspend_entering_slow_clock'=
; arch/arm/mach-at91/pm.o:(.text+0x80): first defined here =20
>=20
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for ATMEL_PM
>    Depends on ARCH_AT91 && !ATMEL_SECURE_PM
>    Selected by
>    - SOC_SAMA7 && ARCH_AT91 && PM

Actually, using mutually exclusive option for ATMEL_PM and
ATMEL_SECURE_PM does not seems to fit this really well. I guess it
would be better to integrate secure PM handling inside existing PM.c
code.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
