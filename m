Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB20D462C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhK3GJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhK3GIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:08:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F1C061574;
        Mon, 29 Nov 2021 22:05:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y12so81992846eda.12;
        Mon, 29 Nov 2021 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qd7ugZO8ErlAqRJmMU/RFyz5a/nU/7Ddv8QHIbivAOM=;
        b=NqxFjtJQnLAWXnShg/7USZZp60vHVyqnY0U3T8VG2YJorB3mU3VDn3R3KLsQGOMcOW
         FxUqozyB4f86NGUifah56iY6zR2EFT7nC2TV1uDYByT3CAhdwNKt4wUBpu2fFXkxKD9m
         wN/YHrU9VnajajDE75SOG/PCummG7+qlnQwTE3OzKAtFheAedY/y3nE0yHwFxjfp/geG
         88HSQ/m0Sd6zEgiHrzxC2Dlq4dRr2i4ThB9HbIzt8PBIjt3MpsahHAXHuSnMrxlodw6C
         pUFbo09e4/Ng9eGG5sSYawyZ1jVm613fStWESR38HeUSeA+FHqj7XHL8+0Gm7S/76G3J
         6Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qd7ugZO8ErlAqRJmMU/RFyz5a/nU/7Ddv8QHIbivAOM=;
        b=4gHMykGhr/r+qprItL3k0a5n0zRlNd4MGacwasBQFj4LPVAD6sbXrT4uTYFafNSy2i
         fg212EN3an9PWokVYHLfBdCI2IDLfjEiXJ48TDXkvvV3eDrnoaac/oPu/ARkUsWjsQCX
         HLlPaF+V1K+lDZrF8cD9OaJGwVsd8KEg9qRhrMOfVpLQ38a9kIlVQQxxZTk2CRax4iGA
         ijDNHbfes+cmgsGTuGL0iPc9Zs63uU6wwWRteqY483JwklCk5+kKS0uSC85VsfO8tHkD
         CRQBw3yLQc+GB7/rCQV+C8JxdFXbdPIuQ6+18tNPxG0ZTeseyn3rHDdL/yMkmCJfDzsg
         Es+g==
X-Gm-Message-State: AOAM531P90jIWQ3pITGaojvg7NMKg/z0kOsd55POZXihOlSND9TgBLE8
        KhWhT+XYQ4FYfu0SnFMt8H+xplcGu9Im1za0
X-Google-Smtp-Source: ABdhPJx1I+m5OvA2PghqwGuZ6GERo2hNzui5wPGnWI0kAkQJx9LWc3dB6iQX+C0VSfa0UUn26W7Apw==
X-Received: by 2002:a17:907:6e16:: with SMTP id sd22mr61633142ejc.542.1638252327196;
        Mon, 29 Nov 2021 22:05:27 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e1sm10542153edc.27.2021.11.29.22.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:05:26 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [RFC PATCH 0/9] arm64: dts: meson: add support for aac2xx devices
Date:   Tue, 30 Nov 2021 06:05:14 +0000
Message-Id: <20211130060523.19161-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for several popular Amlogic S905X3 (SM1) Android
Set-Top Box devices. Like most Android box devices, they ship in variants
with multiple RAM, eMMC, WiFi and BT configurations. RAM and eMMC are not
something we need to consider to get a working boot, but we do need to get
the correct connectivity spec. Broadly speaking we see boxes with Higher
and Lower spec connectivity; High spec is Gigabit Ethernet and Faster dual
antennna WiFi, and Lower spec is Megabit Ethernet and a single antenna. In
some low-end boxes BT is ommitted.

The main reason for the RFC tag is to solicit feedback on the choice of
the -100 and -1000 suffixes which are used to distinguish between devices
with 10/100 Mbit (Internal PHY) or 10/100/1000 Gbit (External PHY) NIC
configurations; which is important to get correct else the box will have
no connectivity. I'm not a big fan of the suffixes, but earlier versions
where I used -int/-ext and -mbit/-gbit resulted in users having no idea
what the difference was. I'd like to informally establish a convention for
this naming before doing similar things with some S905X2 devices.

NB: At the current time the Realtek 8822CS and MT7668 WiFi/BT chips we
have seen on 'AIR' devices are not supported in the kernel so these are
deliberately ommitted. The H96-Max uses a conventional Broadcom module
so has more complete support. I'm also still exploring / learning about
alsa userspace configuration so for now the boxes have simple HDMI audio
support; wiring up the Headphone socket will be done at a later date.

Christian Hewitt (9):
  arm64: dts: meson: add common SM1 ac2xx dtsi
  dt-bindings: arm: amlogic: add X96-AIR bindings
  arm64: dts: meson: add initial device-trees for X96-AIR
  dt-bindings: vendor-prefixes: add cyx prefix
  dt-bindings: arm: amlogic: add A95XF3-AIR bindings
  arm64: dts: meson: add initial device-trees for A95XF3-AIR
  dt-bindings: vendor-prefixes: add haochuangyi prefix
  dt-bindings: arm: amlogic: add H96-Max bindings
  arm64: dts: meson: add initial device-tree for H96-Max

 .../devicetree/bindings/arm/amlogic.yaml      |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 arch/arm64/boot/dts/amlogic/Makefile          |   5 +
 .../dts/amlogic/meson-sm1-a95xf3-air-100.dts  | 108 +++++++
 .../dts/amlogic/meson-sm1-a95xf3-air-1000.dts | 129 ++++++++
 .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 300 ++++++++++++++++++
 .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 145 +++++++++
 .../dts/amlogic/meson-sm1-x96-air-100.dts     | 112 +++++++
 .../dts/amlogic/meson-sm1-x96-air-1000.dts    | 133 ++++++++
 9 files changed, 941 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-100.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-1000.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-100.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-1000.dts

-- 
2.17.1
