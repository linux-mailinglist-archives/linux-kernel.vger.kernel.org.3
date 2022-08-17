Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287D5978CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiHQVQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbiHQVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:16:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A12D57552
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:16:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oOQOX-0004kI-IR; Wed, 17 Aug 2022 23:16:09 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5D4F1CD031;
        Wed, 17 Aug 2022 21:16:05 +0000 (UTC)
Date:   Wed, 17 Aug 2022 23:16:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH 0/4] can: bxcan: add support for ST bxCAN controller
Message-ID: <20220817211604.o44ojny342ynk7zg@pengutronix.de>
References: <20220817143529.257908-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kmsf55lalqtcovvr"
Content-Disposition: inline
In-Reply-To: <20220817143529.257908-1-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmsf55lalqtcovvr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I've stripped down the Cc list a bit...

On 17.08.2022 16:35:25, Dario Binacchi wrote:
> The series adds support for the basic extended CAN controller (bxCAN)
> found in many low- to middle-end STM32 SoCs.
>
> The driver has been tested on the stm32f469i-discovery board with a
> kernel version 5.19.0-rc2 in loopback + silent mode:

I've had no time for a in depth review, but here are some warnings by
the standard checker tools:

Please fix these sparse errors:

| drivers/net/can/bxcan/bxcan-drv.c:641:39: warning: incorrect type in initializer (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:641:39:    expected struct bxcan_regs *regs
| drivers/net/can/bxcan/bxcan-drv.c:641:39:    got struct bxcan_regs [noderef] __iomem *regs
| drivers/net/can/bxcan/bxcan-drv.c:650:15: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:650:15:    expected void const volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:650:15:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:667:20: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:667:20:    expected void volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:667:20:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:672:17: warning: incorrect type in argument 2 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:672:17:    expected void volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:672:17:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:675:9: warning: incorrect type in argument 2 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:675:9:    expected void volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:675:9:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:677:15: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:677:15:    expected void const volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:677:15:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:703:14: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:703:14:    expected void const volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:703:14:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:709:15: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:709:15:    expected void const volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:709:15:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:718:50: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:718:50:    expected void const volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:718:50:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:730:39: warning: incorrect type in initializer (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:730:39:    expected struct bxcan_regs *regs
| drivers/net/can/bxcan/bxcan-drv.c:730:39:    got struct bxcan_regs [noderef] __iomem *regs
| drivers/net/can/bxcan/bxcan-drv.c:735:24: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:735:24:    expected void const volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:735:24:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:742:17: warning: incorrect type in argument 2 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:742:17:    expected void volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:742:17:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:747:28: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:747:28:    expected void volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:747:28:    got unsigned int *
| drivers/net/can/bxcan/bxcan-drv.c:802:39: warning: incorrect type in initializer (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:802:39:    expected struct bxcan_regs *regs
| drivers/net/can/bxcan/bxcan-drv.c:802:39:    got struct bxcan_regs [noderef] __iomem *regs
| drivers/net/can/bxcan/bxcan-drv.c:810:15: warning: incorrect type in argument 1 (different address spaces)
| drivers/net/can/bxcan/bxcan-drv.c:810:15:    expected void const volatile [noderef] __iomem *addr
| drivers/net/can/bxcan/bxcan-drv.c:810:15:    got unsigned int *

(To enable sparse checking, do a "make C=1" to compile.)

Please fix these checkpatch warnings:

| WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
| #74:
| new file mode 100644

Please create a MAINTAINERS entry.

| WARNING: Using vsprintf specifier '%px' potentially exposes the kernel memory layout, if you don't really need the address please consider using '%p'.
| #307: FILE: drivers/net/can/bxcan/bxcan-core.c:179:
| +       dev_info(&pdev->dev, "regs: %px\n", priv->base);

Please remove the print of the base address.

| WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
| #356: FILE: drivers/net/can/bxcan/bxcan-core.h:21:
| +static inline void bxcan_rmw(volatile void __iomem *addr, u32 clear, u32 set)

remove the volatile.

| WARNING: Using vsprintf specifier '%px' potentially exposes the kernel memory layout, if you don't really need the address please consider using '%p'.
| #1273: FILE: drivers/net/can/bxcan/bxcan-drv.c:899:
| +       }
| +
| +       dev_info(dev, "regs: %px, clk: %d Hz, IRQs: %d, %d, %d\n",
| +                priv->regs, priv->can.clock.freq, tx_irq, rx_irq,
| +                sce_irq);

Remote the print of the regs.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kmsf55lalqtcovvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmL9WpAACgkQrX5LkNig
0104Swf/WXC5q/uKxglR55v1iXB0ag/QppN8vUAVT8mrTm2JteBp0W1p+t9MWqjP
WzqJspo6R4uhrdOp6IG0w8IwS6aIESsE6IvYgCrEVjJUBMnHAEgDiaL5YxrTNwqL
bVCskkv93KZmpTEhpHlqUlgTufpxlJOnpo+g5vTy169+0eh1eEP5F2CySrYDcEnO
+r1yf0dKBUpRnMe+EAZ+UN7FK5yHheanbnm44i35zfZ3+Tm72Z4SzS9jd48iINTv
qLmGsTKoYfmW3bYkUreCVEwTC7mrn6suAvVE8bNECtfHkEENwtEHVaQfnI42ySsW
Aiw+/cyVC3TM66PhZtmzT3Slo+Wmkg==
=NSCv
-----END PGP SIGNATURE-----

--kmsf55lalqtcovvr--
