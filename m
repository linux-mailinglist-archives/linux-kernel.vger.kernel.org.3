Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A5E492E66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348751AbiARTV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:21:28 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:55460 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348742AbiARTV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:21:27 -0500
Date:   Tue, 18 Jan 2022 19:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642533682;
        bh=5dUeSSJ4ctACQ6+7qomltkfRNS6763hIzUOtbzKxQxU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=YE6dsf6HKaQEdSsnSQmY4kzgQ76wnUGq7yZSIjt7sW8zXBMROW4xTsQ83YVPfYPyJ
         N6fdSFwUxKDVemibTh/CvVb3/LpI9co6rEB+gp4ZqHQca3yOpMEQRy17EI4clGpMK5
         rSUNEDoBwxQxo7LPWgpE6Tr3aXTZgoZS4j5zsj01hezPHcGS9W2MKpz1OhHcRlIvjw
         FShfTL/Ozi1pBTYUFzbhQBithEUR9wGgFvzgEqWsgCrTYpHHtuWUmis2kTvZQNLk3/
         GPxwnWc+f1hWbe5IMU3Pfx3AAc8W0P2heOf5xL/jyTXadJQ3o2aDLY4HMGvoxTomY9
         xf2Mpqwlia5Mg==
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Subject: [PATCH v2 3/3] MAINTAINERS: Add clk-apple-nco under ARM/APPLE MACHINE
Message-ID: <20220118191839.64086-4-povik+lin@protonmail.com>
In-Reply-To: <20220118191839.64086-1-povik+lin@protonmail.com>
References: <20220118191839.64086-1-povik+lin@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clk-apple-nco driver and corresponding binding schema to MAINTAINERS.

Signed-off-by: Martin Povi=C5=A1er <povik+lin@protonmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e828542b089..9b6585717627 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1765,6 +1765,7 @@ C:        irc://irc.oftc.net/asahi-dev
 T:     git https://github.com/AsahiLinux/linux.git
 F:     Documentation/devicetree/bindings/arm/apple.yaml
 F:     Documentation/devicetree/bindings/arm/apple/*
+F:     Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:     Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:     Documentation/devicetree/bindings/interrupt-controller/apple,aic.ya=
ml
 F:     Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -1773,6 +1774,7 @@ F:        Documentation/devicetree/bindings/pinctrl/a=
pple,pinctrl.yaml
 F:     Documentation/devicetree/bindings/power/apple*
 F:     Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:     arch/arm64/boot/dts/apple/
+F:     drivers/clk/clk-apple-nco.c
 F:     drivers/i2c/busses/i2c-pasemi-core.c
 F:     drivers/i2c/busses/i2c-pasemi-platform.c
 F:     drivers/irqchip/irq-apple-aic.c
--
2.33.0


