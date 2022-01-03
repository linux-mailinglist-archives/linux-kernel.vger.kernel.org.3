Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198CC4834D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiACQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiACQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:02 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C860C061761;
        Mon,  3 Jan 2022 08:40:02 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bm14so138042628edb.5;
        Mon, 03 Jan 2022 08:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eht7o1AHSMEA/BlQ8ldVCsOJ6QACXyHtWePKYMSt5rw=;
        b=AgMDCKqcOg6gqaboXtVg9pN428AaIhXz5ih18VNdvAndj4VdDmLq90HvIiBmcEnn1D
         I0GutjpNPYLXO34MYkGzQfUgbB3zobWI05yYpEx/2SX1YToXoJrNLhIhh3dD138lWGL9
         yA2TwkkrZxZyHW/zmpqcqTG6liEDCoXIyleIaE947Mx9q4YIK1C+CSZ5K2+yo1A5itWV
         2qwb3cBpQho8AZiHsh4eX/NPKAPOchBAwS7a5IQjYGkuMzm0NjRxcJ5KG/DTekBs6k2X
         AiSF6NNVfqG0pstHcCmRFXRVWxYbMwQg21r2bFy7HImRVCZGbtx4103C/Je4ZrsIfExj
         wb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eht7o1AHSMEA/BlQ8ldVCsOJ6QACXyHtWePKYMSt5rw=;
        b=xtD/ue7VXwpTTbXmLj1v6mg5gENjwtnSpm9lLOyFGClRN+MtFxH+EsUi6f1f/oUM2s
         Mtj8fWLx108eqkAk4AnAKjsK/ARqrUEO0NhBqLdjbidCHYf9xg8bLxJJczmiBQ4SBRc7
         HaG1TNuWA/4mveFSJkvkYk5sWzGD4y+S53TIAHjVBEQv1QNHeGZzijdLOu3QbXmSQ/WG
         n/e8suSuCM3lcBok/6uyCEXKvVN7cwBusYuhJJJYV9VhKP63ckSKhiUFc/akuddvRO8o
         Stfb5JWc2Siz0ASDRI0kUiwzpxU5Epjs0S/LQXwt68k9RJYSvVDVp00F/jWrOpUqr/56
         T1EA==
X-Gm-Message-State: AOAM531yC/l0t/C1U3c8ayv0qyqVUJd5u8riocSkCcMQPtAuyCuO9OOQ
        3Xis5BmlV+xj2eAhmVroIr0=
X-Google-Smtp-Source: ABdhPJwKhLJV8eDOclSmpRU2ulnpLvZ4PUBfU/hVi3ZVeuTzJfFYs3bSzXBNG0RG1djQ0TgcVF+xBg==
X-Received: by 2002:a05:6402:154:: with SMTP id s20mr45971514edu.148.1641228000718;
        Mon, 03 Jan 2022 08:40:00 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:00 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 0/9] arm64: dts: meson: add support for aac2xx devices
Date:   Mon,  3 Jan 2022 16:39:47 +0000
Message-Id: <20220103163956.6581-1-christianshewitt@gmail.com>
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
some low-end boxes BT is omitted.

As initial distro setup is frequently performed over SSH or an HDMI GUI
app it is important for users to pick a device-tree with the correct
Ethernet PHY spec else connectivity is impossible. To aid this we append
a -gbit suffix to X96-AIR and A95XF3-AIR models using an external Gigabit
PHY, while 10/00 models with internal PHY have no suffix.

NB: At the current time the Realtek 8822CS and MT7668 WiFi/BT modules we
have seen on 'AIR' devices are not supported in the kernel so these are
deliberately omitted. The H96-Max uses a conventional Broadcom module
so has more complete support. For now the boxes have simple HDMI audio
support; wiring up the Headphone socket will be done at a later date.

Changes since RFC(v1) series:
- Add Robs binding acks on patches 4/7/8 (patches 2/5 still need acks)
- Rename and rework patches around -gbit (as requested by Neil)
- Correct 'manufacturer' typo on patch 8
- Rebase against v5.18/dt64 branch

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
 .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts | 129 ++++++++
 .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts | 108 +++++++
 .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 300 ++++++++++++++++++
 .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 145 +++++++++
 .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 133 ++++++++
 .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 112 +++++++
 9 files changed, 941 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts

-- 
2.17.1

