Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3664964A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351639AbiAUR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:56:39 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16]:30619 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351802AbiAUR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:56:32 -0500
Date:   Fri, 21 Jan 2022 17:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642787789;
        bh=L3GPP4BYomCCX59iwTHBksw8cVdhg6JC4KAsswidStE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=sXUZbx3R8Fcg+QFzkN8yZlMX7rIwNBCBqVA2imLaVJcrN8sqpYCQye+32mCbRjr7B
         30aIYRitdXeIfJ+yohARUU1HRRFqrYGSJF9Ef8t9XdIcWjl3E9Wvs7k7aHSfRcB/z9
         3PLfSgvmtUTVCB9hB6yRfq2dEZyMKS+2rQN9628Mc9BvhShuHzRIk3LvbIC6sTG5Ih
         PEPvssEqwIO0ou5oJ42TMWlnfT+lXoBXeU2nLEUlL3WGkwJ0QXK+ardZn+T2fCa62r
         uPP8sc/574+v5l6CpIsMt3QkngvpKD3jaP+qlJdxGq3U35lz2axPqAxZOidkjpals6
         vXb4Qi7n9+U/g==
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Subject: [PATCH v3 3/3] MAINTAINERS: Add clk-apple-nco under ARM/APPLE MACHINE
Message-ID: <20220121175441.9944-4-povik+lin@protonmail.com>
In-Reply-To: <20220121175441.9944-1-povik+lin@protonmail.com>
References: <20220121175441.9944-1-povik+lin@protonmail.com>
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

Acked-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Martin Povi=C5=A1er <povik+lin@protonmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 086f37a4763f..d6323083b695 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1765,6 +1765,7 @@ C:=09irc://irc.oftc.net/asahi-dev
 T:=09git https://github.com/AsahiLinux/linux.git
 F:=09Documentation/devicetree/bindings/arm/apple.yaml
 F:=09Documentation/devicetree/bindings/arm/apple/*
+F:=09Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:=09Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:=09Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:=09Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -1776,6 +1777,7 @@ F:=09Documentation/devicetree/bindings/spi/apple,spi.=
yaml
 F:=09Documentation/devicetree/bindings/usb/apple,dwc3.yaml
 F:=09Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:=09arch/arm64/boot/dts/apple/
+F:=09drivers/clk/clk-apple-nco.c
 F:=09drivers/i2c/busses/i2c-pasemi-core.c
 F:=09drivers/i2c/busses/i2c-pasemi-platform.c
 F:=09drivers/irqchip/irq-apple-aic.c
--
2.33.0


