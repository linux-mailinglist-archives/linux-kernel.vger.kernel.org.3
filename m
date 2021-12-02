Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0DF46631C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357657AbhLBMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:11:38 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50147 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357658AbhLBMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:11:31 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7F59F58030B;
        Thu,  2 Dec 2021 07:08:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 Dec 2021 07:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=m7muPXqEsZ8ZUctSDdv5jcwZw9
        bSBEQGp5qr1K9ODlk=; b=KuUR4oHxT0xhCHhte6BOaetlf+K3FzEBzDee3uOXzs
        4SX4mQDXrTh6arBYDDzFTYldlLqqG77y+i/ZloDpf+bfTR2nHv6yPEfmK16L3kUv
        176P9lW1YTk1nZxecT6rtlPN0R/HdIw+S9hc9kFumTFkqEMw5CFBQ3e85y2FdBIb
        khGubnayEniZ1k3edNLHYTAojLiH93vwllurfCnq0uD3HncTa3GO7BL+qOS9tHjw
        tuzzbqzR+Yh1lTVHnd7EAU3dMf0VtCtPlWzRms0/Z1Pq6PUoEq6aUsOYCM9GVD8W
        hf8zQUkAHi54LmxDic28IzMb+Ej4bZO9MKvGtaLEBz+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=m7muPX
        qEsZ8ZUctSDdv5jcwZw9bSBEQGp5qr1K9ODlk=; b=RyE/p6xuKvqFdv+iVt5Fz+
        NYpUJbv7/BHcCGsqIIrS65cKhnZ6SVNfyFtDE0dSpibw965UPnvcEPFAJyBGb1fy
        nqyQ/hx5SE1vHyDj2OUfoPxZcCIbdFXvzyTTEtB3V2u12illDsJmYN0Nqz22rtF0
        5z8Da3E0sh3LMphRlyy9DZYnHa9NfLes2rwShJzEDbKX3rYA9NGV7ESIdXuylfP7
        PU3Oqf6sMFPV+nSh0eyZVkmfFTCc5d6gkiq8iL0q/nVoFvYujVEQzJTa3O0vCOli
        TkapJwthZ0hU608NfF8RsXVkhTruB04wrb8zyakWhj5+pYXhGlK9OHc0wQGiBCPQ
        ==
X-ME-Sender: <xms:J7eoYS3b4xT3x5UnvP8b3GL-hDBBWZ74zH2IED_7t3h8Xq1zBTQ6NQ>
    <xme:J7eoYVHcYPceXoxcjIzOTotVnw5iIUNybqIElXXuWTwaNk8EpoFRNRMA9Tw41Ev-g
    ihL4_byt2fabgD6Z40>
X-ME-Received: <xmr:J7eoYa7sOqp1r7506jP9F0ppC0FzQgchSeXLGhxnyS8CxKMnBckzdcrx7farh_onS8Jlowa4yZVxo_X3bxViXxaqmPiVeopK1wMOimFfCm-1iAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffotggggfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehteefgfejueejtd
    egvdfggefhiefgheffvdffudevveetjeduhfdukeduteevjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:J7eoYT2GBsXhluafUHnXoxjGNVRZUe0RntEQ6TNjsTukQh2eHCuCMg>
    <xmx:J7eoYVG64aLNsF542p_MOedi_CyEekiMrB7KMLSUD575pa4qMKJV4w>
    <xmx:J7eoYc-2E6lHnASAV5elXiIZfio7kVR3k87LCEElcs9py_LVlQ5J6g>
    <xmx:KLeoYbVnq4UgeZWyXIjAACa8oZ1rgruIWnqrw1lZedhwlmJpPjROPw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:00 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 0/8] Add support for the silergy,sy7636a
Date:   Thu,  2 Dec 2021 22:07:50 +1000
Message-Id: <20211202120758.41478-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v16:=0D
 - Improve vdd regulator comments=0D
v15:=0D
 - Address comments on the patches=0D
v14:=0D
 - Merge the thermal driver and hwmon=0D
v13:=0D
 - Address comments on thermal driver=0D
 - Rebase on master (without other patches)=0D
v12:=0D
 - Rebase=0D
v11:=0D
 - Address comments on hwmon=0D
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message=0D
v10:=0D
 - Use dev_get_regmap() instead of dev_get_drvdata()=0D
v9:=0D
 - Convert to use the simple-mfd-i2c instead=0D
=0D
Alistair Francis (8):=0D
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml=0D
  mfd: simple-mfd-i2c: Add a Kconfig name=0D
  mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a=0D
  regulator: sy7636a: Remove requirement on sy7636a mfd=0D
  hwmon: sy7636a: Add temperature driver for sy7636a=0D
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a=0D
  ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a=0D
  ARM: dts: imx7d: remarkable2: Enable lcdif=0D
=0D
 .../bindings/mfd/silergy,sy7636a.yaml         |  82 +++++++++++=0D
 Documentation/hwmon/index.rst                 |   1 +=0D
 Documentation/hwmon/sy7636a-hwmon.rst         |  24 ++++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 135 ++++++++++++++++++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   3 +=0D
 drivers/hwmon/Kconfig                         |   9 ++=0D
 drivers/hwmon/Makefile                        |   1 +=0D
 drivers/hwmon/sy7636a-hwmon.c                 | 107 ++++++++++++++=0D
 drivers/mfd/Kconfig                           |   2 +-=0D
 drivers/mfd/simple-mfd-i2c.c                  |  11 ++=0D
 drivers/regulator/Kconfig                     |   1 -=0D
 drivers/regulator/sy7636a-regulator.c         |   7 +-=0D
 include/linux/mfd/sy7636a.h                   |  34 +++++=0D
 13 files changed, 413 insertions(+), 4 deletions(-)=0D
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.y=
aml=0D
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst=0D
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c=0D
 create mode 100644 include/linux/mfd/sy7636a.h=0D
=0D
-- =0D
2.31.1=0D
=0D
