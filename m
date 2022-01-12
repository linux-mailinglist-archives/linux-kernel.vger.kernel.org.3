Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6D48BD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbiALC1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiALC1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:27:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5529C06173F;
        Tue, 11 Jan 2022 18:27:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 30so3993089edv.3;
        Tue, 11 Jan 2022 18:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbtzR3WiRHG8ekOj52mljErX2OG2pvaLPM1gvyJX52k=;
        b=CJF6ONFWOYv/zH1kM5T444rE2ksvFiXVTcRZqRVP6VgL5swvdwNcpOl4HJ652A3KAT
         JcEGdgyOyz8JdXTe9e6sA3ipBqDcgOz4UkXiegSjnBpvY5/rLHcsHssCElJVWCiP28r5
         HNfgxyWr/Fc+CSrD8OJt4/uVqvTn1AgSTGHyp7GieFlf6IKlmhM1BlAXjYmr34seqFJb
         zxBkK7JzFw7aMUAWqCkXlr1YCxF4cOZDhR6M/WlU1V2++ss04pVFLlgkoEsEFJfuW9vI
         yrVgpNv0iiEIxxaWdvm8GNsJo7F5kFSEGuOuL+ylYKq6IzL/yi7CuHVsOfW2tgUp/3aB
         fogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbtzR3WiRHG8ekOj52mljErX2OG2pvaLPM1gvyJX52k=;
        b=fI7uaJVrevi31c3JF99fR1R9s2lePrXXA8olf2UZIGHNY1BeJlE1Pb5EyyhNmxSMwl
         FGD3WT7LZojSnx7uKKY8DhjuEvYDtxw8dNZfKle8D6hU42atin0pt6Y6n8kI6Ugf9xba
         gwB/7T2zjtcmSeJQO5O2cic4D2/g/1B7VpwfKbWR92SbBpr5BqI0PvyVGpaPnBqgsJqR
         rqX1UgXhgLx7ugwv7CajMc7j8NM2qPi2R+m2psNSRkSIK8+sgLBuwWdpvY/2Xm0+SP5C
         GgvLote0Hr/XXN6uKXNL06vKJYGi1utEfIlfJ66BFvAulot1Y0XRWsmzR2Lp7CD/tXEw
         3WVA==
X-Gm-Message-State: AOAM530mgOsbwP1UWymbaaPYgFR22AwMnSae7lYzop7PY8k068NQ7QJU
        U88qU+eJdgXnrcotWCR7uIk=
X-Google-Smtp-Source: ABdhPJzi33yUQF/RXGa49SWv5GOhZhApFEWg/UD9i7/dT4xSvX89Ep+P+0yauxP+fqYH7wZ/FT/MYw==
X-Received: by 2002:a17:906:140e:: with SMTP id p14mr5748656ejc.440.1641954438461;
        Tue, 11 Jan 2022 18:27:18 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ky10sm4041772ejc.151.2022.01.11.18.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:27:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v3 0/9] arm64: dts: meson: add support for ac2xx devices
Date:   Wed, 12 Jan 2022 02:27:04 +0000
Message-Id: <20220112022713.25962-1-christianshewitt@gmail.com>
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

Changes since v2 series:
- Add Robs binding acks (patches 2/5)
- Add Martin/Piotir's Tested-By's (patches 1/3)
- Reorder Tested-By on patch 9
- Correct 'distinguished' typo in patch 5
- Correct typo in series name/subject

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

