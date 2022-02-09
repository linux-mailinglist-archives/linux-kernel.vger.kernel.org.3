Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DCB4AF68C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiBIQZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiBIQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:25:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421BC05CB88;
        Wed,  9 Feb 2022 08:25:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 7C9811F437CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644423933;
        bh=wUyTh4TxAaAhhf0GaFyj+4ErZEcZzUH0SZMh0f5d9aI=;
        h=From:To:Cc:Subject:Date:From;
        b=X3Zo1DikBaErEDlbfGfpcfYsLZVVx4HB6xSkJsJDbnuJB3SbWgYHSFkw+yPWfclOQ
         7BXPGKatk9pqjqTKTJFxaC5RyIxAC8HagGc6y8sAOOAX6mvv9CE1lAcn7XnP8c3ZdL
         35sxQRLm6g6BEYSYcWhVbzcMvhJbqV76D6fP7/uMDe+/VUZup6i4zSmpZ+iY4FatVh
         TYqYIo9S28072Qs7SWeibkeZoHIsuYiIfwfiVhH1xygwSF0MaSlOA3WeRP8GN/AEKh
         d6fgHZCPL/f5TFnL9w5/lO3LVF7DjumyT9fN9I/9QQk4bRy0QDQoJSCb8v1RH4fJ7v
         dqTGDbv5v7Dkg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Detlev Casanova <detlev.casanova@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org (maintainer:ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON
        PARTS)), Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM AND ARM64 SoC
        SUB-ARCHITECTURES (COMMON PARTS)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 0/2] ARM: dts: Support official Raspberry Pi 7inch touchscreen
Date:   Wed,  9 Feb 2022 11:25:10 -0500
Message-Id: <20220209162515.706729-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree to support the official Raspberry Pi 7inch touchscreen.

This also demuxes the i2c0 controller to support both pinctrls.

Detlev Casanova (2):
  ARM: dts: bcm2*: Demux i2c0 with a pinctrl
  ARM: dts: Add bcm2711-rpi-4-b-7inch-ts-dsi.dts

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts | 129 ++++++++++++++++++
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |   1 +
 arch/arm/boot/dts/bcm2711.dtsi                |   2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   9 +-
 .../boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi    |   4 +
 arch/arm/boot/dts/bcm283x.dtsi                |  26 +++-
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts |   2 +
 9 files changed, 170 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts

-- 
2.35.1

